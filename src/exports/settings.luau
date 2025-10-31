--!strict

local env = require("@env/")
local DiscordLuau = require("@DiscordLuau/")

local settings = DiscordLuau.SettingsBuilder.new(env.TOKEN)

return settings