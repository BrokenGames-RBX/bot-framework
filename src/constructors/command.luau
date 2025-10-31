--!strict

local DiscordLuau = require("@DiscordLuau/")

export type command_data = {
	name: string,
	description: string,

	private: boolean?,
	disabled: boolean?,

	options: { any }?,

	permissions: any,
	
	context: any,
	integration: any,
	type: any,

	guard: ((any) -> ())?,
	callback: (any) -> (),
}

export type command = {
	name: string,
	description: string,

	private: boolean,
	disabled: boolean,

	options: { any },

	permissions: any,

	context: any,
	integration: any,
	type: number,

	guard: ((any) -> ())?,
	callback: (any) -> (),

	command: any,
}

return function(command_data: command_data): command
	local command = {} :: command
	local old_callback = command_data.callback

	command.name = command_data.name
	command.description = command_data.description

	command.private = command_data.private or false
	command.disabled = command_data.disabled or false

	command.options = command_data.options or {}

	command.permissions = command_data.permissions
	command.context = command_data.context
	command.integration = command_data.integration
	command.type = command_data.type

	command.guard = command_data.guard

	command.callback = function(...)
		if command.guard and not command.guard(...) then
			return
		end

		old_callback(...)
	end

	command.command = DiscordLuau.CommandBuilder
		.new()
		:setName(command.name)
		:setDescription(command.description)
		:setGuildPermissions(command.permissions)
		:addContext(command.context)
		:addIntegration(command.integration)

	for _, option in pairs(command.options) do
		command.command:addOption(option)
	end

	return command
end
