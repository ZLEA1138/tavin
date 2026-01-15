local mod_name = minetest.get_current_modname()
local mod_path = minetest.get_modpath(mod_name)

-- ADAMAS
minetest.register_node("sb_minerals:stone_ore_adamas", {
	description = "Adamas Ore",
	tiles = {"stone.png^ore_adamas.png"},
	is_ground_content = true,
	groups = {
		crumbly = mining.hardness(3, -2),
		cracky = mining.hardness(3, 3),
		choppy = mining.hardness(3, -2),
		snappy = mining.hardness(3, -2),
		oddly_breakable_by_hand = mining.hardness(3, -2),
	},
	drop = {
		max_items = 1,
		items = {
			{tool_groups = {"pickaxe_level_3"}, items = {"sb_minerals:adamas_crystal_blue"}},
			{tool_groups = {"pickaxe_level_3"}, items = {"sb_minerals:adamas_crystal_green"}},
			{tool_groups = {"pickaxe_level_3"}, items = {"sb_minerals:adamas_crystal_yellow"}},
			{tool_groups = {"pickaxe_level_3"}, items = {"sb_minerals:adamas_crystal_red"}},
			{tool_groups = {"pickaxe_level_3"}, items = {"sb_minerals:adamas_crystal_purple"}, rarity = 16},
		}
	},
	sounds = {},
})

core.register_alias("stone_ore_adamas", "sb_minerals:stone_ore_adamas")

-- AUREM
minetest.register_node("sb_minerals:stone_ore_aurem", {
	description = "Aurem Ore",
	tiles = {"stone.png^ore_aurem.png"},
	is_ground_content = true,
	groups = {
		crumbly = mining.hardness(3, -2),
		cracky = mining.hardness(3, 2),
		choppy = mining.hardness(3, -2),
		snappy = mining.hardness(3, -2),
		oddly_breakable_by_hand = mining.hardness(3, -2),
	},
	drop = {
        max_items = 1,
        items = {
            {
				tool_groups = {"pickaxe_level_2"},
                items = {"sb_minerals:aurem_raw"},
            },
        },
    },
	sounds = {},
})

core.register_alias("stone_ore_aurem", "sb_minerals:stone_ore_aurem")

-- COAL
minetest.register_node("sb_minerals:stone_ore_coal", {
	description = "Coal Ore",
	tiles = {"stone.png^ore_coal.png"},
	is_ground_content = true,
	groups = {
		crumbly = mining.hardness(3, -2),
		cracky = mining.hardness(3, 1),
		choppy = mining.hardness(3, -2),
		snappy = mining.hardness(3, -2),
		oddly_breakable_by_hand = mining.hardness(3, -2),
	},
	drop = {
        max_items = 1,
        items = {
            {
				tool_groups = {"pickaxe"},
                items = {"sb_minerals:coal"},
            },
        },
    },
	sounds = {},
})

core.register_alias("stone_ore_coal", "sb_minerals:stone_ore_coal")

-- CUPRUM
minetest.register_node("sb_minerals:stone_ore_cuprum", {
	description = "Cuprum Ore",
	tiles = {"stone.png^ore_cuprum.png"},
	is_ground_content = true,
	groups = {
		crumbly = mining.hardness(3, -2),
		cracky = mining.hardness(3, 2),
		choppy = mining.hardness(3, -2),
		snappy = mining.hardness(3, -2),
		oddly_breakable_by_hand = mining.hardness(3, -2),
	},
	drop = {
        max_items = 1,
        items = {
            {
				tool_groups = {"pickaxe_level_2"},
                items = {"sb_minerals:cuprum_raw"},
            },
        },
    },
	sounds = {},
})

core.register_alias("stone_ore_cuprum", "sb_minerals:stone_ore_cuprum")

-- FERRUM
minetest.register_node("sb_minerals:stone_ore_ferrum", {
	description = "Ferrum Ore",
	tiles = {"stone.png^ore_ferrum.png"},
	is_ground_content = true,
	groups = {
		crumbly = mining.hardness(3, -2),
		cracky = mining.hardness(3, 2),
		choppy = mining.hardness(3, -2),
		snappy = mining.hardness(3, -2),
		oddly_breakable_by_hand = mining.hardness(3, -2),
	},
	drop = {
        max_items = 1,
        items = {
            {
				tool_groups = {"pickaxe_level_2"},
                items = {"sb_minerals:ferrum_raw"},
            },
        },
    },
	sounds = {},
})

core.register_alias("stone_ore_ferrum", "sb_minerals:stone_ore_ferrum")

-- STANNUM
minetest.register_node("sb_minerals:stone_ore_stannum", {
	description = "Stannum Ore",
	tiles = {"stone.png^ore_stannum.png"},
	is_ground_content = true,
	groups = {
		crumbly = mining.hardness(3, -2),
		cracky = mining.hardness(3, 2),
		choppy = mining.hardness(3, -2),
		snappy = mining.hardness(3, -2),
		oddly_breakable_by_hand = mining.hardness(3, -2),
	},
	drop = {
        max_items = 1,
        items = {
            {
				tool_groups = {"pickaxe_level_2"},
                items = {"sb_minerals:stannum_raw"},
            },
        },
    },
	sounds = {},
})

core.register_alias("stone_ore_stannum", "sb_minerals:stone_ore_stannum")

-- URAN
minetest.register_node("sb_minerals:stone_ore_uran", {
	description = "Uran Ore",
	tiles = {"stone.png^ore_uran.png"},
	is_ground_content = true,
	groups = {
		crumbly = mining.hardness(3, -2),
		cracky = mining.hardness(3, 3),
		choppy = mining.hardness(3, -2),
		snappy = mining.hardness(3, -2),
		oddly_breakable_by_hand = mining.hardness(3, -2),
	},
	drop = {
        max_items = 1,
        items = {
            {
				tool_groups = {"pickaxe_level_3"},
                items = {"sb_minerals:uran_raw"},
            },
        },
    },
	sounds = {},
})

core.register_alias("stone_ore_uran", "sb_minerals:stone_ore_uran")

-- WOLFRAM
minetest.register_node("sb_minerals:stone_ore_wolfram", {
	description = "Wolfram Ore",
	tiles = {"stone.png^ore_wolfram.png"},
	is_ground_content = true,
	groups = {
		crumbly = mining.hardness(3, -2),
		cracky = mining.hardness(3, 3),
		choppy = mining.hardness(3, -2),
		snappy = mining.hardness(3, -2),
		oddly_breakable_by_hand = mining.hardness(3, -2),
	},
	drop = {
        max_items = 1,
        items = {
            {
				tool_groups = {"pickaxe_level_3"},
                items = {"sb_minerals:wolfram_raw"},
            },
        },
    },
	sounds = {},
})

core.register_alias("stone_ore_wolfram", "sb_minerals:stone_ore_wolfram")