local mod_name = minetest.get_current_modname()
local mod_path = minetest.get_modpath(mod_name)

--
-- MARSHTREE
--

-- Marshtree Fence
functions.register_fence("sb_core:fence_marshtree", {
	description = "Marshtree Fence",
	texture = "planks_marshtree.png",
	inventory_image = "fence_overlay.png^planks_marshtree.png^" ..
				"fence_overlay.png^[makealpha:255,126,126",
	wield_image = "fence_overlay.png^planks_marshtree.png^" ..
				"fence_overlay.png^[makealpha:255,126,126",
	material = "sb_core:planks_marshtree",
	groups = {
		crumbly = mining.hardness(2, -1),
		cracky = mining.hardness(2, -1),
		choppy = mining.hardness(2, 0),
		snappy = mining.hardness(2, -1),
		oddly_breakable_by_hand = mining.hardness(2, 0),
		flammable = 2
	},
	sounds = sounds.node_sound_wood_defaults()
})

-- Marshtree Gate
functions.register_fencegate("sb_core:gate_marshtree", {
	description = "Marshtree Fence Gate",
	texture = "planks_marshtree.png",
	material = "sb_core:planks_marshtree",
	groups = {
		crumbly = mining.hardness(2, -1),
		cracky = mining.hardness(2, -1),
		choppy = mining.hardness(2, 0),
		snappy = mining.hardness(2, -1),
		oddly_breakable_by_hand = mining.hardness(2, 0),
		flammable = 2,
		nondirtifier = 1
	}
})




--
-- OKI
--

-- Oki Fence
functions.register_fence("sb_core:fence_oki", {
	description = "Oki Fence",
	texture = "planks_oki.png",
	inventory_image = "fence_overlay.png^planks_oki.png^" ..
				"fence_overlay.png^[makealpha:255,126,126",
	wield_image = "fence_overlay.png^planks_oki.png^" ..
				"fence_overlay.png^[makealpha:255,126,126",
	material = "sb_core:planks_oki",
	groups = {
		crumbly = mining.hardness(2, -1),
		cracky = mining.hardness(2, -1),
		choppy = mining.hardness(2, 0),
		snappy = mining.hardness(2, -1),
		oddly_breakable_by_hand = mining.hardness(2, 0),
		flammable = 2
	},
	sounds = sounds.node_sound_wood_defaults()
})

-- Oki Gate
functions.register_fencegate("sb_core:gate_oki", {
	description = "Oki Fence Gate",
	texture = "planks_oki.png",
	material = "sb_core:planks_oki",
	groups = {
		crumbly = mining.hardness(2, -1),
		cracky = mining.hardness(2, -1),
		choppy = mining.hardness(2, 0),
		snappy = mining.hardness(2, -1),
		oddly_breakable_by_hand = mining.hardness(2, 0),
		flammable = 2,
		nondirtifier = 1
	}
})




--
-- SANA
--

-- Sana Fence
functions.register_fence("sb_core:fence_sana", {
	description = "Sana Fence",
	texture = "planks_sana.png",
	inventory_image = "fence_overlay.png^planks_sana.png^" ..
				"fence_overlay.png^[makealpha:255,126,126",
	wield_image = "fence_overlay.png^planks_sana.png^" ..
				"fence_overlay.png^[makealpha:255,126,126",
	material = "sb_core:planks_sana",
	groups = {
		crumbly = mining.hardness(2, -1),
		cracky = mining.hardness(2, -1),
		choppy = mining.hardness(2, 0),
		snappy = mining.hardness(2, -1),
		oddly_breakable_by_hand = mining.hardness(2, 0),
		flammable = 2
	},
	sounds = sounds.node_sound_wood_defaults()
})

-- Sana Gate
functions.register_fencegate("sb_core:gate_sana", {
	description = "Sana Fence Gate",
	texture = "planks_sana.png",
	material = "sb_core:planks_sana",
	groups = {
		crumbly = mining.hardness(2, -1),
		cracky = mining.hardness(2, -1),
		choppy = mining.hardness(2, 0),
		snappy = mining.hardness(2, -1),
		oddly_breakable_by_hand = mining.hardness(2, 0),
		flammable = 2,
		nondirtifier = 1
	}
})




