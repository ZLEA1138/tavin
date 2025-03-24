local mod_name = minetest.get_current_modname()
local mod_path = minetest.get_modpath(mod_name)

-- Required wrapper to allow customization of functions.after_place_leaves
local function after_place_leaves(...)
	return functions.after_place_leaves(...)
end

-- Required wrapper to allow customization of functions.grow_sapling
local function grow_sapling(...)
	return functions.grow_sapling(...)
end




--
-- MARSHTREE
--

-- Marshtree Log
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

-- Marshtree Planks
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

-- Marshtree Leaves
minetest.register_node("sb_core:leaves_marshtree", {
	description = S("Marshtree Leaves"),
	drawtype = "allfaces_optional",
	waving = 1,
	tiles = {"leaves_marshtree.png"},
	special_tiles = {"leaves_marshtree_simple.png"},
	paramtype = "light",
	is_ground_content = false,
	groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1},
	drop = {
		max_items = 1,
		items = {
			{
				-- player will get sapling with 1/20 chance
				items = {"sb_core:sapling_marshtree"},
				rarity = 20,
			},
			{
				-- player will get leaves only if he get no saplings,
				-- this is because max_items is 1
				items = {"sb_core:leaves_marshtree"},
			}
		}
	},
	sounds = sounds.node_sound_leaves_defaults(),

	after_place_node = after_place_leaves,
})

-- Marshtree Sapling
minetest.register_node("sb_core:sapling_marshtree", {
	description = S("Marshtree Sapling"),
	drawtype = "plantlike",
	tiles = {"sapling_marshtree.png"},
	inventory_image = "sapling_marshtree.png",
	wield_image = "sapling_marshtree.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	on_timer = grow_sapling,
	selection_box = {
		type = "fixed",
		fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16}
	},
	groups = {snappy = 2, dig_immediate = 3, flammable = 2,
		attached_node = 1, sapling = 1},
	sounds = sounds.node_sound_leaves_defaults(),

	on_construct = function(pos)
		minetest.get_node_timer(pos):start(math.random(300, 1500))
	end,

	on_place = function(itemstack, placer, pointed_thing)
		itemstack = functions.sapling_on_place(itemstack, placer, pointed_thing,
			"sb_core:sapling_marshtree",
			-- minp, maxp to be checked, relative to sapling pos
			-- minp_relative.y = 1 because sapling pos has been checked
			{x = -3, y = 1, z = -3},
			{x = 3, y = 6, z = 3},
			-- maximum interval of interior volume check
			4)

		return itemstack
	end,
})




--
-- OKI
--

-- Oki Log
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

-- Oki Planks
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

-- Oki Leaves
minetest.register_node("sb_core:leaves_oki", {
	description = S("Oki Leaves"),
	drawtype = "allfaces_optional",
	waving = 1,
	tiles = {"leaves_oki.png"},
	special_tiles = {"leaves_oki_simple.png"},
	paramtype = "light",
	is_ground_content = false,
	groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1},
	drop = {
		max_items = 1,
		items = {
			{
				-- player will get sapling with 1/20 chance
				items = {"sb_core:sapling_oki"},
				rarity = 20,
			},
			{
				-- player will get leaves only if he get no saplings,
				-- this is because max_items is 1
				items = {"sb_core:leaves_oki"},
			}
		}
	},
	sounds = sounds.node_sound_leaves_defaults(),

	after_place_node = after_place_leaves,
})

-- Oki Sapling
minetest.register_node("sb_core:sapling_oki", {
	description = S("Oki Sapling"),
	drawtype = "plantlike",
	tiles = {"sapling_oki.png"},
	inventory_image = "sapling_oki.png",
	wield_image = "sapling_oki.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	on_timer = grow_sapling,
	selection_box = {
		type = "fixed",
		fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16}
	},
	groups = {snappy = 2, dig_immediate = 3, flammable = 2,
		attached_node = 1, sapling = 1},
	sounds = sounds.node_sound_leaves_defaults(),

	on_construct = function(pos)
		minetest.get_node_timer(pos):start(math.random(300, 1500))
	end,

	on_place = function(itemstack, placer, pointed_thing)
		itemstack = functions.sapling_on_place(itemstack, placer, pointed_thing,
			"sb_core:sapling_oki",
			-- minp, maxp to be checked, relative to sapling pos
			-- minp_relative.y = 1 because sapling pos has been checked
			{x = -3, y = 1, z = -3},
			{x = 3, y = 6, z = 3},
			-- maximum interval of interior volume check
			4)

		return itemstack
	end,
})




