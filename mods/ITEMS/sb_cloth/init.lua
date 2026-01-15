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

core.register_alias("cloth_white", "sb_cloth:white")
core.register_alias("cloth_light_gray", "sb_cloth:light_gray")
core.register_alias("cloth_gray", "sb_cloth:gray")
core.register_alias("cloth_black", "sb_cloth:black")
core.register_alias("cloth_brown", "sb_cloth:brown")
core.register_alias("cloth_red", "sb_cloth:red")
core.register_alias("cloth_orange", "sb_cloth:orange")
core.register_alias("cloth_yellow", "sb_cloth:yellow")
core.register_alias("cloth_light_green", "sb_cloth:light_green")
core.register_alias("cloth_green", "sb_cloth:green")
core.register_alias("cloth_cyan", "sb_cloth:cyan")
core.register_alias("cloth_light_blue", "sb_cloth:light_blue")
core.register_alias("cloth_blue", "sb_cloth:blue")
core.register_alias("cloth_purple", "sb_cloth:purple")
core.register_alias("cloth_magenta", "sb_cloth:magenta")
core.register_alias("cloth_pink", "sb_cloth:pink")

minetest.register_craft({
	output = "sb_cloth:white",
	recipe = {
		{"sb_farming:strandflower", "sb_farming:strandflower"},
		{"sb_farming:strandflower", "sb_farming:strandflower"},
	}
})