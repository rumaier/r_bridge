if GetResourceState('tgiann-inventory') ~= 'started' then return end

Core.Info.Inventory = 'tgiann-inventory'

Core.Inventory = {}

function Core.Inventory.AddItem(src, item, count, metadata)
    local src = src or source
    local action = exports['tgiann-inventory']:AddItem(src, item, count, metadata)
    return (action.itemAddRemoveLog == 'added')
end

function Core.Inventory.RemoveItem(src, item, count, metadata)
    local src = src or source
    local action = exports['tgiann-inventory']:RemoveItem(src, item, count, nil, metadata)
    return action
end 

function Core.Inventory.GetItem(src, item, metadata)
    local src = src or source
    local item = exports['tgiann-inventory']:GetItemByName(src, item, metadata)
    item.count = item.amount
    item.metadata = item.info
    return item
end

function Core.Inventory.GetItemCount(src, item, metadata)
    local src = src or source
    local item = exports['tgiann-inventory']:GetItemByName(src, item, metadata)
    return item.amount or 0
end

function Core.Inventory.GetInventoryItems(src)
    local src = src or source
    return exports['tgiann-inventory']:GetPlayerItems(src)
end

function Core.Inventory.CanCarryItem(src, item, count)
    local src = src or source
    return exports["tgiann-inventory"]:CanCarryItem(src, item, count)
end

function Core.Inventory.RegisterStash(id, label, slots, weight, owner)
    exports["tgiann-inventory"]:CreateCustomStashWithItem(id, {})
end

function Core.Inventory.GetItemInfo(item)
    local itemsList = exports['tgiann-inventory']:GetItemList()
    for _, itemData in pairs(itemsList) do
        if itemData.name == item then
            return itemData
        end
    end
end

function Core.Inventory.SetMetadata(src, item, slot, metadata)
    local src = src or source
    exports["tgiann-inventory"]:UpdateItemMetadata(src, item, slot, metadata)
end