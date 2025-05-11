-- Ricebean Seed
minetest.register_craftitem("sb_farming:seed_ricebean", {
	description = "Ricebean Seeds",
	inventory_image = "ricebean_seed.png",
	groups = {compostability = 48, seed = 2},

	on_place = function(itemstack, placer, pointed_thing)
		return sb_farming.place_seed(itemstack, placer, pointed_thing, "sb_farming:ricebean_1")
	end
})

-- Ricebeans
minetest.register_craftitem("sb_farming:ricebeans", {
	description = "Ricebeans",
	inventory_image = "ricebeans.png",
	groups = {seed = 2, food_ricebean = 1, flammable = 2, compostability = 65},
})

-- dry ricebean seed to give edible ricebean
minetest.register_craft({
	type = "cooking",
	cooktime = 10,
	output = "sb_farming:ricebeans",
	recipe = "sb_farming:seed_ricebean"
})

-- Ricebean Crop
local def = {
	description = "Ricebean Crop",
	drawtype = "plantlike",
	tiles = {"ricebean_1.png"},
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
		handy = 1, snappy = 1, oddly_breakable_by_hand = 1, flammable = 4, plant = 1,
		attached_node = 1, not_in_creative_inventory = 1, growing = 1
	},
	is_ground_content = false,
	sounds = sounds.node_sound_leaves_defaults()
}

-- stage 1

minetest.register_node("sb_farming:ricebean_1", table.copy(def))

-- stage 2

def.tiles = {"ricebean_2.png"}
minetest.register_node("sb_farming:ricebean_2", table.copy(def))

-- stage 3

def.tiles = {"ricebean_3.png"}
minetest.register_node("sb_farming:ricebean_3", table.copy(def))

-- stage 4

def.tiles = {"ricebean_4.png"}
minetest.register_node("sb_farming:ricebean_4", table.copy(def))

-- stage 5

def.tiles = {"ricebean_5.png"}
minetest.register_node("sb_farming:ricebean_5", table.copy(def))

-- stage 6

def.tiles = {"ricebean_6.png"}
def.drop = {
	items = {
		{items = {"sb_farming:seed_ricebean"}, rarity = 2}
	}
}
minetest.register_node("sb_farming:ricebean_6", table.copy(def))

-- stage 7

def.tiles = {"ricebean_7.png"}
def.drop = {
	items = {
		{items = {"sb_farming:seed_ricebean"}, rarity = 1},
		{items = {"sb_farming:seed_ricebean"}, rarity = 3}
	}
}
minetest.register_node("sb_farming:ricebean_7", table.copy(def))

-- stage 8 (final)

def.tiles = {"ricebean_8.png"}
def.groups.growing = nil
def.selection_box = sb_farming.select_final
def.drop = {
	items = {
		{items = {"sb_farming:seed_ricebean 2"}, rarity = 1},
		{items = {"sb_farming:seed_ricebean"}, rarity = 2},
		{items = {"sb_farming:seed_ricebean"}, rarity = 3},
		{items = {"sb_farming:seed_ricebean"}, rarity = 4}
	}
}
minetest.register_node("sb_farming:ricebean_8", table.copy(def))

-- add to registered_plants

sb_farming.registered_plants["sb_farming:ricebeans"] = {
	crop = "sb_farming:ricebeans",
	seed = "sb_farming:seed_ricebean",
	minlight = sb_farming.min_light,
	maxlight = sb_farming.max_light,
	steps = 8
}