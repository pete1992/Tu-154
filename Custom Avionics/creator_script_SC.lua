-- this is temporary script for generating the code, that will create custom DataRefs

-- escape sybols:
-- "\040" = (
-- "\041" = )
-- " \" " = "
-- ' " ' = "

-- in this example, table must be in following format:
-- dataref name [TAB] dataref type [tab] dataref description [TAB] dataref initial value
-- like this:
-- tu154ce/anim/cargo_1	float	положение багажной двери 1. 0 - закрыта, 1 - открыта	0

-- panelDir = path to your aircraft

-- this is temporary script for generating the code, that will create custom DataRefs

local function script_dir()
    local info = debug.getinfo(1, "S").source
    if info:sub(1,1) == "@" then
        local dir = info:match("@(.*/)")
        if dir then
            return dir:gsub("[/\\]$", "")
        end
    end
    return "."
end

local panelDir = script_dir()
print("Panel dir = " .. panelDir)

local dataref_filename = panelDir .. "/DataRefsTu154_int.txt"
local save_filename = panelDir .. "/dataref_creator_2.lua"

print("Opening source file: " .. dataref_filename)
local dataref_file = io.open(dataref_filename, "r")
print("Opening output file: " .. save_filename)
local save_file = io.open(save_filename, "w")

if not dataref_file then
    print("ERROR: Cannot open input file!")
    return
end
if not save_file then
    print("ERROR: Cannot open output file!")
    dataref_file:close()
    return
end

local lines_written = 0

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

        local save_text = "createGlobalProperty"..dataref_type.."\040\""..dataref_name.."\", "..dataref_value.."\041".." -- "..dataref_descr.."\n"
        save_file:write(save_text)
        lines_written = lines_written + 1

        -- Fortschrittsanzeige alle 10 Einträge
        if lines_written % 10 == 0 then
            print("Written " .. lines_written .. " DataRefs...")
        end
    end
end

print("Total DataRefs written: " .. lines_written)
print("Done! Closing files.")
dataref_file:close()
save_file:close()
