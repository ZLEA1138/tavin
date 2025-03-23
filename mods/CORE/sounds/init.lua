local mod_name = minetest.get_current_modname()
local mod_path = minetest.get_modpath(mod_name)

sounds = {}

function sounds.node_sound_defaults(tbl)
	tbl = tbl or {}
	tbl.footstep = tbl.footstep or
			{name = "", gain = 1.0}
	tbl.dug = tbl.dug or
			{name = "dug_node", gain = 0.25}
	tbl.place = tbl.place or
			{name = "place_node_hard", gain = 1.0}
	return tbl
end

function sounds.node_sound_stone_defaults(tbl)
	tbl = tbl or {}
	tbl.footstep = tbl.footstep or
			{name = "hard_footstep", gain = 0.2}
	tbl.dug = tbl.dug or
			{name = "hard_footstep", gain = 1.0}
	sounds.node_sound_defaults(tbl)
	return tbl
end

function sounds.node_sound_dirt_defaults(tbl)
	tbl = tbl or {}
	tbl.footstep = tbl.footstep or
			{name = "dirt_footstep", gain = 0.25}
	tbl.dig = tbl.dig or
			{name = "dig_crumbly", gain = 0.4}
	tbl.dug = tbl.dug or
			{name = "dirt_footstep", gain = 1.0}
	tbl.place = tbl.place or
			{name = "place_node", gain = 1.0}
	sounds.node_sound_defaults(tbl)
	return tbl
end

function sounds.node_sound_sand_defaults(tbl)
	tbl = tbl or {}
	tbl.footstep = tbl.footstep or
			{name = "sand_footstep", gain = 0.05}
	tbl.dug = tbl.dug or
			{name = "sand_footstep", gain = 0.15}
	tbl.place = tbl.place or
			{name = "place_node", gain = 1.0}
	sounds.node_sound_defaults(tbl)
	return tbl
end

function sounds.node_sound_gravel_defaults(tbl)
	tbl = tbl or {}
	tbl.footstep = tbl.footstep or
			{name = "gravel_footstep", gain = 0.25}
	tbl.dig = tbl.dig or
			{name = "gravel_dig", gain = 0.35}
	tbl.dug = tbl.dug or
			{name = "gravel_dug", gain = 1.0}
	tbl.place = tbl.place or
			{name = "place_node", gain = 1.0}
	sounds.node_sound_defaults(tbl)
	return tbl
end

function sounds.node_sound_wood_defaults(tbl)
	tbl = tbl or {}
	tbl.footstep = tbl.footstep or
			{name = "wood_footstep", gain = 0.15}
	tbl.dig = tbl.dig or
			{name = "dig_choppy", gain = 0.4}
	tbl.dug = tbl.dug or
			{name = "wood_footstep", gain = 1.0}
	sounds.node_sound_defaults(tbl)
	return tbl
end

function sounds.node_sound_leaves_defaults(tbl)
	tbl = tbl or {}
	tbl.footstep = tbl.footstep or
			{name = "grass_footstep", gain = 0.45}
	tbl.dug = tbl.dug or
			{name = "grass_footstep", gain = 0.7}
	tbl.place = tbl.place or
			{name = "place_node", gain = 1.0}
	sounds.node_sound_defaults(tbl)
	return tbl
end

function sounds.node_sound_glass_defaults(tbl)
	tbl = tbl or {}
	tbl.footstep = tbl.footstep or
			{name = "glass_footstep", gain = 0.3}
	tbl.dig = tbl.dig or
			{name = "glass_footstep", gain = 0.5}
	tbl.dug = tbl.dug or
			{name = "break_glass", gain = 1.0}
	sounds.node_sound_defaults(tbl)
	return tbl
end

function sounds.node_sound_ice_defaults(tbl)
	tbl = tbl or {}
	tbl.footstep = tbl.footstep or
			{name = "ice_footstep", gain = 0.15}
	tbl.dig = tbl.dig or
			{name = "ice_dig", gain = 0.5}
	tbl.dug = tbl.dug or
			{name = "ice_dug", gain = 0.5}
	sounds.node_sound_defaults(tbl)
	return tbl
end

function sounds.node_sound_metal_defaults(tbl)
	tbl = tbl or {}
	tbl.footstep = tbl.footstep or
			{name = "metal_footstep", gain = 0.2}
	tbl.dig = tbl.dig or
			{name = "dig_metal", gain = 0.5}
	tbl.dug = tbl.dug or
			{name = "dug_metal", gain = 0.5}
	tbl.place = tbl.place or
			{name = "place_node_metal", gain = 0.5}
	sounds.node_sound_defaults(tbl)
	return tbl
end

function sounds.node_sound_water_defaults(tbl)
	tbl = tbl or {}
	tbl.footstep = tbl.footstep or
			{name = "water_footstep", gain = 0.2}
	sounds.node_sound_defaults(tbl)
	return tbl
end

function sounds.node_sound_snow_defaults(tbl)
	tbl = tbl or {}
	tbl.footstep = tbl.footstep or
			{name = "snow_footstep", gain = 0.2}
	tbl.dig = tbl.dig or
			{name = "snow_footstep", gain = 0.3}
	tbl.dug = tbl.dug or
			{name = "snow_footstep", gain = 0.3}
	tbl.place = tbl.place or
			{name = "place_node", gain = 1.0}
	sounds.node_sound_defaults(tbl)
	return tbl
end