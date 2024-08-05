local mod_name = minetest.get_current_modname()
local mod_path = minetest.get_modpath(mod_name)
local S = minetest.get_translator(mod_name)

nabm_soil = {}

-- makes nodes
dofile(mod_path .. DIR_DELIM .. "nodes.lua")
dofile(mod_path .. DIR_DELIM .. "abms.lua")
