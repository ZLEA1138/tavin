-- Hoe registration function

sb_tools.register_hoe = function(name, def)

	-- Check for : prefix (register new hoes in your mod's namespace)
	if name:sub(1,1) ~= ":" then name = ":" .. name end

	-- Check def table
	if def.description == nil then def.description = S("Hoe") end

	if def.inventory_image == nil then def.inventory_image = "unknown_item.png" end

	if def.max_uses == nil then def.max_uses = 30 end

	-- add hoe group
	def.groups = def.groups or {}
	def.groups.hoe = 1

	-- Register the tool
	minetest.register_tool(name, {
		description = def.description,
		inventory_image = def.inventory_image,
		groups = def.groups,
		sound = {breaks = "tool_breaks"},
		damage_groups = def.damage_groups or {fleshy = 1},

		on_use = function(itemstack, user, pointed_thing)
			return sb_tools.hoe_on_use(itemstack, user, pointed_thing, def.max_uses)
		end
	})

	-- Register its recipe
	if def.recipe then

		minetest.register_craft({
			output = name:sub(2),
			recipe = def.recipe
		})
	elseif def.material then

		minetest.register_craft({
			output = name:sub(2),
			recipe = {
				{def.material, def.material, ""},
				{"", "group:stick", ""},
				{"", "group:stick", ""}
			}
		})
	end
end

-- Turns dirt with group soil=1 into soil

function sb_tools.hoe_on_use(itemstack, user, pointed_thing, uses)

	local pt = pointed_thing or {}
	local is_used = false

	-- am I going to hoe the top of a dirt node?
	if pt.type == "node" and pt.above.y == pt.under.y + 1 then

		local under = minetest.get_node(pt.under)
		local upos = pointed_thing.under

		if minetest.is_protected(upos, user:get_player_name()) then
			minetest.record_protection_violation(upos, user:get_player_name())
			return
		end

		local p = {x = pt.under.x, y = pt.under.y + 1, z = pt.under.z}
		local above = minetest.get_node(p)

		-- return if any of the nodes is not registered
		if not minetest.registered_nodes[under.name]
		or not minetest.registered_nodes[above.name] then return end

		-- check if the node above the pointed thing is air
		if above.name ~= "air" then return end

		-- check if pointing at dirt
		if minetest.get_item_group(under.name, "soil") ~= 1 then return end

		-- check if (wet) soil defined
		local ndef = minetest.registered_nodes[under.name]

		if ndef.soil == nil or ndef.soil.wet == nil or ndef.soil.dry == nil then
			return
		end

		if minetest.is_protected(pt.under, user:get_player_name()) then
			minetest.record_protection_violation(pt.under, user:get_player_name())
			return
		end

		-- turn the node into soil, wear out item and play sound
		minetest.set_node(pt.under, {name = ndef.soil.dry}) ; is_used = true

		minetest.sound_play("dig_crumbly", {pos = pt.under, gain = 0.5}, true)
	end

	local wdef = itemstack:get_definition()
	local wear = 65535 / (uses - 1)

	-- using hoe as weapon
	if pt.type == "object" then

		local ent = pt.ref and pt.ref:get_luaentity()
		local dir = user:get_look_dir()

		if (ent and ent.name ~= "__builtin:item"
		and ent.name ~= "__builtin:falling_node") or pt.ref:is_player() then

			pt.ref:punch(user, nil, {full_punch_interval = 1.0,
					damage_groups = wdef.damage_groups}, dir)

			is_used = true
		end
	end

	-- only when used on soil top or external entity
	if is_used then

		-- cretive doesnt wear tools but toolranks registers uses with wear so set to 1
		if sb_farming.is_creative(user:get_player_name()) then
			if mod_tr then wear = 1 else wear = 0 end
		end

		if mod_tr then
			itemstack = toolranks.new_afteruse(itemstack, user, under, {wear = wear})
		else
			itemstack:add_wear(wear)
		end

		if itemstack:get_count() == 0 and wdef.sound and wdef.sound.breaks then
			minetest.sound_play(wdef.sound.breaks, {pos = pt.above, gain = 0.5}, true)
		end
	end

	return itemstack
end

-- Define Hoes

sb_tools.register_hoe("sb_tools:hoe_wood", {
	description = "Wooden Hoe",
	inventory_image = "hoe_wood.png",
	max_uses = 60,
	material = "group:wood"
})

core.register_alias("hoe_wood", "sb_tools:hoe_wood")

sb_tools.register_hoe("sb_tools:hoe_stone", {
	description = "Stone Hoe",
	inventory_image = "hoe_stone.png",
	max_uses = 132,
	material = "group:stone"
})

core.register_alias("hoe_stone", "sb_tools:hoe_stone")

sb_tools.register_hoe("sb_tools:hoe_aereus", {
	description = "Aereus Hoe",
	inventory_image = "hoe_aereus.png",
	max_uses = 260,
	material = "sb_minerals:aereus_ingot"
})

core.register_alias("hoe_aereus", "sb_tools:hoe_aereus")

sb_tools.register_hoe("sb_tools:hoe_ferrum", {
	description = "Ferrum Hoe",
	inventory_image = "hoe_ferrum.png",
	max_uses = 250,
	material = "sb_minerals:ferrum_ingot"
})

core.register_alias("hoe_ferrum", "sb_tools:hoe_ferrum")

sb_tools.register_hoe("sb_tools:hoe_aurem", {
	description = "Aurem Hoe",
	inventory_image = "hoe_aurem.png",
	max_uses = 32,
	material = "sb_minerals:aurem_ingot"
})

core.register_alias("hoe_aurem", "sb_tools:hoe_aurem")

sb_tools.register_hoe("sb_tools:hoe_wolfram", {
	description = "Wolfram Hoe",
	inventory_image = "hoe_wolfram.png",
	max_uses = 1562,
	material = "sb_minerals:wolfram_ingot"
})

core.register_alias("hoe_wolfram", "sb_tools:hoe_wolfram")