--!strict

local DiscordLuau = require("@DiscordLuau/")

local settings = require("./settings")
local client = DiscordLuau.DiscordClient.new(settings)

client:setVerbose(true)

client.internal = {
	commands = {},
	cooldowns = {}
}

return client