-- Strandflower Seed
minetest.register_craftitem("sb_farming:seed_strandflower", {
	description = "Strandflower Seeds",
	inventory_image = "strandflower_seed.png",
	groups = {compostability = 48, seed = 2},

	on_place = function(itemstack, placer, pointed_thing)
		return sb_farming.place_seed(itemstack, placer, pointed_thing, "sb_farming:strandflower_1")
	end
})

-- Strandflower
minetest.register_craftitem("sb_farming:strandflower", {
	description = "Strandflower",
	inventory_image = "strandflower.png",
	groups = {flammable = 4, compostability = 50}
})

-- Strandflower Crop
local def = {
	description = "Strandflower Crop",
	drawtype = "plantlike",
	tiles = {"strandflower_1.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	drop =  "",
	waving = 1,
	selection_box = sb_farming.select,
	groups = {
		handy = 1,
		dig_immediate = 3,
		flammable = 4,
		plant = 1,
		attached_node = 1,
		not_in_creative_inventory = 1,
		growing = 1
	},
	is_ground_content = false,
	sounds = sounds.node_sound_leaves_defaults()
}

-- stage 1
minetest.register_node("sb_farming:strandflower_1", table.copy(def))

-- stage 2
def.tiles = {"strandflower_2.png"}
minetest.register_node("sb_farming:strandflower_2", table.copy(def))

-- stage 3
def.tiles = {"strandflower_3.png"}
minetest.register_node("sb_farming:strandflower_3", table.copy(def))

-- stage 4
def.tiles = {"strandflower_4.png"}
minetest.register_node("sb_farming:strandflower_4", table.copy(def))

-- stage 5
def.tiles = {"strandflower_5.png"}
def.drop = {
	items = {
		{items = {"sb_farming:seed_strandflower"}, rarity = 1}
	}
}
minetest.register_node("sb_farming:strandflower_5", table.copy(def))

-- stage 6
def.tiles = {"strandflower_6.png"}
minetest.register_node("sb_farming:strandflower_6", table.copy(def))

-- stage 7
def.tiles = {"strandflower_7.png"}
def.drop = {
	items = {
		{items = {"sb_farming:strandflower"}, rarity = 2},
		{items = {"sb_farming:seed_strandflower"}, rarity = 1}
	}
}
minetest.register_node("sb_farming:strandflower_7", table.copy(def))

-- stage 8 (final)
def.tiles = {"strandflower_8.png"}
def.groups.growing = nil
def.selection_box = sb_farming.select_final
def.drop = {
	items = {
		{items = {"sb_farming:strandflower"}, rarity = 1},
		{items = {"sb_farming:strandflower"}, rarity = 2},
		{items = {"sb_farming:strandflower"}, rarity = 3},
		{items = {"sb_farming:seed_strandflower"}, rarity = 1},
		{items = {"sb_farming:seed_strandflower"}, rarity = 2},
		{items = {"sb_farming:seed_strandflower"}, rarity = 3}
	}
}
minetest.register_node("sb_farming:strandflower_8", table.copy(def))

-- add to registered_plants
sb_farming.registered_plants["sb_farming:strandflower"] = {
	crop = "sb_farming:strandflower",
	seed = "sb_farming:seed_strandflower",
	minlight = sb_farming.min_light,
	maxlight = sb_farming.max_light,
	steps = 8
}

-- Wild Strandflower (this is what you find on the map)
minetest.register_node("sb_farming:strandflower_wild", {
	description = "Wild Strandflower",
	drawtype = "plantlike",
	waving = 1,
	tiles = {"strandflower_wild.png"},
	inventory_image = "strandflower_wild.png",
	wield_image = "strandflower_wild.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	groups = {
		handy = 1,
		dig_immediate = 3,
		attached_node = 1,
		flammable = 4,
		compostability = 60
	},
	is_ground_content = false,
	drop = {
		items = {
			{items = {"sb_farming:strandflower"}, rarity = 2},
			{items = {"sb_farming:seed_strandflower"}, rarity = 1}
		}
	},
	sounds = sounds.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -8 / 16, -6 / 16, 6 / 16, 5 / 16, 6 / 16}
	}
})