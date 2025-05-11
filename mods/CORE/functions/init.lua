local mod_name = minetest.get_current_modname()
local mod_path = minetest.get_modpath(mod_name)

functions = {}

--
-- Optimized helper to put all items in an inventory into a drops list
--
function functions.get_inventory_drops(pos, inventory, drops)
	local inv = minetest.get_meta(pos):get_inventory()
	local n = #drops
	for i = 1, inv:get_size(inventory) do
		local stack = inv:get_stack(inventory, i)
		if stack:get_count() > 0 then
			drops[n+1] = stack:to_table()
			n = n + 1
		end
	end
end

--
-- Dig upwards
--
local in_dig_up = false

function functions.dig_up(pos, node, digger, max_height)
	if in_dig_up then return end -- Do not recurse
	if digger == nil then return end
	max_height = max_height or 100

	in_dig_up = true
	for y = 1, max_height do
		local up_pos  = vector.offset(pos, 0, y, 0)
		local up_node = minetest.get_node(up_pos)
		if up_node.name ~= node.name then
			break
		end
		if not minetest.node_dig(up_pos, up_node, digger) then
			break
		end
	end
	in_dig_up = false
end

-- errors are hard to handle, instead we rely on resetting this value the next step
minetest.register_globalstep(function()
	in_dig_up = false
end)

--
-- Leafdecay
--

-- Prevent decay of placed leaves
functions.after_place_leaves = function(pos, placer, itemstack, pointed_thing)
	if placer and placer:is_player() then
		local node = minetest.get_node(pos)
		--node.param2 = 1
		minetest.set_node(pos, node)
	end
end

-- Leafdecay
local function leafdecay_after_destruct(pos, oldnode, def)
	for _, v in pairs(minetest.find_nodes_in_area(vector.subtract(pos, def.radius),
			vector.add(pos, def.radius), def.leaves)) do
		local node = minetest.get_node(v)
		local timer = minetest.get_node_timer(v)
		if node.param2 ~= 1 and not timer:is_started() then
			timer:start(math.random(20, 120) / 10)
		end
	end
end

local movement_gravity = tonumber(
	minetest.settings:get("movement_gravity")) or 9.81

local function leafdecay_on_timer(pos, def)
	if minetest.find_node_near(pos, def.radius, def.trunks) then
		return false
	end

	local node = minetest.get_node(pos)
	local drops = minetest.get_node_drops(node.name)
	for _, item in ipairs(drops) do
		local is_leaf
		for _, v in pairs(def.leaves) do
			if v == item then
				is_leaf = true
			end
		end
		if minetest.get_item_group(item, "leafdecay_drop") ~= 0 or
				not is_leaf then
			minetest.add_item({
				x = pos.x - 0.5 + math.random(),
				y = pos.y - 0.5 + math.random(),
				z = pos.z - 0.5 + math.random(),
			}, item)
		end
	end

	minetest.remove_node(pos)
	minetest.check_for_falling(pos)

	-- spawn a few particles for the removed node
	minetest.add_particlespawner({
		amount = 8,
		time = 0.001,
		minpos = vector.subtract(pos, {x=0.5, y=0.5, z=0.5}),
		maxpos = vector.add(pos, {x=0.5, y=0.5, z=0.5}),
		minvel = vector.new(-0.5, -1, -0.5),
		maxvel = vector.new(0.5, 0, 0.5),
		minacc = vector.new(0, -movement_gravity, 0),
		maxacc = vector.new(0, -movement_gravity, 0),
		minsize = 0,
		maxsize = 0,
		node = node,
	})
end

function functions.register_leafdecay(def)
	assert(def.leaves)
	assert(def.trunks)
	assert(def.radius)
	for _, v in pairs(def.trunks) do
		minetest.override_item(v, {
			after_destruct = function(pos, oldnode)
				leafdecay_after_destruct(pos, oldnode, def)
			end,
		})
	end
	for _, v in pairs(def.leaves) do
		minetest.override_item(v, {
			on_timer = function(pos)
				leafdecay_on_timer(pos, def)
			end,
		})
	end
end

--
-- Reeds growing
--

