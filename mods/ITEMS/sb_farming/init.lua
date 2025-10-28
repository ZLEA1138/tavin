--[[
	Based on Farming Redo Mod by TenPlus1
]]

-- global

sb_farming = {
	path = minetest.get_modpath("sb_farming"),
	select = {type = "fixed", fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5}},
	select_final = {type = "fixed", fixed = {-0.5, -0.5, -0.5, 0.5, -2.5/16, 0.5}},
	registered_plants = {},
	min_light = 12,
	max_light = 15,
	mapgen = minetest.get_mapgen_setting("mg_name"),
	use_utensils = minetest.settings:get_bool("farming_use_utensils") ~= false,
}

-- check for creative mode or priv

local creative_mode_cache = minetest.settings:get_bool("creative_mode")

function sb_farming.is_creative(name)
	return creative_mode_cache or minetest.check_player_privs(name, {creative = true})
end

-- stats, locals, settings, function helper

local statistics = dofile(sb_farming.path .. "/statistics.lua")
local random, floor = math.random, math.floor
local time_speed = tonumber(minetest.settings:get("time_speed")) or 72
local SECS_PER_CYCLE = (time_speed > 0 and (24 * 60 * 60) / time_speed) or 0
local function clamp(x, min, max) return (x < min and min) or (x > max and max) or x end

-- return amount of day or night that has elapsed
-- dt is time elapsed, count_day if true counts day, otherwise night

local function day_or_night_time(dt, count_day)

	local t_day = minetest.get_timeofday()
	local t1_day = t_day - dt / SECS_PER_CYCLE
	local t1_c, t2_c  -- t1_c < t2_c and t2_c always in [0, 1)

	if count_day then

		if t_day < 0.25 then
			t1_c = t1_day + 0.75  -- Relative to sunup, yesterday
			t2_c = t_day  + 0.75
		else
			t1_c = t1_day - 0.25  -- Relative to sunup, today
			t2_c = t_day  - 0.25
		end
	else
		if t_day < 0.75 then
			t1_c = t1_day + 0.25  -- Relative to sundown, yesterday
			t2_c = t_day  + 0.25
		else
			t1_c = t1_day - 0.75  -- Relative to sundown, today
			t2_c = t_day  - 0.75
		end
	end

	local dt_c = clamp(t2_c, 0, 0.5) - clamp(t1_c, 0, 0.5)  -- this cycle

	if t1_c < -0.5 then

		local nc = floor(-t1_c)

		t1_c = t1_c + nc
		dt_c = dt_c + 0.5 * nc + clamp(-t1_c - 0.5, 0, 0.5)
	end

	return dt_c * SECS_PER_CYCLE
end

-- Growth Logic

local STAGE_LENGTH_AVG = tonumber(minetest.settings:get("farming_stage_length")) or 200
local STAGE_LENGTH_DEV = STAGE_LENGTH_AVG / 6

-- quick start seed timer

sb_farming.start_seed_timer = function(pos)

	local timer = minetest.get_node_timer(pos)
	local grow_time = floor(random(STAGE_LENGTH_DEV, STAGE_LENGTH_AVG))

	timer:start(grow_time)
end

-- return plant name and stage from node provided

local function plant_name_stage(node)

	local name

	if type(node) == "table" then

		if node.name then name = node.name
		elseif node.x and node.y and node.z then
			node = minetest.get_node_or_nil(node)
			name = node and node.name
		end
	else
		name = tostring(node)
	end

	if not name or name == "ignore" then return nil end

	local sep_pos = name:find("_[^_]+$")

	if sep_pos and sep_pos > 1 then

		local stage = tonumber(name:sub(sep_pos + 1))

		if stage and stage >= 0 then
			return name:sub(1, sep_pos - 1), stage
		end
	end

	return name, 0
end

-- Map from node name to
-- { plant_name = ..., name = ..., stage = n, stages_left = { node_name, ... } }

local plant_stages = {}

sb_farming.plant_stages = plant_stages

--- Registers the stages of growth of a (possible plant) node.
 -- @param node - Node or position table, or node name.
 -- @return - The (possibly zero) number of stages of growth the plant will go through
 --           before being fully grown, or nil if not a plant.

-- Recursive helper

