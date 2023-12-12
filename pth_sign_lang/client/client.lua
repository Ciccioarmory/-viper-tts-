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

RegisterNetEvent('viper-tts:client:playsound', function(userInput)
    local ped = PlayerPedId()

    if not userInput then

        exports['okokNotify']:Alert('TTS', 'You have to include a message! (Example: /tts Hello)', 5000, 'error', true)

        return
    end

    TriggerServerEvent("viper-tts:server:playsound", getNearPlayers(Config.distance), GetEntityCoords(ped), userInput)
end)
