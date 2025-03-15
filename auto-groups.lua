-- Returns the first matching value in the table that contains the specified key
-- @param table The table to search through
-- @param key The key used to match
-- @return The found value or nil if not found
local function matchKey(table, key)
	for k, v in pairs(table) do
		if k:find(key) then
			return v
		end
	end
	
	return nil
end

-- Finds the corresponding group given a group name, a group type, the desired group type, and a list of groups
-- @param name The base name of the group to find 
-- @param type The group type of the base group
-- @param target The desired group type
-- @param groups A list of groups
-- @return The name of the matching group or nil if not found
local function matchGroup(name, type, target, groups)
	return matchKey(groups[target], name:sub(0, name:lower():find(type) - 1))
end

local function main()
	Printf("Print to Commandline History")
	Echo("Print to System Monitor")
	
	Cmd("Clear")
	
	local groupTypes = {"grid", "linear", "even", "odd", "1/3", "2/3", "3/3"}
	local groups = {}
	
	-- Create list of group types to create
	for _, type in pairs(groupTypes) do
		groups[type] = {}
	end
	
	-- Retreive groups
	for _, group in pairs(DataPool().Groups:Children()) do
		local name = group.name
		
		for _, type in pairs(groupTypes) do
			if name:lower():find(type) then
				groups[type][name] = group
				
				break
			end
		end
	end
	
	-- Create linear groups
	for name, group in pairs(groups["grid"]) do
		local matchingGroup = matchGroup(name, "grid", "linear", groups)
		
		local cmd = string.format('Grid 0/0 /MAtricks; Group "%s"; Grid Linearize LeftToRight; Store Group "%s" /Overwrite; Clear', name, matchingGroup.name)
		
		Cmd(cmd)
	end
	
	-- Create even/odd and thirds groups
	for name, group in pairs(groups.linear) do
		group:Dump()
		
		local parts = {
			even = {},
			odd = {},
			["1/3"] = {},
			["2/3"] = {},
			["3/3"] = {}
		}
		
		-- Get list of fixture IDs for even/odd and thirds groups
		for _, fixture in pairs(group.selectiondata) do
			local id = GetSubfixture(fixture.sf_index).fixture.fid

			if fixture.grid.x % 2 == 0 then
				parts["even"][id] = fixture
			else
				parts["odd"][id] = fixture
			end
			
			local remainder = fixture.grid.x % 3
			
			if remainder == 0 then
				parts["1/3"][id] = fixture
			elseif remainder == 1 then
				parts["2/3"][id] = fixture
			else
				parts["3/3"][id] = fixture
			end
		end
		
		-- Create even/odd and thirds groups
		for k, part in pairs(parts) do
			local matchingGroup = matchGroup(name, "linear", k, groups)
			
			for id, fixture in pairs(part) do
				Cmd(string.format("Grid %s/%s /MAtricks", fixture.grid.x, fixture.grid.y))
				Cmd("Fixture " .. id)
			end
			
			Cmd(string.format('Store Group "%s" /Overwrite; Clear', matchingGroup.name))
		end
	end
end

return main
