---@diagnostic disable: duplicate-set-field
if GetResourceState('tgiann-inventory') ~= 'started' then return end

Core.Inventory = {}
Core.Inventory.Current = 'tgiann-inventory'

local TgiannInventory = exports['tgiann-inventory']

Core.Inventory.addItem = function(src, item, count, metadata)
    local success = TgiannInventory:AddItem(src, item, count, metadata)
    return success
end

Core.Inventory.removeItem = function(src, item, count, metadata, slot)
    local success = TgiannInventory:RemoveItem(src, item, count, slot, metadata)
    return success
end

Core.Inventory.setItemMetadata = function(src, item, slot, metadata)
    TgiannInventory:UpdateItemMetadata(src, item, slot, metadata)
end

Core.Inventory.getItem = function(src, item, metadata)
    local item = TgiannInventory:GetItemByName(src, item, metadata)
    item = NormalizeItem(item)
    return item
end

Core.Inventory.getItemCount = function(src, item)
    local count = TgiannInventory:GetItemCount(src, item)
    return count
end

Core.Inventory.getPlayerInventory = function(src)
    local inventory = TgiannInventory:GetPlayerItems(src)
    inventory = NormalizeInventory(inventory)
    return inventory
end

Core.Inventory.canCarryItem = function(src, item, count)
    local canCarry = TgiannInventory:CanCarryItem(src, item, count)
    return canCarry
end

Core.Inventory.getItemInfo = function(item)
    local items = TgiannInventory:GetItemList()
    for _, info in pairs(items) do 
        if info.name == item then return info end
    end
end