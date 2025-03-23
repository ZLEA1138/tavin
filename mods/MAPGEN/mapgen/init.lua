
-- these tell minetest what nodes to generate in the world
minetest.register_alias("mapgen_stone", "sb_core:stone")
minetest.register_alias("mapgen_water_source", "sb_core:water_source")
minetest.register_alias("mapgen_river_water_source", "sb_core:water_source")

mapgen = {}

local mod_name = minetest.get_current_modname()
local mod_path = minetest.get_modpath(mod_name)

function mapgen.get_schematic_path(name)
    return (mod_path .. DIR_DELIM .. "schematics" .. DIR_DELIM .. name .. ".mts")
end

-- biomes
function mapgen.register_biomes()

	-- Tundra
	minetest.register_biome({
		name = "tundra_highland",
		node_dust = "sb_core:dirt_grass_snow",
		node_riverbed = "sb_core:sand",
		depth_riverbed = 2,
		y_max = 31000,
		y_min = 47,
		heat_point = 0,
		humidity_point = 40,
	})

	minetest.register_biome({
		name = "tundra",
		node_top = "sb_core:dirt_grass_snow",
		depth_top = 1,
		node_filler = "sb_core:dirt",
		depth_filler = 1,
		node_riverbed = "sb_core:sand",
		depth_riverbed = 2,
		vertical_blend = 4,
		y_max = 46,
		y_min = 2,
		heat_point = 0,
		humidity_point = 40,
	})

	minetest.register_biome({
		name = "tundra_beach",
		node_top = "sb_core:dirt_grass_snow",
		depth_top = 1,
		node_filler = "sb_core:dirt",
		depth_filler = 2,
		node_riverbed = "sb_core:sand",
		depth_riverbed = 2,
		vertical_blend = 1,
		y_max = 1,
		y_min = -3,
		heat_point = 0,
		humidity_point = 40,
	})

	minetest.register_biome({
		name = "tundra_ocean",
		node_top = "sb_core:sand",
		depth_top = 1,
		node_filler = "sb_core:sand",
		depth_filler = 3,
		node_riverbed = "sb_core:sand",
		depth_riverbed = 2,
		node_cave_liquid = "sb_core:water_source",
		vertical_blend = 1,
		y_max = -4,
		y_min = -255,
		heat_point = 0,
		humidity_point = 40,
	})

	-- Plains
	minetest.register_biome({
		name = "plains",
		node_top = "sb_core:dirt_grass_plains",
		depth_top = 1,
		node_filler = "sb_core:dirt",
		depth_filler = 1,
		node_riverbed = "sb_core:sand",
		depth_riverbed = 2,
		y_max = 31000,
		y_min = 6,
		heat_point = 50,
		humidity_point = 35,
	})

	minetest.register_biome({
		name = "plains_dunes",
		node_top = "sb_core:sand",
		depth_top = 1,
		node_filler = "sb_core:sand",
		depth_filler = 2,
		node_riverbed = "sb_core:sand",
		depth_riverbed = 2,
		vertical_blend = 1,
		y_max = 5,
		y_min = 4,
		heat_point = 50,
		humidity_point = 35,
	})

	minetest.register_biome({
		name = "plains_ocean",
		node_top = "sb_core:sand",
		depth_top = 1,
		node_filler = "sb_core:sand",
		depth_filler = 3,
		node_riverbed = "sb_core:sand",
		depth_riverbed = 2,
		node_cave_liquid = "sb_core:water_source",
		y_max = 3,
		y_min = -255,
		heat_point = 50,
		humidity_point = 35,
	})

	-- forest
	minetest.register_biome({
		name = "forest",
		node_top = "sb_core:dirt_grass_forest",
		depth_top = 1,
		node_filler = "sb_core:dirt",
		depth_filler = 3,
		node_riverbed = "sb_core:sand",
		depth_riverbed = 2,
		y_max = 31000,
		y_min = 6,
		heat_point = 45,
		humidity_point = 70,
	})

	minetest.register_biome({
		name = "forest_dunes",
		node_top = "sb_core:sand",
		depth_top = 1,
		node_filler = "sb_core:sand",
		depth_filler = 3,
		node_riverbed = "sb_core:sand",
		depth_riverbed = 2,
		vertical_blend = 1,
		y_max = 5,
		y_min = 4,
		heat_point = 45,
		humidity_point = 70,
	})

	minetest.register_biome({
		name = "forest_ocean",
		node_top = "sb_core:sand",
		depth_top = 1,
		node_filler = "sb_core:sand",
		depth_filler = 3,
		node_riverbed = "sb_core:sand",
		depth_riverbed = 2,
		node_cave_liquid = "sb_core:water_source",
		y_max = 3,
		y_min = -255,
		heat_point = 45,
		humidity_point = 70,
	})

	
	-- Pine forest
	minetest.register_biome({
		name = "pine_forest",
		node_top = "sb_core:dirt_grass_snow",
		depth_top = 1,
		node_filler = "sb_core:dirt",
		depth_filler = 3,
		node_riverbed = "sb_core:sand",
		depth_riverbed = 2,
		y_max = 31000,
		y_min = 4,
		heat_point = 25,
		humidity_point = 70,
	})
	
	minetest.register_biome({
		name = "pine_forest_shore",
		node_top = "sb_core:sand",
		depth_top = 1,
		node_filler = "sb_core:sand",
		depth_filler = 3,
		node_riverbed = "sb_core:sand",
		depth_riverbed = 2,
		y_max = 3,
		y_min = 4,
		heat_point = 25,
		humidity_point = 70,
	})

	minetest.register_biome({
		name = "pine_forest_ocean",
		node_top = "sb_core:sand",
		depth_top = 1,
		node_filler = "sb_core:sand",
		depth_filler = 3,
		node_riverbed = "sb_core:sand",
		depth_riverbed = 2,
		node_cave_liquid = "sb_core:water_source",
		vertical_blend = 1,
		y_max = 3,
		y_min = -255,
		heat_point = 25,
		humidity_point = 70,
	})

	-- Desert
	minetest.register_biome({
		name = "desert",
		node_top = "sb_core:sand",
		depth_top = 1,
		node_filler = "sb_core:sand",
		depth_filler = 1,
		node_stone = "sb_core:stone",
		node_riverbed = "sb_core:sand",
		depth_riverbed = 2,
		y_max = 31000,
		y_min = 4,
		heat_point = 92,
		humidity_point = 16,
	})

	minetest.register_biome({
		name = "desert_ocean",
		node_top = "sb_core:sand",
		depth_top = 1,
		node_filler = "sb_core:sand",
		depth_filler = 3,
		node_stone = "sb_core:stone",
		node_riverbed = "sb_core:sand",
		depth_riverbed = 2,
		node_cave_liquid = "sb_core:water_source",
		vertical_blend = 1,
		y_max = 3,
		y_min = -255,
		heat_point = 92,
		humidity_point = 16,
	})

	-- Savanna
	minetest.register_biome({
		name = "savanna",
		node_top = "sb_core:dirt_grass_savanna",
		depth_top = 1,
		node_filler = "sb_core:dirt",
		depth_filler = 1,
		node_riverbed = "sb_core:sand",
		depth_riverbed = 2,
		y_max = 31000,
		y_min = 1,
		heat_point = 89,
		humidity_point = 42,
	})

	minetest.register_biome({
		name = "savanna_shore",
		node_top = "sb_core:sand",
		depth_top = 1,
		node_filler = "sb_core:sand",
		depth_filler = 3,
		node_riverbed = "sb_core:sand",
		depth_riverbed = 2,
		y_max = 0,
		y_min = -1,
		heat_point = 89,
		humidity_point = 42,
	})

	minetest.register_biome({
		name = "savanna_ocean",
		node_top = "sb_core:sand",
		depth_top = 1,
		node_filler = "sb_core:sand",
		depth_filler = 3,
		node_riverbed = "sb_core:sand",
		depth_riverbed = 2,
		node_cave_liquid = "sb_core:water_source",
		vertical_blend = 1,
		y_max = -2,
		y_min = -255,
		heat_point = 89,
		humidity_point = 42,
	})
end

mapgen.register_biomes()