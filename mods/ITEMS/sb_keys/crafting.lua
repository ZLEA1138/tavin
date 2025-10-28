--
-- Crafting recipes
--

minetest.register_craft({
	output = "sb_keys:skeleton_keycard",
	recipe = {
		{"sb_minerals:aurem_ingot"},
	}
})

--
-- Cooking recipes
--

minetest.register_craft({
	type = "cooking",
	output = "sb_minerals:aurem_ingot",
	recipe = "sb_keys:keycard",
	cooktime = 5,
})

minetest.register_craft({
	type = "cooking",
	output = "sb_minerals:aurem_ingot",
	recipe = "sb_keys:skeleton_keycard",
	cooktime = 5,
})
