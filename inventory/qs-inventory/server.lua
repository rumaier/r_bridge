if GetResourceState('qs-inventory') ~= 'started' then return end

Core.Info.Inventory = 'qs-inventory'

Core.Inventory = {}

function Core.Inventory.AddItem(src, item, count, metadata)
    local src = src or source
    return exports['qs-inventory']:AddItem(src, item, count, nil, metadata)
end

function Core.Inventory.RemoveItem(src, item, count, metadata)
    local src = src or source
    return exports ['qs-inventory']:RemoveItem(src, item, count, nil, metadata)
end

function Core.Inventory.GetItem(src, item, metadata)
    local src = src or source
    local playerItems = exports['qs-inventory']:GetInventory(src)
    for _, itemInfo in pairs(playerItems) do
        if itemInfo.name == item then
            itemInfo.count = itemInfo.amount
            itemInfo.metadata = itemInfo.info
            itemInfo.stack = itemInfo.unique
            return itemInfo
        end
    end
end

function Core.Inventory.GetItemCount(src, item, metadata)
    local src = src or source
    return exports['qs-inventory']:GetItemTotalAmount(src, item)
end

function Core.Inventory.GetInventoryItems(src)
    local src = src or source
    local playerItems = exports['qs-inventory']:GetInventory(src)
    for _, item in pairs(playerItems) do
        item.count = item.amount
        item.metadata = item.info
        item.stack = not item.unique
    end
    return playerItems
end

function Core.Inventory.CanCarryItem(src, item, count)
    local src = src or source
    return exports['qs-inventory']:CanCarryItem(src, item, count)
end

function Core.Inventory.RegisterStash(id, label, slots, weight, owner)
    -- qs-inventory handles all the stash stuff client side, so we don't need to do anything here
end

function Core.Inventory.GetItemInfo(item)
    local itemInfo = exports['qs-inventory']:GetItemList()[item]
    if not itemInfo then return end
    itemInfo.count = itemInfo.amount
    itemInfo.metadata = itemInfo.info
    itemInfo.stack = not itemInfo.unique
    return itemInfo
end
