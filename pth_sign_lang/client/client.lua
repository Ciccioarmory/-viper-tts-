RegisterCommand('tts', function(source, args, rawCommand)

    local ped = PlayerPedId()

    local userInput = ""

    for k, v in pairs(args) do
        userInput = userInput .. " " .. v
    end

    if not userInput then
        exports['okokNotify']:Alert('TTS', 'You have to include a message! (Example: /tts Hello)', 5000, 'error', true)
        return
    end

    TriggerServerEvent("pth_sign_lang:playsound", getNearPlayers(Config.distance), GetEntityCoords(ped), userInput)
end, false)

--[[ RegisterCommand(Config.command, function()
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = "show"
    })
end)

RegisterNUICallback("closeAll", function(data, cb)
    SetNuiFocus(false, false)
    SendNUIMessage({
        action = "hide"
    })
    cb {
        "ok"
    }
end) ]]

RegisterNUICallback("ReadText", function(data, cb)
    print(json.encode(data))
    TriggerServerEvent("pth_sign_lang:playsound", getNearPlayers(Config.distance), GetEntityCoords(PlayerPedId()), data)
    cb {
        "ok"
    }
end)

function getNearPlayers(radius)
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
