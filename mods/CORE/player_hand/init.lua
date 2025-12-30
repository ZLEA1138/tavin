--  add hand tool
minetest.override_item("", {
	wield_scale = { x = 1, y = 1, z = 1 },
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level = 0,
		groupcaps = {
            oddly_breakable_by_hand = {
				times = mining.max_time(150.00, 0),
                uses = 0,
            },
        },
		damage_groups = {fleshy = 1},
	}
})
