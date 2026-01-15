local mod_name = minetest.get_current_modname()
local mod_path = minetest.get_modpath(mod_name)

-- ADAMAS CRYSTAL
minetest.register_craftitem("sb_minerals:adamas_crystal_blue", {
	description = "Blue Adamas Crystal",
	inventory_image = "adamas_crystal_blue.png"
})

core.register_alias("adamas_crystal_blue", "sb_minerals:adamas_crystal_blue")

minetest.register_craftitem("sb_minerals:adamas_crystal_green", {
	description = "Green Adamas Crystal",
	inventory_image = "adamas_crystal_green.png"
})

core.register_alias("adamas_crystal_green", "sb_minerals:adamas_crystal_green")

minetest.register_craftitem("sb_minerals:adamas_crystal_purple", {
	description = "Purple Adamas Crystal",
	inventory_image = "adamas_crystal_purple.png"
})

core.register_alias("adamas_crystal_purple", "sb_minerals:adamas_crystal_purple")

minetest.register_craftitem("sb_minerals:adamas_crystal_red", {
	description = "Red Adamas Crystal",
	inventory_image = "adamas_crystal_red.png"
})

core.register_alias("adamas_crystal_red", "sb_minerals:adamas_crystal_red")

minetest.register_craftitem("sb_minerals:adamas_crystal_yellow", {
	description = "Yellow Adamas Crystal",
	inventory_image = "adamas_crystal_yellow.png"
})

core.register_alias("adamas_crystal_yellow", "sb_minerals:adamas_crystal_yellow")

core.register_craft({
    type = "cooking",
    output = "sb_minerals:adamas_crystal_blue",
    recipe = "sb_minerals:stone_ore_adamas",
    cooktime = 10,
})

-- AEREUS
minetest.register_craftitem("sb_minerals:aereus_ingot", {
	description = "Aereus Ingot",
	inventory_image = "aereus_ingot.png"
})

core.register_alias("aereus_ingot", "sb_minerals:aereus_ingot")

core.register_craft({
    type = "shapeless",
    output = "sb_minerals:aereus_ingot 4",
    recipe = {
        "sb_minerals:cuprum_ingot",
        "sb_minerals:cuprum_ingot",
        "sb_minerals:cuprum_ingot",
		"sb_minerals:stannum_ingot",
    },
})

-- AUREM
minetest.register_craftitem("sb_minerals:aurem_raw", {
	description = "Raw Aurem",
	inventory_image = "aurem_raw.png"
})

core.register_alias("aurem_raw", "sb_minerals:aurem_raw")

minetest.register_craftitem("sb_minerals:aurem_ingot", {
	description = "Aurem Ingot",
	inventory_image = "aurem_ingot.png"
})

core.register_alias("aurem_ingot", "sb_minerals:aurem_ingot")

minetest.register_craftitem("sb_minerals:aurem_nugget", {
	description = "Aurem Nugget",
	inventory_image = "aurem_nugget.png"
})

core.register_alias("aurem_nugget", "sb_minerals:aurem_nugget")

core.register_craft({
    type = "cooking",
    output = "sb_minerals:aurem_ingot",
    recipe = "sb_minerals:aurem_raw",
    cooktime = 10,
})

core.register_craft({
    type = "cooking",
    output = "sb_minerals:aurem_ingot",
    recipe = "sb_minerals:stone_ore_aurem",
    cooktime = 10,
})

core.register_craft({
    output = "sb_minerals:aurem_ingot",
    recipe = {
        {"sb_minerals:aurem_nugget", "sb_minerals:aurem_nugget", "sb_minerals:aurem_nugget"},
        {"sb_minerals:aurem_nugget", "sb_minerals:aurem_nugget", "sb_minerals:aurem_nugget"},
        {"sb_minerals:aurem_nugget", "sb_minerals:aurem_nugget", "sb_minerals:aurem_nugget"}
    }
})

core.register_craft({
    output = "sb_minerals:aurem_nugget 9",
    recipe = {
        {"sb_minerals:aurem_ingot"}
    }
})

-- COAL
minetest.register_craftitem("sb_minerals:coal", {
	description = "Coal",
	inventory_image = "coal.png",
	groups = {coal = 1, flammable = 1}
})

core.register_alias("coal", "sb_minerals:coal")

core.register_craft({
    type = "cooking",
    output = "sb_minerals:coal",
    recipe = "sb_minerals:stone_ore_coal",
    cooktime = 10,
})

core.register_craft({
    type = "fuel",
    recipe = "sb_minerals:coal",
    burntime = 80,
})

-- CUPRUM
minetest.register_craftitem("sb_minerals:cuprum_raw", {
	description = "Raw Cuprum",
	inventory_image = "cuprum_raw.png"
})

core.register_alias("cuprum_raw", "sb_minerals:cuprum_raw")

