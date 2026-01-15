-- Water
minetest.register_node("sb_core:water_source", {
    description = "Water Source",
	drawtype = "liquid",
	waving = 3,
	tiles = {
		{
			--name = "water_anim.png^[opacity:190",
			name = "water_anim.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.5,
			},
		},
		{
			--name = "water_anim.png^[opacity:190",
			name = "water_anim.png",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.5,
			},
		},
	},
    use_texture_alpha = "blend",
	paramtype = "light",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "source",
    liquid_alternative_source = "sb_core:water_source",
    liquid_alternative_flowing = "sb_core:water_flowing",
	liquid_viscosity = 1,
	post_effect_color = {a = 103, r = 30, g = 60, b = 90},
	groups = {
		water_source = 1,
		liquid = 1,
		water = 1,
		flowing = 0,
		cools_lava = 1
	},
	sounds = sounds.node_sound_water_defaults(),
})

core.register_alias("water_source", "sb_core:water_source")

minetest.register_node("sb_core:water_flowing", {
    description = "Water Flowing",
	drawtype = "flowingliquid",
	waving = 3,
	special_tiles = {
		{
			name = "water_flowing_anim.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.5,
			},
		},
		{
			name = "water_flowing_anim.png",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.5,
			},
		},
    },
	use_texture_alpha = "blend",
    paramtype = "light",
    paramtype2 = "flowingliquid",
	walkable = false,
	pointable = false,
	diggable = false,
    buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "sb_core:water_flowing",
	liquid_alternative_source = "sb_core:water_source",
	liquid_viscosity = 1,
	post_effect_color = {a = 103, r = 30, g = 60, b = 90},
    groups = {
		water_flowing = 1,
		liquid = 1,
		water = 1,
		flowing = 1,
		not_in_creative_inventory = 1,
		cools_lava = 1
	},
	sounds = sounds.node_sound_water_defaults(),
})

core.register_alias("water_flowing", "sb_core:water_flowing")

-- Ice
minetest.register_node("sb_core:ice", {
	description = "Ice",
	tiles = {"ice.png"},
	-- 'is ground content = false' to avoid tunnels in sea ice or ice rivers
	is_ground_content = false,
	paramtype = "light",
	groups = {
		crumbly = mining.hardness(0.5, -1),
		cracky = mining.hardness(0.5, -1),
		choppy = mining.hardness(0.5, 0),
		snappy = mining.hardness(0.5, -1),
		oddly_breakable_by_hand = mining.hardness(0.5, 0),
		cools_lava = 1,
		slippery = 3
	},
	sounds = sounds.node_sound_ice_defaults(),
})

core.register_alias("ice", "sb_core:ice")

-- Packed Ice
minetest.register_node("sb_core:packed_ice", {
	description = "Packed Ice",
	tiles = {"packed_ice.png"},
	-- 'is ground content = false' to avoid tunnels in sea ice or ice rivers
	is_ground_content = false,
	paramtype = "light",
	groups = {
		crumbly = mining.hardness(0.5, -1),
		cracky = mining.hardness(0.5, -1),
		choppy = mining.hardness(0.5, 0),
		snappy = mining.hardness(0.5, -1),
		oddly_breakable_by_hand = mining.hardness(0.5, 0),
		cools_lava = 1,
		slippery = 3
	},
	sounds = sounds.node_sound_ice_defaults(),
})

core.register_alias("packed_ice", "sb_core:packed_ice")

core.register_craft({
    output = "sb_core:packed_ice",
    recipe = {
        {"sb_core:ice", "sb_core:ice", "sb_core:ice"},
        {"sb_core:ice", "sb_core:ice", "sb_core:ice"},
		{"sb_core:ice", "sb_core:ice", "sb_core:ice"}
    }
})

-- Snow
minetest.register_node("sb_core:snow", {
	description = "Snow",
	tiles = {"snow.png"},
	inventory_image = "snowball.png",
	wield_image = "snowball.png",
	paramtype = "light",
	buildable_to = true,
	floodable = true,
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.25, 0.5},
		},
	},
	collision_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -6 / 16, 0.5},
		},
	},
	groups = {
		crumbly = mining.hardness(0.1, 0),
		cracky = mining.hardness(0.1, -1),
		choppy = mining.hardness(0.1, -1),
		snappy = mining.hardness(0.1, -1),
		oddly_breakable_by_hand = mining.hardness(0.1, 0),
		falling_node = 1,
		snowy = 1
	},
	drop = {
        max_items = 1,
        items = {
            {
				tool_groups = {"shovel"},
                items = {"sb_core:snow"},
            },
        },
    },
	sounds = sounds.node_sound_snow_defaults(),
	on_construct = functions.freeze_grass,
	after_destruct = functions.thaw_grass
})

core.register_alias("snow", "sb_core:snow")

-- Snow Block
minetest.register_node("sb_core:snow_block", {
	description = "Snow Block",
	tiles = {"snow.png"},
	groups = {
		crumbly = mining.hardness(0.2, 0),
		cracky = mining.hardness(0.2, -1),
		choppy = mining.hardness(0.2, -1),
		snappy = mining.hardness(0.2, -1),
		oddly_breakable_by_hand = mining.hardness(0.2, 0),
		cools_lava = 1,
		snowy = 1
	},
	drop = {
        max_items = 1,
        items = {
            {
				tool_groups = {"shovel"},
                items = {"sb_core:snow 9"},
            },
        },
    },
	sounds = sounds.node_sound_snow_defaults(),
	on_construct = functions.freeze_grass,
	after_destruct = functions.thaw_grass
})

core.register_alias("snow_block", "sb_core:snow_block")

-- Lava
minetest.register_node("sb_core:lava_source", {
	description = "Lava Source",
	drawtype = "liquid",
	tiles = {
		{
			name = "lava_source_anim.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 3.0,
			},
		},
		{
			name = "lava_source_anim.png",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 3.0,
			},
		},
	},
	paramtype = "light",
	light_source = 14,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "sb_core:lava_flowing",
	liquid_alternative_source = "sb_core:lava_source",
	liquid_viscosity = 7,
	liquid_renewable = false,
	damage_per_second = 4 * 2,
	post_effect_color = {a = 191, r = 255, g = 64, b = 0},
	groups = {
		lava = 3,
		liquid = 2,
		igniter = 1
	},
})

core.register_alias("lava_source", "sb_core:lava_source")

minetest.register_node("sb_core:lava_flowing", {
	description = "Flowing Lava",
	drawtype = "flowingliquid",
	tiles = {"lava.png"},
	special_tiles = {
		{
			name = "lava_flowing_anim.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 3.3,
			},
		},
		{
			name = "lava_flowing_anim.png",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 3.3,
			},
		},
	},
	paramtype = "light",
	paramtype2 = "flowingliquid",
	light_source = 14,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "sb_core:lava_flowing",
	liquid_alternative_source = "sb_core:lava_source",
	liquid_viscosity = 7,
	liquid_renewable = false,
	damage_per_second = 4 * 2,
	post_effect_color = {a = 191, r = 255, g = 64, b = 0},
	groups = {
		lava = 3,
		liquid = 2,
		igniter = 1,
		not_in_creative_inventory = 1
	},
})

core.register_alias("lava_flowing", "sb_core:lava_flowing")