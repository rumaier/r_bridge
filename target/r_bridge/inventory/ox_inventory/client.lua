---@diagnostic disable: duplicate-set-field
if GetResourceState('ox_inventory') ~= 'started' then return end

Core.Inventory = {}
Core.Inventory.Current = 'ox_inventory'
Core.Inventory.IconPath = 'nui://ox_inventory/web/images/%s.png'

local ox_inventory = exports.ox_inventory

Core.Inventory.getItemInfo = function(item)
    local info = ox_inventory:Items(item)
    return info
end