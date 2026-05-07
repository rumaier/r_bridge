---@diagnostic disable: duplicate-set-field
if GetResourceState('ox_target') ~= 'started' then return end
local OX = exports.ox_target

Target = {}

Target.getDetected = function()
    return 'ox_target'
end

Target.addGlobalPedOptions = function(options)
    OX:addGlobalPed(options)
end

Target.removeGlobalPedOption = function(name)
    OX:removeGlobalPed(name)
end

Target.addGlobalPlayerOptions = function(options)
    OX:addGlobalPlayer(options)
end

Target.removeGlobalPlayerOption = function(name)
    OX:removeGlobalPlayer(name)
end

Target.addLocalEntity = function(entity, options)
    OX:addLocalEntity(entity, options)
end

Target.removeLocalEntity = function(entity)
    OX:removeLocalEntity(entity)
end

Target.addModel = function(model, options)
    OX:addModel(model, options)
end

Target.removeModel = function(model)
    OX:removeModel(model)
end

Target.addZone = function(coords, radius, options, debug)
    return OX:addSphereZone({
        coords = coords,
        radius = radius,
        options = options,
        debug = debug
    })
end

Target.removeZone = function(id)
    OX:removeZone(id)
end