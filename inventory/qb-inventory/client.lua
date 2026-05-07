---@diagnostic disable: duplicate-set-field
if GetResourceState('qb-inventory') ~= 'started' then return end
local QB = exports['qb-core']:GetCoreObject()

Inventory = {}

Inventory.getDetected = function()
    return 'qb-inventory'
end

Inventory.getIconPath = function()
    return 'nui://qb-inventory/html/images/%s.png'
end

Inventory.getItemInfo = function(item)
    return QB.Shared.Items[item]
end