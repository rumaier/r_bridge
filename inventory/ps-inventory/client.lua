if GetResourceState('ps-inventory') ~= 'started' then return end

Core.Info.Inventory = 'ps-inventory'
local QBCore = exports['qb-core']:GetCoreObject()

Core.Inventory = {}

function Core.Inventory.OpenStash(id)
    TriggerEvent("inventory:client:SetCurrentStash", id)
    TriggerServerEvent("inventory:server:OpenInventory", "stash", id, {
        maxweight = 50000,
        slots = 50,
    })
end

function Core.Inventory.GetItemInfo(item)
    return QBCore.Shared.Items[item]
end