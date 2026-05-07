Interface = Interface or {}

Interface.notify = function(title, text, type, duration)
    lib.notify({
        title = title,
        description = text,
        type = type,
        duration = duration
    })
end

RegisterNetEvent('r_bridge:notify', Interface.notify)