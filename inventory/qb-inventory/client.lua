if GetResourceState('qb-inventory') ~= 'started' then return end

Core.Info.Inventory = 'qb-inventory'
local QBCore = exports['qb-core']:GetCoreObject()

Core.Inventory = {}

---@param id number
function Core.Inventory.OpenStash(id)
    TriggerEvent("inventory:client:SetCurrentStash", id)
    TriggerServerEvent("inventory:server:OpenInventory", "stash", id, {
        maxweight = 50000,
        slots = 50,
    })
end

---@param item string
function Core.Inventory.GetItemInfo(item)
    return QBCore.Shared.Items[item]
end