local second = 1000
local minute = second * 60
local hour = minute * 60

local function checkBridgeVersion()
    if Cfg.VersionCheck then
        Core.VersionCheck(GetCurrentResourceName())
        SetTimeout(1 * hour, checkBridgeVersion)
    end
end

function Core.VersionCheck(resource)
    local url = 'https://api.github.com/repos/r-scripts-versions/' .. resource .. '/releases/latest'
    local current = GetResourceMetadata(resource, 'version', 0)
    PerformHttpRequest(url, function(err, txt, head)
        if err == 200 then
            local data = json.decode(txt)
            local latest = data.tag_name
            if latest ~= current then
                print('[^3WARNING^0] Please update ' .. resource .. ' to its latest version.')
                print('[^3WARNING^0] Current: ' .. current .. '')
                print('[^3WARNING^0] Latest: ' .. latest .. '')
                print('[^3WARNING^0] https://discord.gg/rscripts')
            end
        end
    end)
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
        checkBridgeVersion()
    end
end)