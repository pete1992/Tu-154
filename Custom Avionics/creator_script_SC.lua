print("panel dir = ",sasl.getAircraftPath())

local dataref_filename = sasl.getAircraftPath() .. "/plugins/SASL/data/modules/Custom Module/DataRefsTu154_int.txt" 
local save_filename = sasl.getAircraftPath() .. "/plugins/SASL/data/modules/Custom Module/dataref_creator_2.lua" 
local dataref_file = io.open(dataref_filename, "r") 
local save_file = io.open(save_filename, "w") 
if dataref_file then
	while true do
		local line = dataref_file:read("*line") 
		if line == nil then break end
		local a = 0
		local b = string.find(line, "\t", a) 
		if b ~= nil and b > 9 then 
			local dataref_name = string.sub(line, a, b-1)
			a = b
			b = string.find(line, "\t", a+1) 
			local dataref_type = string.sub(line, a+1, b-1)
			if dataref_type == "float" then dataref_type = "f"
			elseif dataref_type == "int" then dataref_type = "i"
			elseif dataref_type == "string" then dataref_type = "s"
			elseif dataref_type == "double" then dataref_type = "d"
			end 
			a = b
			b = string.find(line, "\t", a+1) 
			dataref_descr = string.sub(line, a+1, b-1)
			dataref_value = string.sub(line, b+1) 
			if not dataref_value or dataref_value == nil then dataref_value = "0" end
			local save_text = "createGlobalProperty"..dataref_type.."\040\""..dataref_name.."\", "..dataref_value.."\041".." 
			save_file:write (save_text) 
		end
	end
end
