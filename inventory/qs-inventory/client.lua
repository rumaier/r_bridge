if GetResourceState('qs-inventory') ~= 'started' then return end

Core.Info.Inventory = 'qs-inventory'

Core.Inventory = {}

---@param id number
function Core.Inventory.OpenStash(id)
    exports['qs-inventory']:RegisterStash(id, 50, 50000)
end


---@param item string
function Core.Inventory.GetItemInfo(item)
    local itemsLua = exports['qs-inventory']:GetItemList()
    if not itemsLua[item] then return end
    return itemsLua[item]
end
