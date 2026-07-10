---@diagnostic disable: duplicate-set-field, undefined-global
local QB = exports['qb-core']:GetCoreObject()

local Inventory = {}

Inventory.getDetected = function()
    return 'qb-inventory'
end

Inventory.getIconPath = function()
    return 'nui://qb-inventory/html/images/%s.png'
end

Inventory.getItemInfo = function(item)
    return QB.Shared.Items[item]
end

return Inventory
