local modpath = minetest.get_modpath(minetest.get_current_modname())
dofile(modpath .. "/api.lua")

if minetest.get_modpath("sb_cloth") then
	local nodes = {
		{name="sb_cloth:white", description="White Carpet"},
		{name="sb_cloth:light_gray", description="Light Gray Carpet"},
		{name="sb_cloth:gray", description="Gray Carpet"},
		{name="sb_cloth:black", description="Black Carpet"},
		{name="sb_cloth:brown", description="Brown Carpet"},
		{name="sb_cloth:red", description="Red Carpet"},
		{name="sb_cloth:orange", description="Orange Carpet"},
		{name="sb_cloth:yellow", description="Yellow Carpet"},
		{name="sb_cloth:light_green", description="Light Green Carpet"},
		{name="sb_cloth:green", description="Green Carpet"},
		{name="sb_cloth:cyan", description="Cyan Carpet"},
		{name="sb_cloth:light_blue", description="Light Blue Carpet"},
		{name="sb_cloth:blue", description="Blue Carpet"},
		{name="sb_cloth:purple", description="Purple Carpet"},
		{name="sb_cloth:magenta", description="Magenta Carpet"},
		{name="sb_cloth:pink", description="Pink Carpet"},
	}
	for _, node in ipairs(nodes) do
		sb_carpets.register(node.name, {description=node.description})
	end
end
