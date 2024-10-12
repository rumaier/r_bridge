if GetResourceState('origen_inventory') ~= 'started' then return end

Core.Info.Inventory = 'origen_inventory'
local ox_inventory = exports.ox_inventory

Core.Inventory = {}

---@param src number
---@param item string
---@param count number
---@param metadata table | nil
---@return boolean
function Core.Inventory.AddItem(src, item, count, metadata)
    -- TODO:
end

---@param src number
---@param item string
---@param count number
---@param metadata table | nil
---@return boolean | nil
function Core.Inventory.RemoveItem(src, item, count, metadata)
    -- TODO:
end

---@param src number
---@param item string
---@param metadata table | nil
---@return table | nil
function Core.Inventory.GetItem(src, item, metadata)
    -- TODO:
end

---@param src number
---@param item string
---@param metadata table | nil
---@return number
function Core.Inventory.GetItemCount(src, item, metadata)
    -- TODO:
end

---@param src number
---@return table
function Core.Inventory.GetInventoryItems(src)
    -- TODO:
end

---@param src number
---@param item string
---@param count number
---@return boolean
function Core.Inventory.CanCarryItem(src, item, count)
    -- TODO:
end

---@param id number
---@param label string
---@param slots number
---@param weight number
---@param owner string
---@return boolean | number | nil
function Core.Inventory.RegisterStash(id, label, slots, weight, owner)
    -- TODO:
end

---@param item string
---@return table | nil
function Core.Inventory.GetItemInfo(item)
    -- TODO:
end

---@param src number
---@param item string
---@param slot number
---@param metadata table
function Core.Inventory.SetMetadata(src, item, slot, metadata)
    -- TODO:
end