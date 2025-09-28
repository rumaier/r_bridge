Core = {}

exports('returnCoreObject', function()
    return Core
end)

AddEventHandler('onResourceStart', function(resource)
    if (GetCurrentResourceName() == resource) then
        print('------------------------------')
        print(resource .. ' | ' .. GetResourceMetadata(resource, 'version', 0))
        if not Core.Framework.Current then
            print('^1Framework not found^0')
        else
            print('Framework: ' .. Core.Framework.Current)
        end
        if not Core.Inventory.Current then
            print('^1Inventory not found^0')
        else
            print('Inventory: ' .. Core.Inventory.Current)
        end
        if not Core.Target.Current then
            print('^1Target not found^0')
        else
            print('Target: ' .. Core.Target.Current)
        end
        print('------------------------------')
    end
end)