local function reg_plant_stages(plant_name, stage, force_last)

	local node_name = plant_name and plant_name .. "_" .. stage
	local node_def = node_name and minetest.registered_nodes[node_name]

	if not node_def then return nil end

	local stages = plant_stages[node_name]

	if stages then return stages end

	if minetest.get_item_group(node_name, "growing") > 0 then

		local ns = reg_plant_stages(plant_name, stage + 1, true)
		local stages_left = (ns and { ns.name, unpack(ns.stages_left) }) or {}

		stages = {
			plant_name = plant_name,
			name = node_name,
			stage = stage,
			stages_left = stages_left
		}

		if #stages_left > 0 then

			local old_constr = node_def.on_construct
			local old_destr  = node_def.on_destruct

			minetest.override_item(node_name, {

				on_construct = function(pos)

					if old_constr then old_constr(pos) end

					sb_farming.handle_growth(pos)
				end,

				on_destruct = function(pos)

					minetest.get_node_timer(pos):stop()

					if old_destr then old_destr(pos) end
				end,

				on_timer = function(pos, elapsed)
					return sb_farming.plant_growth_timer(pos, elapsed, node_name)
				end,
			})
		end

	elseif force_last then

		stages = {
			plant_name = plant_name,
			name = node_name,
			stage = stage,
			stages_left = {}
		}
	else
		return nil
	end

	plant_stages[node_name] = stages

	return stages
end

-- split name and stage and register crop

local function register_plant_node(node)

	local plant_name, stage = plant_name_stage(node)

	if plant_name then

		local stages = reg_plant_stages(plant_name, stage, false)

		return stages and #stages.stages_left
	end
end

-- check for further growth and set or stop timer

local function set_growing(pos, stages_left)

	if not stages_left then return end

	local timer = minetest.get_node_timer(pos)

	if stages_left > 0 then

		if not timer:is_started() then

			local stage_length = statistics.normal(STAGE_LENGTH_AVG, STAGE_LENGTH_DEV)

			stage_length = clamp(stage_length, 0.5 * STAGE_LENGTH_AVG, 3.0 * STAGE_LENGTH_AVG)

			timer:set(stage_length, -0.5 * random() * STAGE_LENGTH_AVG)
		end

	elseif timer:is_started() then
		timer:stop()
	end
end

-- detects a crop at given position, starting or stopping growth timer when needed

function sb_farming.handle_growth(pos, node)

	if not pos then return end

	local stages_left = register_plant_node(node or pos)

	if stages_left then set_growing(pos, stages_left) end
end

-- register crops nodes and add timer functions

minetest.after(0, function()

	for _, node_def in pairs(minetest.registered_nodes) do
		register_plant_node(node_def)
	end
end)

-- Just in case a growing type or added node is missed (also catches existing
-- nodes added to map before timers were incorporated).

minetest.register_abm({
	label = "Start crop timer",
	nodenames = {"group:growing"},
	interval = 300,
	chance = 1,
	catch_up = false,

	action = function(pos, node)

		-- skip if node timer already active
		if minetest.get_node_timer(pos):is_started() then return end

		-- check if group:growing node is a seed
		local def = minetest.registered_nodes[node.name]

		if def and def.groups and def.groups.seed then

			if def.on_timer then -- start node timer if found

				sb_farming.start_seed_timer(pos)

				return
			end

			local next_stage = def.next_plant

			def = minetest.registered_nodes[next_stage]

			if def then -- switch seed without timer to stage_1 of crop

				local p2 = def.place_param2 or 1

				minetest.set_node(pos, {name = next_stage, param2 = p2})
			end
		else
			sb_farming.handle_growth(pos, node) -- start normal crop timer
		end
	end
})

-- default check crop is on wet soil

sb_farming.can_grow = function(pos)

	local below = minetest.get_node({x = pos.x, y = pos.y -1, z = pos.z})

	return minetest.get_item_group(below.name, "soil") >= 3
end

-- Plant timer function that grows plants under the right conditions.

function sb_farming.plant_growth_timer(pos, elapsed, node_name)

	local stages = plant_stages[node_name]

	if not stages then return false end

	local max_growth = #stages.stages_left

	if max_growth <= 0 then return false end

	local chk1 = minetest.registered_nodes[node_name].growth_check -- old
	local chk2 = minetest.registered_nodes[node_name].can_grow -- new

	if chk1 then -- custom farming redo growth_check function

		if not chk1(pos, node_name) then return true end

	elseif chk2 then -- custom mt 5.9x farming can_grow function

		if not chk2(pos) then return true end

	-- default mt 5.9x sb_farming.can_grow function
	elseif not sb_farming.can_grow(pos) then return true end

	local growth
	local light_pos = {x = pos.x, y = pos.y, z = pos.z}
	local lambda = elapsed / STAGE_LENGTH_AVG

	if lambda < 0.1 then return true end

	local MIN_LIGHT = minetest.registered_nodes[node_name].minlight or sb_farming.min_light
	local MAX_LIGHT = minetest.registered_nodes[node_name].maxlight or sb_farming.max_light

	if max_growth == 1 or lambda < 2.0 then

		local light = (minetest.get_node_light(light_pos) or 0)

		if light < MIN_LIGHT or light > MAX_LIGHT then return true end

		growth = 1
	else
		local night_light = (minetest.get_node_light(light_pos, 0) or 0)
		local day_light = (minetest.get_node_light(light_pos, 0.5) or 0)
		local night_growth = night_light >= MIN_LIGHT and night_light <= MAX_LIGHT
		local day_growth = day_light >= MIN_LIGHT and day_light <= MAX_LIGHT

		if not night_growth then

			if not day_growth then return true end

			lambda = day_or_night_time(elapsed, true) / STAGE_LENGTH_AVG

		elseif not day_growth then

			lambda = day_or_night_time(elapsed, false) / STAGE_LENGTH_AVG
		end

		growth = statistics.poisson(lambda, max_growth)

		if growth < 1 then return true end
	end

	if minetest.registered_nodes[stages.stages_left[growth]] then

		local p2 = minetest.registered_nodes[stages.stages_left[growth] ].place_param2 or 1

		minetest.set_node(pos, {name = stages.stages_left[growth], param2 = p2})
	else
		return true
	end

	return growth ~= max_growth
