local mod_name = minetest.get_current_modname()
local mod_path = minetest.get_modpath(mod_name)

-- WOOD
minetest.register_tool("sb_tools:sword_wood", {
	description = "Wooden Sword",
	inventory_image = "sword_wood.png",
	tool_capabilities = {
		full_punch_interval = 1.2,
		max_drop_level=1,
		groupcaps={
			snappy = {
				times = mining.max_time(75.00, 1),
				uses=60,
				maxlevel=1
			},
		},
		damage_groups = {fleshy=5},
	},
	sound = {breaks = "tool_breaks"},
	groups = {sword = 1, sword_level_1 = 1, flammable = 2}
})

core.register_alias("sword_wood", "sb_tools:sword_wood")

core.register_craft({
    output = "sb_tools:sword_wood",
    recipe = {
        {"group:planks"},
        {"group:planks"},
		{"group:stick"},
    }
})

core.register_craft({
    type = "fuel",
    recipe = "sb_tools:sword_wood",
    burntime = 10,
})

-- STONE
minetest.register_tool("sb_tools:sword_stone", {
	description = "Stone Sword",
	inventory_image = "sword_stone.png",
	tool_capabilities = {
		full_punch_interval = 1.3,
		max_drop_level=2,
		groupcaps={
			snappy = {
				times = mining.max_time(37.50, 2),
				uses=132,
				maxlevel=2
			},
		},
		damage_groups = {fleshy=6},
	},
	sound = {breaks = "tool_breaks"},
	groups = {sword = 1, sword_level_1 = 1, sword_level_2 = 1}
})

core.register_alias("sword_stone", "sb_tools:sword_stone")

core.register_craft({
    output = "sb_tools:sword_stone",
    recipe = {
        {"group:stone"},
        {"group:stone"},
		{"group:stick"},
    }
})

-- AEREUS
minetest.register_tool("sb_tools:sword_aereus", {
	description = "Aereus Sword",
	inventory_image = "sword_aereus.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=3,
		groupcaps={
			snappy = {
				times = mining.max_time(30.00, 3),
				uses=260,
				maxlevel=3
			},
		},
		damage_groups = {fleshy=7},
	},
	sound = {breaks = "tool_breaks"},
	groups = {sword = 1, sword_level_1 = 1, sword_level_2 = 1, sword_level_3 = 1}
})

core.register_alias("sword_aereus", "sb_tools:sword_aereus")

core.register_craft({
    output = "sb_tools:sword_aereus",
    recipe = {
        {"sb_minerals:aereus_ingot"},
        {"sb_minerals:aereus_ingot"},
		{"group:stick"},
    }
})

-- FERRUM
minetest.register_tool("sb_tools:sword_ferrum", {
	description = "Ferrum Sword",
	inventory_image = "sword_ferrum.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=3,
		groupcaps={
			snappy = {
				times = mining.max_time(25.00, 3),
				uses=250,
				maxlevel=3
			},
		},
		damage_groups = {fleshy=7},
	},
	sound = {breaks = "tool_breaks"},
	groups = {sword = 1, sword_level_1 = 1, sword_level_2 = 1, sword_level_3 = 1}
})

core.register_alias("sword_ferrum", "sb_tools:sword_ferrum")

core.register_craft({
    output = "sb_tools:sword_ferrum",
    recipe = {
        {"sb_minerals:ferrum_ingot"},
        {"sb_minerals:ferrum_ingot"},
		{"group:stick"},
    }
})

-- AUREM
minetest.register_tool("sb_tools:sword_aurem", {
	description = "Aurem Sword",
	inventory_image = "sword_aurem.png",
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level=3,
		groupcaps={
			snappy = {
				times = mining.max_time(12.50, 3),
				uses=32,
				maxlevel=3
			},
		},
		damage_groups = {fleshy=5},
	},
	sound = {breaks = "tool_breaks"},
	groups = {sword = 1, sword_level_1 = 1, sword_level_2 = 1, sword_level_3 = 1}
})

core.register_alias("sword_aurem", "sb_tools:sword_aurem")

core.register_craft({
    output = "sb_tools:sword_aurem",
    recipe = {
        {"sb_minerals:aurem_ingot"},
        {"sb_minerals:aurem_ingot"},
		{"group:stick"},
    }
})

-- WOLFRAM
minetest.register_tool("sb_tools:sword_wolfram", {
	description = "Wolfram Sword",
	inventory_image = "sword_wolfram.png",
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level=4,
		groupcaps={
			snappy = {
				times = mining.max_time(19.00, 4),
				uses=1562,
				maxlevel=4
			},
		},
		damage_groups = {fleshy=8},
	},
	sound = {breaks = "tool_breaks"},
	groups = {sword = 1, sword_level_1 = 1, sword_level_2 = 1, sword_level_3 = 1, sword_level_4 = 1}
})

core.register_alias("sword_wolfram", "sb_tools:sword_wolfram")

core.register_craft({
    output = "sb_tools:sword_wolfram",
    recipe = {
        {"sb_minerals:wolfram_ingot"},
        {"sb_minerals:wolfram_ingot"},
		{"group:stick"},
    }
})