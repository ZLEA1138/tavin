local mod_name = minetest.get_current_modname()
local mod_path = minetest.get_modpath(mod_name)

-- MARSHTREE
minetest.register_node("sb_core:log_marshtree", {
	description = "Marshtree Log",
	tiles = {
		"log_marshtree_top.png",
		"log_marshtree_top.png",
		"log_marshtree.png"
	},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {tree = 1, choppy = 12, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = sounds.node_sound_wood_defaults(),
	on_place = minetest.rotate_node,
})

core.register_craft({
    type = "fuel",
    recipe = "sb_core:log_marshtree",
    burntime = 15,
})

minetest.register_node("sb_core:planks_marshtree", {
	description = "Marshtree Planks",
	tiles = {"planks_marshtree.png"},
	is_ground_content = false,
	groups = {planks = 1, choppy = 12, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = sounds.node_sound_wood_defaults(),
})

core.register_craft({
    type = "shapeless",
    output = "sb_core:planks_marshtree 4",
    recipe = {
        "sb_core:log_marshtree",
    },
})

core.register_craft({
    type = "fuel",
    recipe = "sb_core:planks_marshtree",
    burntime = 15,
})


-- OKI
minetest.register_node("sb_core:log_oki", {
	description = "Oki Log",
	tiles = {
		"log_oki_top.png",
		"log_oki_top.png",
		"log_oki.png"
	},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {tree = 1, choppy = 12, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = sounds.node_sound_wood_defaults(),
	on_place = minetest.rotate_node,
})

core.register_craft({
    type = "fuel",
    recipe = "sb_core:log_oki",
    burntime = 15,
})

minetest.register_node("sb_core:planks_oki", {
	description = "Oki Planks",
	tiles = {"planks_oki.png"},
	is_ground_content = false,
	groups = {planks = 1, choppy = 12, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = sounds.node_sound_wood_defaults(),
})

core.register_craft({
    type = "shapeless",
    output = "sb_core:planks_oki 4",
    recipe = {
        "sb_core:log_oki",
    },
})

core.register_craft({
    type = "fuel",
    recipe = "sb_core:planks_oki",
    burntime = 15,
})

-- SANA
minetest.register_node("sb_core:log_sana", {
	description = "Sana Log",
	tiles = {
		"log_sana_top.png",
		"log_sana_top.png",
		"log_sana.png"
	},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {tree = 1, choppy = 12, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = sounds.node_sound_wood_defaults(),
	on_place = minetest.rotate_node,
})

core.register_craft({
    type = "fuel",
    recipe = "sb_core:log_sana",
    burntime = 15,
})

minetest.register_node("sb_core:planks_sana", {
	description = "Sana Planks",
	tiles = {"planks_sana.png"},
	is_ground_content = false,
	groups = {planks = 1, choppy = 12, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = sounds.node_sound_wood_defaults(),
})

core.register_craft({
    type = "shapeless",
    output = "sb_core:planks_sana 4",
    recipe = {
        "sb_core:log_sana",
    },
})

core.register_craft({
    type = "fuel",
    recipe = "sb_core:planks_sana",
    burntime = 15,
})

-- SUNTREE
minetest.register_node("sb_core:log_suntree", {
	description = "Suntree Log",
	tiles = {
		"log_suntree_top.png",
		"log_suntree_top.png",
		"log_suntree.png"
	},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {tree = 1, choppy = 12, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = sounds.node_sound_wood_defaults(),
	on_place = minetest.rotate_node,
})

core.register_craft({
    type = "fuel",
    recipe = "sb_core:log_suntree",
    burntime = 15,
})

minetest.register_node("sb_core:planks_suntree", {
	description = "Suntree Planks",
	tiles = {"planks_suntree.png"},
	is_ground_content = false,
	groups = {planks = 1, choppy = 12, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = sounds.node_sound_wood_defaults(),
})

core.register_craft({
    type = "shapeless",
    output = "sb_core:planks_suntree 4",
    recipe = {
        "sb_core:log_suntree",
    },
})

core.register_craft({
    type = "fuel",
    recipe = "sb_core:planks_suntree",
    burntime = 15,
})

-- TAEDA
minetest.register_node("sb_core:log_taeda", {
	description = "Taeda Log",
	tiles = {
		"log_taeda_top.png",
		"log_taeda_top.png",
		"log_taeda.png"
	},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {tree = 1, choppy = 12, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = sounds.node_sound_wood_defaults(),
	on_place = minetest.rotate_node,
})

core.register_craft({
    type = "fuel",
    recipe = "sb_core:log_taeda",
    burntime = 15,
})

minetest.register_node("sb_core:planks_taeda", {
	description = "Taeda Planks",
	tiles = {"planks_taeda.png"},
	is_ground_content = false,
	groups = {planks = 1, choppy = 12, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = sounds.node_sound_wood_defaults(),
})

core.register_craft({
    type = "shapeless",
    output = "sb_core:planks_taeda 4",
    recipe = {
        "sb_core:log_taeda",
    },
})

core.register_craft({
    type = "fuel",
    recipe = "sb_core:planks_taeda",
    burntime = 15,
})

-- WUNGU
minetest.register_node("sb_core:log_wungu", {
	description = "Wungu Log",
	tiles = {
		"log_wungu_top.png",
		"log_wungu_top.png",
		"log_wungu.png"
	},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {tree = 1, choppy = 12, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = sounds.node_sound_wood_defaults(),
	on_place = minetest.rotate_node,
})

core.register_craft({
    type = "fuel",
    recipe = "sb_core:log_wungu",
    burntime = 15,
})

minetest.register_node("sb_core:planks_wungu", {
	description = "Wungu Planks",
	tiles = {"planks_wungu.png"},
	is_ground_content = false,
	groups = {planks = 1, choppy = 12, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = sounds.node_sound_wood_defaults(),
})

core.register_craft({
    type = "shapeless",
    output = "sb_core:planks_wungu 4",
    recipe = {
        "sb_core:log_wungu",
    },
})

core.register_craft({
    type = "fuel",
    recipe = "sb_core:planks_wungu",
    burntime = 15,
})