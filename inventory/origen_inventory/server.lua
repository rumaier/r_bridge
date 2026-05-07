---@diagnostic disable: duplicate-set-field
if GetResourceState('origen_inventory') ~= 'started' then return end
local ORIGEN = exports.origen_inventory

Inventory = {}

Inventory.getDetected = function()
    return 'origen_inventory'
end

Inventory.addItem = function(src, item, count, metadata)
    return ORIGEN:addItem(src, item, count, metadata)
end

Inventory.removeItem = function(src, item, count, metadata, slot)
    return ORIGEN:removeItem(src, item, count, metadata, slot)
end

Inventory.getItem = function(src, item, metadata)
    local item = ORIGEN:getItem(src, item, metadata)
    return item and NormalizeItem(item)
end

Inventory.getItemCount = function(src, item)
    return ORIGEN:getItemCount(src, item)
end

Inventory.getInventory = function(src)
    local inventory = ORIGEN:getInventory(src)
    return inventory and NormalizeInventory(inventory)
end

Inventory.canCarry = function(src, item, count)
    return ORIGEN:canCarryItem(src, item, count)
end

Inventory.setItemMetadata = function(src, item, slot, metadata)
    return ORIGEN:setMetadata(src, slot, metadata)
end

Inventory.getItemInfo = function(item)
    return ORIGEN:Items(item)
end