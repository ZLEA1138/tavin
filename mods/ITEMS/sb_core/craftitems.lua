local mod_name = minetest.get_current_modname()
local mod_path = minetest.get_modpath(mod_name)

-- BRICK
minetest.register_craftitem("sb_core:brick", {
	description = "Brick",
	inventory_image = "brick.png"
})

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

-- CHARCOAL
minetest.register_craftitem("sb_core:charcoal", {
	description = "Charcoal",
	inventory_image = "charcoal.png",
	groups = {coal = 1, flammable = 1}
})

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

-- STICK
minetest.register_craftitem("sb_core:stick", {
	description = "Stick",
	inventory_image = "stick.png",
	groups = {stick = 1, flammable = 2},
})

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