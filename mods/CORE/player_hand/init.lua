

--  add hand tool
minetest.override_item("", {
	wield_scale = { x = 1, y = 1, z = 1 },
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level = 0,
		groupcaps = {
            oddly_breakable_by_hand = {
                times = { 0.1, 0.7, 2 },
                uses = 0,
            },
			crumbly = {
				times = {
					 [1]=0.05,  [2]=0.15,  [3]=0.30,  [4]=0.45,  [5]=0.60,
					 [6]=0.75,  [7]=0.90,  [8]=1.05,  [9]=1.20, [10]=1.50,
					[11]=2.25, [12]=3.00, [13]=3.75, [14]=4.50,
				},
                uses = 0,
            },
			choppy = {
				times = {
					 [1]=0.05,  [2]=0.10,  [3]=0.30,  [4]=0.40,  [5]=0.75,
					 [6]=0.90,  [7]=1.00,  [8]=1.05,
				},
				uses = 0,
			},
        },
		damage_groups = {fleshy = 1},
	}
})
