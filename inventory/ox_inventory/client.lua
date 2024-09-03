if GetResourceState('ox_inventory') ~= 'started' then return end

local ox_inventory = exports.ox_inventory

Core.Inventory = {}

function Core.Inventory.OpenStash(id)
    ox_inventory:openInventory('stash', id)
end

function Core.Inventory.GetItemInfo(item)
    return ox_inventory:Items(item)
end