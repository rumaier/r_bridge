if GetResourceState('tgiann-inventory') ~= 'started' then return end

Core.Info.Inventory = 'tgiann-inventory'

Core.Inventory = {}

function Core.Inventory.AddItem(src, item, count, metadata)
    local src = src or source
    return -- add item export
end

function Core.Inventory.RemoveItem(src, item, count, metadata)
    local src = src or source
    return -- remove item export
end

function Core.Inventory.GetItem(src, item, metadata)
    local src = src or source
    return exports['tgiann-inventory']:GetItemByName(src, item, metadata) -- NEEDS TESTED
end

function Core.Inventory.GetItemCount(src, item, metadata)
    local src = src or source
    -- get items with export
    -- return count if matches
    return -- item count
end

function Core.Inventory.GetInventoryItems(src)
    local src = src or source
    return exports['tgiann-inventory']:GetPlayerItems(src) -- NEEDS TESTED
end

function Core.Inventory.CanCarryItem(src, item, count)
    local src = src or source
    return exports["tgiann-inventory"]:CanCarryItem(src, item, count) -- NEEDS TESTED
end

function Core.Inventory.RegisterStash(id, label, slots, weight, owner)
    -- have not found anything for this yet, good thing I dont use it
end

function Core.Inventory.GetItemInfo(item)
    local itemsList = exports['tgiann-inventory']:GetItemList() -- NEEDS TESTED
    for _, itemData in pairs(itemsList) do
        if itemData.name == item then
            return itemData
        end
    end
end

function Core.Inventory.SetMetadata(src, item, slot, metadata)
    local src = src or source
    exports["tgiann-inventory"]:UpdateItemMetadata(src, item, slot, metadata) -- NEEDS TESTED
end