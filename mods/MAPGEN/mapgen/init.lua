
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
		depth_filler = 3,
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
		y_min = -128,
		heat_point = 0,
		humidity_point = 40,
	})
	
	
	-- Plains
	minetest.register_biome({
		name = "plains",
		node_top = "sb_core:dirt_grass_plains",
		depth_top = 1,
		node_filler = "sb_core:dirt",
		depth_filler = 3,
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
		y_min = -128,
		heat_point = 50,
		humidity_point = 35,
	})
	
	
	-- Prairie
	minetest.register_biome({
		name = "prairie",
		node_top = "sb_core:dirt_grass_prairie",
		depth_top = 1,
		node_filler = "sb_core:dirt",
		depth_filler = 3,
		node_riverbed = "sb_core:sand",
		depth_riverbed = 2,
		y_max = 26,
		y_min = 3,
		heat_point = 30,
		humidity_point = 35,
	})
	
	minetest.register_biome({
		name = "prairie_ocean",
		node_top = "sb_core:sand",
		depth_top = 1,
		node_filler = "sb_core:sand",
		depth_filler = 3,
		node_riverbed = "sb_core:sand",
		depth_riverbed = 2,
		node_cave_liquid = "sb_core:water_source",
		vertical_blend = 1,
		y_max = 2,
		y_min = -128,
		heat_point = 30,
		humidity_point = 35,
	})
	
	
	-- Fungusland
	minetest.register_biome({
		name = "fungusland",
		node_top = "sb_core:dirt_mycelium",
		depth_top = 1,
		node_filler = "sb_core:dirt",
		depth_filler = 3,
		node_riverbed = "sb_core:sand",
		depth_riverbed = 2,
		y_max = 26,
		y_min = 3,
		heat_point = 45,
		humidity_point = 82,
	})
	
	minetest.register_biome({
		name = "fungusland_ocean",
		node_top = "sb_core:sand",
		depth_top = 1,
		node_filler = "sb_core:sand",
		depth_filler = 3,
		node_riverbed = "sb_core:sand",
		depth_riverbed = 2,
		node_cave_liquid = "sb_core:water_source",
		vertical_blend = 1,
		y_max = 2,
		y_min = -128,
		heat_point = 45,
		humidity_point = 82,
	})
	
	
	-- Forest
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
		y_min = -128,
		heat_point = 45,
		humidity_point = 70,
	})
	
	
	-- Taeda forest
	minetest.register_biome({
		name = "taeda_forest",
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
		name = "taeda_forest_shore",
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
		name = "taeda_forest_ocean",
		node_top = "sb_core:sand",
		depth_top = 1,
		node_filler = "sb_core:sand",
		depth_filler = 3,
		node_riverbed = "sb_core:sand",
		depth_riverbed = 2,
		node_cave_liquid = "sb_core:water_source",
		vertical_blend = 1,
		y_max = 3,
		y_min = -128,
		heat_point = 25,
		humidity_point = 70,
	})
	
	
	-- Oki Forest
	minetest.register_biome({
		name = "oki_forest",
		node_top = "sb_core:dirt_grass_forest",
		depth_top = 1,
		node_filler = "sb_core:dirt",
		depth_filler = 3,
		node_riverbed = "sb_core:sand",
		depth_riverbed = 2,
		y_max = 31000,
		y_min = 6,
		heat_point = 25,
		humidity_point = 70,
	})
	
	minetest.register_biome({
		name = "oki_forest_dunes",
		node_top = "sb_core:sand",
		depth_top = 1,
		node_filler = "sb_core:sand",
		depth_filler = 3,
		node_riverbed = "sb_core:sand",
		depth_riverbed = 2,
		vertical_blend = 1,
		y_max = 5,
		y_min = 4,
		heat_point = 25,
		humidity_point = 70,
	})
	
	minetest.register_biome({
		name = "oki_forest_ocean",
		node_top = "sb_core:sand",
		depth_top = 1,
		node_filler = "sb_core:sand",
		depth_filler = 3,
		node_riverbed = "sb_core:sand",
		depth_riverbed = 2,
		node_cave_liquid = "sb_core:water_source",
		y_max = 3,
		y_min = -128,
		heat_point = 25,
		humidity_point = 70,
	})
	
	
	-- Desert
	minetest.register_biome({
		name = "desert",
		node_top = "sb_core:sand_desert",
		depth_top = 4,
		node_filler = "sb_core:sandstone_desert",
		depth_filler = 6,
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
		y_min = -128,
		heat_point = 92,
		humidity_point = 16,
	})
	
	
	-- Savanna
	minetest.register_biome({
		name = "savanna",
		node_top = "sb_core:dirt_grass_savanna",
		depth_top = 1,
		node_filler = "sb_core:dirt",
		depth_filler = 3,
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
		y_min = -128,
		heat_point = 89,
		humidity_point = 42,
	})
	
	
	-- Swamp
	minetest.register_biome({
		name = "swamp",
		node_top = "sb_core:dirt_grass_swamp",
		depth_top = 1,
		node_filler = "sb_core:dirt",
		depth_filler = 3,
		node_riverbed = "sb_core:sand",
		depth_riverbed = 2,
		y_max = 7,
		y_min = 1,
		heat_point = 80,
		humidity_point = 90,
	})
	
	minetest.register_biome({
		name = "swamp_shore",
		node_top = "sb_core:sand",
		depth_top = 1,
		node_filler = "sb_core:sand",
		depth_filler = 3,
		node_riverbed = "sb_core:sand",
		depth_riverbed = 2,
		y_max = 0,
		y_min = -1,
		heat_point = 80,
		humidity_point = 90,
	})
	
	minetest.register_biome({
		name = "swamp_ocean",
		node_top = "sb_core:sand",
		depth_top = 1,
		node_filler = "sb_core:sand",
		depth_filler = 3,
		node_riverbed = "sb_core:sand",
		depth_riverbed = 2,
		node_cave_liquid = "sb_core:water_source",
		vertical_blend = 1,
		y_max = -1,
		y_min = -128,
		heat_point = 80,
		humidity_point = 90,
	})
	
	
	-- Scorched Wastes
	minetest.register_biome({
		name = "scorched_wastes",
		node_top = "sb_core:dirt_scorched",
		depth_top = 1,
		node_filler = "sb_core:dirt_dry",
		depth_filler = 3,
		node_riverbed = "sb_core:sand",
		depth_riverbed = 2,
		y_max = 31000,
		y_min = 1,
		heat_point = 80,
		humidity_point = 10,
	})
	
	minetest.register_biome({
		name = "scorched_wastes_shore",
		node_top = "sb_core:sand",
		depth_top = 1,
		node_filler = "sb_core:sand",
		depth_filler = 3,
		node_riverbed = "sb_core:sand",
		depth_riverbed = 2,
		y_max = 0,
		y_min = -1,
		heat_point = 80,
		humidity_point = 10,
	})
	
	minetest.register_biome({
		name = "scorched_wastes_ocean",
		node_top = "sb_core:sand",
		depth_top = 1,
		node_filler = "sb_core:sand",
		depth_filler = 3,
		node_riverbed = "sb_core:sand",
		depth_riverbed = 2,
		node_cave_liquid = "sb_core:water_source",
		vertical_blend = 1,
		y_max = -1,
		y_min = -128,
		heat_point = 80,
		humidity_point = 10,
	})
