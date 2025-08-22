Core.Interface = Core.Interface or {}

Core.Interface.alertDialog = function(data)
    -- data follows the ox_lib format

    local alert = lib.alertDialog(data)
    return alert
end