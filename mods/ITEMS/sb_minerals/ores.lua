local mod_name = minetest.get_current_modname()
local mod_path = minetest.get_modpath(mod_name)

-- ADAMAS
minetest.register_node("sb_minerals:stone_ore_adamas", {
	description = "Adamas Ore",
	tiles = {"stone.png^ore_adamas.png"},
	is_ground_content = true,
	groups = {cracky = 9, level = 3},
	drop = {
		max_items = 1,
		items = {
			{items = {"sb_minerals:adamas_crystal_blue"}},
			{items = {"sb_minerals:adamas_crystal_green"}},
			{items = {"sb_minerals:adamas_crystal_yellow"}},
			{items = {"sb_minerals:adamas_crystal_red"}},
			{items = {"sb_minerals:adamas_crystal_purple"}, rarity = 16},
		}
	},
	sounds = {},
})

-- AUREM
minetest.register_node("sb_minerals:stone_ore_aurem", {
	description = "Aurem Ore",
	tiles = {"stone.png^ore_aurem.png"},
	is_ground_content = true,
	groups = {cracky = 9, level = 3},
	drop = "sb_minerals:aurem_raw",
	sounds = {},
})

-- COAL
minetest.register_node("sb_minerals:stone_ore_coal", {
	description = "Coal Ore",
	tiles = {"stone.png^ore_coal.png"},
	is_ground_content = true,
	groups = {cracky = 9},
	drop = "sb_minerals:coal",
	sounds = {},
})

-- CUPRUM
minetest.register_node("sb_minerals:stone_ore_cuprum", {
	description = "Cuprum Ore",
	tiles = {"stone.png^ore_cuprum.png"},
	is_ground_content = true,
	groups = {cracky = 9, level = 2},
	drop = "sb_minerals:cuprum_raw",
	sounds = {},
})

-- FERRUM
minetest.register_node("sb_minerals:stone_ore_ferrum", {
	description = "Ferrum Ore",
	tiles = {"stone.png^ore_ferrum.png"},
	is_ground_content = true,
	groups = {cracky = 9, level = 2},
	drop = "sb_minerals:ferrum_raw",
	sounds = {},
})

-- STANNUM
minetest.register_node("sb_minerals:stone_ore_stannum", {
	description = "Stannum Ore",
	tiles = {"stone.png^ore_stannum.png"},
	is_ground_content = true,
	groups = {cracky = 9, level = 2},
	drop = "sb_minerals:stannum_raw",
	sounds = {},
})

-- URAN
minetest.register_node("sb_minerals:stone_ore_uran", {
	description = "Uran Ore",
	tiles = {"stone.png^ore_uran.png"},
	is_ground_content = true,
	groups = {cracky = 9, level = 3},
	drop = "sb_minerals:uran_raw",
	sounds = {},
})

-- WOLFRAM
minetest.register_node("sb_minerals:stone_ore_wolfram", {
	description = "Wolfram Ore",
	tiles = {"stone.png^ore_wolfram.png"},
	is_ground_content = true,
	groups = {cracky = 9, level = 3},
	drop = "sb_minerals:wolfram_raw",
	sounds = {},
})