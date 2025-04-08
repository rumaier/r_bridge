if GetResourceState('origen_inventory') ~= 'started' then return end

Core.Info.Inventory = 'origen_inventory'
local origen_inventory = exports.origen_inventory

Core.Inventory = {}

function Core.Inventory.ImgPath()
    return "nui://origen_inventory/html/images/%s.png"
end

---@param id number
function Core.Inventory.OpenStash(id)
    -- cant find anything for this in the origen_inventory documentation... PR if you know something I dont. 
end

---@param item string
function Core.Inventory.GetItemInfo(item)
    local items = origen_inventory:GetItems()
    for _, itemInfo in pairs(items) do
        if itemInfo.name == item then
            itemInfo.stack = not itemInfo.unique
            return itemInfo
        end
    end
end