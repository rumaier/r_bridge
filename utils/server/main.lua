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

AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() == resourceName) then
        print('------------------------------')
        print(resourceName .. ' | ' .. GetResourceMetadata(resourceName, 'version', 0))
        print('Framework: ' .. Core.Info.Framework)
        print('Inventory: ' .. Core.Info.Inventory)
        print('Target: ' .. Core.Info.Target)
        print('------------------------------')
        checkVersion()
    end
end)