
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
dofile(mod_path .. DIR_DELIM .. "biomes" .. DIR_DELIM .. "grasslands.lua")
dofile(mod_path .. DIR_DELIM .. "biomes" .. DIR_DELIM .. "ocean.lua")
dofile(mod_path .. DIR_DELIM .. "biomes" .. DIR_DELIM .. "savanna.lua")
dofile(mod_path .. DIR_DELIM .. "biomes" .. DIR_DELIM .. "tundra.lua")