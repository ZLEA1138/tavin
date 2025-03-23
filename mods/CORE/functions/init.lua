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
		node.param2 = 1
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