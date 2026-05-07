---@diagnostic disable: duplicate-set-field
if GetResourceState('codem-inventory') ~= 'started' then return end
local CODEM = exports['codem-inventory']

Inventory = {}

Inventory.getDetected = function()
    return 'codem-inventory'
end

Inventory.getIconPath = function()
    return 'nui://codem-inventory/html/images/%s.png'
end

Inventory.getItemInfo = function(item)
    local items = CODEM:GetItemList()
    for _, i in pairs(items) do
        if i.name == item then
            return i
        end
    end
end