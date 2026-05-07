Interface = Interface or {}

Interface.showTextUi = function(text, options)
    lib.showTextUI(text, options)
end

Interface.hideTextUi = function()
    lib.hideTextUI()
end

Interface.isTextUiOpen = function()
    return lib.isTextUIOpen()
end