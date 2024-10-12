if GetResourceState('origen_inventory') ~= 'started' then return end

Core.Info.Inventory = 'origen_inventory'


Core.Inventory = {}

---@param id number
function Core.Inventory.OpenStash(id)
    -- TODO:
end

---@param item string
function Core.Inventory.GetItemInfo(item)
    -- TODO:
end