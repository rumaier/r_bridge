---@diagnostic disable: duplicate-set-field
if GetResourceState('codem-inventory') ~= 'started' then return end

Core.Inventory = {}
Core.Inventory.Current = 'codem-inventory'

local CodeMInventory = exports['codem-inventory']

Core.Inventory.addItem = function(src, item, count, metadata)
    local success = CodeMInventory:AddItem(src, item, count, nil, metadata)
    return success
end

local function removeMetadataItem(src, item, count, metadata)
    local inventory = Core.Inventory.getPlayerInventory(src)
    if not inventory then return false end
    for _, i in pairs(inventory) do
        if i.name == item and lib.table.matches(i.info, metadata) then
            local success = CodeMInventory:RemoveItem(src, item, count, i.slot)
            if not success then return false end
            return true
        end
    end
end

Core.Inventory.removeItem = function(src, item, count, metadata, slot)
    if metadata then return removeMetadataItem(src, item, count, metadata) end
    local success = CodeMInventory:RemoveItem(src, item, count, slot)
    return success
end

Core.Inventory.setItemMetadata = function(src, item, slot, metadata)
    CodeMInventory:SetItemMetadata(src, slot, metadata)
end

Core.Inventory.getItem = function(src, item, metadata)
    local inventory = Core.Inventory.getPlayerInventory(src)
    if not inventory then return end
    for _, v in pairs(inventory) do
        if v.name == item and (not metadata or lib.table.matches(v.info, metadata)) then
            return NormalizeItem(v)
        end
    end
end

Core.Inventory.getItemCount = function(src, item)
    local count = CodeMInventory:GetItemsTotalAmount(src, item)
    return count
end

Core.Inventory.getPlayerInventory = function(src)
    local identifier = Core.Framework.getPlayerIdentifier(src)
    local inventory = CodeMInventory:GetInventory(identifier, src)
    inventory = NormalizeInventory(inventory)
    return inventory
end

Core.Inventory.canCarryItem = function(src, item, count)
    return true
end

Core.Inventory.getItemInfo = function(item)
    local items = CodeMInventory:GetItemList()
    for _, info in pairs(items) do
        if info.name == item then
            return info
        end
    end
end