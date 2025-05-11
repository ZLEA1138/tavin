local mod_name = minetest.get_current_modname()
local mod_path = minetest.get_modpath(mod_name)

-- FERRUM BARS
functions.register_pane("sb_core:bars_ferrum", {
	description = "Ferrum Bars",
	textures = {"bars_ferrum.png", "", "bars_ferrum_top.png"},
	inventory_image = "bars_ferrum.png",
	wield_image = "bars_ferrum.png",
	groups = {cracky = 11},
	sounds = sounds.node_sound_metal_defaults(),
	recipe = {
		{"sb_minerals:ferrum_ingot", "sb_minerals:ferrum_ingot", "sb_minerals:ferrum_ingot"},
		{"sb_minerals:ferrum_ingot", "sb_minerals:ferrum_ingot", "sb_minerals:ferrum_ingot"}
	}
})