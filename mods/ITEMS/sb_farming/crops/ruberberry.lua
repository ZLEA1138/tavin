-- Ruberberries
minetest.register_craftitem("sb_farming:ruberberries", {
	description = "Ruberberries",
	inventory_image = "ruberberries.png",
	groups = {
		compostability = 48,seed = 2, food_ruberberries = 1, food_ruberberry = 1,
		food_berry = 1
	},
	on_use = minetest.item_eat(1),

	on_place = function(itemstack, placer, pointed_thing)
		return sb_farming.place_seed(itemstack, placer, pointed_thing, "sb_farming:ruberberry_bush_1")
	end
})

sb_farming.add_eatable("sb_farming:ruberberries", 1)

-- Ruberberry Bush
local def = {
	description = "Ruberberry Bush",
	drawtype = "plantlike",
	tiles = {"ruberberry_bush_1.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	drop = "",
	selection_box = sb_farming.select,
	groups = {
		handy = 1, snappy = 3, flammable = 2, plant = 1, attached_node = 1,
		not_in_creative_inventory = 1, growing = 1
	},
	is_ground_content = false,
	sounds = sounds.node_sound_leaves_defaults()
}

-- stage 1

minetest.register_node("sb_farming:ruberberry_bush_1", table.copy(def))

-- stage 2

def.tiles = {"ruberberry_bush_2.png"}
minetest.register_node("sb_farming:ruberberry_bush_2", table.copy(def))

-- stage 3

def.tiles = {"ruberberry_bush_3.png"}
minetest.register_node("sb_farming:ruberberry_bush_3", table.copy(def))

-- stage 4 (final)

def.tiles = {"ruberberry_bush_4.png"}
def.groups.growing = nil
def.selection_box = sb_farming.select_final
def.drop = {
	items = {
		{items = {"sb_farming:ruberberries 2"}, rarity = 1},
		{items = {"sb_farming:ruberberries"}, rarity = 2},
		{items = {"sb_farming:ruberberries"}, rarity = 3}
	}
}
minetest.register_node("sb_farming:ruberberry_bush_4", table.copy(def))

-- add to registered_plants

sb_farming.registered_plants["sb_farming:blueberries"] = {
	crop = "sb_farming:ruberberry_bush",
	seed = "sb_farming:ruberberries",
	minlight = sb_farming.min_light,
	maxlight = sb_farming.max_light,
	steps = 4
}