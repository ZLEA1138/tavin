local mod_name = minetest.get_current_modname()
local mod_path = minetest.get_modpath(mod_name)

-- Ferrum Chain (from chains by X17)
minetest.register_node("sb_core:chain_ferrum", {
	description = "Ferrum Chain",
	inventory_image = "chain_ferrum.png",
	tiles = {"chain_ferrum.png"},
	groups = {cracky = 11, level = 2, chain = 1},
	drawtype = "plantlike",
	paramtype = "light",
	walkable = false,
	climbable = true,
	sunlight_propagates = true,
	selection_box = {
		type = "fixed",
		fixed = {-1/16, -8/16, -1/16, 1/16, 8/16, 1/16}
	},
	node_box = {
		type = "fixed",
		fixed = {-1/16, -8/16, -1/16, 1/16, 8/16, 1/16}
	},
	sounds = sounds.node_sound_metal_defaults(),
	on_place = minetest.rotate_node,
})

minetest.register_craft({
	type = "shaped",
	output = "sb_core:chain_ferrum",
	recipe = {
		{"sb_minerals:ferrum_nugget"},
		{"sb_minerals:ferrum_ingot"},
		{"sb_minerals:ferrum_nugget"},
	},
})

-- Ferrum Ladder
minetest.register_node("sb_core:ladder_ferrum", {
	description = "Ferrum Ladder",
	drawtype = "signlike",
	tiles = {"ladder_ferrum.png"},
	inventory_image = "ladder_ferrum.png",
	wield_image = "ladder_ferrum.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	climbable = true,
	is_ground_content = false,
	selection_box = {
		type = "wallmounted",
		--wall_top = = <default>
		--wall_bottom = = <default>
		--wall_side = = <default>
	},
	groups = {cracky = 10},
	sounds = sounds.node_sound_metal_defaults(),
})

-- Wooden Ladder
minetest.register_node("sb_core:ladder_wood", {
	description = "Wooden Ladder",
	drawtype = "signlike",
	tiles = {"ladder_wood.png"},
	inventory_image = "ladder_wood.png",
	wield_image = "ladder_wood.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	climbable = true,
	is_ground_content = false,
	selection_box = {
		type = "wallmounted",
		--wall_top = = <default>
		--wall_bottom = = <default>
		--wall_side = = <default>
	},
	groups = {choppy = 11, oddly_breakable_by_hand = 3, flammable = 2},
	legacy_wallmounted = true,
	sounds = sounds.node_sound_wood_defaults(),
})

-- Vines
minetest.register_node("sb_core:vines", {
	description = "Vines",
	drawtype = "signlike",
	tiles = {"vines.png"},
	inventory_image = "vines.png",
	wield_image = "vines.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	walkable = false,
	climbable = true,
	is_ground_content = false,
	selection_box = {type = "wallmounted"},
	groups = {choppy = 3, oddly_breakable_by_hand = 3, flammable = 2},
	legacy_wallmounted = true,
	sounds = sounds.node_sound_leaves_defaults()
})