minetest.register_craftitem("sb_minerals:cuprum_ingot", {
	description = "Cuprum Ingot",
	inventory_image = "cuprum_ingot.png"
})

core.register_alias("cuprum_ingot", "sb_minerals:cuprum_ingot")

core.register_craft({
    type = "cooking",
    output = "sb_minerals:cuprum_ingot",
    recipe = "sb_minerals:cuprum_raw",
    cooktime = 10,
})

core.register_craft({
    type = "cooking",
    output = "sb_minerals:cuprum_ingot",
    recipe = "sb_minerals:stone_ore_cuprum",
    cooktime = 10,
})

-- FERRUM
minetest.register_craftitem("sb_minerals:ferrum_raw", {
	description = "Raw Ferrum",
	inventory_image = "ferrum_raw.png"
})

core.register_alias("ferrum_raw", "sb_minerals:ferrum_raw")

minetest.register_craftitem("sb_minerals:ferrum_ingot", {
	description = "Ferrum Ingot",
	inventory_image = "ferrum_ingot.png"
})

core.register_alias("ferrum_ingot", "sb_minerals:ferrum_ingot")

minetest.register_craftitem("sb_minerals:ferrum_nugget", {
	description = "Ferrum Nugget",
	inventory_image = "ferrum_nugget.png"
})

core.register_alias("ferrum_nugget", "sb_minerals:ferrum_nugget")

core.register_craft({
    type = "cooking",
    output = "sb_minerals:ferrum_ingot",
    recipe = "sb_minerals:ferrum_raw",
    cooktime = 10,
})

core.register_craft({
    type = "cooking",
    output = "sb_minerals:ferrum_ingot",
    recipe = "sb_minerals:stone_ore_ferrum",
    cooktime = 10,
})

core.register_craft({
    output = "sb_minerals:ferrum_ingot",
    recipe = {
        {"sb_minerals:ferrum_nugget", "sb_minerals:ferrum_nugget", "sb_minerals:ferrum_nugget"},
        {"sb_minerals:ferrum_nugget", "sb_minerals:ferrum_nugget", "sb_minerals:ferrum_nugget"},
        {"sb_minerals:ferrum_nugget", "sb_minerals:ferrum_nugget", "sb_minerals:ferrum_nugget"}
    }
})

core.register_craft({
    output = "sb_minerals:ferrum_nugget 9",
    recipe = {
        {"sb_minerals:ferrum_ingot"}
    }
})

-- STANNUM
minetest.register_craftitem("sb_minerals:stannum_raw", {
	description = "Raw Stannum",
	inventory_image = "stannum_raw.png"
})

core.register_alias("stannum_raw", "sb_minerals:stannum_raw")

minetest.register_craftitem("sb_minerals:stannum_ingot", {
	description = "Stannum Ingot",
	inventory_image = "stannum_ingot.png"
})

core.register_alias("stannum_ingot", "sb_minerals:stannum_ingot")

core.register_craft({
    type = "cooking",
    output = "sb_minerals:stannum_ingot",
    recipe = "sb_minerals:stannum_raw",
    cooktime = 10,
})

core.register_craft({
    type = "cooking",
    output = "sb_minerals:stannum_ingot",
    recipe = "sb_minerals:stone_ore_stannum",
    cooktime = 10,
})

-- URAN
minetest.register_craftitem("sb_minerals:uran_raw", {
	description = "Raw Uran",
	inventory_image = "uran_raw.png"
})

core.register_alias("uran_raw", "sb_minerals:uran_raw")

minetest.register_craftitem("sb_minerals:uran_ingot", {
	description = "Uran Ingot",
	inventory_image = "uran_ingot.png"
})

core.register_alias("uran_ingot", "sb_minerals:uran_ingot")

core.register_craft({
    type = "cooking",
    output = "sb_minerals:uran_ingot",
    recipe = "sb_minerals:uran_raw",
    cooktime = 10,
})

core.register_craft({
    type = "cooking",
    output = "sb_minerals:uran_ingot",
    recipe = "sb_minerals:stone_ore_uran",
    cooktime = 10,
})

-- WOLFRAM
minetest.register_craftitem("sb_minerals:wolfram_raw", {
	description = "Raw Wolfram",
	inventory_image = "wolfram_raw.png"
})

core.register_alias("wolfram_raw", "sb_minerals:wolfram_raw")

minetest.register_craftitem("sb_minerals:wolfram_ingot", {
	description = "Wolfram Ingot",
	inventory_image = "wolfram_ingot.png"
})

core.register_alias("wolfram_ingot", "sb_minerals:wolfram_ingot")

core.register_craft({
    type = "cooking",
    output = "sb_minerals:wolfram_ingot",
    recipe = "sb_minerals:wolfram_raw",
    cooktime = 10,
})

core.register_craft({
    type = "cooking",
    output = "sb_minerals:wolfram_ingot",
    recipe = "sb_minerals:stone_ore_wolfram",
    cooktime = 10,
})