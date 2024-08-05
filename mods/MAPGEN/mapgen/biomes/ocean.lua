local sealevel = 0
local alt_max = 1000
local alt_min = -1000

local this_biome = "ocean"

-------------------------------
------------ BIOME ------------
-------------------------------

minetest.register_biome({
    name = this_biome,

    node_top = "sb_core:sand",
    depth_top = 1,

    node_filler = "sb_core:sand",
    depth_filler = 5,

    node_riverbed = "sb_core:sand",
    depth_riverbed = 3,

    y_max = sealevel,
    y_min = alt_min,
    vertical_blend = 2,

    heat_point = 50,
    humidity_point = 90,
}, {"ocean", "overworld"})