--
-- SANA
--

-- Sana Log
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

-- Sana Planks
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

-- Sana Leaves
minetest.register_node("sb_core:leaves_sana", {
	description = S("Sana Leaves"),
	drawtype = "allfaces_optional",
	waving = 1,
	tiles = {"leaves_sana.png"},
	special_tiles = {"leaves_sana_simple.png"},
	paramtype = "light",
	is_ground_content = false,
	groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1},
	drop = {
		max_items = 1,
		items = {
			{
				-- player will get sapling with 1/20 chance
				items = {"sb_core:sapling_sana"},
				rarity = 20,
			},
			{
				-- player will get leaves only if he get no saplings,
				-- this is because max_items is 1
				items = {"sb_core:leaves_sana"},
			}
		}
	},
	sounds = sounds.node_sound_leaves_defaults(),

	after_place_node = after_place_leaves,
})

-- Sana Sapling
minetest.register_node("sb_core:sapling_sana", {
	description = S("Sana Sapling"),
	drawtype = "plantlike",
	tiles = {"sapling_sana.png"},
	inventory_image = "sapling_sana.png",
	wield_image = "sapling_sana.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	on_timer = grow_sapling,
	selection_box = {
		type = "fixed",
		fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16}
	},
	groups = {snappy = 2, dig_immediate = 3, flammable = 2,
		attached_node = 1, sapling = 1},
	sounds = sounds.node_sound_leaves_defaults(),

	on_construct = function(pos)
		minetest.get_node_timer(pos):start(math.random(300, 1500))
	end,

	on_place = function(itemstack, placer, pointed_thing)
		itemstack = functions.sapling_on_place(itemstack, placer, pointed_thing,
			"sb_core:sapling_sana",
			-- minp, maxp to be checked, relative to sapling pos
			-- minp_relative.y = 1 because sapling pos has been checked
			{x = -3, y = 1, z = -3},
			{x = 3, y = 6, z = 3},
			-- maximum interval of interior volume check
			4)

		return itemstack
	end,
})




--
-- SUNTREE
--

-- Suntree Log
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

-- Suntree Planks
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

-- Suntree Leaves
minetest.register_node("sb_core:leaves_suntree", {
	description = S("Suntree Leaves"),
	drawtype = "allfaces_optional",
	waving = 1,
	tiles = {"leaves_suntree.png"},
	special_tiles = {"leaves_suntree_simple.png"},
	paramtype = "light",
	is_ground_content = false,
	groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1},
	drop = {
		max_items = 1,
		items = {
			{
				-- player will get sapling with 1/20 chance
				items = {"sb_core:sapling_suntree"},
				rarity = 20,
			},
			{
				-- player will get leaves only if he get no saplings,
				-- this is because max_items is 1
				items = {"sb_core:leaves_suntree"},
			}
		}
	},
	sounds = sounds.node_sound_leaves_defaults(),

	after_place_node = after_place_leaves,
})

-- Suntree Sapling
minetest.register_node("sb_core:sapling_suntree", {
	description = S("Suntree Sapling"),
	drawtype = "plantlike",
	tiles = {"sapling_suntree.png"},
	inventory_image = "sapling_suntree.png",
	wield_image = "sapling_suntree.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	on_timer = grow_sapling,
	selection_box = {
		type = "fixed",
		fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16}
	},
	groups = {snappy = 2, dig_immediate = 3, flammable = 2,
		attached_node = 1, sapling = 1},
	sounds = sounds.node_sound_leaves_defaults(),

	on_construct = function(pos)
		minetest.get_node_timer(pos):start(math.random(300, 1500))
	end,

	on_place = function(itemstack, placer, pointed_thing)
		itemstack = functions.sapling_on_place(itemstack, placer, pointed_thing,
			"sb_core:sapling_suntree",
			-- minp, maxp to be checked, relative to sapling pos
			-- minp_relative.y = 1 because sapling pos has been checked
			{x = -3, y = 1, z = -3},
			{x = 3, y = 6, z = 3},
			-- maximum interval of interior volume check
			4)

		return itemstack
	end,
})




