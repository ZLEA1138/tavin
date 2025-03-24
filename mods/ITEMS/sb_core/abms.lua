
-- Change dirt to grass when near grass
minetest.register_abm({
    nodenames = {"group:spreads_to_dirt"},
    neighbors = {"group:grass_can_grow"},
    interval = 25.0,
    chance = 5,
    action = function(pos, node, active_object_count, active_object_count_wider)
        local nodes = minetest.find_nodes_in_area_under_air(
            vector.offset(pos, -1, -1, -1),
            vector.offset(pos,  1,  1,  1),
            {"group:grass_can_grow"})
        local spread_pos = nil
        for index, value in pairs(nodes) do
            spread_pos = value
            break
        end
        if not spread_pos then
            return
        end
        minetest.set_node(spread_pos, {name = node.name})
    end
})

-- Change grass to dirt when suffocated by solid block above
minetest.register_abm({
    nodenames = {"sb_core:dirt_grass_forest"},
    neighbors = {"group:solid"},
    interval = 25.0,
    chance = 5,
    action = function(pos, node, active_object_count, active_object_count_wider)
        if minetest.get_item_group(minetest.get_node(vector.offset(pos, 0, 1, 0)).name, "solid") ~= 0 then
            minetest.set_node(pos, {name = "sb_core:dirt"})
        end
    end
})

minetest.register_abm({
    nodenames = {"sb_core:dirt_mycelium"},
    neighbors = {"group:solid"},
    interval = 25.0,
    chance = 5,
    action = function(pos, node, active_object_count, active_object_count_wider)
        if minetest.get_item_group(minetest.get_node(vector.offset(pos, 0, 1, 0)).name, "solid") ~= 0 then
            minetest.set_node(pos, {name = "sb_core:dirt"})
        end
    end
})

minetest.register_abm({
    nodenames = {"sb_core:dirt_grass_plains"},
    neighbors = {"group:solid"},
    interval = 25.0,
    chance = 5,
    action = function(pos, node, active_object_count, active_object_count_wider)
        if minetest.get_item_group(minetest.get_node(vector.offset(pos, 0, 1, 0)).name, "solid") ~= 0 then
            minetest.set_node(pos, {name = "sb_core:dirt"})
        end
    end
})

minetest.register_abm({
    nodenames = {"sb_core:dirt_grass_prairie"},
    neighbors = {"group:solid"},
    interval = 25.0,
    chance = 5,
    action = function(pos, node, active_object_count, active_object_count_wider)
        if minetest.get_item_group(minetest.get_node(vector.offset(pos, 0, 1, 0)).name, "solid") ~= 0 then
            minetest.set_node(pos, {name = "sb_core:dirt"})
        end
    end
})

minetest.register_abm({
    nodenames = {"sb_core:dirt_grass_savanna"},
    neighbors = {"group:solid"},
    interval = 25.0,
    chance = 5,
    action = function(pos, node, active_object_count, active_object_count_wider)
        if minetest.get_item_group(minetest.get_node(vector.offset(pos, 0, 1, 0)).name, "solid") ~= 0 then
            minetest.set_node(pos, {name = "sb_core:dirt"})
        end
    end
})

minetest.register_abm({
    nodenames = {"sb_core:dirt_grass_snow"},
    neighbors = {"group:solid"},
    interval = 25.0,
    chance = 5,
    action = function(pos, node, active_object_count, active_object_count_wider)
        if minetest.get_item_group(minetest.get_node(vector.offset(pos, 0, 1, 0)).name, "solid") ~= 0 then
            minetest.set_node(pos, {name = "sb_core:dirt"})
        end
    end
})

minetest.register_abm({
    nodenames = {"sb_core:dirt_grass_swamp"},
    neighbors = {"group:solid"},
    interval = 25.0,
    chance = 5,
    action = function(pos, node, active_object_count, active_object_count_wider)
        if minetest.get_item_group(minetest.get_node(vector.offset(pos, 0, 1, 0)).name, "solid") ~= 0 then
            minetest.set_node(pos, {name = "sb_core:dirt"})
        end
    end
})

-- Moss growth on cobble near water
local moss_correspondences = {
	["sb_core:cobble"] = "sb_core:cobble_mossy",
	["sb_core:stone_bricks"] = "sb_core:stone_bricks_mossy",
}

minetest.register_abm({
	label = "Moss growth",
	nodenames = {"sb_core:cobble", "sb_core:stone_bricks"},
	neighbors = {"group:water"},
	interval = 16,
	chance = 200,
	catch_up = false,
	action = function(pos, node)
		node.name = moss_correspondences[node.name]
		if node.name then
			minetest.set_node(pos, node)
		end
	end
})