local io = require("@lune/stdio")

local emojis = {
    ["Info"] = "ℹ️",
    ["Warn"] = "⚠"
}

local function logFn(level: string, message: string)
    io.write(`[{emojis[level]}  Bot {level}] :: {message}\n`)
end

return {
    logFn = logFn
}