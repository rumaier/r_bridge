---@diagnostic disable: duplicate-set-field, undefined-global
local OX = exports.ox_inventory

local Inventory = {}

Inventory.getDetected = function()
    return 'ox_inventory'
end

Inventory.getIconPath = function()
    return 'nui://ox_inventory/web/images/%s.png'
end

Inventory.getItemInfo = function(item)
    return OX:Items(item)
end

return Inventory
