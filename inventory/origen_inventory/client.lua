---@diagnostic disable: duplicate-set-field
if GetResourceState('origen_inventory') ~= 'started' then return end
local ORIGEN = exports.origen_inventory

Inventory = {}

Inventory.getDetected = function()
    return 'origen_inventory'
end

Inventory.getIconPath = function()
    return 'nui://origen_inventory/html/images/%s.png'
end

Inventory.getItemInfo = function(item)
    return ORIGEN:Items(item)
end