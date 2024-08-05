

--  add hand tool
minetest.override_item("", {
	wield_scale = { x = 1, y = 1, z = 1 },
	tool_capabilities = {
		full_punch_interval = 0.5,
		max_drop_level = 0,
		groupcaps = {
            oddly_breakable_by_hand = {
                times = { 0.1, 0.3, 2 },
                uses = 0,
            },
            cracky = {
                times = { 0.5, 0.8, 2 },
                uses = 0,
            },
        },
		damage_groups = { fleshy = 1 },
	}
})
