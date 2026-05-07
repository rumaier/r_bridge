---@diagnostic disable: duplicate-set-field
if GetResourceState('codem-inventory') ~= 'started' then return end
local CODEM = exports['codem-inventory']

Inventory = {}

Inventory.getDetected = function()
    return 'codem-inventory'
end

Inventory.addItem = function(src, item, count, metadata)
    return CODEM:AddItem(src, item, count, nil, metadata)
end

local function metadataRemove(src, item, count, metadata)
    local inventory = Inventory.getInventory(src) or {}
    for _, i in pairs(inventory) do
        if i.name == item and lib.table.matches(i.metadata, metadata) then
            return Inventory.removeItem(src, item, count, nil, i.slot)
        end
    end
end

Inventory.removeItem = function(src, item, count, metadata, slot)
    if not metadata then
        return CODEM:RemoveItem(src, item, count, slot)
    else
        return metadataRemove(src, item, count, metadata)
    end
end

Inventory.getItem = function(src, item, metadata)
    local inventory = Inventory.getInventory(src) or {}
    for _, i in pairs(inventory) do
        if i.name == item and (not metadata or lib.table.matches(i.metadata, metadata)) then
            return NormalizeItem(i)
        end
    end
end

Inventory.getItemCount = function(src, item)
    return CODEM:GetItemsTotalAmount(src, item)
end

Inventory.getInventory = function(src)
    local identifier = Framework.getPlayerIdentifier(src)
    local inventory = CODEM:GetInventory(identifier, src)
    return NormalizeInventory(inventory)
end

Inventory.canCarry = function(src, item, count)
    return true
end

Inventory.setItemMetadata = function(src, item, slot, metadata)
    return CODEM:setItemMetadata(src, slot, metadata)
end

Inventory.getItemInfo = function(item)
    local items = CODEM:GetItemList()
    for _, i in pairs(items) do
        if i.name == item then
            return i
        end
    end
end