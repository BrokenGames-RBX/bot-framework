--!strict

local DiscordLuau = require("@DiscordLuau/")

local command_constructor = require("@constructors/command")

return function()
	local command = command_constructor({
		name = "template",
		description = "template command",

		private = true, -- disable this!
		disabled = false,

		permissions = (DiscordLuau.PermissionsBuilder.new() :: any):addPermission(
			DiscordLuau.PermissionsBuilder.Permissions.Administrator
		),
		
		context = DiscordLuau.CommandBuilder.Context.Guild,
		integration = DiscordLuau.CommandBuilder.IntegrationType.GuildCommand,
		type = 1,

		callback = function(interaction: DiscordLuau.DiscordInteraction)
			local message = DiscordLuau.MessageBuilder.new():setContent("test command 5!")

			interaction:sendMessageAsync(message)
		end,
	})

	return command
end
