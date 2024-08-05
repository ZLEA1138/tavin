local mod_name = minetest.get_current_modname()
local mod_path = minetest.get_modpath(mod_name)
local S = minetest.get_translator(mod_name)

-- STONE
minetest.register_node("nabm_stone:stone", {
    description = S("Stone"),
    groups = { item_dirt = 1, solid = 1, suffocates = 2, oddly_breakable_by_hand = 2, cracky = 1, stone = 1},
    tiles = { "stone.png" },
    sounds = {},
})
