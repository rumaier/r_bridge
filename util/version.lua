-- https://mrnewbscripts.tebex.io/ 🙏

local function parseVersion(version)
    return version and version:match('%d+%.%d+%.%d+') or version
end

local function getResourceVersion(resource)
    local version = GetResourceMetadata(resource, 'version', 0)
    return parseVersion(version)
end

local portalUrl = 'https://portal.cfx.re/assets/granted-assets'
local githubUrl = 'https://github.com/rumaier/%s/releases/latest'

local function throwUpdatePrints(resource, current, latest, notes, paid)
    print('[^3WARNING^0]: Please update ' .. resource .. ' to its latest version.')
    print('[^3WARNING^0]: Current: ^1' .. current .. '^0')
    print('[^3WARNING^0]: Latest: ^2' .. latest .. '^0')
    print('[^3WARNING^0]: Patch Notes:')
    for _, text in ipairs(notes) do
        print('[^3WARNING^0]: ' .. text)
    end
    print('[^3WARNING^0]: Download: ^5' .. (paid and portalUrl or (githubUrl):format(resource)) .. '^0')
end

Core.VersionCheck = function(resource)
    local url = ('https://raw.githubusercontent.com/rumaier/r_scripts_versions/main/versions.json')
    local version = getResourceVersion(resource)
    PerformHttpRequest(url, function(err, body)
        if err == 200 then
            local data = json.decode(body)
            if data then data = data[resource] end
            if not data then return end
            local paid = not data.repo
            local latest = parseVersion(data.latest)
            local notes = data.notes or {}
            if version ~= latest then
                throwUpdatePrints(resource, version, latest, notes, paid)
            end
        end
    end)
end

AddEventHandler('onResourceStart', function(resource)
    if resource ~= GetCurrentResourceName() then return end
    Core.VersionCheck(resource)
end)
