---@diagnostic disable: duplicate-set-field
if GetResourceState('origen_inventory') ~= 'started' then return end

Core.Inventory = {}
Core.Inventory.Current = 'origen_inventory'

local origen_inventory = exports.origen_inventory

Core.Inventory.addItem = function(src, item, count, metadata)
    local success = origen_inventory:addItem(src, item, count, metadata)
    return success
end

Core.Inventory.removeItem = function(src, item, count, metadata, slot)
    local success = origen_inventory:removeItem(src, item, count, metadata, slot)
    return success
end

Core.Inventory.setItemMetadata = function(src, item, slot, metadata)
    origen_inventory:setMetadata(src, slot, metadata)
end

Core.Inventory.getItem = function(src, item, metadata)
    local item = origen_inventory:getItem(src, item, metadata)
    item = NormalizeItem(item)
    return item
end

Core.Inventory.getItemCount = function(src, item)
    local count = origen_inventory:getItemCount(src, item)
    return count
end

Core.Inventory.getPlayerInventory = function(src)
    local inventory = origen_inventory:getInventory(src)
    inventory = NormalizeInventory(inventory)
    return inventory
end

Core.Inventory.canCarryItem = function(src, item, count)
    local canCarry = origen_inventory:canCarryItem(src, item, count)
    return canCarry
end

Core.Inventory.getItemInfo = function(item)
    local info = origen_inventory:Items(item)
    return info
end