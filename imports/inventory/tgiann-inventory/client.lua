---@diagnostic disable: duplicate-set-field, undefined-global
local TGIANN = exports['tgiann-inventory']

local Inventory = {}

Inventory.getDetected = function()
    return 'tgiann-inventory'
end

Inventory.getIconPath = function()
    return 'nui://inventory_images/html/images/%s.webp'
end

Inventory.getItemInfo = function(item)
    local items = TGIANN:GetItemList()
    for _, i in pairs(items) do
        if i.name == item then
            return i
        end
    end
end

return Inventory
