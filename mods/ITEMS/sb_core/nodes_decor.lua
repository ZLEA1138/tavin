local mod_name = minetest.get_current_modname()
local mod_path = minetest.get_modpath(mod_name)

-- FERRUM BARS
functions.register_pane("sb_core:bars_ferrum", {
	description = "Ferrum Bars",
	textures = {"bars_ferrum.png", "", "bars_ferrum_top.png"},
	inventory_image = "bars_ferrum.png",
	wield_image = "bars_ferrum.png",
	groups = {
		crumbly = mining.hardness(5, -2),
		cracky = mining.hardness(5, 2),
		choppy = mining.hardness(5, -2),
		snappy = mining.hardness(5, -2),
		oddly_breakable_by_hand = mining.hardness(5, -2),
	},
	drop = {
        max_items = 1,
        items = {
            {
				tool_groups = {"pickaxe_level_2"},
                items = {"sb_core:bars_ferrum"},
            },
        },
    },
	sounds = sounds.node_sound_metal_defaults(),
	recipe = {
		{"sb_minerals:ferrum_ingot", "sb_minerals:ferrum_ingot", "sb_minerals:ferrum_ingot"},
		{"sb_minerals:ferrum_ingot", "sb_minerals:ferrum_ingot", "sb_minerals:ferrum_ingot"}
	}
})

core.register_alias("bars_ferrum", "sb_core:bars_ferrum")