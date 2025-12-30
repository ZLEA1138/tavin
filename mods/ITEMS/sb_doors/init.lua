-- our API object
sb_doors = {}

sb_doors.registered_doors = {}
sb_doors.registered_trapdoors = {}


local function replace_old_owner_information(pos)
	local meta = minetest.get_meta(pos)
	local owner = meta:get_string("doors_owner")
	if owner and owner ~= "" then
		meta:set_string("owner", owner)
		meta:set_string("doors_owner", "")
	end
end

local function is_doors_upper_node(pos)
	return minetest.get_node(pos).name == "sb_doors:hidden"
end

-- returns an object to a door object or nil
function sb_doors.get(pos)
	local node_name = minetest.get_node(pos).name
	if sb_doors.registered_doors[node_name] then
		-- A normal upright door
		return {
			pos = pos,
			open = function(self, player)
				if self:state() then
					return false
				end
				return sb_doors.door_toggle(self.pos, nil, player)
			end,
			close = function(self, player)
				if not self:state() then
					return false
				end
				return sb_doors.door_toggle(self.pos, nil, player)
			end,
			toggle = function(self, player)
				return sb_doors.door_toggle(self.pos, nil, player)
			end,
			state = function(self)
				local state = minetest.get_meta(self.pos):get_int("state")
				return state %2 == 1
			end
		}
	elseif sb_doors.registered_trapdoors[node_name] then
		-- A trapdoor
		return {
			pos = pos,
			open = function(self, player)
				if self:state() then
					return false
				end
				return sb_doors.trapdoor_toggle(self.pos, nil, player)
			end,
			close = function(self, player)
				if not self:state() then
					return false
				end
				return sb_doors.trapdoor_toggle(self.pos, nil, player)
			end,
			toggle = function(self, player)
				return sb_doors.trapdoor_toggle(self.pos, nil, player)
			end,
			state = function(self)
				return minetest.get_node(self.pos).name:sub(-5) == "_open"
			end
		}
	else
		return nil
	end
end

-- this hidden node is placed on top of the bottom, and prevents
-- nodes from being placed in the top half of the door.
minetest.register_node("sb_doors:hidden", {
	description = "Hidden Door Segment",
	inventory_image = "blank.png",
	wield_image = "blank.png",
	drawtype = "airlike",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	-- has to be walkable for falling nodes to stop falling.
	walkable = true,
	pointable = false,
	diggable = false,
	buildable_to = false,
	floodable = false,
	drop = "",
	groups = {not_in_creative_inventory = 1},
	on_blast = function() end,
	-- 1px block inside door hinge near node top
	collision_box = {
		type = "fixed",
		fixed = {-15/32, 13/32, -15/32, -13/32, 1/2, -13/32},
	},
})

-- table used to aid door opening/closing
local transform = {
	{
		{v = "_a", param2 = 3},
		{v = "_a", param2 = 0},
		{v = "_a", param2 = 1},
		{v = "_a", param2 = 2},
	},
	{
		{v = "_c", param2 = 1},
		{v = "_c", param2 = 2},
		{v = "_c", param2 = 3},
		{v = "_c", param2 = 0},
	},
	{
		{v = "_b", param2 = 1},
		{v = "_b", param2 = 2},
		{v = "_b", param2 = 3},
		{v = "_b", param2 = 0},
	},
	{
		{v = "_d", param2 = 3},
		{v = "_d", param2 = 0},
		{v = "_d", param2 = 1},
		{v = "_d", param2 = 2},
	},
}

