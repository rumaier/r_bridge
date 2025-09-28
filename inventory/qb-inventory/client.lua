---@diagnostic disable: duplicate-set-field
if GetResourceState('qb-inventory') ~= 'started' then return end

Core.Inventory = {}
Core.Inventory.Current = 'qb-inventory'
Core.Inventory.IconPath = 'nui://qb-inventory/html/images/%s.png'

local QBCore = exports['qb-core']:GetCoreObject()

Core.Inventory.getItemInfo = function(item)
    local info = QBCore.Shared.Items[item]
    return info
end