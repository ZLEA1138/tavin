local mod_name = minetest.get_current_modname()
local mod_path = minetest.get_modpath(mod_name)
local S = minetest.get_translator(mod_name)

-- DIRT
minetest.register_node("nabm_soil:dirt", {
    description = S("Dirt"),
    groups = { item_dirt = 1, solid = 1, suffocates = 2, oddly_breakable_by_hand = 2, crumbly = 1, soil = 1, dirt = 1, grass_can_grow = 1},
    tiles = { "dirt.png" },
    sounds = {},
})
-- SAND
minetest.register_node("nabm_soil:sand", {
    description = S("Sand"),
    groups = { item_sand = 1, solid = 1, falling_node = 1, suffocates = 2, oddly_breakable_by_hand = 2, crumbly = 1, soil = 1, sand = 1},
    tiles = { "sand.png" },
    sounds = {},
})

-- GRASS BLOCK
minetest.register_node("nabm_soil:grass", {
    description = S("Dirt with Grass"),
    groups = { item_grass = 1, solid = 1, suffocates = 2, topsoil = 1, oddly_breakable_by_hand = 2, crumbly = 1, soil = 1, dirt = 1, spreads_to_dirt = 1, },
    tiles = {
        "grass_dirt.png",
        "dirt.png",
        "grass_dirt_side.png",
    },
    drop = "nabm_soil:dirt",
    sounds = {},
})
