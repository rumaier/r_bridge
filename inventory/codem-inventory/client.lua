---@diagnostic disable: duplicate-set-field
if GetResourceState('codem-inventory') ~= 'started' then return end

Core.Inventory = {}
Core.Inventory.Current = 'codem-inventory'
Core.Inventory.IconPath = 'nui://codem-inventory/html/images/%s.png'

local CodeMInventory = exports['codem-inventory']

Core.Inventory.getItemInfo = function(item)
    local items = CodeMInventory:GetItemList()
    for _, info in pairs(items) do
        if info.name == item then
            return info
        end
    end
end