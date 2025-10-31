--!strict

local events = require("@events/")

local logger = require("@exports/logger")
local client = require("@exports/client")

function handle_event(event: events.event)
	client.eventManager[event.name]:connect(function(...)
		event.callback(...)
	end)
end

for _, event: events.event in pairs(events) do
	handle_event(event)
end

client:connectAsync():after(function()
	logger:info("connecting!")
end)