-- Wrapping the functions in ABM action is necessary to make overriding them possible
function functions.grow_reeds(pos, node)
	pos.y = pos.y - 1
	local name = minetest.get_node(pos).name
	if name ~= "sb_core:dirt" and
			name ~= "sb_core:dirt_grass_forest" and
			name ~= "sb_core:dirt_mycelium" and
			name ~= "sb_core:dirt_grass_plains" and
			name ~= "sb_core:dirt_grass_prairie" and
			name ~= "sb_core:dirt_grass_savanna" and
			name ~= "sb_core:dirt_grass_snow" and
			name ~= "sb_core:dirt_grass_swamp" and
			name ~= "sb_core:mud" and
			name ~= "sb_core:sand" and
			name ~= "sb_core:sand_desert" then
		return
	end
	if not minetest.find_node_near(pos, 3, {"group:water"}) then
		return
	end
	pos.y = pos.y + 1
	local height = 0
	while node.name == "sb_core:reeds" and height < 4 do
		height = height + 1
		pos.y = pos.y + 1
		node = minetest.get_node(pos)
	end
	if height == 4 or node.name ~= "air" then
		return
	end
	if minetest.get_node_light(pos) < 13 then
		return
	end
	minetest.set_node(pos, {name = "sb_core:reeds"})
	return true
end

minetest.register_abm({
	label = "Grow reeds",
	nodenames = {"sb_core:reeds"},
	-- Grows on the dirt and surface dirt nodes of the biomes reeds appears in.
	neighbors = {
		"sb_core:dirt",
		"sb_core:dirt_grass_forest",
		"sb_core:dirt_mycelium",
		"sb_core:dirt_grass_plains",
		"sb_core:dirt_grass_prairie",
		"sb_core:dirt_grass_savanna",
		"sb_core:dirt_grass_snow",
		"sb_core:dirt_grass_swamp",
		"sb_core:mud",
		"sb_core:sand",
		"sb_core:sand_desert",
	},
	interval = 14,
	chance = 71,
	action = function(...)
		functions.grow_reeds(...)
	end
})

--
-- Sapling 'on place' function to check protection of node and resulting tree volume
--
function functions.sapling_on_place(itemstack, placer, pointed_thing,
		sapling_name, minp_relative, maxp_relative, interval)
	-- Position of sapling
	local pos = pointed_thing.under
	local node = minetest.get_node_or_nil(pos)
	local pdef = node and minetest.registered_nodes[node.name]

	if pdef and pdef.on_rightclick and
			not (placer and placer:is_player() and
			placer:get_player_control().sneak) then
		return pdef.on_rightclick(pos, node, placer, itemstack, pointed_thing)
	end

	if not pdef or not pdef.buildable_to then
		pos = pointed_thing.above
		node = minetest.get_node_or_nil(pos)
		pdef = node and minetest.registered_nodes[node.name]
		if not pdef or not pdef.buildable_to then
			return itemstack
		end
	end

	local player_name = placer and placer:get_player_name() or ""
	-- Check sapling position for protection
	if minetest.is_protected(pos, player_name) then
		minetest.record_protection_violation(pos, player_name)
		return itemstack
	end
	-- Check tree volume for protection
	if minetest.is_area_protected(
			vector.add(pos, minp_relative),
			vector.add(pos, maxp_relative),
			player_name,
			interval) then
		minetest.record_protection_violation(pos, player_name)
		-- Print extra information to explain
		minetest.chat_send_player(player_name,
		    itemstack:get_definition().description .. " will intersect protection on growth.")
		return itemstack
	end

	if placer then
		functions.log_player_action(placer, "places node", sapling_name, "at", pos)
	end

	local take_item = not minetest.is_creative_enabled(player_name)
	local newnode = {name = sapling_name}
	local ndef = minetest.registered_nodes[sapling_name]
	minetest.set_node(pos, newnode)

	-- Run callback
	if ndef and ndef.after_place_node then
		-- Deepcopy place_to and pointed_thing because callback can modify it
		if ndef.after_place_node(table.copy(pos), placer,
				itemstack, table.copy(pointed_thing)) then
			take_item = false
		end
	end

	-- Run script hook
	for _, callback in ipairs(minetest.registered_on_placenodes) do
		-- Deepcopy pos, node and pointed_thing because callback can modify them
		if callback(table.copy(pos), table.copy(newnode),
				placer, table.copy(node or {}),
				itemstack, table.copy(pointed_thing)) then
			take_item = false
		end
	end

	if take_item then
		itemstack:take_item()
	end

	return itemstack
end

--
-- Grow sapling
--
functions.sapling_growth_defs = {}

-- 'can grow' function

