local dyes = sb_dye.dyes

-- Glass
minetest.register_node("sb_core:glass", {
	description = "Glass",
	drawtype = "glasslike_framed_optional",
	tiles = {"glass.png", "glass_detail.png"},
	use_texture_alpha = "clip", -- only needed for stairs API
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {
		crumbly = mining.hardness(0.3, -1),
		cracky = mining.hardness(0.3, -1),
		choppy = mining.hardness(0.3, -1),
		snappy = mining.hardness(0.3, -1),
		oddly_breakable_by_hand = mining.hardness(0.3, 0),
		glass = 1
	},
	sounds = sounds.node_sound_glass_defaults(),
})

core.register_alias("glass", "sb_core:glass")

minetest.register_craft({
	type = "cooking",
	output = "sb_core:glass",
	recipe = "group:sand",
})

-- Stained Glass
for i = 1, #dyes do
	local name, desc = unpack(dyes[i])

	local color_group = "color_" .. name

	minetest.register_node("sb_core:glass_" .. name, {
		description = desc .. " Stained Glass",
		drawtype = "glasslike_framed_optional",
		tiles = {"glass_" .. name .. ".png", "glass_" .. name .. "_detail.png"},
		use_texture_alpha = "clip", -- only needed for stairs API
		paramtype = "light",
		sunlight_propagates = true,
		is_ground_content = false,
		groups = {
		crumbly = mining.hardness(0.3, -1),
		cracky = mining.hardness(0.3, -1),
		choppy = mining.hardness(0.3, -1),
		snappy = mining.hardness(0.3, -1),
		oddly_breakable_by_hand = mining.hardness(0.3, 0),
		glass = 1
	},
		sounds = sounds.node_sound_glass_defaults(),
	})
	
	minetest.register_craft({
		type = "shapeless",
		output = "sb_core:glass_" .. name,
		recipe = {"group:glass", "sb_dye:" .. name},
	})
end

core.register_alias("glass_white", "sb_core:glass_white")
core.register_alias("glass_light_gray", "sb_core:glass_light_gray")
core.register_alias("glass_gray", "sb_core:glass_gray")
core.register_alias("glass_black", "sb_core:glass_black")
core.register_alias("glass_brown", "sb_core:glass_brown")
core.register_alias("glass_red", "sb_core:glass_red")
core.register_alias("glass_orange", "sb_core:glass_orange")
core.register_alias("glass_yellow", "sb_core:glass_yellow")
core.register_alias("glass_light_green", "sb_core:glass_light_green")
core.register_alias("glass_green", "sb_core:glass_green")
core.register_alias("glass_cyan", "sb_core:glass_cyan")
core.register_alias("glass_light_blue", "sb_core:glass_light_blue")
core.register_alias("glass_blue", "sb_core:glass_blue")
core.register_alias("glass_purple", "sb_core:glass_purple")
core.register_alias("glass_magenta", "sb_core:glass_magenta")
core.register_alias("glass_pink", "sb_core:glass_pink")

-- Glass Pane
functions.register_pane("sb_core:glass_pane", {
	description = "Glass Pane",
	textures = {"glass.png", "", "glass_edge.png"},
	inventory_image = "glass.png",
	wield_image = "glass.png",
	sounds = sounds.node_sound_glass_defaults(),
	groups = {
		crumbly = mining.hardness(0.3, -1),
		cracky = mining.hardness(0.3, -1),
		choppy = mining.hardness(0.3, -1),
		snappy = mining.hardness(0.3, -1),
		oddly_breakable_by_hand = mining.hardness(0.3, 0),
		glass = 1
	},
	recipe = {
		{"sb_core:glass", "sb_core:glass", "sb_core:glass"},
		{"sb_core:glass", "sb_core:glass", "sb_core:glass"}
	}
})

core.register_alias("glass_pane", "sb_core:glass_pane")

-- Stained Glass Pane
for i = 1, #dyes do
	local name, desc = unpack(dyes[i])

	local color_group = "color_" .. name

	functions.register_pane("sb_core:glass_pane_" .. name, {
		description = desc .. " Stained Glass Pane",
		textures = {"glass_" .. name .. ".png", "", "glass_" .. name .. "_edge.png"},
		inventory_image = "glass_" .. name .. ".png",
		wield_image = "glass_" .. name .. ".png",
		groups = {
			crumbly = mining.hardness(0.3, -1),
			cracky = mining.hardness(0.3, -1),
			choppy = mining.hardness(0.3, -1),
			snappy = mining.hardness(0.3, -1),
			oddly_breakable_by_hand = mining.hardness(0.3, 0),
			glass = 1
		},
		sounds = sounds.node_sound_glass_defaults(),
		recipe = {
			{"sb_core:glass_" .. name, "sb_core:glass_" .. name, "sb_core:glass_" .. name},
			{"sb_core:glass_" .. name, "sb_core:glass_" .. name, "sb_core:glass_" .. name}
		}
	})
	
	minetest.register_craft({
		type = "shapeless",
		output = "sb_core:glass_pane_" .. name,
		recipe = {"group:glass_pane", "sb_dye:" .. name},
	})
end

core.register_alias("glass_pane_white", "sb_core:glass_pane_white")
core.register_alias("glass_pane_light_gray", "sb_core:glass_pane_light_gray")
core.register_alias("glass_pane_gray", "sb_core:glass_pane_gray")
core.register_alias("glass_pane_black", "sb_core:glass_pane_black")
core.register_alias("glass_pane_brown", "sb_core:glass_pane_brown")
core.register_alias("glass_pane_red", "sb_core:glass_pane_red")
core.register_alias("glass_pane_orange", "sb_core:glass_pane_orange")
core.register_alias("glass_pane_yellow", "sb_core:glass_pane_yellow")
core.register_alias("glass_pane_light_green", "sb_core:glass_pane_light_green")
core.register_alias("glass_pane_green", "sb_core:glass_pane_green")
core.register_alias("glass_pane_cyan", "sb_core:glass_pane_cyan")
core.register_alias("glass_pane_light_blue", "sb_core:glass_pane_light_blue")
core.register_alias("glass_pane_blue", "sb_core:glass_pane_blue")
core.register_alias("glass_pane_purple", "sb_core:glass_pane_purple")
core.register_alias("glass_pane_magenta", "sb_core:glass_pane_magenta")
core.register_alias("glass_pane_pink", "sb_core:glass_pane_pink")