--
-- TAEDA
--

-- Taeda Log
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

-- Taeda Planks
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

-- Taeda Needles
minetest.register_node("sb_core:leaves_taeda", {
	description = S("Taeda Needles"),
	drawtype = "allfaces_optional",
	waving = 1,
	tiles = {"leaves_taeda.png"},
	special_tiles = {"leaves_taeda_simple.png"},
	paramtype = "light",
	is_ground_content = false,
	groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1},
	drop = {
		max_items = 1,
		items = {
			{
				-- player will get sapling with 1/20 chance
				items = {"sb_core:sapling_taeda"},
				rarity = 20,
			},
			{
				-- player will get leaves only if he get no saplings,
				-- this is because max_items is 1
				items = {"sb_core:leaves_taeda"},
			}
		}
	},
	sounds = sounds.node_sound_leaves_defaults(),

	after_place_node = after_place_leaves,
})

-- Taeda Sapling
minetest.register_node("sb_core:sapling_taeda", {
	description = S("Taeda Sapling"),
	drawtype = "plantlike",
	tiles = {"sapling_taeda.png"},
	inventory_image = "sapling_taeda.png",
	wield_image = "sapling_taeda.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	on_timer = grow_sapling,
	selection_box = {
		type = "fixed",
		fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16}
	},
	groups = {snappy = 2, dig_immediate = 3, flammable = 2,
		attached_node = 1, sapling = 1},
	sounds = sounds.node_sound_leaves_defaults(),

	on_construct = function(pos)
		minetest.get_node_timer(pos):start(math.random(300, 1500))
	end,

	on_place = function(itemstack, placer, pointed_thing)
		itemstack = functions.sapling_on_place(itemstack, placer, pointed_thing,
			"sb_core:sapling_taeda",
			-- minp, maxp to be checked, relative to sapling pos
			-- minp_relative.y = 1 because sapling pos has been checked
			{x = -3, y = 1, z = -3},
			{x = 3, y = 6, z = 3},
			-- maximum interval of interior volume check
			4)

		return itemstack
	end,
})




--
-- WUNGU
--

-- Wungu Log
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

-- Wungu Planks
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

-- Wungu Leaves
minetest.register_node("sb_core:leaves_wungu", {
	description = S("Wungu Leaves"),
	drawtype = "allfaces_optional",
	waving = 1,
	tiles = {"leaves_wungu.png"},
	special_tiles = {"leaves_wungu_simple.png"},
	paramtype = "light",
	is_ground_content = false,
	groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1},
	drop = {
		max_items = 1,
		items = {
			{
				-- player will get sapling with 1/20 chance
				items = {"sb_core:sapling_wungu"},
				rarity = 20,
			},
			{
				-- player will get leaves only if he get no saplings,
				-- this is because max_items is 1
				items = {"sb_core:leaves_wungu"},
			}
		}
	},
	sounds = sounds.node_sound_leaves_defaults(),

	after_place_node = after_place_leaves,
})

-- Wungu Sapling
minetest.register_node("sb_core:sapling_wungu", {
	description = S("Wungu Sapling"),
	drawtype = "plantlike",
	tiles = {"sapling_wungu.png"},
	inventory_image = "sapling_wungu.png",
	wield_image = "sapling_wungu.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	on_timer = grow_sapling,
	selection_box = {
		type = "fixed",
		fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16}
	},
	groups = {snappy = 2, dig_immediate = 3, flammable = 2,
		attached_node = 1, sapling = 1},
	sounds = sounds.node_sound_leaves_defaults(),

	on_construct = function(pos)
		minetest.get_node_timer(pos):start(math.random(300, 1500))
	end,

	on_place = function(itemstack, placer, pointed_thing)
		itemstack = functions.sapling_on_place(itemstack, placer, pointed_thing,
			"sb_core:sapling_wungu",
			-- minp, maxp to be checked, relative to sapling pos
			-- minp_relative.y = 1 because sapling pos has been checked
			{x = -3, y = 1, z = -3},
			{x = 3, y = 6, z = 3},
			-- maximum interval of interior volume check
			4)

		return itemstack
	end,
})