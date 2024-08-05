
-- these tell minetest what nodes to generate in the world
minetest.register_alias("mapgen_stone", "nabm_stone:stone")
minetest.register_alias("mapgen_water_source", "nabm_liquids:water_source")
minetest.register_alias("mapgen_river_water_source", "nabm_liquids:water_source")

nabm_mapgen = {}

local mod_name = minetest.get_current_modname()
local mod_path = minetest.get_modpath(mod_name)

function nabm_mapgen.get_schematic_path(name)
    return (mod_path .. DIR_DELIM .. "schematics" .. DIR_DELIM .. name .. ".mts")
end

-- biomes
dofile(mod_path .. DIR_DELIM .. "biomes" .. DIR_DELIM .. "grasslands.lua")
dofile(mod_path .. DIR_DELIM .. "biomes" .. DIR_DELIM .. "ocean.lua")
