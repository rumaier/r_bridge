---@diagnostic disable: duplicate-set-field
if GetResourceState('qs-inventory') ~= 'started' then return end

Core.Inventory = {}
Core.Inventory.Current = 'qs-inventory'
Core.Inventory.IconPath = 'nui://qs-inventory/html/images/%s.png'

local QSInventory = exports['qs-inventory']

Core.Inventory.getItemInfo = function(item)
    local items = QSInventory:GetItemList()
    return items[item]
end