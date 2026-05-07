---@diagnostic disable: duplicate-set-field
if GetResourceState('qb-inventory') ~= 'started' then return end
local QB = exports['qb-core']:GetCoreObject()
local INV = exports['qb-inventory']

Inventory = {}

Inventory.getDetected = function()
    return 'qb-inventory'
end

Inventory.addItem = function(src, item, count, metadata)
    local success = INV:AddItem(src, item, count, nil, metadata)
    if success then
        TriggerClientEvent('inventory:client:ItemBox', src, QB.Shared.Items[item], 'add', count)
    end
    return success
end

local function metadataRemove(src, item, count, metadata)
    local inventory = Inventory.getInventory(src) or {}
    for _, i in pairs(inventory) do
        if i.name == item and lib.table.matches(i.metadata, metadata) then
            return Inventory.removeItem(src, item, count, nil, i.slot)
        end
    end
    return false
end

Inventory.removeItem = function(src, item, count, metadata, slot)
    if not metadata then
        local success = INV:RemoveItem(src, item, count, slot)
        if success then
            TriggerClientEvent('inventory:client:ItemBox', src, QB.Shared.Items[item], 'remove', count)
        end
        return success
    else
        return metadataRemove(src, item, count, metadata)
    end
end

Inventory.getItem = function(src, item, metadata)
    local items = Inventory.getInventory(src) or {}
    for _, i in pairs(items) do
        if i.name == item and (not metadata or lib.table.matches(i.metadata, metadata)) then
            return NormalizeItem(i)
        end
    end
end

Inventory.getItemCount = function(src, item)
    return INV:GetItemCount(src, item)
end

Inventory.getInventory = function(src)
    local player = QB.Functions.GetPlayer(src)
    return player and NormalizeInventory(player.PlayerData.items)
end

Inventory.canCarry = function(src, item, count)
    return INV:CanAddItem(src, item, count)
end

Inventory.setItemMetadata = function(src, item, slot, metadata)
    item = INV:GetItemBySlot(src, slot)
    if metadataRemove(src, item.name, 1, item.metadata) then
        return Inventory.addItem(src, item.name, 1, metadata)
    end
end

Inventory.getItemInfo = function(item)
    return QB.Shared.Items[item]
end