function sb_doors.door_toggle(pos, node, clicker)
	local meta = minetest.get_meta(pos)
	node = node or minetest.get_node(pos)
	local def = minetest.registered_nodes[node.name]
	local name = def.door.name

	local state = meta:get_string("state")
	if state == "" then
		-- fix up lvm-placed right-hinged doors, default closed
		if node.name:sub(-2) == "_b" then
			state = 2
		else
			state = 0
		end
	else
		state = tonumber(state)
	end

	replace_old_owner_information(pos)

	if clicker and not functions.can_interact_with_node(clicker, pos) then
		return false
	end

	-- until Lua-5.2 we have no bitwise operators :(
	if state % 2 == 1 then
		state = state - 1
	else
		state = state + 1
	end

	local dir = node.param2

	-- It's possible param2 is messed up, so, validate before using
	-- the input data. This indicates something may have rotated
	-- the door, even though that is not supported.
	if not transform[state + 1] or not transform[state + 1][dir + 1] then
		return false
	end

	if state % 2 == 0 then
		minetest.sound_play(def.door.sounds[1],
			{pos = pos, gain = def.door.gains[1], max_hear_distance = 10}, true)
	else
		minetest.sound_play(def.door.sounds[2],
			{pos = pos, gain = def.door.gains[2], max_hear_distance = 10}, true)
	end

	minetest.swap_node(pos, {
		name = name .. transform[state + 1][dir+1].v,
		param2 = transform[state + 1][dir+1].param2
	})
	meta:set_int("state", state)

	return true
end


local function on_place_node(place_to, newnode,
	placer, oldnode, itemstack, pointed_thing)
	-- Run script hook
	for _, callback in ipairs(minetest.registered_on_placenodes) do
		-- Deepcopy pos, node and pointed_thing because callback can modify them
		local place_to_copy = {x = place_to.x, y = place_to.y, z = place_to.z}
		local newnode_copy =
			{name = newnode.name, param1 = newnode.param1, param2 = newnode.param2}
		local oldnode_copy =
			{name = oldnode.name, param1 = oldnode.param1, param2 = oldnode.param2}
		local pointed_thing_copy = {
			type  = pointed_thing.type,
			above = vector.new(pointed_thing.above),
			under = vector.new(pointed_thing.under),
			ref   = pointed_thing.ref,
		}
		callback(place_to_copy, newnode_copy, placer,
			oldnode_copy, itemstack, pointed_thing_copy)
	end
end

local function can_dig_door(pos, digger)
	replace_old_owner_information(pos)
	return functions.can_interact_with_node(digger, pos)
end

function sb_doors.register(name, def)
	if not name:find(":") then
		name = "sb_doors:" .. name
	end

	-- replace old doors of this type automatically
	minetest.register_lbm({
		name = ":sb_doors:replace_" .. name:gsub(":", "_"),
		nodenames = {name.."_b_1", name.."_b_2"},
		action = function(pos, node)
			local l = tonumber(node.name:sub(-1))
			local meta = minetest.get_meta(pos)
			local h = meta:get_int("right") + 1
			local p2 = node.param2
			local replace = {
				{{type = "a", state = 0}, {type = "a", state = 3}},
				{{type = "b", state = 1}, {type = "b", state = 2}}
			}
			local new = replace[l][h]
			-- retain infotext and doors_owner fields
			minetest.swap_node(pos, {name = name .. "_" .. new.type, param2 = p2})
			meta:set_int("state", new.state)
			-- properly place sb_doors:hidden at the right spot
			local p3 = p2
			if new.state >= 2 then
				p3 = (p3 + 3) % 4
			end
			if new.state % 2 == 1 then
				if new.state >= 2 then
					p3 = (p3 + 1) % 4
				else
					p3 = (p3 + 3) % 4
				end
			end
			-- wipe meta on top node as it's unused
			minetest.set_node({x = pos.x, y = pos.y + 1, z = pos.z},
				{name = "sb_doors:hidden", param2 = p3})
		end
	})

	minetest.register_craftitem(":" .. name, {
		description = def.description,
		inventory_image = def.inventory_image,
		groups = table.copy(def.groups),

		on_place = function(itemstack, placer, pointed_thing)
			local pos

			if pointed_thing.type ~= "node" then
				return itemstack
			end

			local doorname = itemstack:get_name()
			local node = minetest.get_node(pointed_thing.under)
			local pdef = minetest.registered_nodes[node.name]
			if pdef and pdef.on_rightclick and
					not (placer and placer:is_player() and
					placer:get_player_control().sneak) then
				return pdef.on_rightclick(pointed_thing.under,
						node, placer, itemstack, pointed_thing)
			end

			if pdef and pdef.buildable_to then
				pos = pointed_thing.under
			else
				pos = pointed_thing.above
				node = minetest.get_node(pos)
				pdef = minetest.registered_nodes[node.name]
				if not pdef or not pdef.buildable_to then
					return itemstack
				end
			end

			local above = {x = pos.x, y = pos.y + 1, z = pos.z}
			local top_node = minetest.get_node_or_nil(above)
			local topdef = top_node and minetest.registered_nodes[top_node.name]

			if not topdef or not topdef.buildable_to then
				return itemstack
			end

			local pn = placer and placer:get_player_name() or ""
			if minetest.is_protected(pos, pn) or minetest.is_protected(above, pn) then
				return itemstack
			end

			local dir = placer and minetest.dir_to_facedir(placer:get_look_dir()) or 0

			local ref = {
				{x = -1, y = 0, z = 0},
				{x = 0, y = 0, z = 1},
				{x = 1, y = 0, z = 0},
				{x = 0, y = 0, z = -1},
			}

			local aside = {
				x = pos.x + ref[dir + 1].x,
				y = pos.y + ref[dir + 1].y,
				z = pos.z + ref[dir + 1].z,
			}

			local state = 0
			if minetest.get_item_group(minetest.get_node(aside).name, "door") == 1 then
				state = state + 2
				minetest.set_node(pos, {name = doorname .. "_b", param2 = dir})
				minetest.set_node(above, {name = "sb_doors:hidden", param2 = (dir + 3) % 4})
			else
				minetest.set_node(pos, {name = doorname .. "_a", param2 = dir})
				minetest.set_node(above, {name = "sb_doors:hidden", param2 = dir})
			end

			local meta = minetest.get_meta(pos)
			meta:set_int("state", state)

			if def.protected then
				meta:set_string("owner", pn)
				meta:set_string("infotext", def.description .. "\n" .. "Owned by " .. pn)
			end

			if not minetest.is_creative_enabled(pn) then
				itemstack:take_item()
			end

			minetest.sound_play(def.sounds.place, {pos = pos}, true)

			on_place_node(pos, minetest.get_node(pos),
				placer, node, itemstack, pointed_thing)

			return itemstack
		end
	})
	def.inventory_image = nil

	if def.recipe then
		minetest.register_craft({
			output = name,
			recipe = def.recipe,
		})
	end
	def.recipe = nil

	if not def.sounds then
		def.sounds = sounds.node_sound_wood_defaults()
	end

	if not def.sound_open then
		def.sound_open = "door_open"
	end

	if not def.sound_close then
		def.sound_close = "door_close"
	end

	if not def.gain_open then
		def.gain_open = 0.3
	end

	if not def.gain_close then
		def.gain_close = 0.3
	end

	def.groups.not_in_creative_inventory = 1
	def.groups.door = 1
	def.drop = name
	def.door = {
		name = name,
		sounds = {def.sound_close, def.sound_open},
		gains = {def.gain_close, def.gain_open},
	}
	if not def.on_rightclick then
		def.on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
			sb_doors.door_toggle(pos, node, clicker)
			return itemstack
		end
	end
	def.after_dig_node = function(pos, node, meta, digger)
		local above = pos:offset(0, 1, 0)
		if is_doors_upper_node(above) then
			minetest.remove_node(above)
		end
		minetest.check_for_falling(above)
	end
	def.on_rotate = function(pos, node, user, mode, new_param2)
		return false
	end

	if def.protected then
		def.can_dig = can_dig_door
		def.on_blast = function() end
		def.on_key_use = function(pos, player)
			local door = sb_doors.get(pos)
			door:toggle(player)
		end
		def.on_skeleton_key_use = function(pos, player, newsecret)
			replace_old_owner_information(pos)
			local meta = minetest.get_meta(pos)
			local owner = meta:get_string("owner")
			local pname = player:get_player_name()

			-- verify placer is owner of lockable door
			if owner ~= pname then
				minetest.record_protection_violation(pos, pname)
				minetest.chat_send_player(pname, "You do not own this locked door.")
				return nil
			end

			local secret = meta:get_string("key_lock_secret")
			if secret == "" then
				secret = newsecret
				meta:set_string("key_lock_secret", secret)
			end

			return secret, "a locked door", owner
		end
		def.node_dig_prediction = ""
	else
		def.on_blast = function(pos, intensity)
			minetest.remove_node(pos)
			local above = pos:offset(0, 1, 0)
			-- hidden node doesn't get blasted away.
			if is_doors_upper_node(above) then
				minetest.remove_node(above)
			end
			return {name}
		end
	end

	def.on_destruct = function(pos)
		local above = pos:offset(0, 1, 0)
		if is_doors_upper_node(above) then
			minetest.remove_node(above)
		end
	end

	def.drawtype = "mesh"
	def.paramtype = "light"
	def.paramtype2 = "facedir"
	def.sunlight_propagates = true
	def.walkable = true
	def.is_ground_content = false
	def.buildable_to = false
	def.selection_box = {type = "fixed", fixed = {-1/2,-1/2,-1/2,1/2,3/2,-6/16}}
	def.collision_box = {type = "fixed", fixed = {-1/2,-1/2,-1/2,1/2,3/2,-6/16}}
	def.use_texture_alpha = def.use_texture_alpha or "clip"

	def.mesh = "door_a.b3d"
	minetest.register_node(":" .. name .. "_a", table.copy(def))

	def.mesh = "door_b.b3d"
	minetest.register_node(":" .. name .. "_b", table.copy(def))

	def.mesh = "door_b.b3d"
	minetest.register_node(":" .. name .. "_c", table.copy(def))

	def.mesh = "door_a.b3d"
	minetest.register_node(":" .. name .. "_d", table.copy(def))

	sb_doors.registered_doors[name .. "_a"] = true
	sb_doors.registered_doors[name .. "_b"] = true
	sb_doors.registered_doors[name .. "_c"] = true
	sb_doors.registered_doors[name .. "_d"] = true
end


-- Marshtree Door
sb_doors.register("door_wood_marshtree", {
		tiles = {{ name = "door_wood_marshtree.png", backface_culling = true }},
		description = "Marshtree Door",
		inventory_image = "door_wood_marshtree_inv.png",
		groups = {
			node = 1,
			crumbly = mining.hardness(3, -1),
			cracky = mining.hardness(3, -1),
			choppy = mining.hardness(3, 0),
			snappy = mining.hardness(3, -1),
			oddly_breakable_by_hand = mining.hardness(3, 0),
			flammable = 2
		},
		gain_open = 0.06,
		gain_close = 0.13,
		recipe = {
			{"sb_core:planks_marshtree", "sb_core:planks_marshtree"},
			{"sb_core:planks_marshtree", "sb_core:planks_marshtree"},
			{"sb_core:planks_marshtree", "sb_core:planks_marshtree"},
		}
})

minetest.register_craft({
	type = "fuel",
	recipe = "sb_doors:door_wood_marshtree",
	burntime = 10,
})

-- Oki Door
sb_doors.register("door_wood_oki", {
		tiles = {{ name = "door_wood_oki.png", backface_culling = true }},
		description = "Oki Door",
		inventory_image = "door_wood_oki_inv.png",
		groups = {
			node = 1,
			crumbly = mining.hardness(3, -1),
			cracky = mining.hardness(3, -1),
			choppy = mining.hardness(3, 0),
			snappy = mining.hardness(3, -1),
			oddly_breakable_by_hand = mining.hardness(3, 0),
			flammable = 2
		},
		gain_open = 0.06,
		gain_close = 0.13,
		recipe = {
			{"sb_core:planks_oki", "sb_core:planks_oki"},
			{"sb_core:planks_oki", "sb_core:planks_oki"},
			{"sb_core:planks_oki", "sb_core:planks_oki"},
		}
})

minetest.register_craft({
	type = "fuel",
	recipe = "sb_doors:door_wood_oki",
	burntime = 10,
})

-- Sana Door
sb_doors.register("door_wood_sana", {
		tiles = {{ name = "door_wood_sana.png", backface_culling = true }},
		description = "Sana Door",
		inventory_image = "door_wood_sana_inv.png",
		groups = {
			node = 1,
			crumbly = mining.hardness(3, -1),
			cracky = mining.hardness(3, -1),
			choppy = mining.hardness(3, 0),
			snappy = mining.hardness(3, -1),
			oddly_breakable_by_hand = mining.hardness(3, 0),
			flammable = 2
		},
		gain_open = 0.06,
		gain_close = 0.13,
		recipe = {
			{"sb_core:planks_sana", "sb_core:planks_sana"},
			{"sb_core:planks_sana", "sb_core:planks_sana"},
			{"sb_core:planks_sana", "sb_core:planks_sana"},
		}
})

minetest.register_craft({
	type = "fuel",
	recipe = "sb_doors:door_wood_sana",
	burntime = 10,
})

-- Suntree Door
sb_doors.register("door_wood_suntree", {
		tiles = {{ name = "door_wood_suntree.png", backface_culling = true }},
		description = "Suntree Door",
		inventory_image = "door_wood_suntree_inv.png",
		groups = {
			node = 1,
			crumbly = mining.hardness(3, -1),
			cracky = mining.hardness(3, -1),
			choppy = mining.hardness(3, 0),
			snappy = mining.hardness(3, -1),
			oddly_breakable_by_hand = mining.hardness(3, 0),
			flammable = 2
		},
		gain_open = 0.06,
		gain_close = 0.13,
		recipe = {
			{"sb_core:planks_suntree", "sb_core:planks_suntree"},
			{"sb_core:planks_suntree", "sb_core:planks_suntree"},
			{"sb_core:planks_suntree", "sb_core:planks_suntree"},
		}
})

minetest.register_craft({
	type = "fuel",
	recipe = "sb_doors:door_wood_suntree",
	burntime = 10,
})

-- Taeda Door
sb_doors.register("door_wood_taeda", {
		tiles = {{ name = "door_wood_taeda.png", backface_culling = true }},
		description = "Taeda Door",
		inventory_image = "door_wood_taeda_inv.png",
		groups = {
			node = 1,
			crumbly = mining.hardness(3, -1),
			cracky = mining.hardness(3, -1),
			choppy = mining.hardness(3, 0),
			snappy = mining.hardness(3, -1),
			oddly_breakable_by_hand = mining.hardness(3, 0),
			flammable = 2
		},
		gain_open = 0.06,
		gain_close = 0.13,
		recipe = {
			{"sb_core:planks_taeda", "sb_core:planks_taeda"},
			{"sb_core:planks_taeda", "sb_core:planks_taeda"},
			{"sb_core:planks_taeda", "sb_core:planks_taeda"},
		}
})

minetest.register_craft({
	type = "fuel",
	recipe = "sb_doors:door_wood_taeda",
	burntime = 10,
})

-- Wungu Door
sb_doors.register("door_wood_wungu", {
		tiles = {{ name = "door_wood_wungu.png", backface_culling = true }},
		description = "Wungu Door",
		inventory_image = "door_wood_wungu_inv.png",
		groups = {
			node = 1,
			crumbly = mining.hardness(3, -1),
			cracky = mining.hardness(3, -1),
			choppy = mining.hardness(3, 0),
			snappy = mining.hardness(3, -1),
			oddly_breakable_by_hand = mining.hardness(3, 0),
			flammable = 2
		},
		gain_open = 0.06,
		gain_close = 0.13,
		recipe = {
			{"sb_core:planks_wungu", "sb_core:planks_wungu"},
			{"sb_core:planks_wungu", "sb_core:planks_wungu"},
			{"sb_core:planks_wungu", "sb_core:planks_wungu"},
		}
})

minetest.register_craft({
	type = "fuel",
	recipe = "sb_doors:door_wood_wungu",
	burntime = 10,
})

-- Ferrum Door
sb_doors.register("door_ferrum", {
		tiles = {{name = "door_ferrum.png", backface_culling = true}},
		description = "Ferrum Door",
		inventory_image = "door_ferrum_inv.png",
		protected = true,
		groups = {
			node = 1,
			crumbly = mining.hardness(5, -2),
			cracky = mining.hardness(5, 2),
			choppy = mining.hardness(5, -2),
			snappy = mining.hardness(5, -2),
			oddly_breakable_by_hand = mining.hardness(5, -2),
		},
		sounds = sounds.node_sound_metal_defaults(),
		sound_open = "ferrum_door_open",
		sound_close = "ferrum_door_close",
		gain_open = 0.2,
		gain_close = 0.2,
		recipe = {
			{"sb_minerals:ferrum_ingot", "sb_minerals:ferrum_ingot"},
			{"sb_minerals:ferrum_ingot", "sb_minerals:ferrum_ingot"},
			{"sb_minerals:ferrum_ingot", "sb_minerals:ferrum_ingot"},
		}
	}
)

----trapdoor----

function sb_doors.trapdoor_toggle(pos, node, clicker)
	node = node or minetest.get_node(pos)

	replace_old_owner_information(pos)

	if clicker and not functions.can_interact_with_node(clicker, pos) then
		return false
	end

	local def = minetest.registered_nodes[node.name]

	if string.sub(node.name, -5) == "_open" then
		minetest.sound_play(def.sound_close,
			{pos = pos, gain = def.gain_close, max_hear_distance = 10}, true)
		minetest.swap_node(pos, {name = string.sub(node.name, 1,
			string.len(node.name) - 5), param1 = node.param1, param2 = node.param2})
	else
		minetest.sound_play(def.sound_open,
			{pos = pos, gain = def.gain_open, max_hear_distance = 10}, true)
		minetest.swap_node(pos, {name = node.name .. "_open",
			param1 = node.param1, param2 = node.param2})
	end
end

function sb_doors.register_trapdoor(name, def)
	if not name:find(":") then
		name = "sb_doors:" .. name
	end

	local name_closed = name
	local name_opened = name.."_open"

	def.on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		sb_doors.trapdoor_toggle(pos, node, clicker)
		return itemstack
	end

	-- Common trapdoor configuration
	def.drawtype = "nodebox"
	def.paramtype = "light"
	def.paramtype2 = "facedir"
	def.is_ground_content = false
	def.use_texture_alpha = def.use_texture_alpha or "clip"

	if def.protected then
		def.can_dig = can_dig_door
		def.after_place_node = function(pos, placer, itemstack, pointed_thing)
			local pn = placer:get_player_name()
			local meta = minetest.get_meta(pos)
			meta:set_string("owner", pn)
			meta:set_string("infotext", def.description .. "\n" .. "Owned by " .. pn)

			return minetest.is_creative_enabled(pn)
		end

		def.on_blast = function() end
		def.on_key_use = function(pos, player)
			local door = sb_doors.get(pos)
			door:toggle(player)
		end
		def.on_skeleton_key_use = function(pos, player, newsecret)
			replace_old_owner_information(pos)
			local meta = minetest.get_meta(pos)
			local owner = meta:get_string("owner")
			local pname = player:get_player_name()

			-- verify placer is owner of lockable door
			if owner ~= pname then
				minetest.record_protection_violation(pos, pname)
				minetest.chat_send_player(pname, "You do not own this trapdoor.")
				return nil
			end

			local secret = meta:get_string("key_lock_secret")
			if secret == "" then
				secret = newsecret
				meta:set_string("key_lock_secret", secret)
			end

			return secret, "a locked trapdoor", owner
		end
		def.node_dig_prediction = ""
	else
		def.on_blast = function(pos, intensity)
			minetest.remove_node(pos)
			return {name}
		end
	end

	if not def.sounds then
		def.sounds = sounds.node_sound_wood_defaults()
	end

	if not def.sound_open then
		def.sound_open = "door_open"
	end

	if not def.sound_close then
		def.sound_close = "door_close"
	end

	if not def.gain_open then
		def.gain_open = 0.3
	end

	if not def.gain_close then
		def.gain_close = 0.3
	end

	local def_opened = table.copy(def)
	local def_closed = table.copy(def)

	if def.nodebox_closed and def.nodebox_opened then
		def_closed.node_box = def.nodebox_closed
	else
		def_closed.node_box = {
		    type = "fixed",
		    fixed = {-0.5, -0.5, -0.5, 0.5, -6/16, 0.5}
		}
	end
	def_closed.selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -6/16, 0.5}
	}
	def_closed.tiles = {
		def.tile_front,
		def.tile_front .. '^[transformFY',
		def.tile_side,
		def.tile_side,
		def.tile_side,
		def.tile_side
	}

	if def.nodebox_opened and def.nodebox_closed then
		def_opened.node_box = def.nodebox_opened
	else
		def_opened.node_box = {
		    type = "fixed",
		    fixed = {-0.5, -0.5, 6/16, 0.5, 0.5, 0.5}
		}
	end
	def_opened.selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, 6/16, 0.5, 0.5, 0.5}
	}
	def_opened.tiles = {
		def.tile_side,
		def.tile_side .. '^[transform2',
		def.tile_side .. '^[transform3',
		def.tile_side .. '^[transform1',
		def.tile_front .. '^[transform46',
		def.tile_front .. '^[transform6'
	}

	def_opened.drop = name_closed
	def_opened.groups.not_in_creative_inventory = 1

	minetest.register_node(name_opened, def_opened)
	minetest.register_node(name_closed, def_closed)

	sb_doors.registered_trapdoors[name_opened] = true
	sb_doors.registered_trapdoors[name_closed] = true
