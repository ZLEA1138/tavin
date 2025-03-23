local mod_name = minetest.get_current_modname()
local mod_path = minetest.get_modpath(mod_name)

-- WOOD
minetest.register_tool("sb_tools:pick_wood", {
	description = "Wooden Pickaxe",
	inventory_image = "pick_wood.png",
	tool_capabilities = {
		full_punch_interval = 1.2,
		max_drop_level=0,
		groupcaps={
			cracky = {
				times = {
					 [1]=0.05,  [2]=0.40,  [3]=0.60,  [4]=0.75,  [5]=0.95,
					 [6]=1.15,  [7]=1.50,  [8]=1.90,  [9]=2.25, [10]=2.65,
					[11]=3.75,
				},
				uses=60,
				maxlevel=1
			},
		},
		damage_groups = {fleshy=2},
	},
	sound = {breaks = "tool_breaks"},
	groups = {pickaxe = 1, flammable = 2}
})

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
		max_drop_level=0,
		groupcaps={
			cracky = {
				times = {
					 [1]=0.05,  [2]=0.20,  [3]=0.30,  [4]=0.40,  [5]=0.50,
					 [6]=0.60,  [7]=0.75,  [8]=0.95,  [9]=1.15, [10]=1.35,
					[11]=1.90,
				},
				uses=132,
				maxlevel=2
			},
		},
		damage_groups = {fleshy=3},
	},
	sound = {breaks = "tool_breaks"},
	groups = {pickaxe = 1}
})

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
		max_drop_level=1,
		groupcaps={
			cracky = {
				times = {
					 [1]=0.05,  [2]=0.17,  [3]=0.25,  [4]=0.30,  [5]=0.40,
					 [6]=0.50,  [7]=0.60,  [8]=0.80,  [9]=0.95, [10]=0.10,
					[11]=1.55, [12]=3.10, [13]=7.05,
				},
				uses=260,
				maxlevel=3
			},
		},
		damage_groups = {fleshy=4},
	},
	sound = {breaks = "tool_breaks"},
	groups = {pickaxe = 1}
})

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
		max_drop_level=1,
		groupcaps={
			cracky = {
				times = {
					 [1]=0.05,  [2]=0.15,  [3]=0.20,  [4]=0.25,  [5]=0.35,
					 [6]=0.40,  [7]=0.50,  [8]=0.65,  [9]=0.75, [10]=0.90,
					[11]=1.25, [12]=2.50, [13]=5.65,
				},
				uses=250,
				maxlevel=3
			},
		},
		damage_groups = {fleshy=4},
	},
	sound = {breaks = "tool_breaks"},
	groups = {pickaxe = 1}
})

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
				times = {
					 [1]=0.05,  [2]=0.10,  [3]=0.10,  [4]=0.15,  [5]=0.20,
					 [6]=0.20,  [7]=0.25,  [8]=0.35,  [9]=0.40, [10]=0.45,
					[11]=0.65, [12]=1.25, [13]=2.85,
				},
				uses=32,
				maxlevel=3
			},
		},
		damage_groups = {fleshy=2},
	},
	sound = {breaks = "tool_breaks"},
	groups = {pickaxe = 1}
})

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
		max_drop_level=3,
		groupcaps={
			cracky = {
				times = {
					 [1]=0.05,  [2]=0.10,  [3]=0.15,  [4]=0.20,  [5]=0.25,
					 [6]=0.30,  [7]=0.40,  [8]=0.50,  [9]=0.60, [10]=0.70,
					[11]=0.95, [12]=1.90, [13]=4.25, [14]=9.40,
				},
				uses=1562,
				maxlevel=4
			},
		},
		damage_groups = {fleshy=5},
	},
	sound = {breaks = "tool_breaks"},
	groups = {pickaxe = 1}
})

core.register_craft({
    output = "sb_tools:pick_wolfram",
    recipe = {
        {"sb_minerals:wolfram_ingot", "sb_minerals:wolfram_ingot", "sb_minerals:wolfram_ingot"},
        {"", "group:stick", ""},
		{"", "group:stick", ""},
    }
})