end

-- refill placed plant by crabman (26/08/2015) updated by TenPlus1

function sb_farming.refill_plant(player, plantname, index)

	local inv = player and player:get_inventory() ; if not inv then return end

	local old_stack = inv:get_stack("main", index)

	if old_stack:get_name() ~= "" then return end

	for i, stack in ipairs(inv:get_list("main")) do

		if stack:get_name() == plantname and i ~= index then

			inv:set_stack("main", index, stack)
			stack:clear()
			inv:set_stack("main", i, stack)

			return
		end
	end
end

-- Place Seeds on Soil

function sb_farming.place_seed(itemstack, placer, pointed_thing, plantname)

	local pt = pointed_thing

	-- check if pointing at a node
	if not itemstack or not pt or pt.type ~= "node" then return end

	local under = minetest.get_node(pt.under)

	-- am I right-clicking on something that has a custom on_place set?
	-- thanks to Krock for helping with this issue :)
	local def = minetest.registered_nodes[under.name]

	if placer and itemstack and def and def.on_rightclick then
		return def.on_rightclick(pt.under, under, placer, itemstack, pt)
	end

	local above = minetest.get_node(pt.above)

	-- check if pointing at the top of the node
	if pt.above.y ~= pt.under.y + 1 then return end

	-- return if any of the nodes is not registered
	if not minetest.registered_nodes[under.name]
	or not minetest.registered_nodes[above.name] then return end

	-- can I replace above node, and am I pointing directly at soil
	if not minetest.registered_nodes[above.name].buildable_to
	or minetest.get_item_group(under.name, "soil") < 2
	or minetest.get_item_group(above.name, "plant") ~= 0 then return end

	-- is player planting seed?
	local name = placer and placer:get_player_name() or ""

	-- if not protected then add node and remove 1 item from the itemstack
	if not minetest.is_protected(pt.above, name) then

		local p2 = minetest.registered_nodes[plantname].place_param2 or 1

		minetest.set_node(pt.above, {name = plantname, param2 = p2})

		sb_farming.start_seed_timer(pt.above)

		minetest.sound_play("default_place_node", {pos = pt.above, gain = 1.0})

		minetest.log("action", string.format("%s planted %s at %s",
			(placer and placer:is_player() and placer:get_player_name() or "A mod"),
			itemstack:get_name(), minetest.pos_to_string(pt.above)
		))

		if placer and itemstack
		and not sb_farming.is_creative(placer:get_player_name()) then

			local name = itemstack:get_name()

			itemstack:take_item()

			-- check for refill
			if itemstack:get_count() == 0 then

				minetest.after(0.2, sb_farming.refill_plant,
						placer, name, placer:get_wield_index())
			end
		end

		return itemstack
	end
end

-- Function to register plants (default farming compatibility)

