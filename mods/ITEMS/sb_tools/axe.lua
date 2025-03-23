local mod_name = minetest.get_current_modname()
local mod_path = minetest.get_modpath(mod_name)

-- WOOD
minetest.register_tool("sb_tools:axe_wood", {
	description = "Wooden Axe",
	inventory_image = "axe_wood.png",
	tool_capabilities = {
		full_punch_interval = 1.2,
		max_drop_level=0,
		groupcaps={
			choppy = {
				times = {
					 [1]=0.05,  [2]=0.10,  [3]=0.15,  [4]=0.25,  [5]=0.30,
					 [6]=0.40,  [7]=0.45,  [8]=0.55,  [9]=0.60, [10]=0.75,
					[11]=1.15, [12]=1.50, [13]=1.90, [14]=2.25,
				},
				uses=60,
				maxlevel=1
			},
		},
		damage_groups = {fleshy=4},
	},
	sound = {breaks = "tool_breaks"},
	groups = {axe = 1, flammable = 2}
})

core.register_craft({
    output = "sb_tools:axe_wood",
    recipe = {
        {"group:planks", "group:planks"},
        {"group:planks", "group:stick"},
		{"", "group:stick"},
    }
})

core.register_craft({ -- why would you do this?
    output = "sb_tools:axe_wood",
    recipe = {
        {"group:planks", "group:planks"},
        {"group:stick", "group:planks"},
		{"group:stick", ""},
    }
})

core.register_craft({
    type = "fuel",
    recipe = "sb_tools:axe_wood",
    burntime = 10,
})

-- STONE
minetest.register_tool("sb_tools:axe_stone", {
	description = "Stone Axe",
	inventory_image = "axe_stone.png",
	tool_capabilities = {
		full_punch_interval = 1.3,
		max_drop_level=0,
		groupcaps={
			choppy = {
				times = {
					 [1]=0.05,  [2]=0.05,  [3]=0.10,  [4]=0.15,  [5]=0.15,
					 [6]=0.20,  [7]=0.25,  [8]=0.30,  [9]=0.30, [10]=0.40,
					[11]=0.60, [12]=0.75, [13]=0.95, [14]=1.15,
				},
				uses=132,
				maxlevel=2
			},
		},
		damage_groups = {fleshy=5},
	},
	sound = {breaks = "tool_breaks"},
	groups = {axe = 1}
})

core.register_craft({
    output = "sb_tools:pick_stone",
    recipe = {
        {"group:stone", "group:stone"},
        {"group:stone", "group:stick"},
		{"", "group:stick"},
    }
})

core.register_craft({ -- why would you do this?
    output = "sb_tools:pick_stone",
    recipe = {
        {"group:stone", "group:stone"},
        {"group:stick", "group:stone"},
		{"group:stick", ""},
    }
})

-- AEREUS
minetest.register_tool("sb_tools:axe_aereus", {
	description = "Aereus Axe",
	inventory_image = "axe_aereus.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		groupcaps={
			choppy = {
				times = {
					 [1]=0.05,  [2]=0.05,  [3]=0.05,  [4]=0.10,  [5]=0.10,
					 [6]=0.15,  [7]=0.20,  [8]=0.25,  [9]=0.25, [10]=0.30,
					[11]=0.50, [12]=0.60, [13]=0.80, [14]=0.95,
				},
				uses=260,
				maxlevel=3
			},
		},
		damage_groups = {fleshy=6},
	},
	sound = {breaks = "tool_breaks"},
	groups = {axe = 1}
})

core.register_craft({
    output = "sb_tools:axe_aereus",
    recipe = {
        {"sb_minerals:aereus_ingot", "group:sb_minerals:aereus_ingot"},
        {"sb_minerals:aereus_ingot", "group:stick"},
		{"", "group:stick"},
    }
})

core.register_craft({ -- why would you do this?
    output = "sb_tools:axe_aereus",
    recipe = {
        {"sb_minerals:aereus_ingot", "sb_minerals:aereus_ingot"},
        {"group:stick", "sb_minerals:aereus_ingot"},
		{"group:stick", ""},
    }
})

