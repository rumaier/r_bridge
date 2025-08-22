---@diagnostic disable: duplicate-set-field
if GetResourceState('MrNewbVehicleKeys') ~= 'started' then return end

Core.CarLock = {}
Core.CarLock.Current = 'MrNewbVehicleKeys'

local MrNewbVehicleKeys = exports.MrNewbVehicleKeys

Core.CarLock.giveKeys = function(src, vehicle)
    local netId = NetworkGetNetworkIdFromEntity(vehicle)
    MrNewbVehicleKeys:GiveKeys(src, netId)
end

Core.CarLock.removeKeys = function(src, vehicle)
    local netId = NetworkGetNetworkIdFromEntity(vehicle)
    MrNewbVehicleKeys:RemoveKeys(src, netId)
end