--
-- SUNTREE
--

-- Suntree Fence
functions.register_fence("sb_core:fence_suntree", {
	description = "Suntree Fence",
	texture = "planks_suntree.png",
	inventory_image = "fence_overlay.png^planks_suntree.png^" ..
				"fence_overlay.png^[makealpha:255,126,126",
	wield_image = "fence_overlay.png^planks_suntree.png^" ..
				"fence_overlay.png^[makealpha:255,126,126",
	material = "sb_core:planks_suntree",
	groups = {
		crumbly = mining.hardness(2, -1),
		cracky = mining.hardness(2, -1),
		choppy = mining.hardness(2, 0),
		snappy = mining.hardness(2, -1),
		oddly_breakable_by_hand = mining.hardness(2, 0),
		flammable = 2
	},
	sounds = sounds.node_sound_wood_defaults()
})

-- Suntree Gate
functions.register_fencegate("sb_core:gate_suntree", {
	description = "Suntree Fence Gate",
	texture = "planks_suntree.png",
	material = "sb_core:planks_suntree",
	groups = {
		crumbly = mining.hardness(2, -1),
		cracky = mining.hardness(2, -1),
		choppy = mining.hardness(2, 0),
		snappy = mining.hardness(2, -1),
		oddly_breakable_by_hand = mining.hardness(2, 0),
		flammable = 2,
		nondirtifier = 1
	}
})




--
-- TAEDA
--

-- Taeda Fence
functions.register_fence("sb_core:fence_taeda", {
	description = "Taeda Fence",
	texture = "planks_taeda.png",
	inventory_image = "fence_overlay.png^planks_taeda.png^" ..
				"fence_overlay.png^[makealpha:255,126,126",
	wield_image = "fence_overlay.png^planks_taeda.png^" ..
				"fence_overlay.png^[makealpha:255,126,126",
	material = "sb_core:planks_taeda",
	groups = {
		crumbly = mining.hardness(2, -1),
		cracky = mining.hardness(2, -1),
		choppy = mining.hardness(2, 0),
		snappy = mining.hardness(2, -1),
		oddly_breakable_by_hand = mining.hardness(2, 0),
		flammable = 2
	},
	sounds = sounds.node_sound_wood_defaults()
})

-- Taeda Gate
functions.register_fencegate("sb_core:gate_taeda", {
	description = "Taeda Fence Gate",
	texture = "planks_taeda.png",
	material = "sb_core:planks_taeda",
	groups = {
		crumbly = mining.hardness(2, -1),
		cracky = mining.hardness(2, -1),
		choppy = mining.hardness(2, 0),
		snappy = mining.hardness(2, -1),
		oddly_breakable_by_hand = mining.hardness(2, 0),
		flammable = 2,
		nondirtifier = 1
	}
})




--
-- WUNGU
--

-- Wungu Fence
functions.register_fence("sb_core:fence_wungu", {
	description = "Wungu Fence",
	texture = "planks_wungu.png",
	inventory_image = "fence_overlay.png^planks_wungu.png^" ..
				"fence_overlay.png^[makealpha:255,126,126",
	wield_image = "fence_overlay.png^planks_wungu.png^" ..
				"fence_overlay.png^[makealpha:255,126,126",
	material = "sb_core:planks_wungu",
	groups = {
		crumbly = mining.hardness(2, -1),
		cracky = mining.hardness(2, -1),
		choppy = mining.hardness(2, 0),
		snappy = mining.hardness(2, -1),
		oddly_breakable_by_hand = mining.hardness(2, 0),
		flammable = 2
	},
	sounds = sounds.node_sound_wood_defaults()
})

-- Wungu Gate
functions.register_fencegate("sb_core:gate_wood", {
	description = "Wungu Fence Gate",
	texture = "planks_wungu.png",
	material = "sb_core:planks_wungu",
	groups = {
		crumbly = mining.hardness(2, -1),
		cracky = mining.hardness(2, -1),
		choppy = mining.hardness(2, 0),
		snappy = mining.hardness(2, -1),
		oddly_breakable_by_hand = mining.hardness(2, 0),
		flammable = 2,
		nondirtifier = 1
	}
})