-- Hay Bale
minetest.register_node("sb_farming:hay_bale", {
	description = "Hay Bale",
	tiles = {"hay_bale.png"},
	is_ground_content = false,
	groups = {snappy=5, oddly_breakable_by_hand = 8, flammable=4, fall_damage_add_percent=-30},
	sounds = sounds.node_sound_leaves_defaults(),
})