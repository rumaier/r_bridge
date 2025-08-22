---@diagnostic disable: duplicate-set-field
if GetResourceState('qb-inventory') ~= 'started' then return end

Core.Inventory = {}
Core.Inventory.Current = 'qb-inventory'

local QBCore = exports['qb-core']:GetCoreObject()
local QBInventory = exports['qb-inventory']

Core.Inventory.addItem = function(src, item, count, metadata)
    local success = QBInventory:AddItem(src, item, count, nil, metadata)
    if not success then return false end
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], 'add', count)
    return true
end

local function removeMetadataItem(src, item, count, metadata)
    local playerInventory = Core.Inventory.getPlayerInventory(src)
    if not playerInventory then return false end
    for _, i in pairs(playerInventory) do
        if i.name == item and lib.table.matches(i.metadata, metadata) then
            local success = QBInventory:RemoveItem(src, item, count, i.slot)
            if not success then return false end
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], 'remove', count)
            return true
        end
    end
end

Core.Inventory.removeItem = function(src, item, count, metadata)
    if metadata then return removeMetadataItem(src, item, count, metadata) end
    local success = QBInventory:RemoveItem(src, item, count)
    if not success then return false end
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], 'remove', count)
    return true
end

Core.Inventory.setItemMetadata = function(src, item, slot, metadata)
    local removed = QBInventory:RemoveItem(src, item, 1, nil, metadata)
    if not removed then return end
    QBInventory:AddItem(src, item, 1, nil, metadata)
end

Core.Inventory.getItem = function(src, item, metadata)
    local playerInventory = Core.Inventory.getPlayerInventory(src)
    if not playerInventory then return end
    for _, v in pairs(playerInventory) do
        if v.name == item and (not metadata or lib.table.matches(v.metadata, metadata)) then
            return NormalizeItem(v)
        end
    end
end

Core.Inventory.getItemCount = function(src, item)
    local count = QBInventory:GetItemCount(src, item)
    return count
end

Core.Inventory.getPlayerInventory = function(src)
    local player = QBCore.Functions.GetPlayer(src)
    if not player then return end
    local inventory = player.PlayerData.items
    inventory = NormalizeInventory(inventory)
    return inventory
end

Core.Inventory.canCarryItem = function(src, item, count)
    local canCarry = QBInventory:CanAddItem(src, item, count)
    return canCarry
end

Core.Inventory.getItemInfo = function(item)
    local info = QBCore.Shared.Items[item]
    return info
end