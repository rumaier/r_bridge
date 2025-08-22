---@diagnostic disable: duplicate-set-field
if GetResourceState('qs-vehiclekeys') ~= 'started' then return end

Core.CarLock = {}
Core.CarLock.Current = 'qs-vehiclekeys'

local QSVehicleKeys = exports['qs-vehiclekeys']

Core.CarLock.giveKeys = function(src, vehicle)
    local model = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
    local plate = GetVehicleNumberPlateText(vehicle)
    QSVehicleKeys:GiveServerKeys(src, plate, model, false)
end

Core.CarLock.removeKeys = function(src, vehicle)
    local model = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
    local plate = GetVehicleNumberPlateText(vehicle)
    QSVehicleKeys:RemoveServerKeys(src, plate, model)
end