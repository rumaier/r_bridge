exports('getFrameworkObject', function()
    return Framework
end)

exports('getInventoryObject', function()
    return Inventory
end)

exports('getTargetObject', function()
    return Target
end)

exports('getNativesObject', function()
    return Natives
end)

AddEventHandler('onResourceStart', function(resource)
    local r_bridge = GetCurrentResourceName()
    if resource ~= r_bridge then return end
    print('-------------------------------')
    local version = GetResourceMetadata(r_bridge, 'version', 0)
    local framework = Framework.getDetected()
    local inventory = Inventory.getDetected()
    local target = Target.getDetected()
    print(r_bridge .. ' | ' .. version)
    print('Framework: ' .. (framework or '^1Not Found^0'))
    print('Inventory: ' .. (inventory or '^1Not Found^0'))
    print('Target: ' .. (target or '^1Not Found^0'))
    print('-------------------------------')
end)