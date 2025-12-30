-- Namespace for functions

sb_flowers = {}

-- Load support for MT game translation.
local S = minetest.get_translator("flowers")


--
-- Flowers
--


-- Flower registration

local function add_simple_flower(name, desc, box, f_groups)
	-- Common flowers' groups
	f_groups.dig_immediate = 3
	f_groups.flower = 1
	f_groups.flora = 1
	f_groups.attached_node = 1

	minetest.register_node("sb_flowers:" .. name, {
		description = desc,
		drawtype = "plantlike",
		waving = 1,
		tiles = {name .. ".png"},
		inventory_image = name .. ".png",
		wield_image = name .. ".png",
		sunlight_propagates = true,
		paramtype = "light",
		walkable = false,
		buildable_to = true,
		groups = f_groups,
		sounds = sounds.node_sound_leaves_defaults(),
		selection_box = {
			type = "fixed",
			fixed = box
		}
	})
end

sb_flowers.datas = {
	{
		"rose",
		"Rose",
		{-2 / 16, -0.5, -2 / 16, 2 / 16, 5 / 16, 2 / 16},
		{color_red = 1, flammable = 1}
	},
	{
		"marigold",
		"Marigold",
		{-2 / 16, -0.5, -2 / 16, 2 / 16, 3 / 16, 2 / 16},
		{color_orange = 1, flammable = 1}
	},
	{
		"dandelion",
		"Dandelion",
		{-4 / 16, -0.5, -4 / 16, 4 / 16, -2 / 16, 4 / 16},
		{color_yellow = 1, flammable = 1}
	},
	{
		"iris",
		"Iris",
		{-2 / 16, -0.5, -2 / 16, 2 / 16, 2 / 16, 2 / 16},
		{color_blue = 1, flammable = 1}
	},
	{
		"clematis",
		"Clematis",
		{-5 / 16, -0.5, -5 / 16, 5 / 16, -1 / 16, 5 / 16},
		{color_violet = 1, flammable = 1}
	},
	{
		"star_tulip",
		"Star Tulip",
		{-5 / 16, -0.5, -5 / 16, 5 / 16, -2 / 16, 5 / 16},
		{color_white = 1, flammable = 1}
	},
}

for _,item in pairs(sb_flowers.datas) do
	add_simple_flower(unpack(item))
end


-- Flower spread
-- Public function to enable override by mods

function sb_flowers.flower_spread(pos, node)
	pos.y = pos.y - 1
	local under = minetest.get_node(pos)
	pos.y = pos.y + 1

	if minetest.get_item_group(under.name, "soil") == 0 then
		return
	end

	local light = minetest.get_node_light(pos)
	if not light or light < 13 then
		return
	end

	local pos0 = vector.subtract(pos, 4)
	local pos1 = vector.add(pos, 4)
	-- Testing shows that a threshold of 3 results in an appropriate maximum
	-- density of approximately 7 flora per 9x9 area.
	if #minetest.find_nodes_in_area(pos0, pos1, "group:flora") > 3 then
		return
	end

	local soils = minetest.find_nodes_in_area_under_air(
		pos0, pos1, "group:soil")
	local num_soils = #soils
	if num_soils >= 1 then
		for si = 1, math.min(3, num_soils) do
			local soil = soils[math.random(num_soils)]
			local soil_name = minetest.get_node(soil).name
			local soil_above = {x = soil.x, y = soil.y + 1, z = soil.z}
			light = minetest.get_node_light(soil_above)
			if light and light >= 13 and
					-- Only spread to same surface node
					soil_name == under.name and
					-- Desert sand is in the soil group
					soil_name ~= "sb_core:desert_sand" then
				minetest.set_node(soil_above, {name = node.name})
			end
		end
	end
end

minetest.register_abm({
	label = "Flower spread",
	nodenames = {"group:flora"},
	interval = 13,
	chance = 300,
	action = function(...)
		sb_flowers.flower_spread(...)
	end,
})


--
-- Mushrooms
--

minetest.register_node("sb_flowers:mushroom_red", {
	description = "Red Death Mushroom",
	tiles = {"mushroom_red.png"},
	inventory_image = "mushroom_red.png",
	wield_image = "mushroom_red.png",
	drawtype = "plantlike",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	groups = {
		mushroom = 1,
		dig_immediate = 3,
		attached_node = 1,
		flammable = 1
	},
	sounds = sounds.node_sound_leaves_defaults(),
	on_use = minetest.item_eat(-5),
	selection_box = {
		type = "fixed",
		fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, -1 / 16, 4 / 16},
	}
})

