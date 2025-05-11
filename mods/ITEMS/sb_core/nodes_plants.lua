local mod_name = minetest.get_current_modname()
local mod_path = minetest.get_modpath(mod_name)
local rarity_lookup = {[1] = 50, [2] = 50, [3] = 50, [4] = 5, [5] = 5}

-- GRASS
minetest.register_node("sb_core:grass_1", {
	description = "Grass",
	drawtype = "plantlike",
	waving = 1,
	tiles = {"grass_1.png"},
	-- Use texture of a taller grass stage in inventory
	inventory_image = "grass_3.png",
	wield_image = "grass_3.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	drop = {
		max_items = 1,
		items = {
			{items = {"sb_farming:seed_wheat"}, rarity = rarity_lookup[1]},
			{items = {"sb_core:grass_1"}}
		}
	},
	groups = {snappy = 1, oddly_breakable_by_hand = 1, flora = 1, attached_node = 1,
		grass = 1, normal_grass = 1, flammable = 1},
	sounds = sounds.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, -5 / 16, 6 / 16},
	},

	on_place = function(itemstack, placer, pointed_thing)
		-- place a random grass node
		local stack = ItemStack("sb_core:grass_" .. math.random(1,5))
		local ret = minetest.item_place(stack, placer, pointed_thing)
		return ItemStack("sb_core:grass_1 " ..
			itemstack:get_count() - (1 - ret:get_count()))
	end,
})

for i = 2, 5 do
	minetest.register_node("sb_core:grass_" .. i, {
		description = "Grass",
		drawtype = "plantlike",
		waving = 1,
		tiles = {"grass_" .. i .. ".png"},
		inventory_image = "grass_" .. i .. ".png",
		wield_image = "grass_" .. i .. ".png",
		paramtype = "light",
		sunlight_propagates = true,
		walkable = false,
		buildable_to = true,
		drop = {
			max_items = 1,
			items = {
				{items = {"sb_farming:seed_wheat"}, rarity = rarity_lookup[i]},
				{items = {"sb_core:grass_1"}}
			}
		},
		groups = {snappy = 1, oddly_breakable_by_hand = 1, flora = 1, attached_node = 1,
			not_in_creative_inventory = 1, grass = 1,
			normal_grass = 1, flammable = 1},
		sounds = sounds.node_sound_leaves_defaults(),
		selection_box = {
			type = "fixed",
			fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, -3 / 16, 6 / 16},
		},
	})
end

-- SEAGRASS
minetest.register_node("sb_core:seagrass_1", {
	description = "Seagrass",
	drawtype = "plantlike",
	waving = 1,
	tiles = {"seagrass_1.png"},
	inventory_image = "seagrass_1.png",
	wield_image = "seagrass_1.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	groups = {snappy = 1, oddly_breakable_by_hand = 1, flammable = 3, flora = 1, grass = 1,
		seagrass = 1, attached_node = 1},
	sounds = sounds.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, -0.25, 6 / 16},
	},

	on_place = function(itemstack, placer, pointed_thing)
		-- place a random seagrass node
		local stack = ItemStack("sb_core:seagrass_" .. math.random(1, 3))
		local ret = minetest.item_place(stack, placer, pointed_thing)
		return ItemStack("sb_core:seagrass_1 " ..
			itemstack:get_count() - (1 - ret:get_count()))
	end,
})

for i = 2, 3 do
	minetest.register_node("sb_core:seagrass_" .. i, {
		description = "Seagrass",
		drawtype = "plantlike",
		waving = 1,
		tiles = {"seagrass_" .. i .. ".png"},
		inventory_image = "seagrass_" .. i .. ".png",
		wield_image = "seagrass_" .. i .. ".png",
		paramtype = "light",
		sunlight_propagates = true,
		walkable = false,
		buildable_to = true,
		groups = {snappy = 1, oddly_breakable_by_hand = 1, flammable = 3, flora = 1,
			attached_node = 1, grass = 1, seagrass = 1, not_in_creative_inventory = 1},
		drop = "sb_core:seagrass_1",
		sounds = sounds.node_sound_leaves_defaults(),
		selection_box = {
			type = "fixed",
			fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, -0.25, 6 / 16},
		},
	})
end

-- REEDS
minetest.register_node("sb_core:reeds", {
	description = "Reeds",
	drawtype = "plantlike",
	tiles = {"reeds.png"},
	inventory_image = "reeds.png",
	wield_image = "reeds.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, 0.5, 6 / 16},
	},
	groups = {snappy = 3, flammable = 2},
	sounds = sounds.node_sound_leaves_defaults(),

	after_dig_node = function(pos, node, metadata, digger)
		functions.dig_up(pos, node, digger)
	end,
})