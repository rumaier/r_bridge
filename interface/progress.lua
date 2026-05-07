Interface = Interface or {}

Interface.progress = function(data)
    return lib.progressCircle(data)
end

Interface.isProgressActive = function()
    return lib.progressActive()
end

Interface.cancelProgress = function()
    lib.cancelProgress()
end