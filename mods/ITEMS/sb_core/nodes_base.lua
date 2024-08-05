local mod_name = minetest.get_current_modname()
local mod_path = minetest.get_modpath(mod_name)

-- STONE
minetest.register_node("sb_core:stone", {
    description = "Stone",
    groups = { item_dirt = 1, solid = 1, suffocates = 2, oddly_breakable_by_hand = 2, cracky = 1, stone = 1},
    tiles = { "stone.png" },
    sounds = {},
})

-- DIRT
minetest.register_node("sb_core:dirt", {
    description = "Dirt",
    groups = { item_dirt = 1, solid = 1, suffocates = 2, oddly_breakable_by_hand = 2, crumbly = 1, soil = 1, dirt = 1, grass_can_grow = 1},
    tiles = { "dirt.png" },
    sounds = {},
})
-- SAND
minetest.register_node("sb_core:sand", {
    description = "Sand",
    groups = { item_sand = 1, solid = 1, falling_node = 1, suffocates = 2, oddly_breakable_by_hand = 2, crumbly = 1, soil = 1, sand = 1},
    tiles = { "sand.png" },
    sounds = {},
})

-- GRASS BLOCK
minetest.register_node("sb_core:grass", {
    description = "Grass Dirt",
    groups = { item_grass = 1, solid = 1, suffocates = 2, topsoil = 1, oddly_breakable_by_hand = 2, crumbly = 1, soil = 1, dirt = 1, spreads_to_dirt = 1, },
    tiles = {
        "grass_dirt.png",
        "dirt.png",
        "dirt.png^grass_dirt_side.png",
    },
    drop = "sb_core:dirt",
    sounds = {},
})
