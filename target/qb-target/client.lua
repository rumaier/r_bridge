if GetResourceState('qb-target') ~= 'started' or GetResourceState('ox_target') == 'started' then return end

local targetZones = {}

Core.Target = {}

function Core.Target.AddGlobalPeds(options)
    for k, v in pairs(options) do
        options[k].action = v.onSelect
    end
    exports['qb-target']:AddGlobalPed({
        options = options, 
        distance = options.distance or 1.5
    })
end

function Core.Target.AddGlobalPlayer(options)
    for k, v in pairs(options) do
        options[k].action = v.onSelect
    end
    exports['qb-target']:AddGlobalPlayer({
        options = options, 
        distance = options.distance or 1.5
    })
end

function Core.Target.AddLocalEntity(entities, options)
    for k, v in pairs(options) do
        options[k].action = v.onSelect
    end
    exports['qb-target']:AddTargetEntity(entities, {
        options = options,
        distance = options.distance or 1.5
    })
end

function Core.Target.AddModel(models, options)
    for k, v in pairs(options) do
        options[k].action = v.onSelect
    end
    exports['qb-target']:AddTargetModel(models, {
        options = options,
        distance = options.distance or 1.5, 
    })
end

function Core.Target.AddBoxZone(name, coords, size, heading, options, drawPoly)
    for k, v in pairs(options) do
        options[k].action = v.onSelect
    end
    exports['qb-target']:AddBoxZone(name, coords, size.x, size.y, {
        name = name,
        debugPoly = drawPoly,
        heading = heading,
        minZ = coords.z - (size.x * 0.5),
        maxZ = coords.z + (size.x * 0.5),
    }, {
        options = options,
        distance = options.distance or 1.5,
    })
    table.insert(targetZones, { name = name, creator = GetInvokingResource() })
end

function Core.Target.RemoveGlobalPeds(name)
    exports['qb-target']:RemoveGlobalPed(name)
end

function Core.Target.RemoveGlobalPlayer(name)
    exports['qb-target']:RemoveGlobalPlayer(name)
end

function Core.Target.RemoveLocalEntity(entity)
    exports['qb-target']:RemoveTargetEntity(entity)
end

function Core.Target.RemoveModel(model)
    exports['qb-target']:RemoveTargetModel(model)
end

function Core.Target.RemoveZone(name)
    for _, data in pairs(targetZones) do
        if data.name == name then
            exports['qb-target']:RemoveZone(name)
            table.remove(targetZones, _)
            break
        end
    end
end

AddEventHandler('onResourceStop', function(resource)
    if resource ~= GetCurrentResourceName() then
        local removed = 0
        for _, target in pairs(targetZones) do
            if target.creator == resource then
                exports['qb-target']:RemoveZone(target.name)
                removed = removed + 1
            end
        end
        if removed > 0 then print('[DEBUG] - removed target zones for:', resource) end
    end
end)