end

-- Marshtree Trapdoor
sb_doors.register_trapdoor("sb_doors:trapdoor_wood_marshtree", {
	description = "Marshtree Trapdoor",
	inventory_image = "trapdoor_wood_marshtree.png",
	wield_image = "trapdoor_wood_marshtree.png",
	tile_front = "trapdoor_wood_marshtree.png",
	tile_side = "trapdoor_wood_marshtree_side.png",
	gain_open = 0.06,
	gain_close = 0.13,
	groups = {
		crumbly = mining.hardness(3, -1),
		cracky = mining.hardness(3, -1),
		choppy = mining.hardness(3, 0),
		snappy = mining.hardness(3, -1),
		oddly_breakable_by_hand = mining.hardness(3, 0),
		flammable = 2,
		door = 1
	},
})

minetest.register_craft({
	output = "sb_doors:trapdoor_wood_marshtree 2",
	recipe = {
		{"sb_core:planks_marshtree", "sb_core:planks_marshtree", "sb_core:planks_marshtree"},
		{"sb_core:planks_marshtree", "sb_core:planks_marshtree", "sb_core:planks_marshtree"},
	}
})

minetest.register_craft({
	type = "fuel",
	recipe = "sb_doors:trapdoor_wood_marshtree",
	burntime = 15,
})

