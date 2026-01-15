-- Firemelon Slice
minetest.register_craftitem("sb_farming:firemelon_slice", {
	description = "Firemelon Slice",
	inventory_image = "firemelon_slice.png",
	groups = {compostability = 48, seed = 2, food_melon_slice = 1},
	on_use = minetest.item_eat(2),

	on_place = function(itemstack, placer, pointed_thing)
		return sb_farming.place_seed(itemstack, placer, pointed_thing, "sb_farming:firemelon_1")
	end
})

core.register_alias("firemelon_slice", "sb_farming:firemelon_slice")

sb_farming.add_eatable("sb_farming:firemelon_slice", 2)

-- Firemelon Crop
local def = {
	description = "Firemelon Crop",
	drawtype = "plantlike",
	tiles = {"firemelon_1.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	drop = "",
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
minetest.register_node("sb_farming:firemelon_1", table.copy(def))

-- stage 2
def.tiles = {"firemelon_2.png"}
minetest.register_node("sb_farming:firemelon_2", table.copy(def))

-- stage 3
def.tiles = {"firemelon_3.png"}
minetest.register_node("sb_farming:firemelon_3", table.copy(def))

-- stage 4
def.tiles = {"firemelon_4.png"}
minetest.register_node("sb_farming:firemelon_4", table.copy(def))

-- stage 5
def.tiles = {"firemelon_5.png"}
minetest.register_node("sb_farming:firemelon_5", table.copy(def))

-- stage 6
def.tiles = {"firemelon_6.png"}
minetest.register_node("sb_farming:firemelon_6", table.copy(def))

-- stage 7
def.tiles = {"firemelon_7.png"}
minetest.register_node("sb_farming:firemelon_7", table.copy(def))

-- stage 8 (final)
minetest.register_node("sb_farming:firemelon_8", {
	description = "Firemelon",
	tiles = {
		"firemelon_top.png",
		"firemelon_bottom.png",
		"firemelon_side.png"
	},
	groups = {
		food_melon = 1, handy = 1, choppy = 10, oddly_breakable_by_hand = 14,
		flammable = 2, plant = 1, compostability = 65
	},
	is_ground_content = false,
	drop = "sb_farming:firemelon_8",
	sounds = sounds.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	on_place = minetest.rotate_node,
})

-- add to registered_plants
sb_farming.registered_plants["sb_farming:firemelon"] = {
	crop = "sb_farming:firemelon",
	seed = "sb_farming:firemelon_slice",
	minlight = sb_farming.min_light,
	maxlight = sb_farming.max_light,
	steps = 8
}