---@diagnostic disable: duplicate-set-field
if GetResourceState('qb-target') ~= 'started' or GetResourceState('ox_target') == 'started' then return end

Core.Target = {}
Core.Target.Current = 'qb-target'

local QBTarget = exports['qb-target']

local function convertOxOptions(options)
    for k, v in pairs(options) do
        options[k].action = v.onSelect
        options[k].onSelect = nil
    end
    return options
end

Core.Target.addGlobalPedOptions = function(options)
    options = convertOxOptions(options)
    QBTarget:AddGlobalPed({ options = options, distance = options.distance or 1.5})
end

Core.Target.removeGlobalPedOptions = function(optionName)
    QBTarget:RemoveGlobalPed(optionName)
end

Core.Target.addGlobalPlayerOptions = function(options)
    options = convertOxOptions(options)
    QBTarget:AddGlobalPlayer({ options = options, distance = options.distance or 1.5})
end

Core.Target.removeGlobalPlayerOptions = function(optionName)
    QBTarget:RemoveGlobalPlayer(optionName)
end

Core.Target.addLocalEntity = function(entity, options)
    options = convertOxOptions(options)
    QBTarget:AddTargetEntity(entity, { options = options, distance = options.distance or 1.5 })
end

Core.Target.removeLocalEntity = function(entity)
    QBTarget:RemoveTargetEntity(entity)
end

Core.Target.addModel = function(models, options)
    options = convertOxOptions(options)
    QBTarget:AddTargetModel(models, { options = options, distance = options.distance or 1.5 })
end

Core.Target.removeModel = function(models)
    QBTarget:RemoveTargetModel(models)
end

local lastId = nil
Core.Target.addBoxZone = function(coords, size, heading, options, debug)
    print('[BRIDGE] - receiving request to add box zone at coords:', coords, 'with size:', size, 'and heading:', heading)
    options = convertOxOptions(options)
    print('[BRIDGE] - converted options for qb:', json.encode(options))
    local id = lastId and lastId + 1 or tostring(GetGameTimer())
    print('[BRIDGE] - generated zone id:', id)
    if id == lastId then 
        print('[BRIDGE] - duplicate id detected, incrementing id')
        id = tostring(tonumber(lastId) + 1)
    end
    print('[BRIDGE] - firing QBTarget export to add box zone with id:', id)
    QBTarget:AddBoxZone(id, coords, size.x, size.y, {
        name = id,
        debugPoly = debug,
        heading = heading,
        minZ = coords.z - (size.z * 0.5),
        maxZ = coords.z + (size.z * 0.5),
    }, {
        options = options,
        distance = options.distance or 1.5,
    })
    lastId = id
    print('[BRIDGE] -returning zone id:', id)
    return id
end

Core.Target.removeZone = function(id)
    QBTarget:RemoveZone(id)
end