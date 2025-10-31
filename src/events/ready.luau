--!strict

local task = require("@lune/task")

local DiscordLuau = require("@DiscordLuau/")

local logger = require("@exports/logger")
local client = require("@exports/client")

local config = require("@config/")

local commands_factory = require("@commands/")
local event_constructor = require("@constructors/event")

function init_commands()
	local commands = commands_factory()
	local commandsList = {}

	for _, command in pairs(commands) do
		table.insert(commandsList, command.command)
	end

	client.internal.commands = commands

	logger:info("registering slash commands...")

	client.discordApplication:setSlashCommandsAsync(commandsList):after(function(_data)
		logger:info("registered slash commands!")
		logger:info("fetching slash commands...")

		client.discordApplication:fetchSlashCommandsAsync():after(function()
			logger:info(`fetched slash commands!`)
		end)
	end)
end

local event = event_constructor({
	name = `onReady`,

	callback = function()
		logger:info(`ready!`)

		if config.commands.enabled then 
			task.spawn(init_commands)
		end
	end,
})

return event
