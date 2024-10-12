if GetResourceState('qs-inventory') ~= 'started' then return end

Core.Info.Inventory = 'qs-inventory'

Core.Inventory = {}

---@param src number
---@param item string
---@param count number
---@param metadata table | nil
---@return boolean
function Core.Inventory.AddItem(src, item, count, metadata)
    local src = src or source
    return exports['qs-inventory']:AddItem(src, item, count, nil, metadata)
end

---@param src number
---@param item string
---@param count number
---@param metadata table | nil
---@return boolean | nil
function Core.Inventory.RemoveItem(src, item, count, metadata)
    local src = src or source
    if metadata ~= nil then
        local playerInv = exports['qs-inventory']:GetInventory(src)
        if not playerInv then return end
        for _, item in pairs(playerInv) do
            if lib.table.matches(item.info, metadata) then
                return exports['qs-inventory']:RemoveItem(src, item.name, count, item.slot)
            end
        end
    end
    return exports['qs-inventory']:RemoveItem(src, item, count, nil)
end

---@param src number
---@param item string
---@param metadata table | nil
---@return table | nil
function Core.Inventory.GetItem(src, item, metadata)
    local src = src or source
    local playerItems = exports['qs-inventory']:GetInventory(src)
    for _, itemInfo in pairs(playerItems) do
        if itemInfo.name == item then
            itemInfo.count = itemInfo.amount
            itemInfo.metadata = itemInfo.info
            itemInfo.stack = not itemInfo.unique
            return itemInfo
        end
    end
end

---@param src number
---@param item string
---@param metadata table | nil
---@return number
function Core.Inventory.GetItemCount(src, item, metadata)
    local src = src or source
    return exports['qs-inventory']:GetItemTotalAmount(src, item)
end

---@param src number
---@return table
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

---@param src number
---@param item string
---@param count number
---@return boolean
function Core.Inventory.CanCarryItem(src, item, count)
    local src = src or source
    return exports['qs-inventory']:CanCarryItem(src, item, count)
end

---@param id number
---@param label string
---@param slots number
---@param weight number
---@param owner string
---@return boolean | number | nil
function Core.Inventory.RegisterStash(id, label, slots, weight, owner)
    -- qs-inventory handles all the stash stuff client side, so we don't need to do anything here
end

---@param item string
---@return table | nil
function Core.Inventory.GetItemInfo(item)
    local itemInfo = exports['qs-inventory']:GetItemList()[item]
    if not itemInfo then return end
    itemInfo.count = itemInfo.amount
    itemInfo.metadata = itemInfo.info
    itemInfo.stack = not itemInfo.unique
    return itemInfo
end

---@param src number
---@param item string
---@param slot number
---@param metadata table
function Core.Inventory.SetMetadata(src, item, slot, metadata)
    local src = src or source
    exports['qs-inventory']:SetItemMetadata(src, slot, metadata)
end