end

function mapgen.register_decorations()
	
	-- Trees
	-- Marshtree
	minetest.register_decoration({
		name = "mapgen:marshtree_1",
		deco_type = "schematic",
		place_on = {"sb_core:dirt_grass_swamp"},
		fill_ratio = 0.02,
		biomes = {"swamp"},
		place_offset_y = 1,
		schematic = minetest.get_modpath("mapgen") .. "/schematics/marshtree_1.mts",
		flags = "place_center_x, place_center_z",
		rotation = "random",
	})
	
	
	-- Oki tree
	minetest.register_decoration({
		name = "mapgen:oki_tree_1",
		deco_type = "schematic",
		place_on = {"sb_core:dirt_grass_forest"},
		fill_ratio = 0.0025,
		biomes = {"oki_forest"},
		place_offset_y = 1,
		schematic = minetest.get_modpath("mapgen") .. "/schematics/oki_tree_1.mts",
		flags = "place_center_x, place_center_z",
		rotation = "random",
	})
	
	
	-- Sana tree
	minetest.register_decoration({
		name = "mapgen:sana_tree_1",
		deco_type = "schematic",
		place_on = {"sb_core:dirt_grass_savanna"},
		fill_ratio = 0.004,
		biomes = {"savanna"},
		place_offset_y = 1,
		schematic = minetest.get_modpath("mapgen") .. "/schematics/sana_tree_1.mts",
		flags = "place_center_x, place_center_z",
		rotation = "random",
	})
	
	
	-- Scorched tree
	minetest.register_decoration({
		name = "mapgen:scorched_tree",
		deco_type = "simple",
		place_on = {"sb_core:dirt_scorched"},
		fill_ratio = 0.005,
		biomes = {"scorched_wastes"},
		decoration = "sb_core:log_scorched",
		height = 4,
	        height_max = 6,
	})
	
	
	-- Suntree
	minetest.register_decoration({
		name = "mapgen:suntree_1",
		deco_type = "schematic",
		place_on = {"sb_core:sand"},
		fill_ratio = 0.0025,
		y_min = 1,
		y_max = 1,
		biomes = {
			"plains_ocean", "prairie_ocean", "fungusland_ocean",
			"forest_ocean", "taeda_forest_ocean", "desert_ocean",
			"savanna_ocean", "swamp_ocean"
		},
		place_offset_y = 1,
		schematic = minetest.get_modpath("mapgen") .. "/schematics/suntree_1.mts",
		flags = "place_center_x, place_center_z",
		rotation = "random",
	})
	
	
	-- Taeda tree
	minetest.register_decoration({
		name = "mapgen:taeda_tree_1",
		deco_type = "schematic",
		place_on = {"sb_core:dirt_grass_snow"},
		fill_ratio = 0.02,
		biomes = {"taeda_forest"},
		place_offset_y = 1,
		schematic = minetest.get_modpath("mapgen") .. "/schematics/taeda_tree_1.mts",
		flags = "place_center_x, place_center_z",
	})
	
	minetest.register_decoration({
		name = "mapgen:taeda_tree_2",
		deco_type = "schematic",
		place_on = {"sb_core:dirt_grass_snow"},
		fill_ratio = 0.0001,
		biomes = {"taeda_forest"},
		place_offset_y = 1,
		schematic = minetest.get_modpath("mapgen") .. "/schematics/taeda_tree_2.mts",
		flags = "place_center_x, place_center_z",
	})
	
	minetest.register_decoration({
		name = "mapgen:taeda_tree_3",
		deco_type = "schematic",
		place_on = {"sb_core:dirt_grass_snow"},
		fill_ratio = 0.005,
		biomes = {"taeda_forest"},
		place_offset_y = 1,
		schematic = minetest.get_modpath("mapgen") .. "/schematics/taeda_tree_3.mts",
		flags = "place_center_x, place_center_z",
	})
	
	
	-- Wungu tree
	minetest.register_decoration({
		name = "mapgen:wungu_tree_1",
		deco_type = "schematic",
		place_on = {"sb_core:dirt_grass_forest"},
		fill_ratio = 0.02,
		biomes = {"forest"},
		place_offset_y = 1,
		schematic = minetest.get_modpath("mapgen") .. "/schematics/wungu_tree_1.mts",
		flags = "place_center_x, place_center_z",
	})
	
	minetest.register_decoration({
		name = "mapgen:wungu_tree_2",
		deco_type = "schematic",
		place_on = {"sb_core:dirt_grass_forest"},
		fill_ratio = 0.005,
		biomes = {"forest"},
		place_offset_y = 1,
		schematic = minetest.get_modpath("mapgen") .. "/schematics/wungu_tree_2.mts",
		flags = "place_center_x, place_center_z",
	})
end

mapgen.register_biomes()
mapgen.register_decorations()