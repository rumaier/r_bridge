Core.Carlock = {}

Core.Info.Carlock = Cfg.Carlock or nil

function Core.Carlock.GiveKeys(vehicle)
    if not Cfg.CarLock then return end
    local plate = GetVehicleNumberPlateText(vehicle)
    local resource = Cfg.CarLock
    if resource == 'qb' then
        TriggerEvent("qb-vehiclekeys:client:AddKeys", plate)
    elseif resource == 'wasabi' then
        exports.wasabi_carlock:GiveKey(plate)
    elseif resource == 'mrnewb' then
        exports.MrNewbVehicleKeys:GiveKeys(vehicle)
    elseif resource == 'quasar' then
        exports['qs-vehiclekeys']:GiveKeys(plate, vehicle, true)
    elseif resource == 'custom' then
        -- insert your car lock sytem here
    end
    debug('[DEBUG] - GiveKeys:', vehicle, plate)
end