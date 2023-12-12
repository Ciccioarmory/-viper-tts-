local QBCore = exports['qb-core']:GetCoreObject()

-- Function to get the user's Discord ID
function GetDiscordId(playerId)
    local identifiers = GetPlayerIdentifiers(playerId)

    for _, identifier in ipairs(identifiers) do
        -- Check if the identifier is a Discord identifier
        if string.match(identifier, "discord:") then
            -- Extract and return the Discord ID
            return string.sub(identifier, 9)
        end
    end

    -- Return nil if no Discord ID is found
    return nil
end

--- Checks if player discord id is in the whitelist, returns true if it is, false if it is not
---@param src integer Player id
local function checkHasAccess(src)
    local playerDiscord = tonumber(GetDiscordId(src))
    print(playerDiscord)
    print(type(playerDiscord))

    if not exports['viper-lib']:contains(Config.Whitelist, playerDiscord) then
        TriggerClientEvent('okokNotify:Alert', src, 'TTS', 'You don\'t have access to this!', 5000, 'error', true)
        return false
    end

    return true
end

--- Gets the message that goes to the tts by cycling trough the args table
---@param table table
function getUserInput(table)
    local userInput = ""

    for k, v in pairs(table) do

        userInput = userInput .. " " .. v

    end

    return userInput
end

QBCore.Commands.Add(Config.command, 'Use the text to speech', {}, false, function(source, args)
    local src = source

    if not checkHasAccess(src) then
        return
    end

    local userInput = getUserInput(args)

    TriggerClientEvent("viper-tts:client:playsound", src, userInput)

end)

RegisterNetEvent('viper-tts:server:playsound', function(nearPlayers, pos, text)
    local src = source

    if not checkHasAccess(src) then
        return
    end

    for _, playerId in pairs(nearPlayers) do

        exports['xsoundTts']:TextToSpeechPos(playerId, "sigh_text", Config.lang, text, Config.volume, pos, false)

    end
end)
