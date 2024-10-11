if GetResourceState('tgiann-inventory') ~= 'started' then return end

Core.Info.Inventory = 'tgiann-inventory'

Core.Inventory = {}

---@param src number
---@param item string
---@param count number
---@param metadata table
---@return boolean
function Core.Inventory.AddItem(src, item, count, metadata)
    local src = src or source
    local action = exports['tgiann-inventory']:AddItem(src, item, count, metadata)
    return (action.itemAddRemoveLog == 'added')
end

---@param src number
---@param item string
---@param count number
---@param metadata table
---@return boolean
function Core.Inventory.RemoveItem(src, item, count, metadata)
    local src = src or source
    local action = exports['tgiann-inventory']:RemoveItem(src, item, count, nil, metadata)
    return action
end 

---@param src number
---@param item string
---@param metadata table
---@return table | nil
function Core.Inventory.GetItem(src, item, metadata)
    local src = src or source
    local item = exports['tgiann-inventory']:GetItemByName(src, item, metadata)
    item.count = item.amount
    item.metadata = item.info
    return item
end

---@param src number
---@param item string
---@param metadata table
---@return number
function Core.Inventory.GetItemCount(src, item, metadata)
    local src = src or source
    local item = exports['tgiann-inventory']:GetItemByName(src, item, metadata)
    return item.amount or 0
end

---@param src number
---@return table
function Core.Inventory.GetInventoryItems(src)
    local src = src or source
    return exports['tgiann-inventory']:GetPlayerItems(src)
end

---@param src number
---@param item string
---@param count number
---@return boolean
function Core.Inventory.CanCarryItem(src, item, count)
    local src = src or source
    return exports["tgiann-inventory"]:CanCarryItem(src, item, count)
end

---@param id number
---@param label string
---@param slots number
---@param weight number
---@param owner string
---@return boolean | number | nil
function Core.Inventory.RegisterStash(id, label, slots, weight, owner)
    exports["tgiann-inventory"]:CreateCustomStashWithItem(id, {})
end

---@param item string
---@return table | nil
function Core.Inventory.GetItemInfo(item)
    local itemsList = exports['tgiann-inventory']:GetItemList()
    for _, itemData in pairs(itemsList) do
        if itemData.name == item then
            return itemData
        end
    end
end

---@param src number
---@param item string
---@param slot number
---@param metadata table
function Core.Inventory.SetMetadata(src, item, slot, metadata)
    local src = src or source
    exports["tgiann-inventory"]:UpdateItemMetadata(src, item, slot, metadata)
end