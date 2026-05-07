function NormalizeItem(item)
    item.count = item.amount or item.count
    item.metadata = item.info or item.metadata
    item.stack = not item.unique or item.stack
    return item
end

function NormalizeInventory(data)
    for _, item in pairs(data) do
        NormalizeItem(item)
    end
    return data
end