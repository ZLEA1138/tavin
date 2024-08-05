local sealevel = 0
local alt_max = 1000
local alt_min = -1000

local this_biome = "nabm_ocean"

-------------------------------
------------ BIOME ------------
-------------------------------

minetest.register_biome({
    name = this_biome,

    node_top = "nabm_soil:sand",
    depth_top = 1,

    node_filler = "nabm_soil:sand",
    depth_filler = 5,

    node_riverbed = "nabm_soil:sand",
    depth_riverbed = 3,

    y_max = sealevel,
    y_min = alt_min,
    vertical_blend = 2,

    heat_point = 50,
    humidity_point = 90,
}, {"ocean", "overworld"})
