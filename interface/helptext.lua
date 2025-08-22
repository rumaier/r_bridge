Core.Interface = Core.Interface or {}

Core.Interface.showHelpText = function(text)
    PlaySoundFrontend(-1, "Click", "DLC_HEIST_HACKING_SNAKE_SOUNDS", false)
    SendNUIMessage({
        action = 'helpText:show',
        data = { text = text }
    })
end

Core.Interface.hideHelpText = function()
    SendNUIMessage({ action = 'helpText:hide' })
end