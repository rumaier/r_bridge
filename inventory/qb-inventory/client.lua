if GetResourceState('qb-inventory') ~= 'started' then return end

Core.Info.Inventory = 'qb-inventory'
local QBCore = exports['qb-core']:GetCoreObject()

Core.Inventory = {}

function Core.Inventory.ImgPath()
    return "nui://qb-inventory/html/images/%s.png"
end

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