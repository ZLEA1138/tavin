-- Blob ore
-- These before scatter ores to avoid other ores in blobs.

-- Clay
minetest.register_ore({
	ore_type        = "blob",
	ore             = "sb_core:clay",
	wherein         = {"sb_core:sand"},
	clust_scarcity  = 16 * 16 * 16,
	clust_size      = 5,
	y_max           = 0,
	y_min           = -15,
	noise_threshold = 0.0,
	noise_params    = {
		offset = 0.5,
		scale = 0.2,
		spread = {x = 5, y = 5, z = 5},
		seed = -316,
		octaves = 1,
		persist = 0.0
	},
})

-- Sand
minetest.register_ore({
	ore_type        = "blob",
	ore             = "sb_core:sand",
	wherein         = {"sb_core:stone"},
	clust_scarcity  = 16 * 16 * 16,
	clust_size      = 5,
	y_max           = 31000,
	y_min           = -128,
	noise_threshold = 0.0,
	noise_params    = {
		offset = 0.5,
		scale = 0.2,
		spread = {x = 5, y = 5, z = 5},
		seed = 2316,
		octaves = 1,
		persist = 0.0
	},
})

-- Dirt
minetest.register_ore({
	ore_type        = "blob",
	ore             = "sb_core:dirt",
	wherein         = {"sb_core:stone"},
	clust_scarcity  = 16 * 16 * 16,
	clust_size      = 5,
	y_max           = 31000,
	y_min           = -31,
	noise_threshold = 0.0,
	noise_params    = {
		offset = 0.5,
		scale = 0.2,
		spread = {x = 5, y = 5, z = 5},
		seed = 17676,
		octaves = 1,
		persist = 0.0
	},
	-- Only where sb_core:dirt is present as surface material
	biomes = {
		"tavin_plains_snowcap", "tavin_plains", "tavin_plains_dunes", "tavin_plains_ocean",
		"tavin_prairie", "tavin_prairie_ocean",
		"tavin_fungusland", "tavin_fungusland_ocean",
		"tavin_forest_snowcap", "tavin_forest", "tavin_forest_dunes", "tavin_forest_ocean",
		"tavin_taeda_forest_snowcap", "tavin_taeda_forest", "tavin_taeda_forest_shore", "tavin_taeda_forest_ocean",
		"tavin_oki_forest", "tavin_oki_forest_dunes", "tavin_oki_forest_ocean",
		"tavin_savanna", "tavin_savanna_shore", "tavin_savanna_ocean",
		"tavin_swamp", "tavin_swamp_shore", "tavin_swamp_ocean",
		"tavin_scorched_wastes", "tavin_scorched_wastes_shore", "tavin_scorched_wastes_ocean",
	}
})

-- Gravel
minetest.register_ore({
	ore_type        = "blob",
	ore             = "sb_core:gravel",
	wherein         = {"sb_core:stone"},
	clust_scarcity  = 16 * 16 * 16,
	clust_size      = 5,
	y_max           = 31000,
	y_min           = -128,
	noise_threshold = 0.0,
	noise_params    = {
		offset = 0.5,
		scale = 0.2,
		spread = {x = 5, y = 5, z = 5},
		seed = 766,
		octaves = 1,
		persist = 0.0
	},
})



-- Scatter ores

-- Adamas
minetest.register_ore({
		ore_type       = "scatter",
		ore            = "sb_minerals:stone_ore_adamas",
		wherein        = "sb_core:stone",
		clust_scarcity = 36 * 36 * 36,
		clust_num_ores = 3,
		clust_size     = 2,
		y_max          = -64,
		y_min          = -95,
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "sb_minerals:stone_ore_adamas",
		wherein        = "sb_core:stone",
		clust_scarcity = 28 * 28 * 28,
		clust_num_ores = 5,
		clust_size     = 3,
		y_max          = -96,
		y_min          = -128,
	})

