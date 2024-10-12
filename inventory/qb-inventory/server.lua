if GetResourceState('qb-inventory') ~= 'started' then return end

Core.Info.Inventory = 'qb-inventory'
local QBCore = exports['qb-core']:GetCoreObject()

Core.Inventory = {}

---@param src number
---@param item string
---@param count number
---@param metadata table | nil
---@return boolean
function Core.Inventory.AddItem(src, item, count, metadata)
    local src = src or source
    local added = exports['qb-inventory']:AddItem(src, item, count, nil, metadata)
    if not added then return added end
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], 'add', count)
    return added
end

---@param src number
---@param item string
---@param count number
---@param metadata table | nil
---@return boolean | nil
function Core.Inventory.RemoveItem(src, item, count, metadata)
    local src = src or source
    if metadata ~= nil then
        local playerInv = QBCore.Functions.GetPlayer(src).PlayerData.items
        if not playerInv then return end
        for _, item in pairs(playerInv) do
            if lib.table.matches(item.info, metadata) then
                local removed = exports['qb-inventory']:RemoveItem(src, item.name, count, item.slot)
                if not removed then return removed end
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item.name], 'remove', count)
                return removed
            end
        end
    end
    local removed = exports['qb-inventory']:RemoveItem(src, item, count, nil)
    if not removed then return removed end
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], 'remove', count)
    return removed
end

---@param src number
---@param item string
---@param metadata table | nil
---@return table | nil
function Core.Inventory.GetItem(src, item, metadata)
    local src = src or source
    local playerItems = QBCore.Functions.GetPlayer(src).PlayerData.items
    if not playerItems then return end
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
    local totalItems = exports['qb-inventory']:GetItemsByName(src, item)
    return totalItems[1].amount or 0
end

---@param src number
---@return table
function Core.Inventory.GetInventoryItems(src)
    local src = src or source
    local playerItems = QBCore.Functions.GetPlayer(src).PlayerData.items
    if not playerItems then return end
    for _, item in pairs(playerItems) do
        item.count = item.amount
        item.metadata = item.info  
        item.stack = item.unique
    end
    return playerItems
end

---@param src number
---@param item string
---@param count number
---@return boolean
function Core.Inventory.CanCarryItem(src, item, count)
    return true -- this framework is garbage, doesn't have a check in v1 inv, so we just return true
end

---@param id number
---@param label string
---@param slots number
---@param weight number
---@param owner string
---@return boolean | number | nil
function Core.Inventory.RegisterStash(id, label, slots, weight, owner)
    -- v1 handles client, idk about v2.. so we just leave this alone
end

---@param item string
---@return table | nil
function Core.Inventory.GetItemInfo(item)
    local itemInfo = QBCore.Shared.Items[item]
    itemInfo.count = item.amount
    itemInfo.metadata = item.info
    itemInfo.stack = item.unique
    return itemInfo
end

---@param src number
---@param item string
---@param slot number
---@param metadata table
function Core.Inventory.SetMetadata(src, item, slot, metadata)
    local src = src or source
    local removed = exports['qb-inventory']:RemoveItem(src, item, 1, slot)
    if not removed then return end
    exports['qb-inventory']:AddItem(src, item, 1, nil, metadata)
end