minetest.register_node("sb_flowers:mushroom_brown", {
	description = "Brown Mushroom",
	tiles = {"mushroom_brown.png"},
	inventory_image = "mushroom_brown.png",
	wield_image = "mushroom_brown.png",
	drawtype = "plantlike",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	groups = {
		mushroom = 1,
		food_mushroom = 1,
		dig_immediate = 3,
		attached_node = 1,
		flammable = 1
	},
	sounds = sounds.node_sound_leaves_defaults(),
	on_use = minetest.item_eat(1),
	selection_box = {
		type = "fixed",
		fixed = {-3 / 16, -0.5, -3 / 16, 3 / 16, -2 / 16, 3 / 16},
	}
})

minetest.register_node("sb_flowers:mushroom_white", {
	description = "White Mushroom",
	tiles = {"mushroom_white.png"},
	inventory_image = "mushroom_white.png",
	wield_image = "mushroom_white.png",
	drawtype = "plantlike",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	groups = {
		mushroom = 1,
		food_mushroom = 1,
		dig_immediate = 3,
		attached_node = 1,
		flammable = 1
	},
	sounds = sounds.node_sound_leaves_defaults(),
	on_use = minetest.item_eat(1),
	selection_box = {
		type = "fixed",
		fixed = {-3 / 16, -0.5, -3 / 16, 3 / 16, -2 / 16, 3 / 16},
	}
})


-- Mushroom spread and death

function sb_flowers.mushroom_spread(pos, node)
	if minetest.get_node_light(pos, 0.5) > 3 then
		if minetest.get_node_light(pos, nil) == 15 then
			minetest.remove_node(pos)
		end
		return
	end
	local positions = minetest.find_nodes_in_area_under_air(
		{x = pos.x - 1, y = pos.y - 2, z = pos.z - 1},
		{x = pos.x + 1, y = pos.y + 1, z = pos.z + 1},
		{"group:soil", "group:tree"})
	if #positions == 0 then
		return
	end
	local pos2 = positions[math.random(#positions)]
	pos2.y = pos2.y + 1
	if minetest.get_node_light(pos2, 0.5) <= 3 then
		minetest.set_node(pos2, {name = node.name})
	end
end

minetest.register_abm({
	label = "Mushroom spread",
	nodenames = {"group:mushroom"},
	interval = 11,
	chance = 150,
	action = function(...)
		sb_flowers.mushroom_spread(...)
	end,
})


--
-- Waterlily
--

local waterlily_def = {
	description = "Waterlily",
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {"waterlily.png", "waterlily_bottom.png"},
	inventory_image = "waterlily.png",
	wield_image = "waterlily.png",
	use_texture_alpha = "clip",
	liquids_pointable = true,
	walkable = false,
	buildable_to = true,
	floodable = true,
	groups = {
		dig_immediate = 3,
		flower = 1,
		flammable = 1
	},
	sounds = sounds.node_sound_leaves_defaults(),
	node_placement_prediction = "",
	node_box = {
		type = "fixed",
		fixed = {-0.5, -31 / 64, -0.5, 0.5, -15 / 32, 0.5}
	},
	selection_box = {
		type = "fixed",
		fixed = {-7 / 16, -0.5, -7 / 16, 7 / 16, -15 / 32, 7 / 16}
	},

	on_place = function(itemstack, placer, pointed_thing)
		local pos = pointed_thing.above
		local node = minetest.get_node(pointed_thing.under)
		local def = minetest.registered_nodes[node.name]

		if def and def.on_rightclick then
			return def.on_rightclick(pointed_thing.under, node, placer, itemstack,
					pointed_thing)
		end

		if def and def.liquidtype == "source" and
				minetest.get_item_group(node.name, "water") > 0 then
			local player_name = placer and placer:get_player_name() or ""
			if not minetest.is_protected(pos, player_name) then
				minetest.set_node(pos, {name = "sb_flowers:waterlily" ..
					(def.waving == 3 and "_waving" or ""),
					param2 = math.random(0, 3)})
				if not minetest.is_creative_enabled(player_name) then
					itemstack:take_item()
				end
			else
				minetest.chat_send_player(player_name, "Node is protected")
				minetest.record_protection_violation(pos, player_name)
			end
		end

		return itemstack
	end
}

minetest.register_node("sb_flowers:waterlily", waterlily_def)

