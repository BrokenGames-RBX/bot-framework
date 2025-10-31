--!strict

local fs = require("@lune/fs")
local event_constructor = require("@constructors/event")

local root = `src/events`
local events = {}

export type event_data = event_constructor.event_data
export type event = event_constructor.event

for _, name in pairs(fs.readDir(root)) do 
    name = string.gsub(name, ".luau", "")

    if name == "init" then 
        continue
    end

    local event = require(`./{name}`) :: event

    table.insert(events, event)
end

return events