-- Oki Trapdoor
sb_doors.register_trapdoor("sb_doors:trapdoor_wood_oki", {
	description = "Oki Trapdoor",
	inventory_image = "trapdoor_wood_oki.png",
	wield_image = "trapdoor_wood_oki.png",
	tile_front = "trapdoor_wood_oki.png",
	tile_side = "trapdoor_wood_oki_side.png",
	gain_open = 0.06,
	gain_close = 0.13,
	groups = {
		crumbly = mining.hardness(3, -1),
		cracky = mining.hardness(3, -1),
		choppy = mining.hardness(3, 0),
		snappy = mining.hardness(3, -1),
		oddly_breakable_by_hand = mining.hardness(3, 0),
		flammable = 2,
		door = 1
	},
})

minetest.register_craft({
	output = "sb_doors:trapdoor_wood_oki 2",
	recipe = {
		{"sb_core:planks_oki", "sb_core:planks_oki", "sb_core:planks_oki"},
		{"sb_core:planks_oki", "sb_core:planks_oki", "sb_core:planks_oki"},
	}
})

minetest.register_craft({
	type = "fuel",
	recipe = "sb_doors:trapdoor_wood_oki",
	burntime = 15,
})

-- Sana Trapdoor
sb_doors.register_trapdoor("sb_doors:trapdoor_wood_sana", {
	description = "Sana Trapdoor",
	inventory_image = "trapdoor_wood_sana.png",
	wield_image = "trapdoor_wood_sana.png",
	tile_front = "trapdoor_wood_sana.png",
	tile_side = "trapdoor_wood_sana_side.png",
	gain_open = 0.06,
	gain_close = 0.13,
	groups = {
		crumbly = mining.hardness(3, -1),
		cracky = mining.hardness(3, -1),
		choppy = mining.hardness(3, 0),
		snappy = mining.hardness(3, -1),
		oddly_breakable_by_hand = mining.hardness(3, 0),
		flammable = 2,
		door = 1
	},
})

