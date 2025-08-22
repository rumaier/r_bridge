function NormalizeItem(item)
    item.count = item.amount
    item.metadata = item.info
    item.stack = not item.unique
    item.amount = nil
    item.info = nil
    item.unique = nil
    return item
end

function NormalizeInventory(data)
    for _, v in pairs(data) do
        v = NormalizeItem(v)
    end
    return data
end