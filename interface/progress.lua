Core.Interface = Core.Interface or {}

Core.Interface.progress = function(data)
    local progress = lib.progressCircle(data)
    return progress
end

Core.Interface.closeProgress = function()
    lib.cancelProgress()
end