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

core.register_alias("carpet_white", "sb_carpets:white")
core.register_alias("carpet_light_gray", "sb_carpets:light_gray")
core.register_alias("carpet_gray", "sb_carpets:gray")
core.register_alias("carpet_black", "sb_carpets:black")
core.register_alias("carpet_brown", "sb_carpets:brown")
core.register_alias("carpet_red", "sb_carpets:red")
core.register_alias("carpet_orange", "sb_carpets:orange")
core.register_alias("carpet_yellow", "sb_carpets:yellow")
core.register_alias("carpet_light_green", "sb_carpets:light_green")
core.register_alias("carpet_green", "sb_carpets:green")
core.register_alias("carpet_cyan", "sb_carpets:cyan")
core.register_alias("carpet_light_blue", "sb_carpets:light_blue")
core.register_alias("carpet_blue", "sb_carpets:blue")
core.register_alias("carpet_purple", "sb_carpets:purple")
core.register_alias("carpet_magenta", "sb_carpets:magenta")
core.register_alias("carpet_pink", "sb_carpets:pink")