local function checkVersion()
    if not Cfg.VersionCheck then return end
    local url = 'https://api.github.com/repos/rumaier/r_bridge/releases/latest'
    local current = GetResourceMetadata(GetCurrentResourceName(), 'version', 0)
    PerformHttpRequest(url, function(err, text, headers)
        if err == 200 then
            local data = json.decode(text)
            local latest = data.tag_name
            if latest ~= current then
                print('[^3WARNING^0] Please update '.. GetCurrentResourceName() ..' to the latest version from Github')
                print('[^3WARNING^0] https://github.com/rumaier/r_bridge/releases/latest ^0')
            end
        end
    end, 'GET', '', { ['Content-Type'] = 'application/json' })
    SetTimeout(3600000, checkVersion)
end

AddEventHandler('onResourceStart', function(resource)
    if (GetCurrentResourceName() == resource) then
        print('------------------------------')
        print(resource .. ' | ' .. GetResourceMetadata(resource, 'version', 0))
        if not Core.Info.Framework then
            print('^1Framework not found^0')
        else
            print('Framework: ' .. Core.Info.Framework)
        end
        if not Core.Info.Inventory then
            print('^1Inventory not found^0')
        else
            print('Inventory: ' .. Core.Info.Inventory)
        end
        if not Core.Info.Target then
            print('^1Target not found^0')
        else
            print('Target: ' .. Core.Info.Target)
        end
        if Cfg.Carlock then
            print('Carlock: ' .. Cfg.Carlock)
        end
        print('------------------------------')
        checkVersion()
    end
end)