-- Based on default/torch.lua from Minetest Game

local mod_name = minetest.get_current_modname()
local mod_path = minetest.get_modpath(mod_name)

sb_torch = {}

torch_light = 14

local function on_flood(pos, oldnode, newnode)
	minetest.add_item(pos, ItemStack("sb_torch:torch 1"))
	-- Play flame-extinguish sound if liquid is not an 'igniter'
	local nodedef = minetest.registered_items[newnode.name]
	if not (nodedef and nodedef.groups and
			nodedef.groups.igniter and nodedef.groups.igniter > 0) then
		minetest.sound_play(
			"cool_lava",
			{pos = pos, max_hear_distance = 16, gain = 0.07},
			true
		)
	end
	-- Remove the torch node
	return false
end

minetest.register_node("sb_torch:torch", {
	description = "Torch",
	drawtype = "mesh",
	mesh = "torch_floor.obj",
	inventory_image = "torch.png",
	wield_image = "torch.png",
	tiles = {{
		    name = "torch_anim.png",
		    animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 3.3}
	}},
	use_texture_alpha = "clip",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	liquids_pointable = false,
	light_source = torch_light,
	groups = {choppy = 2, dig_immediate = 3, flammable = 1, attached_node = 1, torch = 1},
	drop = "sb_torch:torch",
	selection_box = {
		type = "wallmounted",
		wall_bottom = {-1/8, -1/2, -1/8, 1/8, 2/16, 1/8},
	},
	sounds = sounds.node_sound_wood_defaults(),
	on_place = function(itemstack, placer, pointed_thing)
		local under = pointed_thing.under
		local node = minetest.get_node(under)
		local def = minetest.registered_nodes[node.name]
		if def and def.on_rightclick and
			not (placer and placer:is_player() and
			placer:get_player_control().sneak) then
			return def.on_rightclick(under, node, placer, itemstack,
				pointed_thing) or itemstack
		end

		local above = pointed_thing.above
		local wdir = minetest.dir_to_wallmounted(vector.subtract(under, above))
		local fakestack = itemstack
		if wdir == 0 then
			fakestack:set_name("sb_torch:torch_ceiling")
		elseif wdir == 1 then
			fakestack:set_name("sb_torch:torch")
		else
			fakestack:set_name("sb_torch:torch_wall")
		end

		itemstack = minetest.item_place(fakestack, placer, pointed_thing, wdir)
		itemstack:set_name("sb_torch:torch")

		return itemstack
	end,
	floodable = true,
	on_flood = on_flood,
	on_rotate = false
})

minetest.register_node("sb_torch:torch_wall", {
	drawtype = "mesh",
	mesh = "torch_wall.obj",
	tiles = {{
		    name = "torch_anim.png",
		    animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 3.3}
	}},
	use_texture_alpha = "clip",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	light_source = torch_light,
	groups = {choppy = 2, dig_immediate = 3, flammable = 1, not_in_creative_inventory = 1, attached_node = 1, torch = 1},
	drop = "sb_torch:torch",
	selection_box = {
		type = "wallmounted",
		wall_side = {-1/2, -1/2, -1/8, -1/8, 1/8, 1/8},
	},
	sounds = sounds.node_sound_wood_defaults(),
	floodable = true,
	on_flood = on_flood,
	on_rotate = false
})

minetest.register_node("sb_torch:torch_ceiling", {
	drawtype = "mesh",
	mesh = "torch_ceiling.obj",
	tiles = {{
		    name = "torch_anim.png",
		    animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 3.3}
	}},
	use_texture_alpha = "clip",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	light_source = torch_light,
	groups = {choppy = 2, dig_immediate = 3, flammable = 1, not_in_creative_inventory = 1, attached_node = 1, torch = 1},
	drop = "sb_torch:torch",
	selection_box = {
		type = "wallmounted",
		wall_top = {-1/8, -1/16, -5/16, 1/8, 1/2, 1/8},
	},
	sounds = sounds.node_sound_wood_defaults(),
	floodable = true,
	on_flood = on_flood,
	on_rotate = false
})

minetest.register_lbm({
	name = "sb_torch:3dtorch",
	nodenames = {"sb_torch:torch", "torches:floor", "torches:wall"},
	action = function(pos, node)
		if node.param2 == 0 then
			minetest.set_node(pos, {name = "sb_torch:torch_ceiling",
				param2 = node.param2})
		elseif node.param2 == 1 then
			minetest.set_node(pos, {name = "sb_torch:torch",
				param2 = node.param2})
		else
			minetest.set_node(pos, {name = "sb_torch:torch_wall",
				param2 = node.param2})
		end
	end
})

minetest.register_craft({
	output = "sb_torch:torch 4",
	recipe = {
		{"sb_minerals:coal_lump"},
		{"group:stick"},
	}
})