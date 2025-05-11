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
	groups = {water_source = 1, liquid = 1, water = 1, flowing = 0, cools_lava = 1},
	sounds = sounds.node_sound_water_defaults(),
  })

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
    groups = {water_flowing = 1, liquid = 1, water = 1, flowing = 1, not_in_creative_inventory = 1, cools_lava = 1},
	sounds = sounds.node_sound_water_defaults(),
})

-- Ice
minetest.register_node("sb_core:ice", {
	description = "Ice",
	tiles = {"ice.png"},
	-- 'is ground content = false' to avoid tunnels in sea ice or ice rivers
	is_ground_content = false,
	paramtype = "light",
	groups = {cracky = 2, oddly_breakable_by_hand = 8, cools_lava = 1, slippery = 3},
	sounds = sounds.node_sound_ice_defaults(),
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
	groups = {crumbly = 2, falling_node = 1, snowy = 1},
	sounds = sounds.node_sound_snow_defaults(),

	--on_construct = function(pos)
		--pos.y = pos.y - 1
		--if minetest.get_node(pos).name == "sb_core:dirt_with_grass" then
			--minetest.set_node(pos, {name = "sb_core:dirt_with_snow"})
		--end
	--end,
})

-- Snow Block
minetest.register_node("sb_core:snow_block", {
	description = "Snow Block",
	tiles = {"snow.png"},
	groups = {crumbly = 3, cools_lava = 1, snowy = 1},
	sounds = sounds.node_sound_snow_defaults(),

	--on_construct = function(pos)
		--pos.y = pos.y - 1
		--if minetest.get_node(pos).name == "default:dirt_with_grass" then
			--minetest.set_node(pos, {name = "default:dirt_with_snow"})
		--end
	--end,
})