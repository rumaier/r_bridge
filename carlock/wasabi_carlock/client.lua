---@diagnostic disable: duplicate-set-field
if GetResourceState('wasabi_carlock') ~= 'started' then return end

Core.CarLock = {}
Core.CarLock.Current = 'wasabi_carlock'

local wasabi_carlock = exports.wasabi_carlock

Core.CarLock.giveKeys = function(vehicle)
    local plate = GetVehicleNumberPlateText(vehicle)
    wasabi_carlock:GiveKey(plate)
end

Core.CarLock.removeKeys = function(vehicle)
    local plate = GetVehicleNumberPlateText(vehicle)
    wasabi_carlock:RemoveKey(plate)
end