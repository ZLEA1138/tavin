local mod_name = minetest.get_current_modname()
local mod_path = minetest.get_modpath(mod_name)

sb_minerals = {}

-- makes nodes
dofile(mod_path .. DIR_DELIM .. "craftitems.lua")
dofile(mod_path .. DIR_DELIM .. "nodes.lua")
dofile(mod_path .. DIR_DELIM .. "ores.lua")