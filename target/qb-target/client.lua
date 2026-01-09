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
    options = convertOxOptions(options)
    local id = lastId and lastId + 1 or GetGameTimer()
    if id == lastId then id = id + 1 end
    local prefix = 'r_bridge:target:'
    QBTarget:AddBoxZone(prefix .. id, coords, size.x, size.y, {
        name = prefix .. id,
        debugPoly = debug,
        heading = heading,
        minZ = coords.z - (size.z * 0.5),
        maxZ = coords.z + (size.z * 0.5),
    }, {
        options = options,
        distance = options.distance or 1.5,
    })
    lastId = id
    return id
end

Core.Target.removeZone = function(id)
    QBTarget:RemoveZone(id)
end