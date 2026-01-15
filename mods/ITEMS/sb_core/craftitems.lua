local mod_name = minetest.get_current_modname()
local mod_path = minetest.get_modpath(mod_name)

-- BRICK
minetest.register_craftitem("sb_core:brick", {
	description = "Brick",
	inventory_image = "brick.png"
})

core.register_alias("brick", "sb_core:brick")

core.register_craft({
    type = "cooking",
    output = "sb_core:brick",
    recipe = "sb_core:clay_lump",
    cooktime = 10,
})

-- CLAY LUMP
minetest.register_craftitem("sb_core:clay_lump", {
	description = "Clay Lump",
	inventory_image = "clay_lump.png"
})

core.register_alias("clay_lump", "sb_core:clay_lump")

-- CHARCOAL
minetest.register_craftitem("sb_core:charcoal", {
	description = "Charcoal",
	inventory_image = "charcoal.png",
	groups = {coal = 1, flammable = 1}
})

core.register_alias("charcoal", "sb_core:charcoal")

core.register_craft({
    type = "cooking",
    output = "sb_core:charcoal",
    recipe = "group:tree",
    cooktime = 10,
})

core.register_craft({
    type = "fuel",
    recipe = "sb_core:charcoal",
    burntime = 80,
})

-- FLINT
minetest.register_craftitem("sb_core:flint", {
	description = "Flint",
	inventory_image = "flint.png"
})

core.register_alias("flint", "sb_core:flint")

-- STICK
minetest.register_craftitem("sb_core:stick", {
	description = "Stick",
	inventory_image = "stick.png",
	groups = {stick = 1, flammable = 2},
})

core.register_alias("stick", "sb_core:stick")

core.register_craft({
    output = "sb_core:stick 4",
    recipe = {
        {"group:planks"},
        {"group:planks"}
    }
})

core.register_craft({
    type = "fuel",
    recipe = "sb_core:stick",
    burntime = 5,
})

-- WUNGU FRUIT
minetest.register_craftitem("sb_core:wungu_fruit", {
	description = "Wungu Fruit",
	inventory_image = "wungu_fruit.png",
	on_use = minetest.item_eat(4),
	groups = {compostability = 65},
})

core.register_alias("wungu_fruit", "sb_core:wungu_fruit")

-- STRING
minetest.register_craftitem("sb_core:string", {
	description = "String",
	inventory_image = "string.png",
	groups = {flammable = 2},
})

core.register_alias("string", "sb_core:string")

minetest.register_craft({
	output = "sb_core:string 2",
	recipe = {
		{"sb_farming:strandflower"},
		{"sb_farming:strandflower"},
	}
})

-- PAPER
minetest.register_craftitem("sb_core:paper", {
	description = "Paper",
	inventory_image = "paper.png",
	groups = {flammable = 3},
})

minetest.register_craft({
	output = "sb_core:paper 3",
	recipe = {
		{"sb_core:reeds", "sb_core:reeds", "sb_core:reeds"},
	}
})

core.register_alias("paper", "sb_core:paper")