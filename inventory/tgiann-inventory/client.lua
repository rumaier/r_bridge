if GetResourceState('tgiann-inventory') ~= 'started' then return end

Core.Info.Inventory = 'tgiann-inventory'

Core.Inventory = {}

function Core.Inventory.ImgPath()
    return "nui://inventory_images/html/images/%s.webp"
end

function Core.Inventory.OpenStash(id)
    -- open stash export... not sure what it is yet. 
end

function Core.Inventory.GetItemInfo(item)
    local itemsList = exports['tgiann-inventory']:GetItemList()
    for _, itemData in pairs(itemsList) do
        if itemData.name == item then
            return itemData
        end
    end
end