local mod_name = minetest.get_current_modname()
local mod_path = minetest.get_modpath(mod_name)

-- Wungu
minetest.register_node("sb_core:log_wungu", {
	description = "Wungu Log",
	groups = {tree = 1, choppy = choppy, oddly_breakable_by_hand = 1, flammable = 2},
	tiles = {
		"log_wungu_top.png",
		"log_wungu_top.png",
		"log_wungu.png"
	},
	sounds = {},
	paramtype2 = "facedir",
	on_place = minetest.rotate_node,
})
