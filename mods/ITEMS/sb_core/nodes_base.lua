local mod_name = minetest.get_current_modname()
local mod_path = minetest.get_modpath(mod_name)

-- STONE
minetest.register_node("sb_core:stone", {
    description = "Stone",
    tiles = {"stone.png"},
	is_ground_content = true,
    groups = {cracky = 6, stone = 1},
	drop = "sb_core:cobble",
    sounds = sounds.node_sound_stone_defaults(),
})

core.register_craft({
    type = "cooking",
    output = "sb_core:stone",
    recipe = "sb_core:cobble",
    cooktime = 10,
})

core.register_craft({
    type = "cooking",
    output = "sb_core:stone",
    recipe = "sb_core:cobble_mossy",
    cooktime = 10,
})

-- COBBLESTONE
minetest.register_node("sb_core:cobble", {
	description = "Cobblestone",
	tiles = {"cobble.png"},
	is_ground_content = false,
	groups = {cracky = 7, stone = 2},
	sounds = sounds.node_sound_stone_defaults(),
})

minetest.register_node("sb_core:cobble_mossy", {
	description = "Mossy Cobblestone",
	tiles = {"cobble_mossy.png"},
	is_ground_content = false,
	groups = {cracky = 7, stone = 1},
	sounds = sounds.node_sound_stone_defaults(),
})

-- SMOOTH STONE
minetest.register_node("sb_core:stone_smooth", {
	description = "Smooth Stone",
	tiles = {"stone_smooth.png"},
	is_ground_content = false,
	groups = {cracky = 7, stone = 1},
	sounds = sounds.node_sound_stone_defaults(),
})

core.register_craft({
    type = "cooking",
    output = "sb_core:stone_smooth",
    recipe = "sb_core:stone",
    cooktime = 10,
})

-- STONE BRICK
minetest.register_node("sb_core:stone_bricks", {
	description = "Stone Bricks",
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"stone_bricks.png"},
	is_ground_content = false,
	groups = {cracky = 6, stone = 1},
	sounds = sounds.node_sound_stone_defaults(),
})

core.register_craft({
    output = "sb_core:stone_bricks 4",
    recipe = {
        {"sb_core:stone", "sb_core:stone"},
        {"sb_core:stone", "sb_core:stone"}
    }
})

minetest.register_node("sb_core:stone_bricks_mossy", {
	description = "Mossy Stone Bricks",
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"stone_bricks_mossy.png"},
	is_ground_content = false,
	groups = {cracky = 6, stone = 1},
	sounds = sounds.node_sound_stone_defaults(),
})

-- DIRT
minetest.register_node("sb_core:dirt", {
    description = "Dirt",
    tiles = {"dirt.png"},
	is_ground_content = true,
    groups = {crumbly = 5, oddly_breakable_by_hand = 8, soil = 1, grass_can_grow = 1, pathable = 1},
	soil = {
		base = "sb_core:dirt",
		dry = "sb_farming:soil",
		wet = "sb_farming:soil_wet"
	},
    sounds = sounds.node_sound_dirt_defaults(),
})

-- DRY DIRT
minetest.register_node("sb_core:dirt_dry", {
	description = "Dry Dirt",
	tiles = {"dirt_dry.png"},
	is_ground_content = true,
	groups = {crumbly = 5, oddly_breakable_by_hand = 8},
	sounds = sounds.node_sound_dirt_defaults(),
})

-- SCORCHED DIRT
minetest.register_node("sb_core:dirt_scorched", {
	description = "Scorched Dirt",
	tiles = {"dirt_scorched.png"},
	is_ground_content = true,
	groups = {crumbly = 8, oddly_breakable_by_hand = 11},
	sounds = sounds.node_sound_gravel_defaults(),
})

-- GRASS BLOCKS
minetest.register_node("sb_core:dirt_grass_forest", {
    description = "Forest Grass Block",
    tiles = {
        "dirt_grass_forest.png",
        "dirt.png",
        "dirt.png^dirt_grass_forest_side.png",
    },
	is_ground_content = true,
    groups = {crumbly = 6, oddly_breakable_by_hand = 9, soil = 1, spreads_to_dirt = 1, pathable = 1},
	soil = {
		base = "sb_core:dirt_grass_forest",
		dry = "sb_farming:soil",
		wet = "sb_farming:soil_wet"
	},
    drop = "sb_core:dirt",
    sounds = sounds.node_sound_dirt_defaults(),
})

