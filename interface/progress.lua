Core.Interface = Core.Interface or {}

Core.Interface.progress = function(data)
    local progress = lib.progressCircle(data)
    return progress
end

Core.Interface.isProgressActive = function()
    return lib.progressActive()
end

Core.Interface.closeProgress = function()
    lib.cancelProgress()
end