local portalUrl = 'https://portal.cfx.re/assets/granted-assets'
local githubUrl = 'https://github.com/rumaier/%s/releases/latest'

local function alert(resource, current, latest, url)
    print('^3-------------------------------------------------------------------------^0')
    print('[^3WARNING^0] Please update ' .. resource .. ' to its latest version.')
    print('[^3WARNING^0] Current: ^1' .. current .. '^0')
    print('[^3WARNING^0] Latest: ^2' .. latest .. '^0')
    print('[^3WARNING^0] Download: ^5' .. url .. '^0')
    print('^3-------------------------------------------------------------------------^0')
end

local function parse(version)
    return version:match('%d+%.%d+%.%d+')
end

local function getVersion(resource)
    local version = GetResourceMetadata(resource, 'version', 0)
    return parse(version)
end

local function check(resource)
    resource = resource or GetInvokingResource()
    local version = getVersion(resource)
    local url = 'https://raw.githubusercontent.com/rumaier/r_scripts_versions/main/versions.json'
    PerformHttpRequest(url, function(err, body)
        if err ~= 200 then return end
        body = json.decode(body)
        local data = body[resource]
        local latest = parse(data.latest)
        local url = not data.repo and portalUrl or githubUrl:format(resource)
        if version ~= latest then
            alert(resource, version, latest, url)
        end
    end)
end

exports('checkVersion', check)

AddEventHandler('onResourceStart', function(resource)
    local r_bridge = GetCurrentResourceName()
    if resource == r_bridge then
        check(r_bridge)
    end
end)