minetest.register_node("sb_core:dirt_mycelium", {
    description = "Mycelium Block",
    tiles = {
        "dirt_mycelium.png",
        "dirt.png",
        "dirt.png^dirt_mycelium_side.png",
    },
	is_ground_content = true,
	groups = {crumbly = 6, oddly_breakable_by_hand = 9, soil = 1, spreads_to_dirt = 1, pathable = 1},
	soil = {
		base = "sb_core:dirt_mycelium",
		dry = "sb_farming:soil",
		wet = "sb_farming:soil_wet"
	},
    drop = "sb_core:dirt",
    sounds = sounds.node_sound_dirt_defaults(),
})

minetest.register_node("sb_core:dirt_grass_plains", {
    description = "Plains Grass Block",
    tiles = {
        "dirt_grass_plains.png",
        "dirt.png",
        "dirt.png^dirt_grass_plains_side.png",
    },
	is_ground_content = true,
    groups = {crumbly = 6, oddly_breakable_by_hand = 9, soil = 1, spreads_to_dirt = 1, pathable = 1},
	soil = {
		base = "sb_core:dirt_grass_plains",
		dry = "sb_farming:soil",
		wet = "sb_farming:soil_wet"
	},
    drop = "sb_core:dirt",
    sounds = sounds.node_sound_dirt_defaults(),
})

minetest.register_node("sb_core:dirt_grass_prairie", {
    description = "Prairie Grass Block",
    tiles = {
        "dirt_grass_prairie.png",
        "dirt.png",
        "dirt.png^dirt_grass_prairie_side.png",
    },
	is_ground_content = true,
    groups = {crumbly = 6, oddly_breakable_by_hand = 9, soil = 1, spreads_to_dirt = 1, pathable = 1},
	soil = {
		base = "sb_core:dirt_grass_prairie",
		dry = "sb_farming:soil",
		wet = "sb_farming:soil_wet"
	},
    drop = "sb_core:dirt",
    sounds = sounds.node_sound_dirt_defaults(),
})

minetest.register_node("sb_core:dirt_grass_savanna", {
    description = "Savanna Grass Block",
    tiles = {
        "dirt_grass_savanna.png",
        "dirt.png",
        "dirt.png^dirt_grass_savanna_side.png",
    },
	is_ground_content = true,
    groups = {crumbly = 6, oddly_breakable_by_hand = 9, soil = 1, spreads_to_dirt = 1, pathable = 1},
	soil = {
		base = "sb_core:dirt_grass_savanna",
		dry = "sb_farming:soil",
		wet = "sb_farming:soil_wet"
	},
    drop = "sb_core:dirt",
    sounds = sounds.node_sound_dirt_defaults(),
})

minetest.register_node("sb_core:dirt_grass_snow", {
    description = "Snowy Grass Block",
    tiles = {
        "snow.png",
        "dirt.png",
        "dirt.png^snow_side.png",
    },
	is_ground_content = true,
    groups = {crumbly = 6, oddly_breakable_by_hand = 9, soil = 1, spreads_to_dirt = 1, pathable = 1},
	soil = {
		base = "sb_core:dirt_grass_snow",
		dry = "sb_farming:soil",
		wet = "sb_farming:soil_wet"
	},
    drop = "sb_core:dirt",
    sounds = sounds.node_sound_dirt_defaults(),
})

minetest.register_node("sb_core:dirt_grass_swamp", {
    description = "Swamp Grass Block",
    tiles = {
        "dirt_grass_swamp.png",
        "dirt.png",
        "dirt.png^dirt_grass_swamp_side.png",
    },
	is_ground_content = true,
    groups = {crumbly = 6, oddly_breakable_by_hand = 9, soil = 1, spreads_to_dirt = 1, pathable = 1},
	soil = {
		base = "sb_core:dirt_grass_swamp",
		dry = "sb_farming:soil",
		wet = "sb_farming:soil_wet"
	},
    drop = "sb_core:dirt",
    sounds = sounds.node_sound_dirt_defaults(),
})

