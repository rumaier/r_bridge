---@diagnostic disable: duplicate-set-field
if GetResourceState('tgiann-inventory') ~= 'started' then return end
local TGIANN = exports['tgiann-inventory']

Inventory = {}

Inventory.getDetected = function()
    return 'tgiann-inventory'
end

Inventory.addItem = function(src, item, count, metadata)
    return TGIANN:AddItem(src, item, count, nil, metadata)
end

Inventory.removeItem = function(src, item, count, metadata, slot)
    return TGIANN:RemoveItem(src, item, count, slot, metadata)
end

Inventory.getItem = function(src, item, metadata)
    local item = TGIANN:GetItemByName(src, item, metadata)
    return item and NormalizeItem(item)
end

Inventory.getItemCount = function(src, item)
    return TGIANN:GetItemCount(src, item)
end

Inventory.getInventory = function(src)
    local inventory = TGIANN:GetPlayerItems(src)
    return inventory and NormalizeInventory(inventory)
end

Inventory.canCarry = function(src, item, count)
    return TGIANN:CanCarryItem(src, item, count)
end

Inventory.setItemMetadata = function(src, item, slot, metadata)
    return TGIANN:UpdateItemMetadata(src, item, slot, metadata)
end

Inventory.getItemInfo = function(item)
    local items = TGIANN:GetItemList()
    for _, i in pairs(items) do
        if i.name == item then
            return i
        end
    end
end