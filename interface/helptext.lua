Core.Interface = Core.Interface or {}

Core.Interface.showHelpText = function(text)
    SendNUIMessage({
        action = 'helpText:show',
        data = { text = text }
    })
end

Core.Interface.hideHelpText = function()
    SendNUIMessage({ action = 'helpText:hide' })
end