-- DIRT PATH
minetest.register_node("sb_core:dirt_path", {
    description = "Dirt Path",
    tiles = {
        "dirt_path.png",
        "dirt.png",
        "dirt.png^dirt_path_side.png",
    },
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			-- 15/16 of the normal height
			{-0.5, -0.5, -0.5, 0.5, 0.4375, 0.5},
		}
	},
	is_ground_content = true,
    groups = {crumbly = 6, oddly_breakable_by_hand = 9, dirtifies_below_solid = 1},
    drop = "sb_core:dirt",
    sounds = sounds.node_sound_dirt_defaults(),
})

-- MUD
minetest.register_node("sb_core:mud", {
    description = "Mud",
    tiles = {"mud.png"},
	is_ground_content = true,
    groups = {crumbly = 5, oddly_breakable_by_hand = 8},
    sounds = sounds.node_sound_dirt_defaults(),
})

-- PACKED MUD (WIP crafting recipe)
minetest.register_node("sb_core:mud_packed", {
    description = "Packed Mud",
    tiles = {"mud_packed.png"},
	is_ground_content = false,
    groups = {cracky = 4},
    sounds = sounds.node_sound_dirt_defaults(),
})

-- MUD BRICKS
minetest.register_node("sb_core:mud_bricks", {
    description = "Mud Bricks",
    tiles = {"mud_bricks.png"},
	is_ground_content = false,
    groups = {cracky = 6},
    sounds = sounds.node_sound_dirt_defaults(),
})

core.register_craft({
    output = "sb_core:mud_bricks",
    recipe = {
        {"sb_core:mud_packed", "sb_core:mud_packed"},
        {"sb_core:mud_packed", "sb_core:mud_packed"}
    }
})

-- SAND
minetest.register_node("sb_core:sand", {
    description = "Sand",
    tiles = {"sand.png"},
	is_ground_content = true,
    groups = {crumbly = 5, oddly_breakable_by_hand = 8, falling_node = 1, sand = 1},
    sounds = sounds.node_sound_sand_defaults(),
})

-- DESERT SAND
minetest.register_node("sb_core:sand_desert", {
    description = "Desert Sand",
    tiles = {"sand_desert.png"},
	is_ground_content = true,
    groups = {crumbly = 5, oddly_breakable_by_hand = 8, falling_node = 1, sand = 1},
    sounds = sounds.node_sound_sand_defaults(),
})

-- SANDSTONE
minetest.register_node("sb_core:sandstone", {
    description = "Sandstone",
    tiles = {"sandstone.png"},
	is_ground_content = true,
    groups = {cracky = 3},
    sounds = sounds.node_sound_stone_defaults(),
})

core.register_craft({
    output = "sb_core:sandstone",
    recipe = {
        {"sb_core:sand", "sb_core:sand"},
        {"sb_core:sand", "sb_core:sand"}
    }
})

-- DESERT SANDSTONE
minetest.register_node("sb_core:sandstone_desert", {
    description = "Desert Sandstone",
    tiles = {"sandstone_desert.png"},
	is_ground_content = true,
    groups = {cracky = 3},
    sounds = sounds.node_sound_stone_defaults(),
})

core.register_craft({
    output = "sb_core:sandstone_desert",
    recipe = {
        {"sb_core:sand_desert", "sb_core:sand_desert"},
        {"sb_core:sand_desert", "sb_core:sand_desert"}
    }
})

-- SMOOTH SANDSTONE
minetest.register_node("sb_core:sandstone_smooth", {
    description = "Smooth Sandstone",
    tiles = {"sandstone_smooth.png"},
	is_ground_content = true,
    groups = {cracky = 7},
    sounds = sounds.node_sound_stone_defaults(),
})

core.register_craft({
    type = "cooking",
    output = "sb_core:sandstone_smooth",
    recipe = "sb_core:sandstone",
    cooktime = 10,
})

