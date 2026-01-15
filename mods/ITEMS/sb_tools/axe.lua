local mod_name = minetest.get_current_modname()
local mod_path = minetest.get_modpath(mod_name)

-- WOOD
minetest.register_tool("sb_tools:axe_wood", {
	description = "Wooden Axe",
	inventory_image = "axe_wood.png",
	tool_capabilities = {
		full_punch_interval = 1.2,
		max_drop_level=1,
		groupcaps={
			choppy = {
				times = mining.max_time(75.00, 1),
				uses=60,
				maxlevel=1
			},
		},
		damage_groups = {fleshy=4},
	},
	sound = {breaks = "tool_breaks"},
	groups = {axe = 1, axe_level_1 = 1, flammable = 2},
	on_place = function(itemstack, user, pointed_thing)
		if pointed_thing.type ~= "node" then
			return
		end
		
		local pos = pointed_thing.under
		local pname = user:get_player_name()
		
		if minetest.is_protected(pos, pname) then
			minetest.record_protection_violation(pos, pname)
			return
		end
		
		if functions.has_stripped(pos) then
			functions.strip_log(pos,user,creative_mode)
		end
	end
})

core.register_alias("axe_wood", "sb_tools:axe_wood")

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
		max_drop_level=2,
		groupcaps={
			choppy = {
				times = mining.max_time(37.50, 2),
				uses=132,
				maxlevel=2
			},
		},
		damage_groups = {fleshy=5},
	},
	sound = {breaks = "tool_breaks"},
	groups = {axe = 1, axe_level_1 = 1, axe_level_2 = 1},
	on_place = function(itemstack, user, pointed_thing)
		if pointed_thing.type ~= "node" then
			return
		end
		
		local pos = pointed_thing.under
		local pname = user:get_player_name()
		
		if minetest.is_protected(pos, pname) then
			minetest.record_protection_violation(pos, pname)
			return
		end
		
		if functions.has_stripped(pos) then
			functions.strip_log(pos,user,creative_mode)
		end
	end
})

core.register_alias("axe_stone", "sb_tools:axe_stone")

core.register_craft({
    output = "sb_tools:axe_stone",
    recipe = {
        {"group:stone", "group:stone"},
        {"group:stone", "group:stick"},
		{"", "group:stick"},
    }
})

core.register_craft({ -- why would you do this?
    output = "sb_tools:axe_stone",
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
		max_drop_level=3,
		groupcaps={
			choppy = {
				times = mining.max_time(30.00, 3),
				uses=260,
				maxlevel=3
			},
		},
		damage_groups = {fleshy=6},
	},
	sound = {breaks = "tool_breaks"},
	groups = {axe = 1, axe_level_1 = 1, axe_level_2 = 1, axe_level_3 = 1},
	on_place = function(itemstack, user, pointed_thing)
		if pointed_thing.type ~= "node" then
			return
		end
		
		local pos = pointed_thing.under
		local pname = user:get_player_name()
		
		if minetest.is_protected(pos, pname) then
			minetest.record_protection_violation(pos, pname)
			return
		end
		
		if functions.has_stripped(pos) then
			functions.strip_log(pos,user,creative_mode)
		end
	end
})

core.register_alias("axe_aereus", "sb_tools:axe_aereus")

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
		max_drop_level=3,
		groupcaps={
			choppy = {
				times = mining.max_time(25.00, 3),
				uses=250,
				maxlevel=3
			},
		},
		damage_groups = {fleshy=6},
	},
	sound = {breaks = "tool_breaks"},
	groups = {axe = 1, axe_level_1 = 1, axe_level_2 = 1, axe_level_3 = 1},
	on_place = function(itemstack, user, pointed_thing)
		if pointed_thing.type ~= "node" then
			return
		end
		
		local pos = pointed_thing.under
		local pname = user:get_player_name()
		
		if minetest.is_protected(pos, pname) then
			minetest.record_protection_violation(pos, pname)
			return
		end
		
		if functions.has_stripped(pos) then
			functions.strip_log(pos,user,creative_mode)
		end
	end
})

core.register_alias("axe_ferrum", "sb_tools:axe_ferrum")

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
				times = mining.max_time(12.50, 3),
				uses=32,
				maxlevel=3
			},
		},
		damage_groups = {fleshy=4},
	},
	sound = {breaks = "tool_breaks"},
	groups = {axe = 1, axe_level_1 = 1, axe_level_2 = 1, axe_level_3 = 1},
	on_place = function(itemstack, user, pointed_thing)
		if pointed_thing.type ~= "node" then
			return
		end
		
		local pos = pointed_thing.under
		local pname = user:get_player_name()
		
		if minetest.is_protected(pos, pname) then
			minetest.record_protection_violation(pos, pname)
			return
		end
		
		if functions.has_stripped(pos) then
			functions.strip_log(pos,user,creative_mode)
		end
	end
})

core.register_alias("axe_aurem", "sb_tools:axe_aurem")

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
		max_drop_level=4,
		groupcaps={
			choppy = {
				times = mining.max_time(19.00, 4),
				uses=1562,
				maxlevel=4
			},
		},
		damage_groups = {fleshy=7},
	},
	sound = {breaks = "tool_breaks"},
	groups = {axe = 1, axe_level_1 = 1, axe_level_2 = 1, axe_level_3 = 1, axe_level_4 = 1},
	on_place = function(itemstack, user, pointed_thing)
		if pointed_thing.type ~= "node" then
			return
		end
		
		local pos = pointed_thing.under
		local pname = user:get_player_name()
		
		if minetest.is_protected(pos, pname) then
			minetest.record_protection_violation(pos, pname)
			return
		end
		
		if functions.has_stripped(pos) then
			functions.strip_log(pos,user,creative_mode)
		end
	end
})

core.register_alias("axe_wolfram", "sb_tools:axe_wolfram")

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