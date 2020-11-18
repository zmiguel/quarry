function isInventoryFull()
	for i=1, 16 do
		if turtle.getItemCount(i) == 0 then
			return false
		end
	end
	
	return true
end

-- Fixes inventory scattering.
function stackItems()
	-- Remember seen items
	m = {}
			
	for i=1, 16 do
		local this = turtle.getItemDetail(i)
		
		if this ~= nil then
			-- Slot is not empty
		
			local saved = m[this.name]
		
			if saved ~= nil then
				-- We've seen this item before in the inventory
			
				local ammount = this.count
			
				turtle.select(i)
				turtle.transferTo(saved.slot)
			
				if ammount > saved.space then
					-- We have leftovers, and now the
					-- saved slot is full, so we replace
					-- it by the current one
				
					saved.slot = i
					saved.count = ammount - saved.space
					-- Update on table.
					m[this.name] = saved
			
				elseif ammount == saved.space then
					-- Just delete the entry
					
					m[this.name] = nil
					
				end
				
			else
				-- There isn't another slot with this
				-- item so far, so sign this one up.
			
			this.slot = i
			this.space = turtle.getItemSpace(i)
			
			m[this.name] = this
			
			end
		end
	end
end

function selectItem(name)
	for i=1, 16 do
		local data = turtle.getItemDetail(i)
		if data and data.name == name then
			turtle.select(i)
			return true
		end
	end
	return false
end

function getItemCount(name)
	local count = 0
	for i=1, 16 do
		local data = turtle.getItemDetail(i)
		if data and data.name == name then
			count = count + data.count
		end
	end
	return count
end

function dropThrash()
	local thrash = {
		"minecraft:stone", 
		"minecraft:dirt", 
		"minecraft:gravel", 
		"minecraft:sand", 
		"minecraft:cobblestone", 
		"minecraft:sandstone", 
		"minecraft:bedrock", 
		"chisel:limestone", 
		"chisel:marble", 
		"chisel:diorite", 
		"chisel:granite", 
		"chisel:andesite", 
		"harvestcraft:salt"
	}

	for i=1, 16 do
	
		details = turtle.getItemDetail(i)
		
		if details then
		
			for j=1, #thrash do
				if details.name == thrash[j] then
					turtle.select(i)
					turtle.drop()
				end
			end
		end
	end
end
