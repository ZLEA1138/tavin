--  add hand tool
minetest.override_item("", {
	wield_scale = { x = 1, y = 1, z = 1 },
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level = 0,
		groupcaps = {
            oddly_breakable_by_hand = {
                times = {
					 [1]=0.05,   [2]=0.15,   [3]=0.30,   [4]=0.40,   [5]=0.45,
					 [6]=0.50,   [7]=0.60,   [8]=0.75,   [9]=0.90,  [10]=1.00,
					[11]=1.05,  [12]=1.15,  [13]=1.20,  [14]=1.50,  [15]=2.25,
					[16]=3.00,  [17]=3.75,  [18]=4.20,  [19]=4.50,  [20]=5.25,
					[21]=7.50,  [22]=12.50, [23]=15.00, [24]=20.00,
				},
                uses = 0,
            },
        },
		damage_groups = {fleshy = 1},
	}
})
