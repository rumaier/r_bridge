---@diagnostic disable: duplicate-set-field, undefined-global
local ONE = exports.one_inventory

local Inventory = {}

Inventory.getDetected = function()
    return 'one_inventory'
end

Inventory.addItem = function(src, item, count, metadata)
    return ONE:AddItem(src, item, count, metadata)
end

Inventory.removeItem = function(src, item, count, metadata, slot)
    return ONE:RemoveItem(src, item, count, metadata, slot)
end

Inventory.getItem = function(src, item, metadata)
    return ONE:GetItem(src, item, metadata)
end

Inventory.getItemCount = function(src, item)
    return ONE:GetItemCount(src, item)
end

Inventory.getInventory = function(src)
    return ONE:GetInventoryItems(src)
end

Inventory.canCarry = function(src, item, count)
    return ONE:CanCarryItem(src, item, count)
end

Inventory.setItemMetadata = function(src, item, slot, metadata)
    return ONE:SetItemMetadata(src, slot, metadata)
end

Inventory.getItemInfo = function(item)
    return ONE:GetItemDefinition(item)
end

return Inventory
