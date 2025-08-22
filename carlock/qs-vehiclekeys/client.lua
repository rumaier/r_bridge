---@diagnostic disable: duplicate-set-field
if GetResourceState('qs-vehiclekeys') ~= 'started' then return end

Core.CarLock = {}
Core.CarLock.Current = 'qs-vehiclekeys'

local QSVehicleKeys = exports['qs-vehiclekeys']

Core.CarLock.giveKeys = function(vehicle)
    local model = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
    local plate = GetVehicleNumberPlateText(vehicle)
    QSVehicleKeys:GiveKeys(plate, model, true)
end

Core.CarLock.removeKeys = function(vehicle)
    local model = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
    local plate = GetVehicleNumberPlateText(vehicle)
    QSVehicleKeys:RemoveKeys(plate, model)
end