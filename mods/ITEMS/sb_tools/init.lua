local mod_name = minetest.get_current_modname()
local mod_path = minetest.get_modpath(mod_name)

sb_minerals = {}

-- makes nodes
dofile(mod_path .. DIR_DELIM .. "pick.lua")
dofile(mod_path .. DIR_DELIM .. "sword.lua")
dofile(mod_path .. DIR_DELIM .. "axe.lua")
dofile(mod_path .. DIR_DELIM .. "shovel.lua")