-- SMOOTH DESERT SANDSTONE
minetest.register_node("sb_core:sandstone_smooth_desert", {
    description = "Smooth Desert Sandstone",
    tiles = {"sandstone_smooth_desert.png"},
	is_ground_content = true,
    groups = {cracky = 7},
    sounds = sounds.node_sound_stone_defaults(),
})

core.register_craft({
    type = "cooking",
    output = "sb_core:sandstone_smooth_desert",
    recipe = "sb_core:sandstone_desert",
    cooktime = 10,
})

-- SANDSTONE BRICKS
minetest.register_node("sb_core:sandstone_bricks", {
    description = "Sandstone Bricks",
    tiles = {"sandstone_bricks.png"},
	is_ground_content = true,
    groups = {cracky = 3},
    sounds = sounds.node_sound_stone_defaults(),
})

core.register_craft({
    output = "sb_core:sandstone_bricks 4",
    recipe = {
        {"sb_core:sandstone", "sb_core:sandstone"},
        {"sb_core:sandstone", "sb_core:sandstone"}
    }
})

-- DESERT SANDSTONE BRICKS
minetest.register_node("sb_core:sandstone_bricks_desert", {
    description = "Desert Sandstone Bricks",
    tiles = {"sandstone_bricks_desert.png"},
	is_ground_content = true,
    groups = {cracky = 3},
    sounds = sounds.node_sound_stone_defaults(),
})

core.register_craft({
    output = "sb_core:sandstone_bricks_desert 4",
    recipe = {
        {"sb_core:sandstone_desert", "sb_core:sandstone_desert"},
        {"sb_core:sandstone_desert", "sb_core:sandstone_desert"}
    }
})

-- GRAVEL
minetest.register_node("sb_core:gravel", {
	description = "Gravel",
	tiles = {"gravel.png"},
	is_ground_content = true,
	groups = {crumbly = 6, oddly_breakable_by_hand = 9, falling_node = 1},
	drop = {
		max_items = 1,
		items = {
			{items = {"sb_core:flint"}, rarity = 16},
			{items = {"sb_core:gravel"}}
		}
	},
	sounds = sounds.node_sound_gravel_defaults(),
})

-- OBSIDIAN
minetest.register_node("sb_core:obsidian", {
	description = "Obsidian",
	tiles = {"obsidian.png"},
	is_ground_content = false,
	groups = {cracky = 14, level = 4},
	sounds = sounds.node_sound_stone_defaults(),
})

-- OBSIDIAN BRICK
minetest.register_node("sb_core:obsidian_bricks", {
	description = "Obsidian Bricks",
	tiles = {"obsidian_bricks.png"},
	is_ground_content = false,
	groups = {cracky = 14, level = 4},
	sounds = sounds.node_sound_stone_defaults(),
})

core.register_craft({
    output = "sb_core:obsidian_bricks 4",
    recipe = {
        {"sb_core:obsidian", "sb_core:obsidian"},
        {"sb_core:obsidian", "sb_core:obsidian"}
    }
})

-- CLAY
minetest.register_node("sb_core:clay", {
	description = "Clay",
	tiles = {"clay.png"},
	is_ground_content = true,
	groups = {crumbly = 6, oddly_breakable_by_hand = 9},
	drop = "sb_core:clay_lump 4",
	sounds = sounds.node_sound_dirt_defaults(),
})

core.register_craft({
    output = "sb_core:clay",
    recipe = {
        {"sb_core:clay_lump", "sb_core:clay_lump"},
        {"sb_core:clay_lump", "sb_core:clay_lump"}
    }
})

-- BRICKS
minetest.register_node("sb_core:bricks", {
	description = "Bricks",
	tiles = {
		"bricks.png^[transformFX",
		"bricks.png",
	},
	is_ground_content = false,
	groups = {cracky = 7},
	sounds = sounds.node_sound_stone_defaults(),
})

core.register_craft({
    output = "sb_core:bricks",
    recipe = {
        {"sb_core:brick", "sb_core:brick"},
        {"sb_core:brick", "sb_core:brick"}
    }
})