local mod_name = minetest.get_current_modname()
local mod_path = minetest.get_modpath(mod_name)

sb_core = {}

-- makes nodes
dofile(mod_path .. DIR_DELIM .. "nodes_base.lua")
dofile(mod_path .. DIR_DELIM .. "nodes_bedrock.lua")
dofile(mod_path .. DIR_DELIM .. "nodes_chest.lua")
dofile(mod_path .. DIR_DELIM .. "nodes_climbable.lua")
dofile(mod_path .. DIR_DELIM .. "nodes_decor.lua")
dofile(mod_path .. DIR_DELIM .. "nodes_fencegate.lua")
dofile(mod_path .. DIR_DELIM .. "nodes_glass.lua")
dofile(mod_path .. DIR_DELIM .. "nodes_liquid.lua")
dofile(mod_path .. DIR_DELIM .. "nodes_plants.lua")
dofile(mod_path .. DIR_DELIM .. "nodes_trees.lua")
dofile(mod_path .. DIR_DELIM .. "nodes_walls.lua")
dofile(mod_path .. DIR_DELIM .. "craftitems.lua")
dofile(mod_path .. DIR_DELIM .. "abms.lua")