Core.Interface = Core.Interface or {}

Core.Interface.notify = function(title, text, type, duration)
    lib.notify({
        title = title,
        description = text,
        type = type,
        duration = duration,
        position = 'top-right'
    })
end

RegisterNetEvent('r_bridge:notify', Core.Interface.notify)