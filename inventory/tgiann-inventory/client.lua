---@diagnostic disable: duplicate-set-field
if GetResourceState('tgiann-inventory') ~= 'started' then return end

Core.Inventory = {}
Core.Inventory.Current = 'tgiann-inventory'
Core.Inventory.IconPath = 'nui://inventory_images/html/images/%s.webp'

local TgiannInventory = exports['tgiann-inventory']

Core.Inventory.getItemInfo = function(item)
    local items = TgiannInventory:GetItemList()
    for _, info in pairs(items) do
        if info.name == item then return info end
    end
end
