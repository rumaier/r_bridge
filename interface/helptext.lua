Core.Interface = Core.Interface or {}

local helpTextActive = false

Core.Interface.showHelpText = function(text)
    PlaySoundFrontend(-1, "Click", "DLC_HEIST_HACKING_SNAKE_SOUNDS", false)
    SendNUIMessage({
        action = 'helpText:show',
        data = { text = text }
    })
    helpTextActive = true
end

Core.Interface.hideHelpText = function()
    SendNUIMessage({ action = 'helpText:hide' })
    helpTextActive = false
end

Core.Interface.isHelpTextActive = function()
    return helpTextActive
end