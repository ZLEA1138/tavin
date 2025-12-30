-- Hay Bale
minetest.register_node("sb_farming:hay_bale", {
	description = "Hay Bale",
	tiles = {"hay_bale.png"},
	is_ground_content = false,
	groups = {
		crumbly = mining.hardness(0.5, -1),
		cracky = mining.hardness(0.5, -1),
		choppy = mining.hardness(0.5, -1),
		snappy = mining.hardness(0.5, 0),
		oddly_breakable_by_hand = mining.hardness(0.5, 0),
		flammable=4,
		fall_damage_add_percent=-30
	},
	sounds = sounds.node_sound_leaves_defaults(),
})