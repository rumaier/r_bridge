Interface = Interface or {}

Interface.input = function(heading, rows, options)
    return lib.inputDialog(heading, rows, options)
end

Interface.closeInput = function()
    lib.closeInputDialog()
end