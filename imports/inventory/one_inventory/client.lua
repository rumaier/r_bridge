---@diagnostic disable: duplicate-set-field, undefined-global
local ONE = exports.one_inventory

local Inventory = {}

Inventory.getDetected = function()
    return 'one_inventory'
end

Inventory.getIconPath = function()
    return 'nui://one_inventory/web/images/%s.png'
end

Inventory.getItemInfo = function(item)
    return ONE:GetItemDefinition(item)
end

return Inventory
