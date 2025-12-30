local mod_name = minetest.get_current_modname()
local mod_path = minetest.get_modpath(mod_name)

mining = {}

-- Table of all hardness percentage values
local function hardness_table()
	local hardness = {
		0.1,
		0.2,
		0.25,
		0.3,
		0.4,
		0.5,
		0.6,
		0.65,
		0.7,
		0.75,
		0.8,
		1,
		1.15,
		1.25,
		1.4,
		1.5,
		1.8,
		2,
		2.5,
		2.8,
		3,
		3.5,
		4,
		4.5,
		5,
		10,
		22.5,
		30,
		35,
		50,
		100,
	}
	
	return hardness
end

--
-- Mining time helpers
--

-- Use this when registering a tool
mining.max_time = function(base_time, tool_level)
	local hardness = hardness_table()
	local hardness_size = #hardness
	
	local mine_time = {}
	
	for i = 1, hardness_size do
		mine_time[i * 10] = base_time * (hardness[i] / 100)
		
		for j = 1, 4 do
			if tool_level + 1 > j then
				mine_time[i * 10 + j] = mine_time[i *10]
			else
				mine_time[i * 10 + j] = mine_time[i * 10] * (10 / 3)
			end
		end
		
		mine_time[i * 10 + 5] = mine_time[i * 10] * (10 / 3) -- no tool level is compatible
		
		if tool_level < 0 then
			mine_time[i * -10] = 150 * (hardness[i] / 100) * tool_level -- tool is incompatible but node is hand-breakable
		else
			mine_time[i * -10] = 150 * (hardness[i] / 100)
		end
		
		mine_time[i * -10 - 1] = mine_time[i * -10] * (10 / 3) -- tool is incompatible, node is not hand-breakable
	end
	
	return mine_time
end

-- Use this when registering a node
mining.hardness = function(base_hardness, tool_level)
	local hardness = hardness_table()
	local hardness_size = #hardness
	
	local total_hardness
	
	for i = 1, hardness_size do
		if hardness[i] == base_hardness then
			if tool_level >= 0 and tool_level <= 4 then
				total_hardness = i * 10 + tool_level
			elseif tool_level == -1 then
				total_hardness = i * -10
			elseif tool_level == -2 then
				total_hardness = i * -10 - 1
			end
			
			return total_hardness
		end
	end
end