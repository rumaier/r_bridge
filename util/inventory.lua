function NormalizeItem(item)
    item.count = item.amount or item.count
    item.metadata = item.info or item.metadata
    item.stack = (not item.unique) or item.stack
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