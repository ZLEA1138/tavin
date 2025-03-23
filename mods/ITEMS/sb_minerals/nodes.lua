local mod_name = minetest.get_current_modname()
local mod_path = minetest.get_modpath(mod_name)

-- AEREUS
minetest.register_node("sb_minerals:aereus_block", {
	description = "Block of Aereus",
	tiles = {"aereus_block.png"},
	is_ground_content = false,
	groups = {cracky = 10, level = 2},
	sounds = sounds.node_sound_stone_defaults(),
})

core.register_craft({
    output = "sb_minerals:aereus_block",
    recipe = {
        {"sb_minerals:aereus_ingot", "sb_minerals:aereus_ingot", "sb_minerals:aereus_ingot"},
        {"sb_minerals:aereus_ingot", "sb_minerals:aereus_ingot", "sb_minerals:aereus_ingot"},
        {"sb_minerals:aereus_ingot", "sb_minerals:aereus_ingot", "sb_minerals:aereus_ingot"}
    }
})

core.register_craft({
    output = "sb_minerals:aereus_ingot 9",
    recipe = {
        {"sb_minerals:aereus_block"}
    }
})

-- AUREM
minetest.register_node("sb_minerals:aurem_block", {
	description = "Block of Aurem",
	tiles = {"aurem_block.png"},
	is_ground_content = false,
	groups = {cracky = 9, level = 3},
	sounds = sounds.node_sound_stone_defaults(),
})

core.register_craft({
    output = "sb_minerals:aurem_block",
    recipe = {
        {"sb_minerals:aurem_ingot", "sb_minerals:aurem_ingot", "sb_minerals:aurem_ingot"},
        {"sb_minerals:aurem_ingot", "sb_minerals:aurem_ingot", "sb_minerals:aurem_ingot"},
        {"sb_minerals:aurem_ingot", "sb_minerals:aurem_ingot", "sb_minerals:aurem_ingot"}
    }
})

core.register_craft({
    output = "sb_minerals:aurem_ingot 9",
    recipe = {
        {"sb_minerals:aurem_block"}
    }
})

-- COAL
minetest.register_node("sb_minerals:coal_block", {
	description = "Block of Coal",
	tiles = {"coal_block.png"},
	is_ground_content = false,
	groups = {cracky = 11},
	sounds = sounds.node_sound_stone_defaults(),
})

core.register_craft({
    output = "sb_minerals:coal_block",
    recipe = {
        {"sb_minerals:coal", "sb_minerals:coal", "sb_minerals:coal"},
        {"sb_minerals:coal", "sb_minerals:coal", "sb_minerals:coal"},
        {"sb_minerals:coal", "sb_minerals:coal", "sb_minerals:coal"}
    }
})

core.register_craft({
    output = "sb_minerals:coal 9",
    recipe = {
        {"sb_minerals:coal_block"}
    }
})

-- CUPRUM
minetest.register_node("sb_minerals:cuprum_block", {
	description = "Block of Cuprum",
	tiles = {"cuprum_block.png"},
	is_ground_content = false,
	groups = {cracky = 9, level = 2},
	sounds = sounds.node_sound_stone_defaults(),
})

core.register_craft({
    output = "sb_minerals:cuprum_block",
    recipe = {
        {"sb_minerals:cuprum_ingot", "sb_minerals:cuprum_ingot", "sb_minerals:cuprum_ingot"},
        {"sb_minerals:cuprum_ingot", "sb_minerals:cuprum_ingot", "sb_minerals:cuprum_ingot"},
        {"sb_minerals:cuprum_ingot", "sb_minerals:cuprum_ingot", "sb_minerals:cuprum_ingot"}
    }
})

core.register_craft({
    output = "sb_minerals:cuprum_ingot 9",
    recipe = {
        {"sb_minerals:cuprum_block"}
    }
})

-- FERRUM
minetest.register_node("sb_minerals:ferrum_block", {
	description = "Block of Ferrum",
	tiles = {"ferrum_block.png"},
	is_ground_content = false,
	groups = {cracky = 11, level = 2},
	sounds = sounds.node_sound_stone_defaults(),
})

core.register_craft({
    output = "sb_minerals:ferrum_block",
    recipe = {
        {"sb_minerals:ferrum_ingot", "sb_minerals:ferrum_ingot", "sb_minerals:ferrum_ingot"},
        {"sb_minerals:ferrum_ingot", "sb_minerals:ferrum_ingot", "sb_minerals:ferrum_ingot"},
        {"sb_minerals:ferrum_ingot", "sb_minerals:ferrum_ingot", "sb_minerals:ferrum_ingot"}
    }
})

core.register_craft({
    output = "sb_minerals:ferrum_ingot 9",
    recipe = {
        {"sb_minerals:ferrum_block"}
    }
})

-- STANNUM
minetest.register_node("sb_minerals:stannum_block", {
	description = "Block of Stannum",
	tiles = {"stannum_block.png"},
	is_ground_content = false,
	groups = {cracky = 9, level = 2},
	sounds = sounds.node_sound_stone_defaults(),
})

core.register_craft({
    output = "sb_minerals:stannum_block",
    recipe = {
        {"sb_minerals:stannum_ingot", "sb_minerals:stannum_ingot", "sb_minerals:stannum_ingot"},
        {"sb_minerals:stannum_ingot", "sb_minerals:stannum_ingot", "sb_minerals:stannum_ingot"},
        {"sb_minerals:stannum_ingot", "sb_minerals:stannum_ingot", "sb_minerals:stannum_ingot"}
    }
})

core.register_craft({
    output = "sb_minerals:stannum_ingot 9",
    recipe = {
        {"sb_minerals:stannum_block"}
    }
})

-- URAN
minetest.register_node("sb_minerals:uran_block", {
	description = "Block of Uran",
	tiles = {"uran_block.png"},
	is_ground_content = false,
	groups = {cracky = 11, level = 3},
	sounds = sounds.node_sound_stone_defaults(),
})

core.register_craft({
    output = "sb_minerals:uran_block",
    recipe = {
        {"sb_minerals:uran_ingot", "sb_minerals:uran_ingot", "sb_minerals:uran_ingot"},
        {"sb_minerals:uran_ingot", "sb_minerals:uran_ingot", "sb_minerals:uran_ingot"},
        {"sb_minerals:uran_ingot", "sb_minerals:uran_ingot", "sb_minerals:uran_ingot"}
    }
})

core.register_craft({
    output = "sb_minerals:uran_ingot 9",
    recipe = {
        {"sb_minerals:uran_block"}
    }
})

-- WOLFRAM
minetest.register_node("sb_minerals:wolfram_block", {
	description = "Block of Wolfram",
	tiles = {"wolfram_block.png"},
	is_ground_content = false,
	groups = {cracky = 11, level = 3},
	sounds = sounds.node_sound_stone_defaults(),
})

core.register_craft({
    output = "sb_minerals:wolfram_block",
    recipe = {
        {"sb_minerals:wolfram_ingot", "sb_minerals:wolfram_ingot", "sb_minerals:wolfram_ingot"},
        {"sb_minerals:wolfram_ingot", "sb_minerals:wolfram_ingot", "sb_minerals:wolfram_ingot"},
        {"sb_minerals:wolfram_ingot", "sb_minerals:wolfram_ingot", "sb_minerals:wolfram_ingot"}
    }
})

core.register_craft({
    output = "sb_minerals:wolfram_ingot 9",
    recipe = {
        {"sb_minerals:wolfram_block"}
    }
})