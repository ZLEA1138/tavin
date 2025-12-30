-- Wheat Seed
minetest.register_craftitem("sb_farming:seed_wheat", {
	description = "Wheat Seeds",
	inventory_image = "wheat_seed.png",
	groups = {compostability = 45, seed = 2},

	on_place = function(itemstack, placer, pointed_thing)
		return sb_farming.place_seed(itemstack, placer, pointed_thing, "sb_farming:wheat_1")
	end
})

-- Wheat (item)
minetest.register_craftitem("sb_farming:wheat", {
	description = "Wheat",
	inventory_image = "wheat.png",
	groups = {food_wheat = 1, flammable = 4}
})

-- Wheat Crop
local def = {
	description = "Wheat Crop",
	drawtype = "plantlike",
	tiles = {"wheat_1.png"},
	paramtype = "light",
	paramtype2 = "meshoptions",
	place_param2 = 3,
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	drop = "",
	waving = 1,
	selection_box = sb_farming.select,
	groups = {
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

minetest.register_node("sb_farming:wheat_1", table.copy(def))

-- stage 2

def.tiles = {"wheat_2.png"}
minetest.register_node("sb_farming:wheat_2", table.copy(def))

-- stage 3

def.tiles = {"wheat_3.png"}
minetest.register_node("sb_farming:wheat_3", table.copy(def))

-- stage 4

def.tiles = {"wheat_4.png"}
minetest.register_node("sb_farming:wheat_4", table.copy(def))

-- stage 5

def.tiles = {"wheat_5.png"}
minetest.register_node("sb_farming:wheat_5", table.copy(def))

-- stage 6

def.tiles = {"wheat_6.png"}
def.drop = {
	items = {
		{items = {"sb_farming:wheat"}, rarity = 2},
		{items = {"sb_farming:seed_wheat"}, rarity = 2}
	}
}
minetest.register_node("sb_farming:wheat_6", table.copy(def))

-- stage 7

def.tiles = {"wheat_7.png"}
def.drop = {
	items = {
		{items = {"sb_farming:wheat"}, rarity = 2},
		{items = {"sb_farming:seed_wheat"}, rarity = 1}
	}
}
minetest.register_node("sb_farming:wheat_7", table.copy(def))

-- stage 8 (final)

def.tiles = {"wheat_8.png"}
def.groups.growing = nil
def.selection_box = sb_farming.select_final
def.drop = {
	items = {
		{items = {"sb_farming:wheat 2"}, rarity = 1},
		{items = {"sb_farming:wheat"}, rarity = 2},
		{items = {"sb_farming:seed_wheat 2"}, rarity = 1},
		{items = {"sb_farming:seed_wheat"}, rarity = 2}
	}
}
minetest.register_node("sb_farming:wheat_8", table.copy(def))

-- add to registered_plants

sb_farming.registered_plants["sb_farming:wheat"] = {
	crop = "sb_farming:wheat",
	seed = "sb_farming:seed_wheat",
	minlight = sb_farming.min_light,
	maxlight = sb_farming.max_light,
	steps = 8
}
