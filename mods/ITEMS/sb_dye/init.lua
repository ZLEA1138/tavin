-- Based on dye mod from Minetest Game

sb_dye = {}

-- Make dye names and descriptions available globally
sb_dye.dyes = {
	{"white",       "White"},
	{"light_gray",  "Light Gray"},
	{"gray",        "Gray"},
	{"black",       "Black"},
	{"brown",       "Brown"},
	{"red",         "Red"},
	{"orange",      "Orange"},
	{"yellow",      "Yellow"},
	{"light_green", "Light Green"},
	{"green",       "Green"},
	{"cyan",        "Cyan"},
	{"light_blue",  "Light Blue"},
	{"blue",        "Blue"},
	{"purple",      "Purple"},
	{"magenta",     "Magenta"},
	{"pink",        "Pink"},
}

-- Define items
for _, row in ipairs(sb_dye.dyes) do
	local name = row[1]
	local description = row[2]
	local groups = {dye = 1}
	groups["color_" .. name] = 1

	minetest.register_craftitem("sb_dye:" .. name, {
		inventory_image = "dye_" .. name .. ".png",
		description = description .. " Dye",
		groups = groups
	})

	minetest.register_craft({
		output = "sb_dye:" .. name .. " 4",
		recipe = {
			{"group:flower,color_" .. name}
		},
	})
end

-- Manually add coal -> black dye
minetest.register_craft({
	output = "sb_dye:black 4",
	recipe = {
		{"group:coal"}
	},
})

-- Manually add blueberries->purple dye

minetest.register_craft({
	output = "sb_dye:purple 2",
	recipe = {
		{"default:blueberries"}
	},
})

-- Mix recipes

local dye_recipes = {
	-- src1, src2, dst
	-- RYB mixes
	{"red", "blue", "purple"},
	{"yellow", "red", "orange"},
	{"yellow", "blue", "light_green"},
	-- RYB complementary mixes
	{"yellow", "purple", "gray"},
	{"blue", "orange", "gray"},
	-- CMY mixes - approximation
	{"cyan", "yellow", "light_green"},
	{"cyan", "magenta", "blue"},
	{"yellow", "magenta", "red"},
	-- other mixes that result in a color we have
	{"red", "light_green", "brown"},
	{"magenta", "blue", "purple"},
	{"light_green", "blue", "cyan"},
	{"pink", "purple", "magenta"},
	-- mixes with black
	{"white", "black", "light_gray"},
	{"light_gray", "black", "gray"},
	{"light_green", "black", "green"},
	{"orange", "black", "brown"},
	-- mixes with white
	{"white", "red", "pink"},
	{"white", "gray", "light_gray"},
	{"white", "green", "light_green"},
	{"white", "blue", "light_blue"},
}

for _, mix in pairs(dye_recipes) do
	minetest.register_craft({
		type = "shapeless",
		output = "sb_dye:" .. mix[3] .. " 2",
		recipe = {"sb_dye:" .. mix[1], "sb_dye:" .. mix[2]},
	})
end