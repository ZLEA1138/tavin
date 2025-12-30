local mod_name = minetest.get_current_modname()
local mod_path = minetest.get_modpath(mod_name)

-- Turn dirt and grass to paths (from Path by Atlante)
local function is_attached_bottom(pos)
    local node = minetest.get_node(pos)
    local def = minetest.registered_nodes[pos]
    local paramtype2 = def and def.paramtype2 or "none"
    local attach_group = minetest.get_item_group(node.name, "attached_node")

    if attach_group == 3 then
        return true
    elseif attach_group == 1 then
        if paramtype2 == "wallmounted" then
            return minetest.wallmounted_to_dir(node.param2).y == -1
        end
        return true
    elseif attach_group == 2
        and paramtype2 == "facedir" -- 4dir won't attach to bottom
        and minetest.facedir_to_dir(node.param2).y == -1 then
        return true
    end
    return false
end

local function shovel_on_place(itemstack, user, pointed_thing)
    if pointed_thing.type ~= "node" then
        return itemstack
    end
    local pos = pointed_thing.under
    local under_node = minetest.get_node(pos)
    local under_def = minetest.registered_nodes[under_node.name]
    if under_def and under_def.on_rightclick then
        return under_def.on_rightclick(pos, under_node, user, itemstack, pointed_thing)
    end
    if vector.subtract(pointed_thing.above, pos).y ~= 1 then
        -- only allow from top
        return itemstack
    end

    local tool_def = minetest.registered_tools[itemstack:get_name()]
    local uses = 100
    if tool_def.tool_capabilities
        and tool_def.tool_capabilities.groupcaps
        and tool_def.tool_capabilities.groupcaps.crumbly then
        uses = tool_def.tool_capabilities.groupcaps.crumbly.uses or 100
    end
    local wear = minetest.get_tool_wear_after_use(uses)

    local node = minetest.get_node(pos)
    local node_def = minetest.registered_nodes[node.name]
    local name = user:get_player_name()

    if node_def and node_def.groups and node_def.groups.pathable == 1 then
        if minetest.is_protected(pos, name) then
            minetest.record_protection_violation(pos, name)
            return itemstack
        end
        local pos_above = {x = pos.x, y = pos.y + 1, z = pos.z}
        local node_above = minetest.get_node(pos_above)
        if is_attached_bottom(pos_above) then
            if minetest.is_protected(pos_above, name) then
                minetest.record_protection_violation(pos_above, name)
                return itemstack
            end
            drop_attached_node(pos_above)
        elseif node_above.name ~= "air" then
            return itemstack
        end
        minetest.set_node(pos, {name = "sb_core:dirt_path"})
        if not minetest.is_creative_enabled(name) then
            itemstack:add_wear(wear)
        end
    end
    return itemstack
end

-- WOOD
minetest.register_tool("sb_tools:shovel_wood", {
	description = "Wooden Shovel",
	inventory_image = "shovel_wood.png",
	wield_image = "shovel_wood.png^[transformR90",
	tool_capabilities = {
		full_punch_interval = 1.2,
		max_drop_level=1,
		groupcaps={
			crumbly = {
				times = mining.max_time(75.00, 1),
				uses=60,
				maxlevel=1
			},
		},
		damage_groups = {fleshy=2},
	},
	sound = {breaks = "tool_breaks"},
	groups = {shovel = 1, shovel_level_1 = 1, flammable = 2},
	on_place = shovel_on_place
})

core.register_craft({
    output = "sb_tools:shovel_wood",
    recipe = {
        {"group:planks"},
        {"group:stick"},
		{"group:stick"},
    }
})

core.register_craft({
    type = "fuel",
    recipe = "sb_tools:shovel_wood",
    burntime = 10,
})

