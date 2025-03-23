local mod_name = minetest.get_current_modname()
local mod_path = minetest.get_modpath(mod_name)

-- WOOD
minetest.register_tool("sb_tools:shovel_wood", {
	description = "Wooden Shovel",
	inventory_image = "shovel_wood.png",
	wield_image = "shovel_wood.png^[transformR90",
	tool_capabilities = {
		full_punch_interval = 1.2,
		max_drop_level=0,
		groupcaps={
			crumbly = {
				times = {
					 [1]=0.05,  [2]=0.10,  [3]=0.15,  [4]=0.20,  [5]=0.40,
					 [6]=0.45,  [7]=0.50,  [8]=0.55,
				},
				uses=60,
				maxlevel=1
			},
		},
		damage_groups = {fleshy=2},
	},
	sound = {breaks = "tool_breaks"},
	groups = {shovel = 1, flammable = 2}
})

core.register_craft({
    output = "sb_tools:shovel_wood",
    recipe = {
        {"group:planks"},
        {"group:stick"},
		{"group:stick"},
    }
})

core.register_craft({
    type = "fuel",
    recipe = "sb_tools:shovel_wood",
    burntime = 10,
})

-- STONE
minetest.register_tool("sb_tools:shovel_stone", {
	description = "Stone Shovel",
	inventory_image = "shovel_stone.png",
	wield_image = "shovel_stone.png^[transformR90",
	tool_capabilities = {
		full_punch_interval = 1.3,
		max_drop_level=0,
		groupcaps={
			crumbly = {
				times = {
					 [1]=0.05,  [2]=0.05,  [3]=0.10,  [4]=0.10,  [5]=0.20,
					 [6]=0.25,  [7]=0.25,  [8]=0.30,
				},
				uses=132,
				maxlevel=2
			},
		},
		damage_groups = {fleshy=3},
	},
	sound = {breaks = "tool_breaks"},
	groups = {shovel = 1}
})

core.register_craft({
    output = "sb_tools:shovel_stone",
    recipe = {
        {"group:stone"},
        {"group:stick"},
		{"group:stick"},
    }
})

-- AEREUS
minetest.register_tool("sb_tools:shovel_aereus", {
	description = "Aereus Shovel",
	inventory_image = "shovel_aereus.png",
	wield_image = "shovel_aereus.png^[transformR90",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		groupcaps={
			crumbly = {
				times = {
					 [1]=0.05,  [2]=0.05,  [3]=0.05,  [4]=0.10,  [5]=0.15,
					 [6]=0.20,  [7]=0.20,  [8]=0.25,
				},
				uses=260,
				maxlevel=3
			},
		},
		damage_groups = {fleshy=4},
	},
	sound = {breaks = "tool_breaks"},
	groups = {shovel = 1}
})

core.register_craft({
    output = "sb_tools:shovel_aereus",
    recipe = {
        {"sb_minerals:aereus_ingot"},
        {"group:stick"},
		{"group:stick"},
    }
})

-- FERRUM
minetest.register_tool("sb_tools:shovel_ferrum", {
	description = "Ferrum Shovel",
	inventory_image = "shovel_ferrum.png",
	wield_image = "shovel_ferrum.png^[transformR90",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		groupcaps={
			crumbly = {
				times = {
					 [1]=0.05,  [2]=0.05,  [3]=0.05,  [4]=0.10,  [5]=0.15,
					 [6]=0.15,  [7]=0.20,  [8]=0.20,
				},
				uses=250,
				maxlevel=3
			},
		},
		damage_groups = {fleshy=4},
	},
	sound = {breaks = "tool_breaks"},
	groups = {shovel = 1}
})

core.register_craft({
    output = "sb_tools:shovel_ferrum",
    recipe = {
        {"sb_minerals:ferrum_ingot"},
        {"group:stick"},
		{"group:stick"},
    }
})

-- AUREM
minetest.register_tool("sb_tools:shovel_aurem", {
	description = "Aurem Shovel",
	inventory_image = "shovel_aurem.png",
	wield_image = "shovel_aurem.png^[transformR90",
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level=3,
		groupcaps={
			crumbly = {
				times = {
					 [1]=0.05,  [2]=0.05,  [3]=0.05,  [4]=0.05,  [5]=0.10,
					 [6]=0.10,  [7]=0.10,  [8]=0.10,
				},
				uses=32,
				maxlevel=3
			},
		},
		damage_groups = {fleshy=2},
	},
	sound = {breaks = "tool_breaks"},
	groups = {shovel = 1}
})

core.register_craft({
    output = "sb_tools:shovel_aurem",
    recipe = {
        {"sb_minerals:aurem_ingot"},
        {"group:stick"},
		{"group:stick"},
    }
})

-- WOLFRAM
minetest.register_tool("sb_tools:shovel_wolfram", {
	description = "Wolfram Shovel",
	inventory_image = "shovel_wolfram.png",
	wield_image = "shovel_wolfram.png^[transformR90",
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level=3,
		groupcaps={
			crumbly = {
				times = {
					 [1]=0.05,  [2]=0.05,  [3]=0.05,  [4]=0.05,  [5]=0.10,
					 [6]=0.15,  [7]=0.15,  [8]=0.15,
				},
				uses=1562,
				maxlevel=4
			},
		},
		damage_groups = {fleshy=5},
	},
	sound = {breaks = "tool_breaks"},
	groups = {shovel = 1}
})

core.register_craft({
    output = "sb_tools:shovel_wolfram",
    recipe = {
        {"sb_minerals:wolfram_ingot"},
        {"group:stick"},
		{"group:stick"},
    }
})