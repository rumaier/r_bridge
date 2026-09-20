---@diagnostic disable: duplicate-set-field, undefined-global
local WASABI = exports.wasabi_inventory

local Inventory = {}

Inventory.getDetected = function()
    return 'wasabi_inventory'
end

Inventory.getIconPath = function()
    return 'nui://wasabi_inventory/ui/images/%s.png'
end

Inventory.getItemInfo = function(item)
    return WASABI:Items(item)
end

return Inventory
