Core.Interface = Core.Interface or {}

Core.Interface.showTextUI = function(text, options)
    lib.showTextUI(text, options)
end

Core.Interface.hideTextUI = function()
    lib.hideTextUI()
end

Core.Interface.isTextUiActive = function()
    return lib.isTextUIOpen()
end