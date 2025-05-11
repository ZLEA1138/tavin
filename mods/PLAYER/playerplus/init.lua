--[[
	PlayerPlus by TenPlus1
]]

playerplus = {}

-- get node but use fallback for nil or unknown

local node_ok = function(pos, fallback)

	local node = minetest.get_node_or_nil(pos)

	if node and minetest.registered_nodes[node.name] then
		return node.name
	end

	return fallback or "air"
end

--  mod check and timer set

local monoids = minetest.get_modpath("player_monoids")
local pova_mod = minetest.get_modpath("pova")
local armor_mod = minetest.get_modpath("3d_armor")
local timer = 0
local math_min = math.min

-- main function run for each player

minetest.register_globalstep(function(dtime)

	-- one second timer
	timer = timer + dtime ; if timer < 1 then return end ; timer = 0

	-- define locals outside loop
	local name, pos, ndef, def, nslow, nfast, prop

	-- loop through players
	for _,player in pairs(minetest.get_connected_players()) do

		-- who am I?
		name = player:get_player_name()

		if name and playerplus[name] then

			-- where am I?
			pos = player:get_pos()

			-- node standing on
			playerplus[name].nod_stand = node_ok(
					{x = pos.x, y = pos.y - 0.1, z = pos.z})

			-- Does the node below me have an on_walk_over function set?
			ndef = minetest.registered_nodes[playerplus[name].nod_stand]

			if ndef and ndef.on_walk_over then
				ndef.on_walk_over(pos, ndef, player)
			end

			prop = player:get_properties()

			-- node at eye level
			playerplus[name].nod_head = node_ok(
					{x = pos.x, y = pos.y + prop.eye_height, z = pos.z})

			-- node at foot level
			playerplus[name].nod_feet = node_ok(
					{x = pos.x, y = pos.y + 0.2, z = pos.z})

			-- get player physics
			def = player:get_physics_override()

			if armor_mod and armor and armor.def then

				-- get player physics from armor
				def.speed = armor.def[name].speed or def.speed
				def.jump = armor.def[name].jump or def.jump
				def.gravity = armor.def[name].gravity or def.gravity
			end

			-- are we standing on any nodes that speed player up?
			nfast = nil

			if playerplus[name].nod_stand == "sb_core:ice" then
				nfast = true
			end

			-- are we standing on any nodes that slow player down?
			nslow = nil

			if playerplus[name].nod_stand == "sb_core:snow"
			or playerplus[name].nod_stand == "sb_core:snow_block"
			or playerplus[name].nod_stand == "sb_core:mud" then
				nslow = true
			end

			-- apply speed changes
			if nfast and not playerplus[name].nfast then

				pova.add_override(name, "playerplus:nfast", {speed = 0.4})

				pova.do_override(player)

				playerplus[name].nfast = true

			elseif not nfast and playerplus[name].nfast then

				pova.del_override(name, "playerplus:nfast")

				pova.do_override(player)

				playerplus[name].nfast = nil
			end

			-- apply slowdown changes
			if nslow and not playerplus[name].nslow then

				pova.add_override(name, "playerplus:nslow", {speed = -0.4})

				pova.do_override(player)

				playerplus[name].nslow = true

			elseif not nslow and playerplus[name].nslow then

				pova.del_override(name, "playerplus:nslow")

				pova.do_override(player)

				playerplus[name].nslow = nil
			end

--print ("Speed: " .. def.speed .. " / Jump: " .. def.jump .. " / Gravity: " .. def.gravity)

			-- Is player suffocating inside a normal node without no_clip privs?
			local ndef = minetest.registered_nodes[playerplus[name].nod_head]

			if ndef.walkable == true
			and ndef.drowning == 0
			and ndef.damage_per_second <= 0
			and ndef.groups.disable_suffocation ~= 1
			and ndef.drawtype == "normal"
			and not minetest.check_player_privs(name, {noclip = true}) then

				if player:get_hp() > 0 then
					player:set_hp(player:get_hp() - 2, {suffocation = true})
				end
			end

			-- am I near a cactus?
			--local near = minetest.find_node_near(pos, 1, "default:cactus")

			--if near and vector.distance(pos, near) < 1.1 then
				--player:set_hp(player:get_hp() - 2, {cactus = true})
			--end
		end
	end
end)

-- check for old sneak_glitch setting

local old_sneak = minetest.settings:get_bool("old_sneak")

-- set to blank on join and apply sneak glitch (for 3rd party mods)

minetest.register_on_joinplayer(function(player)

	local name = player:get_player_name()

	playerplus[name] = {nod_head = "", nod_feet = "", nod_stand = ""}

	-- apply old sneak glitch if enabled
	if old_sneak then
		player:set_physics_override({new_move = false, sneak_glitch = true})
	end
end)

-- clear when player leaves

minetest.register_on_leaveplayer(function(player)
	playerplus[ player:get_player_name() ] = nil
end)

-- add privelage to disable knock-back

minetest.register_privilege("no_knockback", {
	description = "Disables player knock-back effect", give_to_singleplayer = false
})

-- player knock-back function

local function punchy(
		player, hitter, time_from_last_punch, tool_capabilities, dir, damage)

	if not dir then return end -- we need to know where to send player away from

	local name = player:get_player_name()

	-- is player attached to anything (mob, bed, boat etc.)
	if player_api.player_attached[name] then return end

	-- check if player has 'no_knockback' privelage
	local privs = minetest.get_player_privs(name)

	if privs["no_knockback"] then return end

	local damage = 0

	if tool_capabilities then

		local armor = player:get_armor_groups() or {}
		local tmp

		-- calculate knockback damage
		for group,_ in pairs( (tool_capabilities.damage_groups or {}) ) do

			tmp = time_from_last_punch / (tool_capabilities.full_punch_interval or 1.4)

			if tmp < 0 then tmp = 0.0 elseif tmp > 1 then tmp = 1.0 end

			if group ~= "knockback" then
				damage = damage + (tool_capabilities.damage_groups[group] or 0) * tmp
			end
		end

		-- if custom value found then use instead
		if tool_capabilities.damage_groups["knockback"] then
			damage = tool_capabilities.damage_groups["knockback"]
		end

	end
	-- END tool damage

	local kb = math_min(32, damage * 2)

--print ("--- knockback", player:get_player_name(), damage, kb)

	-- knock back player
	player:add_velocity({x = dir.x * kb, y = -1, z = dir.z * kb})
end

-- is player knock-back effect enabled?

if minetest.settings:get_bool("player_knockback") ~= false then
	minetest.register_on_punchplayer(punchy)
end
