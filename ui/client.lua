local isTextUiOpen = false
local isHelpTextVisible = false

Core.Ui = {}

RegisterCommand('ui', function()
    Core.Ui.ShowTextUi("E", "Remove Vehicle")
    Core.Ui.ShowHelpText("Do what this text says")
    SetTimeout(5000, function()
        Core.Ui.HideTextUi()
        Core.Ui.HideHelpText()
    end)
end, false)

function Core.Ui.ShowTextUi(key, text)
    SendNUIMessage({
        type = "text-ui",
        display = true,
        key = key,
        text = text
    })
    isTextUiOpen = true
end

function Core.Ui.HideTextUi()
    SendNUIMessage({
        type = "text-ui",
        display = false
    })
    isTextUiOpen = false
end

function Core.Ui.isTextUiOpen()
    return isTextUiOpen
end

function Core.Ui.ShowHelpText(text)
    SendNUIMessage({
        type = "help-text",
        display = true,
        text = text
    })
    PlaySoundFrontend(-1, "Click", "DLC_HEIST_HACKING_SNAKE_SOUNDS", false)
    isHelpTextVisible = true
end

function Core.Ui.HideHelpText()
    SendNUIMessage({
        type = "help-text",
        display = false
    })
    isHelpTextVisible = false
end

function Core.Ui.isHelpTextVisible()
    return isHelpTextVisible
end