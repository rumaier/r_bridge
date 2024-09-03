if GetResourceState('ox_target') ~= 'started' then return end

local ox_target = exports.ox_target

Core.Target = {}

function Core.Target.AddLocalEntity(entities, options)
    ox_target:addLocalEntity(entities, options)
end

function Core.Target.AddModel(models, options)
    ox_target:addModel(models, options)
end

function Core.Target.AddBoxZone(name, coords, size, heading, options)
    return ox_target:addBoxZone({
        coords = coords,
        size = size,
        rotation = heading,
        debug = Cfg.Debug or false,
        options = options,
    })
end

function Core.Target.RemoveLocalEntity(entity)
    ox_target:removeLocalEntity(entity)
end

function Core.Target.RemoveModel(model)
    ox_target:removeModel(model)
end

function Core.Target.RemoveZone(id, name)
    ox_target:removeZone(id)
end
