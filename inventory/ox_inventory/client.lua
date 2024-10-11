if GetResourceState('ox_inventory') ~= 'started' then return end

Core.Info.Inventory = 'ox_inventory'
local ox_inventory = exports.ox_inventory

Core.Inventory = {}

---@param id number
function Core.Inventory.OpenStash(id)
    ox_inventory:openInventory('stash', id)
end

---@param item string
function Core.Inventory.GetItemInfo(item)
    return ox_inventory:Items(item)
end