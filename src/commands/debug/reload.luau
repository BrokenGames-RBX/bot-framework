--!strict

local DiscordLuau = require("@DiscordLuau/")

local client = require("@exports/client")
local flags = require("@flags/")

local commands_factory = require("@commands/")
local command_constructor = require("@constructors/command")

return function()
	local command = command_constructor({
		name = "reload",
		description = "reload all of the bot's commands",

		private = false,
		disabled = false,

		permissions = (DiscordLuau.PermissionsBuilder.new() :: any):addPermission(
			DiscordLuau.PermissionsBuilder.Permissions.Administrator
		),

		context = DiscordLuau.CommandBuilder.Context.Guild,
		integration = DiscordLuau.CommandBuilder.IntegrationType.GuildCommand,
		type = 1,

		callback = function(interaction: DiscordLuau.DiscordInteraction)
			client.internal.commands = commands_factory()

			local message = DiscordLuau.MessageBuilder.new()
			
			message:setContent("reloaded commands!")
			message:setFlags(bit32.lshift(1, flags.EPHEMERAL))

			interaction:sendMessageAsync(message)
		end,
	})

	return command
end