function functions.can_grow(pos)
	local node_under = minetest.get_node_or_nil({x = pos.x, y = pos.y - 1, z = pos.z})
	if not node_under then
		return false
	end
	if minetest.get_item_group(node_under.name, "soil") == 0 then
		return false
	end
	local light_level = minetest.get_node_light(pos)
	if not light_level or light_level < 13 then
		return false
	end
	return true
end

function functions.on_grow_failed(pos)
	minetest.get_node_timer(pos):start(300)
end

-- New marshtree
function functions.grow_marshtree(pos)
	local path = minetest.get_modpath("mapgen") ..
		"/schematics/marshtree_1.mts"
	minetest.place_schematic({x = pos.x - 4, y = pos.y, z = pos.z - 4},
		path, "random", nil, false)
end

-- New oki tree
function functions.grow_oki_tree(pos)
	local path = minetest.get_modpath("mapgen") ..
		"/schematics/oki_tree_1.mts"
	minetest.place_schematic({x = pos.x - 6, y = pos.y, z = pos.z - 6},
		path, "random", nil, false)
end

-- New sana tree
function functions.grow_sana_tree(pos)
	local path = minetest.get_modpath("mapgen") ..
		"/schematics/sana_tree_1.mts"
	minetest.place_schematic({x = pos.x - 4, y = pos.y, z = pos.z - 3},
		path, "random", nil, false)
end

-- New suntree
function functions.grow_suntree(pos)
	local path = minetest.get_modpath("mapgen") ..
		"/schematics/suntree_1.mts"
	minetest.place_schematic({x = pos.x - 2, y = pos.y, z = pos.z - 2},
		path, "random", nil, false)
end

-- New taeda tree
function functions.grow_taeda_tree(pos)
	local path = minetest.get_modpath("mapgen") ..
		"/schematics/taeda_tree_1.mts"
	minetest.place_schematic({x = pos.x - 3, y = pos.y, z = pos.z - 3},
		path, "random", nil, false)
end

-- New wungu tree
function functions.grow_wungu_tree(pos)
	local path = minetest.get_modpath("mapgen") ..
		"/schematics/wungu_tree_1.mts"
	minetest.place_schematic({x = pos.x - 2, y = pos.y, z = pos.z - 2},
		path, "random", nil, false)
end

function functions.register_sapling_growth(name, def)
	functions.sapling_growth_defs[name] = {
		can_grow = def.can_grow or functions.can_grow,
		on_grow_failed = def.on_grow_failed or functions.on_grow_failed,
		grow = assert(def.grow)
	}
end

function functions.grow_sapling(pos)
	local node = minetest.get_node(pos)
	local sapling_def = functions.sapling_growth_defs[node.name]

	if not sapling_def then
		minetest.log("warning", "functions.grow_sapling called on undefined sapling " .. node.name)
		return
	end

	if not sapling_def.can_grow(pos) then
		sapling_def.on_grow_failed(pos)
		return
	end

	minetest.log("action", "Growing sapling " .. node.name .. " at " .. minetest.pos_to_string(pos))
	sapling_def.grow(pos)
end

local function register_sapling_growth(nodename, grow)
	functions.register_sapling_growth(nodename, {grow = grow})
end

register_sapling_growth("sb_core:sapling_marshtree", functions.grow_marshtree)
register_sapling_growth("sb_core:sapling_oki", functions.grow_oki_tree)
register_sapling_growth("sb_core:sapling_sana", functions.grow_sana_tree)
register_sapling_growth("sb_core:sapling_suntree", functions.grow_suntree)
register_sapling_growth("sb_core:sapling_taeda", functions.grow_taeda_tree)
register_sapling_growth("sb_core:sapling_wungu", functions.grow_wungu_tree)

--
-- Strip logs (from stripped_tree by 1faco)
--
functions.has_stripped = function(pos)
	local node = minetest.get_node(pos).name or pos
	local mod_name, node_name = unpack(node:split(":"))
	local has_stripped = minetest.registered_nodes[mod_name..":".."stripped_"..node_name]
	return has_stripped
end

functions.strip_log = function(pos,user,creative_mode)
	local old_node = minetest.get_node(pos)
	local old_node_name = minetest.get_node(pos).name or pos
	local mod_name, node_name = unpack(old_node_name:split(":"))
	local stripped = mod_name..":".."stripped_"..node_name
	minetest.swap_node(pos,{name=stripped,param2=old_node.param2})
	
	return itemstack
