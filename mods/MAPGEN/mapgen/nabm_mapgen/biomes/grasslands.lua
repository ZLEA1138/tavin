local sealevel = 0
local alt_max = 1000
local alt_min = -1000

local this_biome = "nabm_grasslands"

-------------------------------
------------ BIOME ------------
-------------------------------

minetest.register_biome({
    name = this_biome,

    node_top = "nabm_soil:grass",
    depth_top = 1,

    node_filler = "nabm_soil:dirt",
    depth_filler = 5,

    node_riverbed = "nabm_soil:sand",
    depth_riverbed = 3,

    y_max = alt_max,
    y_min = sealevel,
    vertical_blend = 2,

    heat_point = 50,
    humidity_point = 50,
}, {"field", "overworld", "clearing"})

-------------------------------
--------- DECORATIONS ---------
-------------------------------

local sch = nabm_mapgen.get_schematic_path

-- sparse "trees"
minetest.register_decoration({
    deco_type = "schematic",
    place_on = {"group:soil"},
    sidelen = 80,
    noise_params = {
        offset = 0,
        scale = 0.01,
        spread = {x = 10, y = 10, z = 10},
        seed = 69,
        octaves = 4,
        persistence = 0.2,
        lacunarity = 1.0,
    },
    y_max = alt_max,
    y_min = sealevel,
    schematic = sch("not_actually_a_tree_0"),
    flags = "place_center_x, place_center_z",
    rotation = "random",
    biomes = {this_biome},
})
