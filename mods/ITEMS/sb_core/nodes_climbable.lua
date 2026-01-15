local mod_name = minetest.get_current_modname()
local mod_path = minetest.get_modpath(mod_name)

-- Ferrum Chain (from chains by X17)
minetest.register_node("sb_core:chain_ferrum", {
	description = "Ferrum Chain",
	inventory_image = "chain_ferrum.png",
	tiles = {"chain_ferrum.png"},
	groups = {
		crumbly = mining.hardness(5, -2),
		cracky = mining.hardness(5, 2),
		choppy = mining.hardness(5, -2),
		snappy = mining.hardness(5, -2),
		oddly_breakable_by_hand = mining.hardness(5, -2),
		chain = 1
	},
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
	drop = {
        max_items = 1,
        items = {
            {
				tool_groups = {"pickaxe_level_2"},
                items = {"sb_core:chain_ferrum"},
            },
        },
    },
	sounds = sounds.node_sound_metal_defaults(),
	on_place = minetest.rotate_node,
})

core.register_alias("chain_ferrum", "sb_core:chain_ferrum")

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
	groups = {
		crumbly = mining.hardness(5, -2),
		cracky = mining.hardness(5, 2),
		choppy = mining.hardness(5, -2),
		snappy = mining.hardness(5, -2),
		oddly_breakable_by_hand = mining.hardness(5, -2),
		chain = 1
	},
	drop = {
        max_items = 1,
        items = {
            {
				tool_groups = {"pickaxe_level_2"},
                items = {"sb_core:ladder_ferrum"},
            },
        },
    },
	sounds = sounds.node_sound_metal_defaults(),
})

core.register_alias("ladder_ferrum", "sb_core:ladder_ferrum")

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
	groups = {
		crumbly = mining.hardness(0.4, -1),
		cracky = mining.hardness(0.4, -1),
		choppy = mining.hardness(0.4, 0),
		snappy = mining.hardness(0.4, -1),
		oddly_breakable_by_hand = mining.hardness(0.4, 0),
		flammable = 2
	},
	legacy_wallmounted = true,
	sounds = sounds.node_sound_wood_defaults(),
})

core.register_alias("ladder_wood", "sb_core:ladder_wood")

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
	groups = {
		crumbly = mining.hardness(0.2, -1),
		cracky = mining.hardness(0.2, -1),
		choppy = mining.hardness(0.2, 0),
		snappy = mining.hardness(0.2, -1),
		oddly_breakable_by_hand = mining.hardness(0.2, 0),
		flammable = 2
	},
	legacy_wallmounted = true,
	sounds = sounds.node_sound_leaves_defaults()
})

core.register_alias("vines", "sb_core:vines")