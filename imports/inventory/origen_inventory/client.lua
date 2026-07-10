---@diagnostic disable: duplicate-set-field, undefined-global
local ORIGEN = exports.origen_inventory

local Inventory = {}

Inventory.getDetected = function()
    return 'origen_inventory'
end

Inventory.getIconPath = function()
    return 'nui://origen_inventory/html/images/%s.png'
end

Inventory.getItemInfo = function(item)
    return ORIGEN:Items(item)
end

return Inventory
