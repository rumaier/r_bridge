---@diagnostic disable: duplicate-set-field
if GetResourceState('ox_inventory') ~= 'started' then return end
local OX = exports.ox_inventory

Inventory = {}

Inventory.getDetected = function()
    return 'ox_inventory'
end

Inventory.addItem = function(src, item, count, metadata)
    return OX:AddItem(src, item, count, metadata)
end

Inventory.removeItem = function(src, item, count, metadata, slot)
    return OX:RemoveItem(src, item, count, metadata, slot)
end

Inventory.getItem = function(src, item, metadata)
    return OX:GetItem(src, item, metadata)
end

Inventory.getItemCount = function(src, item)
    return OX:GetItemCount(src, item)
end

Inventory.getInventory = function(src)
    return OX:GetInventoryItems(src)
end

Inventory.canCarry = function(src, item, count)
    return OX:CanCarryItem(src, item, count)
end

Inventory.setItemMetadata = function(src, item, slot, metadata)
    return OX:SetMetadata(src, slot, metadata)
end

Inventory.getItemInfo = function(item)
    return OX:Items(item)
end