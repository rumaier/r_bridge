---@diagnostic disable: undefined-global

local Interface = {}

Interface.notify = function(title, text, type, duration)
    lib.notify({
        title = title,
        description = text,
        type = type,
        duration = duration or 5000,
    })
end

Interface.alert = function(data)
    return lib.alertDialog(data)
end

Interface.registerContext = function(data)
    lib.registerContext(data)
end

Interface.showContext = function(id)
    lib.showContext(id)
end

Interface.hideContext = function()
    lib.hideContext()
end

Interface.showHud = function()

end

Interface.hideHud = function()

end

Interface.input = function(heading, rows, options)
    return lib.inputDialog(heading, rows, options)
end

Interface.closeInput = function()
    lib.closeInputDialog()
end

Interface.progress = function(data)
    return lib.progressCircle(data)
end

Interface.isProgressActive = function()
    return lib.progressActive()
end

Interface.cancelProgress = function()
    lib.cancelProgress()
end

Interface.skillCheck = function(difficulty, inputs)
    return lib.skillCheck(difficulty, inputs)
end

Interface.cancelSkillCheck = function()
    lib.cancelSkillCheck()
end

Interface.showTextUi = function(text, options)
    lib.showTextUI(text, options)
end

Interface.hideTextUi = function()
    lib.hideTextUI()
end

Interface.isTextUiOpen = function()
    return lib.isTextUIOpen()
end

return Interface
