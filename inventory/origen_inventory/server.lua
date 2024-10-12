if GetResourceState('origen_inventory') ~= 'started' then return end

Core.Info.Inventory = 'origen_inventory'
local origen_inventory = exports.origen_inventory

Core.Inventory = {}

---@param src number
---@param item string
---@param count number
---@param metadata table | nil
---@return boolean
function Core.Inventory.AddItem(src, item, count, metadata)
    local src = src or source
    return origen_inventory:AddItem(src, item, count, nil, nil, metadata)
end

---@param src number
---@param item string
---@param count number
---@param metadata table | nil
---@return boolean | nil
function Core.Inventory.RemoveItem(src, item, count, metadata)
    local src = src or source
    return origen_inventory:RemoveItem(src, item, count, metadata)
end

---@param src number
---@param item string
---@param metadata table | nil
---@return table | nil
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

---@param src number
---@param item string
---@param metadata table | nil
---@return number
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

---@param src number
---@return table
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

---@param src number
---@param item string
---@param count number
---@return boolean
function Core.Inventory.CanCarryItem(src, item, count)
    local src = src or source
    return origen_inventory:CanCarryItems(src, item, count)
end

---@param id number
---@param label string
---@param slots number
---@param weight number
---@param owner string
---@return boolean | number | nil
function Core.Inventory.RegisterStash(id, label, slots, weight, owner)
    -- I dont use stash systems, I am probably just gonna end up removing the functions for it.
end

---@param item string
---@return table | nil
function Core.Inventory.GetItemInfo(item)
    local items = origen_inventory:GetItems()
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
    origen_inventory:SetItemMetadata(src, item, slot, metadata)
end