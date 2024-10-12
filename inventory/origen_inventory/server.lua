if GetResourceState('origen_inventory') ~= 'started' then return end

Core.Info.Inventory = 'origen_inventory'
local origen_inventory = exports.origen_inventory

Core.Inventory = {}

function Core.Inventory.AddItem(src, item, count, metadata)
    local src = src or source
    return origen_inventory:AddItem(src, item, count, nil, nil, metadata)
end

function Core.Inventory.RemoveItem(src, item, count, metadata)
    local src = src or source
    return origen_inventory:RemoveItem(src, item, count, metadata)
end

function Core.Inventory.GetItem(src, item, metadata)
    local src = src or source
    local items = origen_inventory:GetInventory(src)
    for _, itemInfo in pairs(items) do
        if itemInfo.name == item and metadata == nil then
            itemInfo.count = itemInfo.amount
            itemInfo.metadata = itemInfo.info
            itemInfo.stack = not itemInfo.unique
            return itemInfo
        elseif itemInfo.name == item and metadata ~= nil then
            if itemInfo.info == metadata then
                itemInfo.count = itemInfo.amount
                itemInfo.metadata = itemInfo.info
                itemInfo.stack = not itemInfo.unique
                return itemInfo
            end
        end
    end
end

function Core.Inventory.GetItemCount(src, item, metadata)
    local src = src or source
    if metadata == nil then
        return origen_inventory:GetItemTotalAmount(src, item)
    else
        local items = origen_inventory:GetInventory(src)
        for _, itemInfo in pairs(items) do
            if itemInfo.name == item and itemInfo.info == metadata then
                return itemInfo.amount
            end
        end
    end
    return 0
end

function Core.Inventory.GetInventoryItems(src)
    local src = src or source
    local items = origen_inventory:GetInventory(src)
    for _, itemInfo in pairs(items) do
        itemInfo.count = itemInfo.amount
        itemInfo.metadata = itemInfo.info
        itemInfo.stack = not itemInfo.unique
    end
    return items
end

function Core.Inventory.CanCarryItem(src, item, count)
    local src = src or source
    return origen_inventory:CanCarryItems(src, item, count)
end

function Core.Inventory.RegisterStash(id, label, slots, weight, owner)
    -- I dont use stash systems, I am probably just gonna end up removing the functions for it.
end

function Core.Inventory.GetItemInfo(item)
    local items = origen_inventory:GetItems()
    for _, itemInfo in pairs(items) do
        if itemInfo.name == item then
            itemInfo.stack = not itemInfo.unique
            return itemInfo
        end
    end
end

function Core.Inventory.SetMetadata(src, item, slot, metadata)
    local src = src or source
    origen_inventory:SetItemMetadata(src, item, slot, metadata)
end