Core.Interface = Core.Interface or {}

Core.Interface.inputDialog = function(heading, rows, options)
    -- follows the ox_lib format

    local input = lib.inputDialog(heading, rows, options)
    return input
end

Core.Interface.closeInputDialog = function()
    lib.closeInputDialog()
end