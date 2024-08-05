inventory = {
	pages = {},
	pages_unordered = {},
	contexts = {},
	enabled = true
}

function inventory.register_page(name, def)
	assert(name, "Invalid inventory page. Requires a name")
	assert(def, "Invalid inventory page. Requires a def[inition] table")
	assert(def.get, "Invalid inventory page. Def requires a get function.")
	assert(not inventory.pages[name], "Attempt to register already registered inventory page " .. dump(name))

	inventory.pages[name] = def
	def.name = name
	table.insert(inventory.pages_unordered, def)
end

function inventory.override_page(name, def)
	assert(name, "Invalid inventory page override. Requires a name")
	assert(def, "Invalid inventory page override. Requires a def[inition] table")
	local page = inventory.pages[name]
	assert(page, "Attempt to override inventory page " .. dump(name) .. " which does not exist.")
	for key, value in pairs(def) do
		page[key] = value
	end
end

function inventory.get_nav_fs(player, context, nav, current_idx)
	-- Only show tabs if there is more than one page
	if #nav > 1 then
		return "tabheader[0,0;inventory_nav_tabs;" .. table.concat(nav, ",") ..
				";" .. current_idx .. ";true;false]"
	else
		return ""
	end
end

local theme_inv = [[
		image[0,5.2;1,1;gui_hb_bg.png]
		image[1,5.2;1,1;gui_hb_bg.png]
		image[2,5.2;1,1;gui_hb_bg.png]
		image[3,5.2;1,1;gui_hb_bg.png]
		image[4,5.2;1,1;gui_hb_bg.png]
		image[5,5.2;1,1;gui_hb_bg.png]
		image[6,5.2;1,1;gui_hb_bg.png]
		image[7,5.2;1,1;gui_hb_bg.png]
		list[current_player;main;0,5.2;8,1;]
		list[current_player;main;0,6.35;8,3;8]
	]]

function inventory.make_formspec(player, context, content, show_inv, size)
	local tmp = {
		size or "size[8,9.1]",
		inventory.get_nav_fs(player, context, context.nav_titles, context.nav_idx),
		show_inv and theme_inv or "",
		content
	}
	return table.concat(tmp, "")
end

function inventory.get_homepage_name(player)
	return "inventory:crafting"
end

function inventory.get_formspec(player, context)
	-- Generate navigation tabs
	local nav = {}
	local nav_ids = {}
	local current_idx = 1
	for i, pdef in pairs(inventory.pages_unordered) do
		if not pdef.is_in_nav or pdef:is_in_nav(player, context) then
			nav[#nav + 1] = pdef.title
			nav_ids[#nav_ids + 1] = pdef.name
			if pdef.name == context.page then
				current_idx = #nav_ids
			end
		end
	end
	context.nav = nav_ids
	context.nav_titles = nav
	context.nav_idx = current_idx

	-- Generate formspec
	local page = inventory.pages[context.page] or inventory.pages["404"]
	if page then
		return page:get(player, context)
	else
		local old_page = context.page
		local home_page = inventory.get_homepage_name(player)

		if old_page == home_page then
			minetest.log("error", "[inventory] Couldn't find " .. dump(old_page) ..
					", which is also the old page")

			return ""
		end

		context.page = home_page
		assert(inventory.pages[context.page], "[inventory] Invalid homepage")
		minetest.log("warning", "[inventory] Couldn't find " .. dump(old_page) ..
				" so switching to homepage")

		return inventory.get_formspec(player, context)
	end
end

function inventory.get_or_create_context(player)
	local name = player:get_player_name()
	local context = inventory.contexts[name]
	if not context then
		context = {
			page = inventory.get_homepage_name(player)
		}
		inventory.contexts[name] = context
	end
	return context
end

function inventory.set_context(player, context)
	inventory.contexts[player:get_player_name()] = context
end

function inventory.set_player_inventory_formspec(player, context)
	local fs = inventory.get_formspec(player,
			context or inventory.get_or_create_context(player))
	player:set_inventory_formspec(fs)
end

function inventory.set_page(player, pagename)
	local context = inventory.get_or_create_context(player)
	local oldpage = inventory.pages[context.page]
	if oldpage and oldpage.on_leave then
		oldpage:on_leave(player, context)
	end
	context.page = pagename
	local page = inventory.pages[pagename]
	if page.on_enter then
		page:on_enter(player, context)
	end
	inventory.set_player_inventory_formspec(player, context)
end

function inventory.get_page(player)
	local context = inventory.contexts[player:get_player_name()]
	return context and context.page or inventory.get_homepage_name(player)
end

minetest.register_on_joinplayer(function(player)
	if inventory.enabled then
		inventory.set_player_inventory_formspec(player)
	end
end)

minetest.register_on_leaveplayer(function(player)
	inventory.contexts[player:get_player_name()] = nil
end)

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "" or not inventory.enabled then
		return false
	end

	-- Get Context
	local name = player:get_player_name()
	local context = inventory.contexts[name]
	if not context then
		inventory.set_player_inventory_formspec(player)
		return false
	end

	-- Was a tab selected?
	if fields.inventory_nav_tabs and context.nav then
		local tid = tonumber(fields.inventory_nav_tabs)
		if tid and tid > 0 then
			local id = context.nav[tid]
			local page = inventory.pages[id]
			if id and page then
				inventory.set_page(player, id)
			end
		end
	else
		-- Pass event to page
		local page = inventory.pages[context.page]
		if page and page.on_player_receive_fields then
			return page:on_player_receive_fields(player, context, fields)
		end
	end
end)
