
-- global

pova = {debug = false}

-- local

local pova_list = {}
local min, max = math.min, math.max

-- override loop interval, 0 to disable

local pova_loop = minetest.settings:get_bool("pova_loop") or 1.0

-- when higher than 0, activate main loop that totals override list on a timer,
-- incase we have any rogue mods that don't play well with player physics.

if pova_loop > 0 then

	local timer = 0

	minetest.register_globalstep(function(dtime)

		timer = timer + dtime

		if timer < pova_loop then return end

		timer = 0

		-- loop through players and apply overrides
		for _,player in pairs(minetest.get_connected_players()) do
			pova.do_override(player)
		end
	end)
end

-- global functions

function pova.add_override(name, item, def)
	if name and item and def and pova_list[name] then
		pova_list[name][item] = def
	end
end

function pova.get_override(name, item)
	return pova_list[name] and pova_list[name][item]
end

function pova.del_override(name, item)
	if name and item and pova_list[name] then
		pova_list[name][item] = nil
	end
end

function pova.do_override(player)

	local name = player and player:get_player_name()

	-- somehow player is missing on list
	if not name or not pova_list[name] then return end

	-- store player override list
	local list = pova_list[name]

	-- set base defaults
	local speed, jump, gravity = 1, 1, 1

	-- check for new defaults
	if list["default"] then
		speed = list["default"].speed or 1
		jump = list["default"].jump or 1
		gravity = list["default"].gravity or 1
	end

	-- loop through list of named overrides
	for id, var in pairs(list) do

		-- skip any custom names
		if var and id ~= "default" and id ~= "min" and id ~= "max" and id ~= "force" then

			-- add any additional changes
			speed = speed + (list[id].speed or 0)
			jump = jump + (list[id].jump or 0)
			gravity = gravity + (list[id].gravity or 0)
		end
	end

	-- make sure total doesn't go below minimum values
	if list["min"] then
		speed = max(list["min"].speed or 0, speed)
		jump = max(list["min"].jump or 0, jump)
		gravity = max(list["min"].gravity or 0, gravity)
	end

	-- make sure total doesn't go above maximum values
	if list["max"] then
		speed = min(list["max"].speed or speed, speed)
		jump = min(list["max"].jump or jump, jump)
		gravity = min(list["max"].gravity or gravity, gravity)
	end

	-- force values (for things like sleeping in bed when speed is 0)
	if list["force"] then
		speed = list["force"].speed or speed
		jump = list["force"].jump or jump
		gravity = list["force"].gravity or gravity
	end

	-- for testing only
	if pova.debug and name == "singleplayer" then
		print ("speed: " .. speed .. " / jump: " .. jump .. " / gravity: " .. gravity)
	end

	-- set new overrides
	player:set_physics_override({speed = speed, jump = jump, gravity = gravity})
end

-- set player table on join

minetest.register_on_joinplayer(function(player)
	pova_list[ player:get_player_name() ] = {}
	pova.do_override(player)
end)

-- reset player table on respawn

minetest.register_on_respawnplayer(function(player)
	if player then
		pova_list[ player:get_player_name() ] = {}
		pova.do_override(player)
	end
end)

-- blank player table on leave

minetest.register_on_leaveplayer(function(player)
	if player then
		pova_list[ player:get_player_name() ] = nil
	end
end)

-- axe tool to showcase features

minetest.register_craftitem("pova:axe", {
	description = "Test Axe (left to apply, right to remove effects)",
	inventory_image = "default_tool_steelaxe.png",
	groups = {not_in_creative_inventory = 1},

	on_use = function(itemstack, user, pointed_thing)

		local name = user:get_player_name()

		-- set new defaults
		pova.add_override(name, "default", {speed = 2, jump = 3, gravity = 1})

		-- define changes that are added onto defaults
		pova.add_override(name, "test", {speed = 1, jump = -1, gravity = 0.5})

--= speed is now 3, jump is 2 and gravity is 1.5

		-- set new minimum for jump
		pova.add_override(name, "min", {jump = 3})

		-- add new maximum for speed
		pova.add_override(name, "max", {speed = 2})

		-- add force value for gravity
		pova.add_override(name, "force", {gravity = 1.2})

--= speed is now max 2, jump is min 3 and gravity forced to 1.2

		-- apply override
		pova.do_override(user)

		minetest.chat_send_player(name, "POVA Effects applied!")
	end,

	on_place = function(itemstack, user, pointed_thing)

		local name = user:get_player_name()

		-- remove changes
		pova.del_override(name, "min")
		pova.del_override(name, "max")
		pova.del_override(name, "force")
		pova.del_override(name, "test")
		pova.del_override(name, "default")

		-- apply override
		pova.do_override(user)

		minetest.chat_send_player(name, "POVA Effects removed!")
	end
})

print("[MOD] Pova loaded")
