sb_shelves = {}

-- Bookshelf inventory
local bookshelf_formspec =
	"size[8,7;]" ..
	"list[context;books;0,0.3;8,2;]" ..
	"list[current_player;main;0,2.85;8,1;]" ..
	"list[current_player;main;0,4.08;8,3;8]" ..
	"listring[context;books]" ..
	"listring[current_player;main]" ..
	inventory.get_hotbar_bg(0,2.85)

local function update_bookshelf(pos)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	local invlist = inv:get_list("books")

	local formspec = bookshelf_formspec
	-- Inventory slots overlay
	local bx, by = 0, 0.3
	local n_written, n_empty = 0, 0
	for i = 1, 16 do
		if i == 9 then
			bx = 0
			by = by + 1
		end
		local stack = invlist[i]
		if stack:is_empty() then
			formspec = formspec ..
				"image[" .. bx .. "," .. by .. ";1,1;bookshelf_slot.png]"
		else
			local metatable = stack:get_meta():to_table() or {}
			if metatable.fields and metatable.fields.text then
				n_written = n_written + stack:get_count()
			else
				n_empty = n_empty + stack:get_count()
			end
		end
		bx = bx + 1
	end
	meta:set_string("formspec", formspec)
	if n_written + n_empty == 0 then
		meta:set_string("infotext", "Empty Bookshelf")
	else
		meta:set_string("infotext", "Bookshelf (" .. n_written .. " written, " .. n_empty .. " empty books)")
	end
end

-- Bookshelf
local bookshelf_def = {
	description = "Bookshelf",
	tiles = {"planks_wungu.png", "planks_wungu.png", "planks_wungu.png",
		"planks_wungu.png", "bookshelf.png", "bookshelf.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {
		crumbly = mining.hardness(1.5, -1),
		cracky = mining.hardness(1.5, -1),
		choppy = mining.hardness(1.5, 0),
		snappy = mining.hardness(1.5, -1),
		oddly_breakable_by_hand = mining.hardness(1.5, -1),
		flammable = 3
	},
	sounds = sounds.node_sound_wood_defaults(),

	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		inv:set_size("books", 8 * 2)
		update_bookshelf(pos)
	end,
	can_dig = function(pos,player)
		local inv = minetest.get_meta(pos):get_inventory()
		return inv:is_empty("books")
	end,
	allow_metadata_inventory_put = function(pos, listname, index, stack)
		if minetest.get_item_group(stack:get_name(), "book") ~= 0 then
			return stack:get_count()
		end
		return 0
	end,
	on_metadata_inventory_put = function(pos)
		update_bookshelf(pos)
	end,
	on_metadata_inventory_take = function(pos)
		update_bookshelf(pos)
	end,
	on_metadata_inventory_move = function(pos)
		update_bookshelf(pos)
	end,
	on_blast = function(pos)
		local drops = {}
		functions.get_inventory_drops(pos, "books", drops)
		drops[#drops+1] = "sb_shelves:bookshelf"
		minetest.remove_node(pos)
		return drops
	end,
}
functions.set_inventory_action_loggers(bookshelf_def, "bookshelf")
minetest.register_node("sb_shelves:bookshelf", bookshelf_def)