--!strict

local DiscordLuau = require("@DiscordLuau/")

return function(interaction: DiscordLuau.DiscordInteraction)
    local options = interaction.data.options
    local options_list = {}

    for _, option in pairs(options) do
        options_list[option.name] = option.value
    end

    return options_list
end