end

--
-- Fence registration helper
--
local fence_collision_extra = minetest.settings:get_bool("enable_fence_tall") and 3/8 or 0

function functions.register_fence(name, def)
	local fence_texture = "fence_overlay.png^" .. def.texture ..
			"^fence_overlay.png^[makealpha:255,126,126"
	-- Allow almost everything to be overridden
	local default_fields = {
		paramtype = "light",
		drawtype = "nodebox",
		node_box = {
			type = "connected",
			fixed = {-1/8, -1/2, -1/8, 1/8, 1/2, 1/8},
			-- connect_top =
			-- connect_bottom =
			connect_front = {{-1/16,  3/16, -1/2,   1/16,  5/16, -1/8 },
				         {-1/16, -5/16, -1/2,   1/16, -3/16, -1/8 }},
			connect_left =  {{-1/2,   3/16, -1/16, -1/8,   5/16,  1/16},
				         {-1/2,  -5/16, -1/16, -1/8,  -3/16,  1/16}},
			connect_back =  {{-1/16,  3/16,  1/8,   1/16,  5/16,  1/2 },
				         {-1/16, -5/16,  1/8,   1/16, -3/16,  1/2 }},
			connect_right = {{ 1/8,   3/16, -1/16,  1/2,   5/16,  1/16},
				         { 1/8,  -5/16, -1/16,  1/2,  -3/16,  1/16}}
		},
		collision_box = {
			type = "connected",
			fixed = {-1/8, -1/2, -1/8, 1/8, 1/2 + fence_collision_extra, 1/8},
			-- connect_top =
			-- connect_bottom =
			connect_front = {-1/8, -1/2, -1/2,  1/8, 1/2 + fence_collision_extra, -1/8},
			connect_left =  {-1/2, -1/2, -1/8, -1/8, 1/2 + fence_collision_extra,  1/8},
			connect_back =  {-1/8, -1/2,  1/8,  1/8, 1/2 + fence_collision_extra,  1/2},
			connect_right = { 1/8, -1/2, -1/8,  1/2, 1/2 + fence_collision_extra,  1/8}
		},
		connects_to = {"group:fence", "group:wood", "group:tree", "group:wall"},
		inventory_image = fence_texture,
		wield_image = fence_texture,
		tiles = {def.texture},
		sunlight_propagates = true,
		is_ground_content = false,
		groups = {},
	}
	for k, v in pairs(default_fields) do
		if def[k] == nil then
			def[k] = v
		end
	end

	-- Always add to the fence group, even if no group provided
	def.groups.fence = 1

	local material = def.material
	def.texture = nil
	def.material = nil

	minetest.register_node(name, def)

	-- Register crafting recipe, trim away starting colon if any
	if not material then return end
	name = string.gsub(name, "^:", "")
	minetest.register_craft({
		output = name .. " 4",
		recipe = {
			{ material, 'group:stick', material },
			{ material, 'group:stick', material },
		}
	})
end

--
-- Fence gate registration helper
--
local fence_collision_extra = minetest.settings:get_bool("enable_fence_tall") and 3/8 or 0

function functions.register_fencegate(name, def)
	local fence = {
		description = def.description,
		drawtype = "mesh",
		tiles = {},
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		is_ground_content = false,
		drop = name .. "_closed",
		connect_sides = {"left", "right"},
		groups = def.groups,
		sounds = def.sounds,
		on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
			local node_def = minetest.registered_nodes[node.name]
			minetest.swap_node(pos, {name = node_def._gate, param2 = node.param2})
			minetest.sound_play(node_def._gate_sound, {pos = pos, gain = 0.15,
				max_hear_distance = 8}, true)
			return itemstack
		end,
		selection_box = {
			type = "fixed",
			fixed = {-1/2, -1/2, -1/4, 1/2, 1/2, 1/4}
		},
	}


	if type(def.texture) == "string" then
		fence.tiles[1] = {name = def.texture, backface_culling = true}
	elseif def.texture.backface_culling == nil then
		fence.tiles[1] = table.copy(def.texture)
		fence.tiles[1].backface_culling = true
	else
		fence.tiles[1] = def.texture
	end

	if not fence.sounds then
		fence.sounds = sounds.node_sound_wood_defaults()
	end

	fence.groups.fence = 1

	local fence_closed = table.copy(fence)
	fence_closed.mesh = "fencegate_closed.obj"
	fence_closed._gate = name .. "_open"
	fence_closed._gate_sound = "fencegate_open"
	fence_closed.collision_box = {
		type = "fixed",
		fixed = {-1/2, -1/2, -1/8, 1/2, 1/2 + fence_collision_extra, 1/8}
	}

	local fence_open = table.copy(fence)
	fence_open.mesh = "fencegate_open.obj"
	fence_open._gate = name .. "_closed"
	fence_open._gate_sound = "fencegate_close"
	fence_open.groups.not_in_creative_inventory = 1
	fence_open.collision_box = {
		type = "fixed",
		fixed = {{-1/2, -1/2, -1/8, -3/8, 1/2 + fence_collision_extra, 1/8},
			 {-1/2, -3/8, -1/2, -3/8, 3/8,                         0  }}
	}

	minetest.register_node(":" .. name .. "_closed", fence_closed)
	minetest.register_node(":" .. name .. "_open", fence_open)

	minetest.register_craft({
		output = name .. "_closed",
		recipe = {
			{"group:stick", def.material, "group:stick"},
			{"group:stick", def.material, "group:stick"}
		}
	})
