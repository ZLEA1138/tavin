local mod_name = minetest.get_current_modname()
local mod_path = minetest.get_modpath(mod_name)
local S = minetest.get_translator(mod_name)

-- make the actual pebble item
minetest.register_craftitem("nabm_pebbles:pebbles", {
	description = S("Pebbles"),
	inventory_image = "pebbles.png",
	groups = { item_pebble = 1, craftitem = 1, }
})


-- can make pebbles from stone
minetest.register_craft({
    type = "shapeless",
    output = "nabm_pebbles:pebbles 4",
    recipe = {
        "nabm_stone:stone"
    },
})
-- make a 2x2 grid to make it back into stone
minetest.register_craft({
    output = "nabm_stone:stone",
    recipe = {
        { "nabm_pebbles:pebbles", "nabm_pebbles:pebbles" },
        { "nabm_pebbles:pebbles", "nabm_pebbles:pebbles" },
    },
})