function sb_farming.register_plant(name, def)

	if not def.steps then return nil end

	local mname = name:split(":")[1]
	local pname = name:split(":")[2]

	-- Check def
	def.description = def.description or "Seed"
	def.inventory_image = def.inventory_image or "unknown_item.png"
	def.minlight = def.minlight or 12
	def.maxlight = def.maxlight or 15

	-- Register seed
	minetest.register_node(":" .. mname .. ":seed_" .. pname, {

		description = def.description,
		tiles = {def.inventory_image},
		inventory_image = def.inventory_image,
		wield_image = def.inventory_image,
		drawtype = "signlike",
		groups = {
			seed = 1, snappy = 3, attached_node = 1, flammable = 2, growing = 1,
			compostability = 65, handy = 1
		},
		is_ground_content = false,
		paramtype = "light",
		paramtype2 = "wallmounted",
		walkable = false,
		sunlight_propagates = true,
		selection_box = sb_farming.select,
		place_param2 = 1, -- place seed flat
		next_plant = mname .. ":" .. pname .. "_1",

		on_timer = function(pos, elapsed)

			local def = minetest.registered_nodes[mname .. ":" .. pname .. "_1"]

			if def then
				minetest.set_node(pos, {name = def.name, param2 = def.place_param2})
			end
		end,

		on_place = function(itemstack, placer, pointed_thing)

			return sb_farming.place_seed(itemstack, placer, pointed_thing,
					mname .. ":seed_" .. pname)
		end
	})

	-- Register harvest
	minetest.register_craftitem(":" .. mname .. ":" .. pname, {
		description = pname:gsub("^%l", string.upper),
		inventory_image = mname .. "_" .. pname .. ".png",
		groups = def.groups or {flammable = 2},
	})

	-- Register growing steps
	for i = 1, def.steps do

		local base_rarity = 1

		if def.steps ~= 1 then
			base_rarity =  8 - (i - 1) * 7 / (def.steps - 1)
		end

		local drop = {
			items = {
				{items = {mname .. ":" .. pname}, rarity = base_rarity},
				{items = {mname .. ":" .. pname}, rarity = base_rarity * 2},
				{items = {mname .. ":seed_" .. pname}, rarity = base_rarity},
				{items = {mname .. ":seed_" .. pname}, rarity = base_rarity * 2},
			}
		}

		local sel = sb_farming.select
		local g = {
			handy = 1, snappy = 3, flammable = 2, plant = 1, growing = 1,
			attached_node = 1, not_in_creative_inventory = 1,
		}

		-- Last step doesn't need growing=1 so Abm never has to check these
		-- also increase selection box for visual indication plant has matured
		if i == def.steps then
			sel = sb_farming.select_final
			g.growing = 0
		end

		local node_name = mname .. ":" .. pname .. "_" .. i

		local next_plant = nil

		if i < def.steps then
			next_plant = mname .. ":" .. pname .. "_" .. (i + 1)
		end

		local desc = pname:gsub("^%l", string.upper)

		minetest.register_node(node_name, {
			description = desc .. " Crop",
			drawtype = "plantlike",
			waving = 1,
			tiles = {mname .. "_" .. pname .. "_" .. i .. ".png"},
			paramtype = "light",
			paramtype2 = def.paramtype2,
			place_param2 = def.place_param2,
			walkable = false,
			buildable_to = true,
			sunlight_propagates = true,
			drop = drop,
			selection_box = sel,
			groups = g,
			is_ground_content = false,
			sounds = sb_farming.node_sound_leaves_defaults(),
			minlight = def.minlight,
			maxlight = def.maxlight,
			next_plant = next_plant
		})
	end

	-- add to sb_farming.registered_plants
	sb_farming.registered_plants[mname .. ":" .. pname] = {
		crop = mname .. ":" .. pname,
		seed = mname .. ":seed_" .. pname,
		steps = def.steps,
		minlight = def.minlight,
		maxlight = def.maxlight
	}
--	print(dump(sb_farming.registered_plants[mname .. ":" .. pname]))

	return {seed = mname .. ":seed_" .. pname, harvest = mname .. ":" .. pname}
end

-- Load new global settings if found inside mod folder

local input = io.open(sb_farming.path .. "/sb_farming.conf", "r")

if input then dofile(sb_farming.path .. "/sb_farming.conf") ; input:close() end

-- load new world-specific settings if found inside world folder

local worldpath = minetest.get_worldpath()

input = io.open(worldpath .. "/sb_farming.conf", "r")

if input then dofile(worldpath .. "/sb_farming.conf") ; input:close() end

-- helper function to add {eatable} group to food items, also {flammable}

function sb_farming.add_eatable(item, hp)

	local def = minetest.registered_items[item]

	if def then

		local groups = table.copy(def.groups) or {}

		groups.eatable = hp ; groups.flammable = 2

		minetest.override_item(item, {groups = groups})
	end
end

-- setup soil, register hoes, override grass

dofile(sb_farming.path .. "/soil.lua")


-- add crops
dofile(sb_farming.path .. "/crops/firemelon.lua")
dofile(sb_farming.path .. "/crops/groundroot.lua")
dofile(sb_farming.path .. "/crops/pringshoot.lua")
dofile(sb_farming.path .. "/crops/ricebeans.lua")
dofile(sb_farming.path .. "/crops/ruberberry.lua")
dofile(sb_farming.path .. "/crops/spicecorn.lua")
dofile(sb_farming.path .. "/crops/strandflower.lua")
dofile(sb_farming.path .. "/crops/wheat.lua")