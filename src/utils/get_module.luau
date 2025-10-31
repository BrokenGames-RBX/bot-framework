local luau = require("@lune/luau")
local fs = require("@lune/fs")

local logger = require("@exports/logger")

return function(path)
	local source = fs.readFile(path)

	if not source then
		logger:warn(`Failed to read file: {path}`)

		return
	end

	local bytecode = luau.compile(source)
	local loaded = luau.load(bytecode)

	if not loaded then
		logger:warn(`Failed to load bytecode for {path}`)
		
		return
	end

	return loaded
end :: () -> ((any) -> (any))