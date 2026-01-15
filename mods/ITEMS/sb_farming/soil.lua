-- default dry soil node

local dry_soil = "sb_farming:soil"

-- normal soil

minetest.register_node("sb_farming:soil", {
	description = "Soil",
	tiles = {"dirt.png^soil.png", "dirt.png"},
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			-- 15/16 of the normal height
			{-0.5, -0.5, -0.5, 0.5, 0.4375, 0.5},
		}
	},
	drop = "sb_core:dirt",
	groups = {
		crumbly = mining.hardness(0.8, 0),
		cracky = mining.hardness(0.8, -1),
		choppy = mining.hardness(0.8, -1),
		snappy = mining.hardness(0.8, -1),
		oddly_breakable_by_hand = mining.hardness(0.8, 0),
		not_in_creative_inventory = 1,
		soil = 2,
		grassland = 1,
		field = 1,
		dirtifies_below_solid = 1
	},
	is_ground_content = false,
	sounds = sounds.node_sound_dirt_defaults(),
	soil = {
		base = "sb_core:dirt",
		dry = "sb_farming:soil",
		wet = "sb_farming:soil_wet"
	}
})

core.register_alias("soil", "sb_farming:soil")

-- wet soil

minetest.register_node("sb_farming:soil_wet", {
	description = "Wet Soil",
	tiles = {
		"dirt.png^soil_wet.png",
		"dirt.png^soil_wet_side.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			-- 15/16 of the normal height
			{-0.5, -0.5, -0.5, 0.5, 0.4375, 0.5},
		}
	},
	drop = "sb_core:dirt",
	groups = {
		crumbly = mining.hardness(0.8, 0),
		cracky = mining.hardness(0.8, -1),
		choppy = mining.hardness(0.8, -1),
		snappy = mining.hardness(0.8, -1),
		oddly_breakable_by_hand = mining.hardness(0.8, 0),
		not_in_creative_inventory = 1,
		soil = 3,
		grassland = 1,
		field = 1,
		dirtifies_below_solid = 1
	},
	is_ground_content = false,
	sounds = sounds.node_sound_dirt_defaults(),
	soil = {
		base = "sb_core:dirt", dry = "sb_farming:soil", wet = "sb_farming:soil_wet"
	}
})

-- if water near soil then change to wet soil

minetest.register_abm({
	label = "Soil changes",
	nodenames = {"group:field"},
	interval = 15,
	chance = 4,
	catch_up = false,

	action = function(pos, node)

		local ndef = minetest.registered_nodes[node.name]
		if not ndef or not ndef.soil or not ndef.soil.wet
		or not ndef.soil.base or not ndef.soil.dry then return end

		pos.y = pos.y + 1
		local nn = minetest.get_node_or_nil(pos)
		pos.y = pos.y - 1

		if nn then nn = nn.name else return end

		-- what's on top of soil, if solid/not plant change soil to dirt
		if minetest.registered_nodes[nn]
		and minetest.registered_nodes[nn].walkable
		and minetest.get_item_group(nn, "plant") == 0
		and minetest.get_item_group(nn, "growing") == 0 then

			minetest.set_node(pos, {name = ndef.soil.base})

			return
		end

		-- check if water is within 3 nodes
		if minetest.find_node_near(pos, 3, {"group:water"}) then

			-- only change if it's not already wet soil
			if node.name ~= ndef.soil.wet then
				minetest.set_node(pos, {name = ndef.soil.wet})
			end

		-- only dry out soil if no unloaded blocks nearby, just incase
		elseif not minetest.find_node_near(pos, 3, {"ignore"}) then

			if node.name == ndef.soil.wet then
				minetest.set_node(pos, {name = ndef.soil.dry})

			-- if crop or seed found don't turn to dry soil
			elseif node.name == ndef.soil.dry
			and minetest.get_item_group(nn, "plant") == 0
			and minetest.get_item_group(nn, "growing") == 0 then
				minetest.set_node(pos, {name = ndef.soil.base})
			end
		end
	end
})