minetest.register_craft({
	output = "sb_doors:trapdoor_wood_sana 2",
	recipe = {
		{"sb_core:planks_sana", "sb_core:planks_sana", "sb_core:planks_sana"},
		{"sb_core:planks_sana", "sb_core:planks_sana", "sb_core:planks_sana"},
	}
})

minetest.register_craft({
	type = "fuel",
	recipe = "sb_doors:trapdoor_wood_sana",
	burntime = 15,
})

-- Suntree Trapdoor
sb_doors.register_trapdoor("sb_doors:trapdoor_wood_suntree", {
	description = "Suntree Trapdoor",
	inventory_image = "trapdoor_wood_suntree.png",
	wield_image = "trapdoor_wood_suntree.png",
	tile_front = "trapdoor_wood_suntree.png",
	tile_side = "trapdoor_wood_suntree_side.png",
	gain_open = 0.06,
	gain_close = 0.13,
	groups = {
		crumbly = mining.hardness(3, -1),
		cracky = mining.hardness(3, -1),
		choppy = mining.hardness(3, 0),
		snappy = mining.hardness(3, -1),
		oddly_breakable_by_hand = mining.hardness(3, 0),
		flammable = 2,
		door = 1
	},
})

minetest.register_craft({
	output = "sb_doors:trapdoor_wood_suntree 2",
	recipe = {
		{"sb_core:planks_suntree", "sb_core:planks_suntree", "sb_core:planks_suntree"},
		{"sb_core:planks_suntree", "sb_core:planks_suntree", "sb_core:planks_suntree"},
	}
})