end

--
-- Log API / helpers
--
local log_non_player_actions = minetest.settings:get_bool("log_non_player_actions", false)

local is_pos = function(v)
	return type(v) == "table" and
		type(v.x) == "number" and type(v.y) == "number" and type(v.z) == "number"
end

function functions.log_player_action(player, ...)
	local msg = player:get_player_name()
	if player.is_fake_player or not player:is_player() then
		if not log_non_player_actions then
			return
		end
		msg = msg .. "(" .. (type(player.is_fake_player) == "string"
			and player.is_fake_player or "*") .. ")"
	end
	for _, v in ipairs({...}) do
		-- translate pos
		local part = is_pos(v) and minetest.pos_to_string(v) or v
		-- no leading spaces before punctuation marks
		msg = msg .. (string.match(part, "^[;,.]") and "" or " ") .. part
	end
	minetest.log("action",  msg)
end

local nop = function() end
function functions.set_inventory_action_loggers(def, name)
	local on_move = def.on_metadata_inventory_move or nop
	def.on_metadata_inventory_move = function(pos, from_list, from_index,
			to_list, to_index, count, player)
		functions.log_player_action(player, "moves stuff in", name, "at", pos)
		return on_move(pos, from_list, from_index, to_list, to_index, count, player)
	end
	local on_put = def.on_metadata_inventory_put or nop
	def.on_metadata_inventory_put = function(pos, listname, index, stack, player)
		functions.log_player_action(player, "moves", stack:get_name(), stack:get_count(), "to", name, "at", pos)
		return on_put(pos, listname, index, stack, player)
	end
	local on_take = def.on_metadata_inventory_take or nop
	def.on_metadata_inventory_take = function(pos, listname, index, stack, player)
		functions.log_player_action(player, "takes", stack:get_name(), stack:get_count(), "from", name, "at", pos)
		return on_take(pos, listname, index, stack, player)
	end
end

--
-- Pane nodes
--
local function is_pane(pos)
	return minetest.get_item_group(minetest.get_node(pos).name, "pane") > 0
end

local function connects_dir(pos, name, dir)
	local aside = vector.add(pos, minetest.facedir_to_dir(dir))
	if is_pane(aside) then
		return true
	end

	local connects_to = minetest.registered_nodes[name].connects_to
	if not connects_to then
		return false
	end
	local list = minetest.find_nodes_in_area(aside, aside, connects_to)

	if #list > 0 then
		return true
	end

	return false
end

local function swap(pos, node, name, param2)
	if node.name == name and node.param2 == param2 then
		return
	end

	minetest.swap_node(pos, {name = name, param2 = param2})
end

local function update_pane(pos)
	if not is_pane(pos) then
		return
	end
	local node = minetest.get_node(pos)
	local name = node.name
	if name:sub(-5) == "_flat" then
		name = name:sub(1, -6)
	end

	local any = node.param2
	local c = {}
	local count = 0
	for dir = 0, 3 do
		c[dir] = connects_dir(pos, name, dir)
		if c[dir] then
			any = dir
			count = count + 1
		end
	end

	if count == 0 then
		swap(pos, node, name .. "_flat", any)
	elseif count == 1 then
		swap(pos, node, name .. "_flat", (any + 1) % 4)
	elseif count == 2 then
		if (c[0] and c[2]) or (c[1] and c[3]) then
			swap(pos, node, name .. "_flat", (any + 1) % 4)
		else
			swap(pos, node, name, 0)
		end
	else
		swap(pos, node, name, 0)
	end
