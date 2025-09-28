---@diagnostic disable: duplicate-set-field
if GetResourceState('ox_target') ~= 'started' then return end

Core.Target = {}
Core.Target.Current = 'ox_target'

local ox_target = exports.ox_target

Core.Target.addGlobalPedOptions = function(options)
    ox_target:addGlobalPed(options)
end

Core.Target.removeGlobalPedOptions = function(optionName)
    ox_target:removeGlobalPed(optionName)
end

Core.Target.addGlobalPlayerOptions = function(options)
    ox_target:addGlobalPlayer(options)
end

Core.Target.removeGlobalPlayerOptions = function(optionName)
    ox_target:removeGlobalPlayer(optionName)
end

Core.Target.addLocalEntity = function(entity, options)
    ox_target:addLocalEntity(entity, options)
end

Core.Target.removeLocalEntity = function(entity)
    ox_target:removeLocalEntity(entity)
end

Core.Target.addModel = function(models, options)
    ox_target:addModel(models, options)
end

Core.Target.removeModel = function(models)
    ox_target:removeModel(models)
end

Core.Target.addBoxZone = function(coords, size, heading, options, debug)
    local id = ox_target:addBoxZone({ coords = coords, size = size, rotation = heading, options = options, debug = debug })
    return id
end

Core.Target.removeZone = function(id)
    ox_target:removeZone(id)
end