minetest.register_craft({
	type = "fuel",
	recipe = "sb_doors:trapdoor_wood_suntree",
	burntime = 15,
})

-- Taeda Trapdoor
sb_doors.register_trapdoor("sb_doors:trapdoor_wood_taeda", {
	description = "Taeda Trapdoor",
	inventory_image = "trapdoor_wood_taeda.png",
	wield_image = "trapdoor_wood_taeda.png",
	tile_front = "trapdoor_wood_taeda.png",
	tile_side = "trapdoor_wood_taeda_side.png",
	gain_open = 0.06,
	gain_close = 0.13,
	groups = {
		crumbly = mining.hardness(3, -1),
		cracky = mining.hardness(3, -1),
		choppy = mining.hardness(3, 0),
		snappy = mining.hardness(3, -1),
		oddly_breakable_by_hand = mining.hardness(3, 0),
		flammable = 2,
		door = 1
	},
})

minetest.register_craft({
	output = "sb_doors:trapdoor_wood_taeda 2",
	recipe = {
		{"sb_core:planks_taeda", "sb_core:planks_taeda", "sb_core:planks_taeda"},
		{"sb_core:planks_taeda", "sb_core:planks_taeda", "sb_core:planks_taeda"},
	}
})

minetest.register_craft({
	type = "fuel",
	recipe = "sb_doors:trapdoor_wood_taeda",
	burntime = 15,
})

