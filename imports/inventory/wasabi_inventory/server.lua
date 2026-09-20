---@diagnostic disable: duplicate-set-field, undefined-global
local WASABI = exports.wasabi_inventory

local Inventory = {}

Inventory.getDetected = function()
    return 'wasabi_inventory'
end

Inventory.addItem = function(src, item, count, metadata)
    return WASABI:AddItem(src, item, count, metadata)
end

Inventory.removeItem = function(src, item, count, metadata, slot)
    return WASABI:RemoveItem(src, item, count, metadata, slot)
end

Inventory.getItem = function(src, item, metadata)
    return WASABI:GetItem(src, item, metadata)
end

Inventory.getItemCount = function(src, item)
    return WASABI:GetItemCount(src, item)
end

Inventory.getInventory = function(src)
    return WASABI:GetInventoryItems(src)
end

Inventory.canCarry = function(src, item, count)
    return WASABI:CanCarryItem(src, item, count)
end

Inventory.setItemMetadata = function(src, item, slot, metadata)
    return WASABI:SetMetadata(src, slot, metadata)
end

Inventory.getItemInfo = function(item)
    return WASABI:Items(item)
end

return Inventory
