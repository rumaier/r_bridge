---@diagnostic disable: duplicate-set-field
if GetResourceState('wasabi_carlock') ~= 'started' then return end

Core.CarLock = {}
Core.CarLock.Current = 'wasabi_carlock'

local wasabi_carlock = exports.wasabi_carlock

Core.CarLock.giveKeys = function(src, vehicle)
    local plate = GetVehicleNumberPlateText(vehicle)
    wasabi_carlock:GiveKey(src, plate)
end

Core.CarLock.removeKeys = function(src, vehicle)
    local plate = GetVehicleNumberPlateText(vehicle)
    wasabi_carlock:RemoveKey(src, plate)
end