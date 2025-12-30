-- Pring Shoot
minetest.register_craftitem("sb_farming:pringshoot", {
	description = "Pring Shoot",
	inventory_image = "pringshoot.png",
	groups = {compostability = 48, seed = 2, food_pringshoot = 1},
	on_use = minetest.item_eat(4),

	on_place = function(itemstack, placer, pointed_thing)
		return sb_farming.place_seed(itemstack, placer, pointed_thing, "sb_farming:pringshoot_1")
	end
})

sb_farming.add_eatable("sb_farming:pringshoot", 4)

-- Pring Shoot Crop
local def = {
	description = "Pring Shoot Crop",
	drawtype = "plantlike",
	tiles = {"pringshoot_1.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	drop = "",
	waving = 1,
	selection_box = sb_farming.select,
	groups = {
		handy = 1,
		dig_immediate = 3,
		flammable = 2,
		plant = 1,
		attached_node = 1,
		not_in_creative_inventory = 1,
		growing = 1
	},
	is_ground_content = false,
	sounds = sounds.node_sound_leaves_defaults()
}

-- stage 1
minetest.register_node("sb_farming:pringshoot_1", table.copy(def))

-- stage 2
def.tiles = {"pringshoot_2.png"}
minetest.register_node("sb_farming:pringshoot_2", table.copy(def))

-- stage 3
def.tiles = {"pringshoot_3.png"}
minetest.register_node("sb_farming:pringshoot_3", table.copy(def))

-- stage 4
def.tiles = {"pringshoot_4.png"}
minetest.register_node("sb_farming:pringshoot_4", table.copy(def))

-- stage 5
def.tiles = {"pringshoot_5.png"}
minetest.register_node("sb_farming:pringshoot_5", table.copy(def))

-- stage 6
def.tiles = {"pringshoot_6.png"}
minetest.register_node("sb_farming:pringshoot_6", table.copy(def))

-- stage 7
def.tiles = {"pringshoot_7.png"}
def.drop = {
	items = {
		{items = {"sb_farming:pringshoot"}, rarity = 1},
		{items = {"sb_farming:pringshoot"}, rarity = 3}
	}
}
minetest.register_node("sb_farming:pringshoot_7", table.copy(def))

-- stage 8 (final)
def.tiles = {"pringshoot_8.png"}
def.groups.growing = nil
def.selection_box = sb_farming.select_final
def.drop = {
	items = {
		{items = {"sb_farming:pringshoot 2"}, rarity = 1},
		{items = {"sb_farming:pringshoot"}, rarity = 2},
		{items = {"sb_farming:pringshoot"}, rarity = 3},
	}
}
minetest.register_node("sb_farming:pringshoot_8", table.copy(def))

-- add to registered_plants
sb_farming.registered_plants["sb_farming:pringshoot"] = {
	crop = "sb_farming:pringshoot",
	seed = "sb_farming:pringshoot",
	minlight = sb_farming.min_light,
	maxlight = sb_farming.max_light,
	steps = 8
}