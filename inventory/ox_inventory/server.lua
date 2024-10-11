if GetResourceState('ox_inventory') ~= 'started' then return end

Core.Info.Inventory = 'ox_inventory'
local ox_inventory = exports.ox_inventory

Core.Inventory = {}

---@param src number
---@param item string
---@param count number
---@param metadata table
---@return boolean
function Core.Inventory.AddItem(src, item, count, metadata)
    local src = src or source
    return ox_inventory:AddItem(src, item, count, metadata)
end

---@param src number
---@param item string
---@param count number
---@param metadata table
---@return boolean
function Core.Inventory.RemoveItem(src, item, count, metadata)
    local src = src or source
    return ox_inventory:RemoveItem(src, item, count, metadata)
end

---@param src number
---@param item string
---@param metadata table
---@return table | nil
function Core.Inventory.GetItem(src, item, metadata)
    local src = src or source
    return ox_inventory:GetItem(src, item, metadata, false)
end

---@param src number
---@param item string
---@param metadata table
---@return number
function Core.Inventory.GetItemCount(src, item, metadata)
    local src = src or source
    return ox_inventory:GetItemCount(src, item, metadata, false)
end

---@param src number
---@return table
function Core.Inventory.GetInventoryItems(src)
    local src = src or source
    return ox_inventory:GetInventoryItems(src, false)
end

---@param src number
---@param item string
---@param count number
---@return boolean
function Core.Inventory.CanCarryItem(src, item, count)
    local src = src or source
    return ox_inventory:CanCarryItem(src, item, count)
end

---@param id number
---@param label string
---@param slots number
---@param weight number
---@param owner string
---@return boolean | number | nil
function Core.Inventory.RegisterStash(id, label, slots, weight, owner)
    return ox_inventory:RegisterStash(id, label, slots, weight, owner)
end

---@param item string
---@return table | nil
function Core.Inventory.GetItemInfo(item)
    return ox_inventory:Items(item)
end

---@param src number
---@param item string
---@param slot number
---@param metadata table
function Core.Inventory.SetMetadata(src, item, slot, metadata)
    local src = src or source
    ox_inventory:SetMetadata(src, slot, metadata)
end