-- Wungu Trapdoor
sb_doors.register_trapdoor("sb_doors:trapdoor_wood_wungu", {
	description = "Wungu Trapdoor",
	inventory_image = "trapdoor_wood_wungu.png",
	wield_image = "trapdoor_wood_wungu.png",
	tile_front = "trapdoor_wood_wungu.png",
	tile_side = "trapdoor_wood_wungu_side.png",
	gain_open = 0.06,
	gain_close = 0.13,
	groups = {
		crumbly = mining.hardness(3, -1),
		cracky = mining.hardness(3, -1),
		choppy = mining.hardness(3, 0),
		snappy = mining.hardness(3, -1),
		oddly_breakable_by_hand = mining.hardness(3, 0),
		flammable = 2,
		door = 1
	},
})

minetest.register_craft({
	output = "sb_doors:trapdoor_wood_wungu 2",
	recipe = {
		{"sb_core:planks_wungu", "sb_core:planks_wungu", "sb_core:planks_wungu"},
		{"sb_core:planks_wungu", "sb_core:planks_wungu", "sb_core:planks_wungu"},
	}
})

minetest.register_craft({
	type = "fuel",
	recipe = "sb_doors:trapdoor_wood_wungu",
	burntime = 15,
})

-- Ferrum Trapdoor
sb_doors.register_trapdoor("sb_doors:trapdoor_ferrum", {
	description = "Ferrum Trapdoor",
	inventory_image = "trapdoor_ferrum.png",
	wield_image = "trapdoor_ferrum.png",
	tile_front = "trapdoor_ferrum.png",
	tile_side = "trapdoor_ferrum_side.png",
	protected = true,
	sounds = sounds.node_sound_metal_defaults(),
	sound_open = "ferrum_door_open",
	sound_close = "ferrum_door_close",
	gain_open = 0.2,
	gain_close = 0.2,
	groups = {
		crumbly = mining.hardness(5, -2),
		cracky = mining.hardness(5, 2),
		choppy = mining.hardness(5, -2),
		snappy = mining.hardness(5, -2),
		oddly_breakable_by_hand = mining.hardness(5, -2),
		door = 1
	},
})

minetest.register_craft({
	output = "sb_doors:trapdoor_ferrum",
	recipe = {
		{"sb_minerals:ferrum_ingot", "sb_minerals:ferrum_ingot"},
		{"sb_minerals:ferrum_ingot", "sb_minerals:ferrum_ingot"},
	}
})