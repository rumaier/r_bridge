if GetResourceState('qs-inventory') ~= 'started' then return end

Core.Info.Inventory = 'qs-inventory'

Core.Inventory = {}

function Core.Inventory.ImgPath()
    return "nui://qs-inventory/html/images/%s.png"
end

function Core.Inventory.OpenStash(id)
    exports['qs-inventory']:RegisterStash(id, 50, 50000)
end

function Core.Inventory.GetItemInfo(item)
    local itemsLua = exports['qs-inventory']:GetItemList()
    if not itemsLua[item] then return end
    return itemsLua[item]
end
