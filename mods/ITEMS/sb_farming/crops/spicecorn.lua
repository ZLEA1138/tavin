-- Spicecorn
minetest.register_craftitem("sb_farming:spicecorn", {
	description = "Spicecorn",
	inventory_image = "spicecorn.png",
	groups = {compostability = 45, seed = 2, food_corn = 1},
	on_use = minetest.item_eat(3),

	on_place = function(itemstack, placer, pointed_thing)
		return sb_farming.place_seed(itemstack, placer, pointed_thing, "sb_farming:spicecorn_1")
	end
})

sb_farming.add_eatable("sb_farming:spicecorn", 3)

-- Spicecorn Crop
local def = {
	description = "Spicecorn Crop",
	drawtype = "plantlike",
	tiles = {"spicecorn_1.png"},
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
minetest.register_node("sb_farming:spicecorn_1", table.copy(def))

-- stage 2
def.tiles = {"spicecorn_2.png"}
minetest.register_node("sb_farming:spicecorn_2", table.copy(def))

-- stage 3
def.tiles = {"spicecorn_3.png"}
minetest.register_node("sb_farming:spicecorn_3", table.copy(def))

-- stage 4
def.tiles = {"spicecorn_4.png"}
minetest.register_node("sb_farming:spicecorn_4", table.copy(def))

-- stage 5
def.tiles = {"spicecorn_5.png"}
minetest.register_node("sb_farming:spicecorn_5", table.copy(def))

-- stage 6
def.tiles = {"spicecorn_6.png"}
def.visual_scale = 1.9
minetest.register_node("sb_farming:spicecorn_6", table.copy(def))

-- stage 7
def.tiles = {"spicecorn_7.png"}
def.drop = {
	items = {
		{items = {"sb_farming:spicecorn"}, rarity = 1},
		{items = {"sb_farming:spicecorn"}, rarity = 3}
	}
}
minetest.register_node("sb_farming:spicecorn_7", table.copy(def))

-- stage 8 (final)
def.tiles = {"spicecorn_8.png"}
def.groups.growing = nil
def.selection_box = sb_farming.select_final
def.drop = {
	items = {
		{items = {"sb_farming:spicecorn 2"}, rarity = 1},
		{items = {"sb_farming:spicecorn"}, rarity = 2},
		{items = {"sb_farming:spicecorn"}, rarity = 3}
	}
}
minetest.register_node("sb_farming:spicecorn_8", table.copy(def))

-- add to registered_plants
sb_farming.registered_plants["sb_farming:spicecorn"] = {
	crop = "sb_farming:spicecorn",
	seed = "sb_farming:spicecorn",
	minlight = sb_farming.min_light,
	maxlight = sb_farming.max_light,
	steps = 8
}