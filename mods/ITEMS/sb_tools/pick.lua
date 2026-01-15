local mod_name = minetest.get_current_modname()
local mod_path = minetest.get_modpath(mod_name)

-- WOOD
minetest.register_tool("sb_tools:pick_wood", {
	description = "Wooden Pickaxe",
	inventory_image = "pick_wood.png",
	tool_capabilities = {
		full_punch_interval = 1.2,
		max_drop_level=1,
		groupcaps={
			cracky = {
				times = mining.max_time(75.00, 1),
				uses=60,
				maxlevel=1
			},
		},
		damage_groups = {fleshy=2},
	},
	sound = {breaks = "tool_breaks"},
	groups = {pickaxe = 1, pickaxe_level_1 = 1, flammable = 2}
})

core.register_alias("pick_wood", "sb_tools:pick_wood")

core.register_craft({
    output = "sb_tools:pick_wood",
    recipe = {
        {"group:planks", "group:planks", "group:planks"},
        {"", "group:stick", ""},
		{"", "group:stick", ""},
    }
})

core.register_craft({
    type = "fuel",
    recipe = "sb_tools:pick_wood",
    burntime = 10,
})

-- STONE
minetest.register_tool("sb_tools:pick_stone", {
	description = "Stone Pickaxe",
	inventory_image = "pick_stone.png",
	tool_capabilities = {
		full_punch_interval = 1.3,
		max_drop_level=2,
		groupcaps={
			cracky = {
				times = mining.max_time(37.50, 2),
				uses=132,
				maxlevel=2
			},
		},
		damage_groups = {fleshy=3},
	},
	sound = {breaks = "tool_breaks"},
	groups = {pickaxe = 1, pickaxe_level_1 = 1, pickaxe_level_2 = 1}
})

core.register_alias("pick_stone", "sb_tools:pick_stone")

core.register_craft({
    output = "sb_tools:pick_stone",
    recipe = {
        {"group:stone", "group:stone", "group:stone"},
        {"", "group:stick", ""},
		{"", "group:stick", ""},
    }
})

-- AEREUS
minetest.register_tool("sb_tools:pick_aereus", {
	description = "Aereus Pickaxe",
	inventory_image = "pick_aereus.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=3,
		groupcaps={
			cracky = {
				times = mining.max_time(30.00, 3),
				uses=260,
				maxlevel=3
			},
		},
		damage_groups = {fleshy=4},
	},
	sound = {breaks = "tool_breaks"},
	groups = {pickaxe = 1, pickaxe_level_1 = 1, pickaxe_level_2 = 1, pickaxe_level_3 = 1}
})

core.register_alias("pick_aereus", "sb_tools:pick_aereus")

core.register_craft({
    output = "sb_tools:pick_aereus",
    recipe = {
        {"sb_minerals:aereus_ingot", "sb_minerals:aereus_ingot", "sb_minerals:aereus_ingot"},
        {"", "group:stick", ""},
		{"", "group:stick", ""},
    }
})

-- FERRUM
minetest.register_tool("sb_tools:pick_ferrum", {
	description = "Ferrum Pickaxe",
	inventory_image = "pick_ferrum.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=3,
		groupcaps={
			cracky = {
				times = mining.max_time(25.00, 3),
				uses=250,
				maxlevel=3
			},
		},
		damage_groups = {fleshy=4},
	},
	sound = {breaks = "tool_breaks"},
	groups = {pickaxe = 1, pickaxe_level_1 = 1, pickaxe_level_2 = 1, pickaxe_level_3 = 1}
})

core.register_alias("pick_ferrum", "sb_tools:pick_ferrum")

core.register_craft({
    output = "sb_tools:pick_ferrum",
    recipe = {
        {"sb_minerals:ferrum_ingot", "sb_minerals:ferrum_ingot", "sb_minerals:ferrum_ingot"},
        {"", "group:stick", ""},
		{"", "group:stick", ""},
    }
})

-- AUREM
minetest.register_tool("sb_tools:pick_aurem", {
	description = "Aurem Pickaxe",
	inventory_image = "pick_aurem.png",
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level=3,
		groupcaps={
			cracky = {
				times = mining.max_time(12.50, 3),
				uses=32,
				maxlevel=3
			},
		},
		damage_groups = {fleshy=2},
	},
	sound = {breaks = "tool_breaks"},
	groups = {pickaxe = 1, pickaxe_level_1 = 1, pickaxe_level_2 = 1, pickaxe_level_3 = 1}
})

core.register_alias("pick_aurem", "sb_tools:pick_aurem")

core.register_craft({
    output = "sb_tools:pick_aurem",
    recipe = {
        {"sb_minerals:aurem_ingot", "sb_minerals:aurem_ingot", "sb_minerals:aurem_ingot"},
        {"", "group:stick", ""},
		{"", "group:stick", ""},
    }
})

-- WOLFRAM
minetest.register_tool("sb_tools:pick_wolfram", {
	description = "Wolfram Pickaxe",
	inventory_image = "pick_wolfram.png",
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level=4,
		groupcaps={
			cracky = {
				times = mining.max_time(19.00, 4),
				uses=1562,
				maxlevel=4
			},
		},
		damage_groups = {fleshy=5},
	},
	sound = {breaks = "tool_breaks"},
	groups = {pickaxe = 1, pickaxe_level_1 = 1, pickaxe_level_2 = 1, pickaxe_level_3 = 1, pickaxe_level_4 = 1}
})

core.register_alias("pick_wolfram", "sb_tools:pick_wolfram")

core.register_craft({
    output = "sb_tools:pick_wolfram",
    recipe = {
        {"sb_minerals:wolfram_ingot", "sb_minerals:wolfram_ingot", "sb_minerals:wolfram_ingot"},
        {"", "group:stick", ""},
		{"", "group:stick", ""},
    }
})