if GetResourceState('ox_inventory') ~= 'started' then return end

Core.Info.Inventory = 'ox_inventory'
local ox_inventory = exports.ox_inventory

Core.Inventory = {}

function Core.Inventory.ImgPath()
    return "nui://ox_inventory/web/images/%s.png"
end

function Core.Inventory.OpenStash(id)
    ox_inventory:openInventory('stash', id)
end

function Core.Inventory.GetItemInfo(item)
    return ox_inventory:Items(item)
end