-- FERRUM
minetest.register_tool("sb_tools:axe_ferrum", {
	description = "Ferrum Axe",
	inventory_image = "axe_ferrum.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		groupcaps={
			choppy = {
				times = {
					 [1]=0.05,  [2]=0.05,  [3]=0.05,  [4]=0.10,  [5]=0.10,
					 [6]=0.15,  [7]=0.15,  [8]=0.20,  [9]=0.20, [10]=0.25,
					[11]=0.40, [12]=0.50, [13]=0.65, [14]=0.75,
				},
				uses=250,
				maxlevel=3
			},
		},
		damage_groups = {fleshy=6},
	},
	sound = {breaks = "tool_breaks"},
	groups = {axe = 1}
})

core.register_craft({
    output = "sb_tools:axe_ferrum",
    recipe = {
        {"sb_minerals:ferrum_ingot", "group:sb_minerals:ferrum_ingot"},
        {"sb_minerals:ferrum_ingot", "group:stick"},
		{"", "group:stick"},
    }
})

core.register_craft({ -- why would you do this?
    output = "sb_tools:axe_ferrum",
    recipe = {
        {"sb_minerals:ferrum_ingot", "sb_minerals:ferrum_ingot"},
        {"group:stick", "sb_minerals:ferrum_ingot"},
		{"group:stick", ""},
    }
})

-- AUREM
minetest.register_tool("sb_tools:axe_aurem", {
	description = "Aurem Axe",
	inventory_image = "axe_aurem.png",
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level=3,
		groupcaps={
			choppy = {
				times = {
					 [1]=0.05,  [2]=0.05,  [3]=0.05,  [4]=0.05,  [5]=0.05,
					 [6]=0.10,  [7]=0.10,  [8]=0.10,  [9]=0.10, [10]=0.15,
					[11]=0.20, [12]=0.25, [13]=0.35, [14]=0.40,
				},
				uses=32,
				maxlevel=3
			},
		},
		damage_groups = {fleshy=4},
	},
	sound = {breaks = "tool_breaks"},
	groups = {axe = 1}
})

core.register_craft({
    output = "sb_tools:axe_aurem",
    recipe = {
        {"sb_minerals:aurem_ingot", "group:sb_minerals:aurem_ingot"},
        {"sb_minerals:aurem_ingot", "group:stick"},
		{"", "group:stick"},
    }
})

core.register_craft({ -- why would you do this?
    output = "sb_tools:axe_aurem",
    recipe = {
        {"sb_minerals:aurem_ingot", "sb_minerals:aurem_ingot"},
        {"group:stick", "sb_minerals:aurem_ingot"},
		{"group:stick", ""},
    }
})

-- WOLFRAM
minetest.register_tool("sb_tools:axe_wolfram", {
	description = "Wolfram Axe",
	inventory_image = "axe_wolfram.png",
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level=3,
		groupcaps={
			choppy = {
				times = {
					 [1]=0.05,  [2]=0.05,  [3]=0.05,  [4]=0.10,  [5]=0.10,
					 [6]=0.10,  [7]=0.15,  [8]=0.15,  [9]=0.15, [10]=0.20,
					[11]=0.30, [12]=0.40, [13]=0.50, [14]=0.60,
				},
				uses=1562,
				maxlevel=4
			},
		},
		damage_groups = {fleshy=7},
	},
	sound = {breaks = "tool_breaks"},
	groups = {axe = 1}
})

core.register_craft({
    output = "sb_tools:axe_wolfram",
    recipe = {
        {"sb_minerals:wolfram_ingot", "group:sb_minerals:wolfram_ingot"},
        {"sb_minerals:wolfram_ingot", "group:stick"},
		{"", "group:stick"},
    }
})

core.register_craft({ -- why would you do this?
    output = "sb_tools:axe_wolfram",
    recipe = {
        {"sb_minerals:wolfram_ingot", "sb_minerals:wolfram_ingot"},
        {"group:stick", "sb_minerals:wolfram_ingot"},
		{"group:stick", ""},
    }
})