end

minetest.register_on_placenode(function(pos, node)
	if minetest.get_item_group(node, "pane") then
		update_pane(pos)
	end
	for i = 0, 3 do
		local dir = minetest.facedir_to_dir(i)
		update_pane(vector.add(pos, dir))
	end
end)

minetest.register_on_dignode(function(pos)
	for i = 0, 3 do
		local dir = minetest.facedir_to_dir(i)
		update_pane(vector.add(pos, dir))
	end
end)

function functions.register_pane(name, def)
	for i = 1, 15 do
		minetest.register_alias(name .. "_" .. i, name .. "_flat")
	end

	local flatgroups = table.copy(def.groups)
	flatgroups.pane = 1
	minetest.register_node(name .. "_flat", {
		description = def.description,
		drawtype = "nodebox",
		paramtype = "light",
		is_ground_content = false,
		sunlight_propagates = true,
		inventory_image = def.inventory_image,
		wield_image = def.wield_image,
		paramtype2 = "facedir",
		tiles = {
			def.textures[3],
			def.textures[3],
			def.textures[3],
			def.textures[3],
			def.textures[1],
			def.textures[1]
		},
		groups = flatgroups,
		drop = name .. "_flat",
		sounds = def.sounds,
		use_texture_alpha = def.use_texture_alpha and "blend" or "clip",
		node_box = {
			type = "fixed",
			fixed = {{-1/2, -1/2, -1/32, 1/2, 1/2, 1/32}},
		},
		selection_box = {
			type = "fixed",
			fixed = {{-1/2, -1/2, -1/32, 1/2, 1/2, 1/32}},
		},
		connect_sides = { "left", "right" },
	})

	local groups = table.copy(def.groups)
	groups.pane = 1
	groups.not_in_creative_inventory = 1
	minetest.register_node(name, {
		drawtype = "nodebox",
		paramtype = "light",
		is_ground_content = false,
		sunlight_propagates = true,
		description = def.description,
		tiles = {
			def.textures[3],
			def.textures[3],
			def.textures[1]
		},
		groups = groups,
		drop = name .. "_flat",
		sounds = def.sounds,
		use_texture_alpha = def.use_texture_alpha and "blend" or "clip",
		node_box = {
			type = "connected",
			fixed = {{-1/32, -1/2, -1/32, 1/32, 1/2, 1/32}},
			connect_front = {{-1/32, -1/2, -1/2, 1/32, 1/2, -1/32}},
			connect_left = {{-1/2, -1/2, -1/32, -1/32, 1/2, 1/32}},
			connect_back = {{-1/32, -1/2, 1/32, 1/32, 1/2, 1/2}},
			connect_right = {{1/32, -1/2, -1/32, 1/2, 1/2, 1/32}},
		},
		connects_to = {"group:pane", "group:stone", "group:glass", "group:wood", "group:tree"},
	})

	minetest.register_craft({
		output = name .. "_flat 16",
		recipe = def.recipe
	})
end

