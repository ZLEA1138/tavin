local dyes = sb_dye.dyes

for i = 1, #dyes do
	local name, desc = unpack(dyes[i])

	local color_group = "color_" .. name

	minetest.register_node("sb_cloth:" .. name, {
		description = desc .. " Cloth",
		tiles = {"cloth_" .. name .. ".png"},
		is_ground_content = false,
		groups = {
			crumbly = mining.hardness(0.8, 0),
			cracky = mining.hardness(0.8, -1),
			choppy = mining.hardness(0.8, -1),
			snappy = mining.hardness(0.8, -1),
			oddly_breakable_by_hand = mining.hardness(0.8, 0),
			flammable = 3,
			cloth = 1,
			[color_group] = 1
		},
		sounds = sounds.node_sound_defaults(),
	})
	
	minetest.register_craft({
		type = "shapeless",
		output = "sb_cloth:" .. name,
		recipe = {"group:cloth", "sb_dye:" .. name},
	})
end

minetest.register_craft({
	output = "sb_cloth:white",
	recipe = {
		{"sb_farming:strandflower", "sb_farming:strandflower"},
		{"sb_farming:strandflower", "sb_farming:strandflower"},
	}
})