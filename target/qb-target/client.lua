if GetResourceState('qb-target') ~= 'started' or GetResourceState('ox_target') == 'started' then return end

Core.Target = {}

function Core.Target.AddLocalEntity(entities, options)
    for k, v in pairs(options) do
        options[k].action = v.onSelect
    end
    exports['qb-target']:AddTargetEntity(entities, {
        options = options,
        distance = 1.5
    })
end

function Core.Target.AddModel(models, options)
    for k, v in pairs(options) do
        options[k].action = v.onSelect
    end
    exports['qb-target']:AddTargetModel(models, {
        options = options,
        distance = 1.5, 
    })
end

function Core.Target.AddBoxZone(name, coords, size, heading, options)
    for k, v in pairs(options) do
        options[k].action = v.onSelect
    end
    exports['qb-target']:AddBoxZone(name, coords, size.x, size.y, {
        name = name,
        debugPoly = Cfg.Debug,
        heading = heading,
        minZ = coords.z - (size.x * 0.5),
        maxZ = coords.z + (size.x * 0.5),
    }, {
        options = options,
        distance = 1.5,
    })
end

function Core.Target.RemoveLocalEntity(entity)
    exports['qb-target']:RemoveTargetEntity(entity)
end

function Core.Target.RemoveModel(model)
    exports['qb-target']:RemoveTargetModel(model)
end

function Core.Target.RemoveZone(id, name)
    exports['qb-target']:RemoveZone(name)
end