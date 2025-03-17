if GetResourceState('codem-inventory') ~= 'started' then return end

Core.Info.Inventory = 'codem-inventory'

Core.Inventory = {}

function Core.Inventory.AddItem(src, item, count, metadata)
    local src = src or source
    return exports['codem-inventory']:AddItem(src, item, count, nil, metadata)
end

function Core.Inventory.RemoveItem(src, item, count, metadata)
    local src = src or source
    if metadata ~= nil then
        local items = exports['codem-inventory']:GetInventory(nil, src)
        for _, pItem in pairs(items) do
            if pItem.name == item.name and lib.table.matches(item.info, metadata) then
                return exports['codem-inventory']:RemoveItem(src, pItem.name, count, pItem.slot)
            end
        end
    end
    return exports['codem-inventory']:RemoveItem(src, item, count, nil)
end

function Core.Inventory.GetItem(src, item, metadata)
    local src = src or source
    local items = exports['codem-inventory']:GetInventory(nil, src)
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
        return exports['codem-inventory']:GetItemsTotalAmount(src, item)
    else
        local items = exports['codem-inventory']:GetInventory(nil, src)
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
    local items = exports['codem-inventory']:GetInventory(nil, src)
    for _, itemInfo in pairs(items) do
        itemInfo.count = itemInfo.amount
        itemInfo.metadata = itemInfo.info
        itemInfo.stack = not itemInfo.unique
    end
    return items
end

function Core.Inventory.CanCarryItem(src, item, count)
    return true -- codem-inventory is another one that doesnt have a canCarry export.... do better.
end

function Core.Inventory.RegisterStash(id, label, slots, weight, owner)
    -- could not find any exports in this for the docs... thank god I dont use it. May just remove stash shit.
end

function Core.Inventory.GetItemInfo(item)
    local items = exports['codem-inventory']:GetItemList()
    for _, itemInfo in pairs(items) do
        if itemInfo.name == item then
            itemInfo.stack = not itemInfo.unique
            return itemInfo
        end
    end
end

function Core.Inventory.SetMetadata(src, item, slot, metadata)
    local src = src or source
    exports['codem-inventory']:SetItemMetadata(src, slot, metadata)
end