-- Aurum
minetest.register_ore({
	ore_type       = "scatter",
	ore            = "sb_minerals:stone_ore_aurem",
	wherein        = "sb_core:stone",
	clust_scarcity = 15 * 15 * 15,
	clust_num_ores = 3,
	clust_size     = 2,
	y_max          = -64,
	y_min          = -95,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "sb_minerals:stone_ore_aurem",
	wherein        = "sb_core:stone",
	clust_scarcity = 13 * 13 * 13,
	clust_num_ores = 5,
	clust_size     = 3,
	y_max          = -96,
	y_min          = -128,
})

-- Coal
minetest.register_ore({
	ore_type       = "scatter",
	ore            = "sb_minerals:stone_ore_coal",
	wherein        = "sb_core:stone",
	clust_scarcity = 8 * 8 * 8,
	clust_num_ores = 8,
	clust_size     = 3,
	y_max          = 64,
	y_min          = -63,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "sb_minerals:stone_ore_coal",
	wherein        = "sb_core:stone",
	clust_scarcity = 12 * 12 * 12,
	clust_num_ores = 30,
	clust_size     = 5,
	y_max          = -64,
	y_min          = -128,
})

-- Cuprum
minetest.register_ore({
	ore_type       = "scatter",
	ore            = "sb_minerals:stone_ore_cuprum",
	wherein        = "sb_core:stone",
	clust_scarcity = 12 * 12 * 12,
	clust_num_ores = 4,
	clust_size     = 3,
	y_max          = -64,
	y_min          = -95,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "sb_minerals:stone_ore_cuprum",
	wherein        = "sb_core:stone",
	clust_scarcity = 9 * 9 * 9,
	clust_num_ores = 5,
	clust_size     = 3,
	y_max          = -96,
	y_min          = -128,
})

-- Ferrum

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "sb_minerals:stone_ore_ferrum",
	wherein        = "sb_core:stone",
	clust_scarcity = 7 * 7 * 7,
	clust_num_ores = 5,
	clust_size     = 3,
	y_max          = -64,
	y_min          = -95,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "sb_minerals:stone_ore_ferrum",
	wherein        = "sb_core:stone",
	clust_scarcity = 12 * 12 * 12,
	clust_num_ores = 29,
	clust_size     = 5,
	y_max          = -96,
	y_min          = -128,
})

-- Stannum
minetest.register_ore({
	ore_type       = "scatter",
	ore            = "sb_minerals:stone_ore_stannum",
	wherein        = "sb_core:stone",
	clust_scarcity = 13 * 13 * 13,
	clust_num_ores = 4,
	clust_size     = 3,
	y_max          = -64,
	y_min          = -95,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "sb_minerals:stone_ore_stannum",
	wherein        = "sb_core:stone",
	clust_scarcity = 10 * 10 * 10,
	clust_num_ores = 5,
	clust_size     = 3,
	y_max          = -96,
	y_min          = -128,
})

-- Uran
minetest.register_ore({
	ore_type       = "scatter",
	ore            = "sb_minerals:stone_ore_uran",
	wherein        = "sb_core:stone",
	clust_scarcity = 18 * 18 * 18,
	clust_num_ores = 3,
	clust_size     = 2,
	y_max          = -64,
	y_min          = -95,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "sb_minerals:stone_ore_uran",
	wherein        = "sb_core:stone",
	clust_scarcity = 14 * 14 * 14,
	clust_num_ores = 5,
	clust_size     = 3,
	y_max          = -96,
	y_min          = -128,
})

-- Wolfram
minetest.register_ore({
	ore_type       = "scatter",
	ore            = "sb_minerals:stone_ore_adamas",
	wherein        = "sb_core:stone",
	clust_scarcity = 17 * 17 * 17,
	clust_num_ores = 4,
	clust_size     = 3,
	y_max          = -64,
	y_min          = -95,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "sb_minerals:stone_ore_adamas",
	wherein        = "sb_core:stone",
	clust_scarcity = 15 * 15 * 15,
	clust_num_ores = 4,
	clust_size     = 3,
	y_max          = -96,
	y_min          = -128,
})