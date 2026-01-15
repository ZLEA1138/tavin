local mod_name = minetest.get_current_modname()
local mod_path = minetest.get_modpath(mod_name)

local bedrock = {}

bedrock.layer = -128

minetest.register_node("sb_core:bedrock", {
	description = "Bedrock",
	tiles = {"bedrock.png"},
	is_ground_content = false,
	on_blast = function() end,
	on_destruct = function() end,
	can_dig = function() return false end,
	diggable = false,
	groups = {
		immortal = 1,
		unbreakable = 1,
		not_in_creative_inventory = 1
	},
	drop = "",
	sounds = sounds.node_sound_stone_defaults(),
})

core.register_alias("bedrock", "sb_core:bedrock")

-- Based on bedrock2 by Wuzzy
minetest.register_on_generated(function(minp, maxp)
	if maxp.y >= bedrock.layer and minp.y <= bedrock.layer then
		local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
		local data = vm:get_data()
		local area = VoxelArea:new({MinEdge=emin, MaxEdge=emax})
		local c_bedrock = minetest.get_content_id("sb_core:bedrock")

		for x = minp.x, maxp.x do
			for z = minp.z, maxp.z do
				local p_pos = area:index(x, bedrock.layer, z)
				data[p_pos] = c_bedrock
			end
		end

		vm:set_data(data)
		vm:calc_lighting()
		vm:update_liquids()
		vm:write_to_map()
	end
end)