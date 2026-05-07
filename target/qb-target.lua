---@diagnostic disable: duplicate-set-field
if GetResourceState('qb-target') ~= 'started' then return end
if GetResourceState('ox_target') == 'started' then return end

local QB = exports['qb-target']
local lastZoneId = 0

local function assignZoneId()
    lastZoneId = lastZoneId > 0 and lastZoneId + 1 or GetGameTimer()
    return 'r_bridge:' .. lastZoneId
end

local function convert(options)
    for k, v in pairs(options) do
        options[k].action = v.onSelect
    end
    return options
end

Target = {}

Target.getDetected = function()
    return 'qb-target'
end

Target.addGlobalPedOptions = function(options)
    QB:AddGlobalPed({
        options = convert(options),
        distance = options.distance or 2.0,
    })
end

Target.removeGlobalPedOption = function(name)
    QB:RemoveGlobalPed(name)
end

Target.addGlobalPlayerOptions = function(options)
    QB:AddGlobalPlayer({
        options = convert(options),
        distance = options.distance or 2.0,
    })
end

Target.removeGlobalPlayerOption = function(name)
    QB:RemoveGlobalPlayer(name)
end

Target.addLocalEntity = function(entity, options)
    QB:AddTargetEntity(entity, {
        options = convert(options),
        distance = options.distance or 2.0,
    })
end

Target.removeLocalEntity = function(entity)
    QB:RemoveTargetEntity(entity)
end

Target.addModel = function(model, options)
    QB:AddTargetModel(model, {
        options = convert(options),
        distance = options.distance or 2.0,
    })
end

Target.removeModel = function(model)
    QB:RemoveTargetModel(model)
end

Target.addZone = function(coords, radius, options, debug)
    local id = assignZoneId()
    QB:AddCircleZone(id, coords, radius, {
        name = id,
        debugPoly = debug,
        useZ = true
    }, {
        options = convert(options),
        distance = options.distance or 2.0,
    })
    return id
end

Target.removeZone = function(id)
    QB:RemoveZone(id)
end