--
-- Wall registration helper
--
functions.register_wall = function(wall_name, wall_desc, wall_texture_table, wall_groups, wall_mat, wall_sounds)
	--make wall_texture_table paramenter backwards compatible for mods passing single texture
	if type(wall_texture_table) ~= "table" then
		wall_texture_table = { wall_texture_table }
	end
	-- inventory node, and pole-type wall start item
	minetest.register_node(wall_name, {
		description = wall_desc,
		drawtype = "nodebox",
		node_box = {
			type = "connected",
			fixed = {-1/4, -1/2, -1/4, 1/4, 1/2, 1/4},
			-- connect_bottom =
			connect_front = {-3/16, -1/2, -1/2,  3/16, 3/8, -1/4},
			connect_left = {-1/2, -1/2, -3/16, -1/4, 3/8,  3/16},
			connect_back = {-3/16, -1/2,  1/4,  3/16, 3/8,  1/2},
			connect_right = { 1/4, -1/2, -3/16,  1/2, 3/8,  3/16},
		},
		collision_box = {
			type = "connected",
			fixed = {-1/4, -1/2, -1/4, 1/4, 1/2 + fence_collision_extra, 1/4},
			-- connect_top =
			-- connect_bottom =
			connect_front = {-1/4,-1/2,-1/2,1/4,1/2 + fence_collision_extra,-1/4},
			connect_left = {-1/2,-1/2,-1/4,-1/4,1/2 + fence_collision_extra,1/4},
			connect_back = {-1/4,-1/2,1/4,1/4,1/2 + fence_collision_extra,1/2},
			connect_right = {1/4,-1/2,-1/4,1/2,1/2 + fence_collision_extra,1/4},
		},
		connects_to = { "group:wall", "group:stone", "group:fence", "group:wall_connected" },
		paramtype = "light",
		is_ground_content = false,
		tiles = wall_texture_table,
		walkable = true,
		groups = wall_groups,
		sounds = wall_sounds,
	})

	-- crafting recipe
	-- HACK:
	--   Walls have no crafts, when register new wall via API from another mod, but in the same namespace (`walls`).
	--   So we should remove `":"` at the beginning of the name.
	if wall_name:sub(1, 1) == ":" then
		wall_name = wall_name:sub(2)
	end
	minetest.register_craft({
		output = wall_name .. " 6",
		recipe = {
			{wall_mat, wall_mat, wall_mat},
			{wall_mat, wall_mat, wall_mat},
		}
	})

end

-- Turn dirt path and similar nodes to dirt if a solid node is placed above it (from MineClone2 by Wuzzy)
local vector_offset = vector.offset

minetest.register_on_placenode(function(pos, newnode, placer, oldnode, itemstack, pointed_thing)
	if minetest.get_item_group(newnode.name, "solid") ~= 0 or minetest.get_item_group(newnode.name, "nondirtifier") ~= 1 then
		local below = vector_offset(pos, 0, -1, 0)
		local belownode = minetest.get_node(below)
		if minetest.get_item_group(belownode.name, "dirtifies_below_solid") == 1 then
			minetest.set_node(below, {name="sb_core:dirt"})
		end
	end
end)

minetest.register_abm({
	label = "Turn grass path below solid block into dirt",
	nodenames = {"sb_core:dirt_path"},
	neighbors = {"group:solid"},
	interval = 8,
	chance = 50,
	action = function(pos, node)
		local above = minetest.get_node(vector_offset(pos, 0, 1, 0)).name
		if above == "ignore" then return end
		local nodedef = minetest.registered_nodes[above]
		if nodedef and (nodedef.groups and nodedef.groups.solid) then
			minetest.set_node(pos, {name = "sb_core:dirt"})
		end
	end,
})

--
-- Register a craft to copy the metadata of items
--

function functions.register_craft_metadata_copy(ingredient, result)
	minetest.register_craft({
		type = "shapeless",
		output = result,
		recipe = {ingredient, result}
	})

	minetest.register_on_craft(function(itemstack, player, old_craft_grid, craft_inv)
		if itemstack:get_name() ~= result then
			return
		end

		local original
		local index
		for i = 1, #old_craft_grid do
			if old_craft_grid[i]:get_name() == result then
				original = old_craft_grid[i]
				index = i
			end
		end
		if not original then
			return
		end
		local copymeta = original:get_meta():to_table()
		itemstack:get_meta():from_table(copymeta)
		-- put the book with metadata back in the craft grid
		craft_inv:set_stack("craft", index, original)
	end)
end



function functions.can_interact_with_node(player, pos)
	if player and player:is_player() then
		if minetest.check_player_privs(player, "protection_bypass") then
			return true
		end
	else
		return false
	end

	local meta = minetest.get_meta(pos)
	local owner = meta:get_string("owner")

	if not owner or owner == "" or owner == player:get_player_name() then
		return true
	end

	-- Is player wielding the right key?
	local item = player:get_wielded_item()
	if minetest.get_item_group(item:get_name(), "key") == 1 then
		local key_meta = item:get_meta()

		if key_meta:get_string("secret") == "" then
			local key_oldmeta = item:get_meta():get_string("")
			if key_oldmeta == "" or not minetest.parse_json(key_oldmeta) then
				return false
			end

			key_meta:set_string("secret", minetest.parse_json(key_oldmeta).secret)
			item:set_metadata("")
		end

		return meta:get_string("key_lock_secret") == key_meta:get_string("secret")
	end

	return false
end