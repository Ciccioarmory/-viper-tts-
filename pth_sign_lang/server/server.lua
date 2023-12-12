RegisterServerEvent("pth_sign_lang:playsound")
AddEventHandler("pth_sign_lang:playsound", function(nearPlayers, pos, text)
    local source = source
    for _, usource in pairs(nearPlayers) do
        exports.xsoundTts:TextToSpeechPos(usource, "sigh_text", Config.lang, text, Config.volume, pos, false)
    end
end)
