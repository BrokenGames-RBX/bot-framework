--!strict

local task = require("@lune/task")
local DateTime = require("@lune/datetime")

local config = require("@config/")
local client = require("@exports/client")

local event_constructor = require("@constructors/event")

local cooldowns_enabled = true

function handle_chat_command(interaction)
	local command = client.internal.commands[interaction.data.name]

	if not command then 
		return
	end

	if cooldowns_enabled then
		local cooldowns = client.internal.cooldowns

		if not cooldowns then
			client.internal.cooldowns = {}
		end
		
		local disabled = command and command.disabled or false

		if disabled then 
			return
		end

		if not cooldowns[command.name] then
			cooldowns[command.name] = {}
		end

		local now = DateTime.now().unixTimestampMillis
		local timestamps = cooldowns[command.name]

		local default_duration = config.commands.cooldown
		local cooldown_duration = (command.cooldown or default_duration) * 1000

		if timestamps[interaction.user.id] then
			local expiration = timestamps[interaction.user.id] + cooldown_duration

			if now < expiration then
				return
			end
		end

		pcall(function()
			command.callback(interaction)

			timestamps[interaction.user.id] = now

			task.delay(cooldown_duration / 1000, function()
				timestamps[interaction.user.id] = nil
			end)
		end)
	else
		pcall(command.callback, interaction)
	end
end

local event = event_constructor({
	name = `onInteraction`,

	callback = function(interaction)
		if not config.commands.enabled then 
			return
		end
		
		local is_chat_command = interaction.type == 2

		if is_chat_command then
			handle_chat_command(interaction)
		end
	end,
})

return event
