--!strict

local fs = require("@lune/fs")

local config = require("@config/")
local logger = require("@exports/logger")

local command_constructor = require("@constructors/command")
local get_module = require("@utils/get_module")

export type command_data = command_constructor.command_data
export type command = command_constructor.command

local function loadCommands(): { [string]: command }
	local commands = {}

	if not config.commands.enabled then 
		return commands
	end

	local function traverse(parent: string)
		for _, name in pairs(fs.readDir(parent)) do
			if name:find("init") then
				continue
			end

			local path = `{parent}/{name}`

			if fs.isFile(path) then
				if not path:match("%.luau$") then
					continue
				end

				local module = get_module(path)()
				local success, command = pcall(module)

				if not success then
					logger:warn(`Failed to execute command module {path}: {command}`)

					continue
				end

				command = command :: command

				if command.private then
					return
				end

				commands[command.name] = command
			elseif fs.isDir(path) then
				traverse(path)
			end
		end
	end

	traverse("./src/commands")

	return commands :: { [string]: command }
end

return loadCommands
