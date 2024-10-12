if GetResourceState('codem-inventory') ~= 'started' then return end

Core.Info.Inventory = 'codem-inventory'

Core.Inventory = {}

---@param src number
---@param item string
---@param count number
---@param metadata table | nil
---@return boolean
function Core.Inventory.AddItem(src, item, count, metadata)
    local src = src or source
    return exports['codem-inventory']:AddItem(src, item, count, nil, metadata)
end

---@param src number
---@param item string
---@param count number
---@param metadata table | nil
---@return boolean | nil
function Core.Inventory.RemoveItem(src, item, count, metadata)
    local src = src or source
    if metadata ~= nil then
        local items = exports['codem-inventory']:GetInventory(nil, src)
        for _, itemInfo in pairs(items) do
            if itemInfo.name == item then
                if itemInfo.info == metadata then
                    return exports['codem-inventory']:RemoveItem(src, item, count, itemInfo.slot)
                end
            end
        end
    end
    return exports['codem-inventory']:RemoveItem(src, item, count, nil)
end

---@param src number
---@param item string
---@param metadata table | nil
---@return table | nil
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

---@param src number
---@param item string
---@param metadata table
---@return number
function Core.Inventory.GetItemCount(src, item, metadata)
    local src = src or source
    if metadata == nil then
        return exports['codem-inventory']:GetItemsTotalAmount(src, item)
    else
        local items = exports['codem-inventory']:GetInventory(nil, src)
        for _, itemInfo in pairs(items) do
            if itemInfo.name == item then
                if itemInfo.info == metadata then
                    return itemInfo.amount
                end
            end
        end
    end
    return 0
end

---@param src number
---@return table
function Core.Inventory.GetInventoryItems(src)
    local src = src or source
    return exports['codem-inventory']:GetInventory(nil, src)
end

---@param src number
---@param item string
---@param count number
---@return boolean
function Core.Inventory.CanCarryItem(src, item, count)
    return true -- codem-inventory is another one that doesnt have a canCarry export.... do better.
end

---@param id number
---@param label string
---@param slots number
---@param weight number
---@param owner string
---@return boolean | number | nil
function Core.Inventory.RegisterStash(id, label, slots, weight, owner)
    -- could not find any exports in this for the docs... thank god I dont use it. May just remove stash shit.
end

---@param item string
---@return table | nil
function Core.Inventory.GetItemInfo(item)
    local items = exports['codem-inventory']:GetItemList()
    for _, itemInfo in pairs(items) do
        if itemInfo.name == item then
            itemInfo.stack = not itemInfo.unique
            return itemInfo
        end
    end
end

---@param src number
---@param item string
---@param slot number
---@param metadata table
function Core.Inventory.SetMetadata(src, item, slot, metadata)
    local src = src or source
    exports['codem-inventory']:SetItemMetadata(src, slot, metadata)
end