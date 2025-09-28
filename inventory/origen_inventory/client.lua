---@diagnostic disable: duplicate-set-field
if GetResourceState('origen_inventory') ~= 'started' then return end

Core.Inventory = {}
Core.Inventory.Current = 'origen_inventory'
Core.Inventory.IconPath = 'nui://origen_inventory/html/images/%s.png'

local origen_inventory = exports.origen_inventory

Core.Inventory.getItemInfo = function(item)
    local info = origen_inventory:Items(item)
    return info
end