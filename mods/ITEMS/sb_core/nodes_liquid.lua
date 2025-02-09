

minetest.register_node("sb_core:water_source", {
    description = "Water Source",
    groups = { water_source = 1, liquid = 1, water = 1, flowing = 0,},

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
    drawtype = "liquid",
    paramtype = "light",
    waving = 3,

    walkable = false,
    liquid_move_physics = true,
    move_resistance = 1,
    pointable = false,
    diggable = false,
    buildable_to = true,
    liquidtype = "source",
    liquid_viscosity = 1,
    --liquid_renewable = true,
    liquid_range = 8,
    liquid_alternative_source = "sb_core:water_source",
    liquid_alternative_flowing = "sb_core:water_flowing",
	post_effect_color = {a = 103, r = 30, g = 60, b = 90},
    --_on_node_update = pmb_fluid_api.flow_maybe(0.5)
  })

  minetest.register_node("sb_core:water_flowing", {
    description = "Water Flowing",
    groups = { water_flowing = 1, liquid = 1, water = 1, flowing = 1, not_in_creative_inventory = 1},
	
	
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
    --{
        --name = "water_anim.png^[opacity:190",
        --backface_culling = false,
    --},
    --{
        --name = "water_anim.png^[opacity:190",
        --backface_culling = true,
    --}
    },
    --name = "water_anim.png^[opacity:190",
	name = "water_anim.png",
    use_texture_alpha = "blend",
    drawtype = "flowingliquid",

    paramtype = "light",
    paramtype2 = "flowingliquid",
    waving = 3,

    walkable = false,
    liquid_move_physics = true,
    move_resistance = 1,
    pointable = false,
    diggable = false,
    buildable_to = true,
    liquidtype = "flowing",
    liquid_viscosity = 1,
    --liquid_renewable = false,
    liquid_range = 8,
    liquid_alternative_source = "sb_core:water_source",
    liquid_alternative_flowing = "sb_core:water_flowing",
	post_effect_color = {a = 103, r = 30, g = 60, b = 90},
  })
