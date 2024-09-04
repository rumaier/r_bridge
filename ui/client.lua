local isTextUiOpen = false
local isHelpTextVisible = false

Core.Ui = {}

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