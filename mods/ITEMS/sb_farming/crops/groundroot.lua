-- Groundroot
minetest.register_craftitem("sb_farming:groundroot", {
	description = "Groundroot",
	inventory_image = "groundroot.png",
	groups = {compostability = 48, seed = 2, food_groundroot = 1},

	on_place = function(itemstack, placer, pointed_thing)
		return sb_farming.place_seed(itemstack, placer, pointed_thing, "sb_farming:groundroot_1")
	end,

	-- 1 in 3 chance of being poisoned
	on_use = function(itemstack, user, pointed_thing)

		if user then

			if math.random(3) == 1 then
				return minetest.do_item_eat(-1, nil, itemstack, user, pointed_thing)
			else
				return minetest.do_item_eat(1, nil, itemstack, user, pointed_thing)
			end
		end
	end
})

sb_farming.add_eatable("sb_farming:groundroot", 1)

-- Groundroot Crop
local def = {
	description = "Groundroot Crop",
	drawtype = "plantlike",
	tiles = {"groundroot_1.png"},
	paramtype = "light",
	sunlight_propagates = true,
	waving = 1,
	walkable = false,
	buildable_to = true,
	drop = "",
	selection_box = sb_farming.select,
	groups = {
		handy = 1, snappy = 1, oddly_breakable_by_hand = 1, flammable = 2, plant = 1, attached_node = 1,
		not_in_creative_inventory = 1, growing = 1
	},
	is_ground_content = false,
	sounds = sounds.node_sound_leaves_defaults()
}

-- stage 1
minetest.register_node("sb_farming:groundroot_1", table.copy(def))

-- stage 2
def.tiles = {"groundroot_2.png"}
minetest.register_node("sb_farming:groundroot_2", table.copy(def))

-- stage 3
def.tiles = {"groundroot_3.png"}
def.drop = {
	items = {
		{items = {"sb_farming:groundroot"}, rarity = 1},
		{items = {"sb_farming:groundroot"}, rarity = 3}
	}
}
minetest.register_node("sb_farming:groundroot_3", table.copy(def))

-- stage 4 (final)
def.tiles = {"groundroot_4.png"}
def.groups.growing = nil
def.selection_box = sb_farming.select_final
def.drop = {
	items = {
		{items = {"sb_farming:groundroot 2"}, rarity = 1},
		{items = {"sb_farming:groundroot"}, rarity = 2},
		{items = {"sb_farming:groundroot"}, rarity = 3}
	}
}
minetest.register_node("sb_farming:groundroot_4", table.copy(def))

-- add to registered_plants
sb_farming.registered_plants["sb_farming:groundroot"] = {
	crop = "sb_farming:groundroot",
	seed = "sb_farming:groundroot",
	minlight = sb_farming.min_light,
	maxlight = sb_farming.max_light,
	steps = 4
}