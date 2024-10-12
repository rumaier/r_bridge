if GetResourceState('codem-inventory') ~= 'started' then return end

Core.Info.Inventory = 'codem-inventory'

Core.Inventory = {}

---@param id number
function Core.Inventory.OpenStash(id)
    -- does not exist in codem-inventory
end

---@param item string
function Core.Inventory.GetItemInfo(item)
    local items = exports['codem-inventory']:GetItemList()
    for _, itemInfo in pairs(items) do
        if itemInfo.name == item then
            itemInfo.stack = not itemInfo.unique
            return itemInfo
        end
    end
end