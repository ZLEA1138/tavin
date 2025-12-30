local mod_name = minetest.get_current_modname()
local mod_path = minetest.get_modpath(mod_name)

-- Cobblestone Wall
functions.register_wall("sb_core:wall_cobble",
	"Cobblestone Wall",
	{"cobble.png"},
	{
		crumbly = mining.hardness(2, -2),
		cracky = mining.hardness(2, 1),
		choppy = mining.hardness(2, -2),
		snappy = mining.hardness(2, -2),
		oddly_breakable_by_hand = mining.hardness(2, -2),
		wall = 1,
		stone = 2
	},
	"sb_core:cobble",
	sounds.node_sound_stone_defaults()
)

-- Mossy Cobblestone Wall
functions.register_wall("sb_core:wall_cobble_mossy",
	"Mossy Cobblestone Wall",
	{"cobble_mossy.png"},
	{
		crumbly = mining.hardness(2, -2),
		cracky = mining.hardness(2, 1),
		choppy = mining.hardness(2, -2),
		snappy = mining.hardness(2, -2),
		oddly_breakable_by_hand = mining.hardness(2, -2),
		wall = 1,
		stone = 2
	},
	"sb_core:cobble_mossy",
	sounds.node_sound_stone_defaults()
)

-- Stone Brick Wall
functions.register_wall("sb_core:wall_stone_brick",
	"Stone Brick Wall",
	{"stone_bricks.png"},
	{
		crumbly = mining.hardness(1.5, -2),
		cracky = mining.hardness(1.5, 1),
		choppy = mining.hardness(1.5, -2),
		snappy = mining.hardness(1.5, -2),
		oddly_breakable_by_hand = mining.hardness(1.5, -2),
		wall = 1,
		stone = 2
	},
	"sb_core:stone_bricks",
	sounds.node_sound_stone_defaults()
)

-- Mossy Stone Brick Wall
functions.register_wall("sb_core:wall_stone_brick_mossy",
	"Mossy Stone Brick Wall",
	{"stone_bricks_mossy.png"},
	{
		crumbly = mining.hardness(1.5, -2),
		cracky = mining.hardness(1.5, 1),
		choppy = mining.hardness(1.5, -2),
		snappy = mining.hardness(1.5, -2),
		oddly_breakable_by_hand = mining.hardness(1.5, -2),
		wall = 1,
		stone = 2
	},
	"sb_core:stone_bricks_mossy",
	sounds.node_sound_stone_defaults()
)

-- Brick Wall
functions.register_wall("sb_core:wall_brick",
	"Brick Wall",
	{"bricks.png"},
	{
		crumbly = mining.hardness(2, -2),
		cracky = mining.hardness(2, 1),
		choppy = mining.hardness(2, -2),
		snappy = mining.hardness(2, -2),
		oddly_breakable_by_hand = mining.hardness(2, -2),
		wall = 1,
		stone = 2
	},
	"sb_core:bricks",
	sounds.node_sound_stone_defaults()
)

-- Mud Brick Wall
functions.register_wall("sb_core:wall_mud_brick",
	"Mud Brick Wall",
	{"mud_bricks.png"},
	{
		crumbly = mining.hardness(1.5, -2),
		cracky = mining.hardness(1.5, 1),
		choppy = mining.hardness(1.5, -2),
		snappy = mining.hardness(1.5, -2),
		oddly_breakable_by_hand = mining.hardness(1.5, -2),
		wall = 1,
		stone = 2
	},
	"sb_core:mud_bricks",
	sounds.node_sound_stone_defaults()
)

-- Sandstone Wall
functions.register_wall("sb_core:wall_sandstone",
	"Sandstone Wall",
	{"sandstone.png"},
	{
		crumbly = mining.hardness(0.5, -2),
		cracky = mining.hardness(0.5, 1),
		choppy = mining.hardness(0.5, -2),
		snappy = mining.hardness(0.5, -2),
		oddly_breakable_by_hand = mining.hardness(0.5, -2),
		wall = 1,
		stone = 2
	},
	"sb_core:sandstone",
	sounds.node_sound_stone_defaults()
)

-- Desert Sandstone Wall
functions.register_wall("sb_core:wall_sandstone_desert",
	"Desert Sandstone Wall",
	{"sandstone_desert.png"},
	{
		crumbly = mining.hardness(0.5, -2),
		cracky = mining.hardness(0.5, 1),
		choppy = mining.hardness(0.5, -2),
		snappy = mining.hardness(0.5, -2),
		oddly_breakable_by_hand = mining.hardness(0.5, -2),
		wall = 1,
		stone = 2
	},
	"sb_core:sandstone_desert",
	sounds.node_sound_stone_defaults()
)

-- Sandstone Brick Wall
functions.register_wall("sb_core:wall_sandstone_bricks",
	"Sandstone Brick Wall",
	{"sandstone_bricks.png"},
	{
		crumbly = mining.hardness(0.8, -2),
		cracky = mining.hardness(0.8, 1),
		choppy = mining.hardness(0.8, -2),
		snappy = mining.hardness(0.8, -2),
		oddly_breakable_by_hand = mining.hardness(0.8, -2),
		wall = 1,
		stone = 2
	},
	"sb_core:sandstone_bricks",
	sounds.node_sound_stone_defaults()
)

-- Desert Sandstone Brick Wall
functions.register_wall("sb_core:wall_sandstone_bricks_desert",
	"Desert Sandstone Brick Wall",
	{"sandstone_bricks_desert.png"},
	{
		crumbly = mining.hardness(0.8, -2),
		cracky = mining.hardness(0.8, 1),
		choppy = mining.hardness(0.8, -2),
		snappy = mining.hardness(0.8, -2),
		oddly_breakable_by_hand = mining.hardness(0.8, -2),
		wall = 1,
		stone = 2
	},
	"sb_core:sandstone_bricks_desert",
	sounds.node_sound_stone_defaults()
)