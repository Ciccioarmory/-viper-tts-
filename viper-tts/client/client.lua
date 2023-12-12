local function getNearPlayers(radius)
    local nearesPlayers = {}
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local playersList = GetActivePlayers()
    for _, uPid in pairs(playersList) do
        if NetworkIsPlayerConnected(uPid) then
            local uPed = GetPlayerPed(uPid)
            local uCoords = GetEntityCoords(uPed)
            local distance = #(coords - uCoords)
            if distance <= radius then
                table.insert(nearesPlayers, GetPlayerServerId(uPid))
            end
        end
    end
    return nearesPlayers
end

-- Event to get close players and actually play the sound
RegisterNetEvent('viper-tts:client:playsound', function(userInput)

    -- Getting the player ped
    local ped = PlayerPedId()

    -- Checking if userInput has been provided
    if not userInput then

        -- Error notify
        exports['okokNotify']:Alert('TTS', 'You have to include a message! (Example: /tts Hello)', 5000, 'error', true)

        return
    end

    -- Playing the sound server side giving an array of id's, the ped position and the userInput
    TriggerServerEvent("viper-tts:server:playsound", getNearPlayers(Config.distance), GetEntityCoords(ped), userInput)
end)
