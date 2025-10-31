local util = require("./util")

local logFn = util.logFn

export type RLogImpl = {
	__index: Log,

	new: () -> Log,

	info: (self: Log, message: string) -> (),
	error: (self: Log, message: string) -> (),
	warn: (self: Log, message: string) -> (),
	debug: (self: Log, message: string) -> (),
}

export type Log = typeof(setmetatable(
	{} :: {
		filePath: string?,
		prettyOutput: string,

		info: (self: Log, message: string) -> (),
		error: (self: Log, message: string) -> (),
		warn: (self: Log, message: string) -> (),
		debug: (self: Log, message: string) -> (),
	},
	{} :: RLogImpl
))

local log = {}
log.__index = log

--[[
    Constructs a new log instance.

    @param filePath Optional string which is a path to log to.
    @param prettyOutput Boolean which determines whether or not to make the console output pretty.
]]
function log.new(): Log
	-- make class
	local self = setmetatable({}, log)

	return self :: Log
end

--[[
    Logs an info message. If ``prettyOutput`` is enabled, it will show as bold and blue.

    @param self
    @param message The string to log.
]]
function log.info(_self: Log, message: string)
	logFn("Info", message)
end

--[[
    Logs an error message. If ``prettyOutput`` is enabled, it will show as bold and red.

    @param self
    @param message The string to log.
]]
function log.error(_self: Log, message: string)
	logFn("Error", message)
end

--[[
    Logs a warning message. If ``prettyOutput`` is enabled, it will show as bold and yellow.

    @param self
    @param message The string to log.
]]
function log.warn(_self: Log, message: string)
	logFn("Warn", message)
end

--[[
    Logs a debug message. If ``prettyOutput`` is enabled, it will show as bold and white.

    @param self
    @param message The string to log.
]]
function log.debug(_self: Log, message: string)
	logFn("Debug", message)
end

return log :: RLogImpl
