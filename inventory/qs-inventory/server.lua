---@diagnostic disable: duplicate-set-field
if GetResourceState('qs-inventory') ~= 'started' then return end

Core.Inventory = {}
Core.Inventory.Current = 'qs-inventory'

local QSInventory = exports['qs-inventory']

Core.Inventory.addItem = function(src, item, count, metadata)
    local success = QSInventory:AddItem(src, item, count, nil, metadata)
    return success
end

local function removeMetadataItem(src, item, count, metadata)
    local inventory = Core.Inventory.getPlayerInventory(src)
    if not inventory then return false end
    for _, i in pairs(inventory) do
        if i.name == item and lib.table.matches(i.metadata, metadata) then
            local success = QSInventory:RemoveItem(src, item, count, i.slot)
            return success
        end
    end
    return false
end

Core.Inventory.removeItem = function(src, item, count, metadata, slot)
    if metadata then return removeMetadataItem(src, item, count, metadata) end
    local success = QSInventory:RemoveItem(src, item, count, slot)
    return success
end

Core.Inventory.setItemMetadata = function(src, item, slot, metadata)
    QSInventory:SetItemMetadata(src, slot, metadata)
end

Core.Inventory.getItem = function(src, item, metadata)
    local inventory = Core.Inventory.getPlayerInventory(src)
    if not inventory then return end
    for _, v in pairs(inventory) do
        if v.name == item and (not metadata or lib.table.matches(v.metadata, metadata)) then
            return NormalizeItem(v)
        end
    end
end

Core.Inventory.getItemCount = function(src, item)
    local count = QSInventory:GetItemTotalAmount(src, item)
    return count
end

Core.Inventory.getPlayerInventory = function(src)
    local inventory = QSInventory:GetInventory(src)
    inventory = NormalizeInventory(inventory)
    return inventory
end

Core.Inventory.canCarryItem = function(src, item, count)
    local canCarry = QSInventory:CanCarryItem(src, item, count)
    return canCarry
end

Core.Inventory.getItemInfo = function(item)
    local items = QSInventory:GetItemList()
    return items[item]
end