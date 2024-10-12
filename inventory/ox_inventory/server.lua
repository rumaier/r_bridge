if GetResourceState('ox_inventory') ~= 'started' then return end

Core.Info.Inventory = 'ox_inventory'
local ox_inventory = exports.ox_inventory

Core.Inventory = {}

function Core.Inventory.AddItem(src, item, count, metadata)
    local src = src or source
    return ox_inventory:AddItem(src, item, count, metadata)
end

function Core.Inventory.RemoveItem(src, item, count, metadata)
    local src = src or source
    return ox_inventory:RemoveItem(src, item, count, metadata)
end

function Core.Inventory.GetItem(src, item, metadata)
    local src = src or source
    return ox_inventory:GetItem(src, item, metadata, false)
end

function Core.Inventory.GetItemCount(src, item, metadata)
    local src = src or source
    return ox_inventory:GetItemCount(src, item, metadata, false)
end

function Core.Inventory.GetInventoryItems(src)
    local src = src or source
    return ox_inventory:GetInventoryItems(src, false)
end

function Core.Inventory.CanCarryItem(src, item, count)
    local src = src or source
    return ox_inventory:CanCarryItem(src, item, count)
end

function Core.Inventory.RegisterStash(id, label, slots, weight, owner)
    return ox_inventory:RegisterStash(id, label, slots, weight, owner)
end

function Core.Inventory.GetItemInfo(item)
    return ox_inventory:Items(item)
end

function Core.Inventory.SetMetadata(src, item, slot, metadata)
    local src = src or source
    ox_inventory:SetMetadata(src, slot, metadata)
end