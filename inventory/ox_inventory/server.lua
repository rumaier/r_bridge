---@diagnostic disable: duplicate-set-field
if GetResourceState('ox_inventory') ~= 'started' then return end

Core.Inventory = {}
Core.Inventory.Current = 'ox_inventory'

local ox_inventory = exports.ox_inventory

Core.Inventory.addItem = function(src, item, count, metadata)
    local success = ox_inventory:AddItem(src, item, count, metadata)
    return success
end

Core.Inventory.removeItem = function(src, item, count, metadata, slot)
    local success = ox_inventory:RemoveItem(src, item, count, metadata, slot)
    return success
end

Core.Inventory.setItemMetadata = function(src, item, slot, metadata)
    ox_inventory:SetMetadata(src, slot, metadata)
end

Core.Inventory.getItem = function(src, item, metadata)
    local item = ox_inventory:GetItem(src, item, metadata, false)
    return item
end

Core.Inventory.getItemCount = function(src, item)
    local count = ox_inventory:GetItemCount(src, item)
    return count
end

Core.Inventory.getPlayerInventory = function(src)
    local inventory = ox_inventory:GetInventoryItems(src, false)
    return inventory
end

Core.Inventory.canCarryItem = function(src, item, count)
    local canCarry = ox_inventory:CanCarryItem(src, item, count)
    return canCarry
end

Core.Inventory.getItemInfo = function(item)
    local info = ox_inventory:Items(item)
    return info
end