-- STONE
minetest.register_tool("sb_tools:shovel_stone", {
	description = "Stone Shovel",
	inventory_image = "shovel_stone.png",
	wield_image = "shovel_stone.png^[transformR90",
	tool_capabilities = {
		full_punch_interval = 1.3,
		max_drop_level=2,
		groupcaps={
			crumbly = {
				times = mining.max_time(37.50, 2),
				uses=132,
				maxlevel=2
			},
		},
		damage_groups = {fleshy=3},
	},
	sound = {breaks = "tool_breaks"},
	groups = {shovel = 1, shovel_level_1 = 1, shovel_level_2 = 1},
	on_place = shovel_on_place
})

core.register_craft({
    output = "sb_tools:shovel_stone",
    recipe = {
        {"group:stone"},
        {"group:stick"},
		{"group:stick"},
    }
})

-- AEREUS
minetest.register_tool("sb_tools:shovel_aereus", {
	description = "Aereus Shovel",
	inventory_image = "shovel_aereus.png",
	wield_image = "shovel_aereus.png^[transformR90",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=3,
		groupcaps={
			crumbly = {
				times = mining.max_time(30.00, 3),
				uses=260,
				maxlevel=3
			},
		},
		damage_groups = {fleshy=4},
	},
	sound = {breaks = "tool_breaks"},
	groups = {shovel = 1, shovel_level_1 = 1, shovel_level_2 = 1, shovel_level_3 = 1},
	on_place = shovel_on_place
})

core.register_craft({
    output = "sb_tools:shovel_aereus",
    recipe = {
        {"sb_minerals:aereus_ingot"},
        {"group:stick"},
		{"group:stick"},
    }
})

-- FERRUM
minetest.register_tool("sb_tools:shovel_ferrum", {
	description = "Ferrum Shovel",
	inventory_image = "shovel_ferrum.png",
	wield_image = "shovel_ferrum.png^[transformR90",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=3,
		groupcaps={
			crumbly = {
				times = mining.max_time(25.00, 3),
				uses=250,
				maxlevel=3
			},
		},
		damage_groups = {fleshy=4},
	},
	sound = {breaks = "tool_breaks"},
	groups = {shovel = 1, shovel_level_1 = 1, shovel_level_2 = 1, shovel_level_3 = 1},
	on_place = shovel_on_place
})

core.register_craft({
    output = "sb_tools:shovel_ferrum",
    recipe = {
        {"sb_minerals:ferrum_ingot"},
        {"group:stick"},
		{"group:stick"},
    }
})

-- AUREM
minetest.register_tool("sb_tools:shovel_aurem", {
	description = "Aurem Shovel",
	inventory_image = "shovel_aurem.png",
	wield_image = "shovel_aurem.png^[transformR90",
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level=3,
		groupcaps={
			crumbly = {
				times = mining.max_time(12.50, 3),
				uses=32,
				maxlevel=3
			},
		},
		damage_groups = {fleshy=2},
	},
	sound = {breaks = "tool_breaks"},
	groups = {shovel = 1, shovel_level_1 = 1, shovel_level_2 = 1, shovel_level_3 = 1},
	on_place = shovel_on_place
})

core.register_craft({
    output = "sb_tools:shovel_aurem",
    recipe = {
        {"sb_minerals:aurem_ingot"},
        {"group:stick"},
		{"group:stick"},
    }
})

-- WOLFRAM
minetest.register_tool("sb_tools:shovel_wolfram", {
	description = "Wolfram Shovel",
	inventory_image = "shovel_wolfram.png",
	wield_image = "shovel_wolfram.png^[transformR90",
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level=4,
		groupcaps={
			crumbly = {
				times = mining.max_time(19.00, 4),
				uses=1562,
				maxlevel=4
			},
		},
		damage_groups = {fleshy=5},
	},
	sound = {breaks = "tool_breaks"},
	groups = {shovel = 1, shovel_level_1 = 1, shovel_level_2 = 1, shovel_level_3 = 1, shovel_level_4 = 1},
	on_place = shovel_on_place
})

core.register_craft({
    output = "sb_tools:shovel_wolfram",
    recipe = {
        {"sb_minerals:wolfram_ingot"},
        {"group:stick"},
		{"group:stick"},
    }
})