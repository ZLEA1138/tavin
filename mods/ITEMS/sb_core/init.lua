local mod_name = minetest.get_current_modname()
local mod_path = minetest.get_modpath(mod_name)

sb_core = {}

-- makes nodes
dofile(mod_path .. DIR_DELIM .. "nodes_base.lua")
dofile(mod_path .. DIR_DELIM .. "nodes_liquid.lua")
dofile(mod_path .. DIR_DELIM .. "nodes_trees.lua")
dofile(mod_path .. DIR_DELIM .. "abms.lua")