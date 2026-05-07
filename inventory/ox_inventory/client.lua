---@diagnostic disable: duplicate-set-field
if GetResourceState('ox_inventory') ~= 'started' then return end
local OX = exports.ox_inventory

Inventory = {}

Inventory.getDetected = function()
    return 'ox_inventory'
end

Inventory.getIconPath = function()
    return 'nui://ox_inventory/web/images/%s.png'
end

Inventory.getItemInfo = function(item)
    return OX:Items(item)
end