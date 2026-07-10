---@diagnostic disable: undefined-global

--[[
    Import API inspired by ox_lib
    https://github.com/overextended/ox_lib

    Copyright © Linden <https://github.com/thelindat>
]]

local bridgeName = 'r_bridge'
local context = IsDuplicityVersion() and 'server' or 'client'

local providers = {
    framework = { 'qbx_core', 'qb-core', 'es_extended' },
    inventory = { 'ox_inventory', 'qb-inventory', 'codem-inventory', 'origen_inventory', 'tgiann-inventory' },
    target = { 'ox_target', 'qb-target' },
}

local function detectProvider(namespace)
    for _, resource in ipairs(providers[namespace]) do
        if GetResourceState(resource) == 'started' then
            return resource
        end
    end

    error(('no supported %s resource is running'):format(namespace))
end

local function loadModule(namespace)
    local dir = providers[namespace]
        and ('imports/%s/%s'):format(namespace, detectProvider(namespace))
        or ('imports/%s'):format(namespace)

    local chunk = LoadResourceFile(bridgeName, ('%s/%s.lua'):format(dir, context))
    if not chunk then
        error(('module %s is not available on the %s'):format(namespace, context))
    end

    local util = LoadResourceFile(bridgeName, ('imports/%s/util.lua'):format(namespace))
    if util then
        chunk = util .. '\n' .. chunk
    end

    local fn, err = load(chunk, ('@@%s/%s/%s.lua'):format(bridgeName, namespace, context))
    if not fn then
        error(err)
    end

    return fn()
end

bridge = setmetatable({}, {
    __index = function(self, namespace)
        local module = loadModule(namespace)
        rawset(self, namespace, module)
        return module
    end
})

if GetCurrentResourceName() == bridgeName then
    if context == 'server' then
        AddEventHandler('onResourceStart', function(resource)
            if resource ~= bridgeName then return end

            local function detected(namespace)
                for _, name in ipairs(providers[namespace]) do
                    if GetResourceState(name) == 'started' then
                        return name
                    end
                end
            end

            print('-------------------------------')
            print(('%s | %s'):format(bridgeName, GetResourceMetadata(bridgeName, 'version', 0)))
            print('Framework: ' .. (detected('framework') or '^1Not Found^0'))
            print('Inventory: ' .. (detected('inventory') or '^1Not Found^0'))
            print('Target: ' .. (detected('target') or '^1Not Found^0'))
            print('-------------------------------')
        end)

        local function checkOwnVersion()
            bridge.version.check(bridgeName)
            SetTimeout(3600000, checkOwnVersion)
        end

        AddEventHandler('onResourceStart', function(resource)
            if resource == bridgeName then
                checkOwnVersion()
            end
        end)
    else
        local _ = bridge.framework
        RegisterNetEvent('r_bridge:notify', function(...)
            bridge.interface.notify(...)
        end)
    end
end
