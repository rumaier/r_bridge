if GetResourceState('ox_target') ~= 'started' then return end

local ox_target = exports.ox_target
local targetZones = {}

Core.Target = {}

function Core.Target.AddGlobalPeds(options)
    ox_target:addGlobalPed(options)
end

function Core.Target.AddGlobalPlayer(options)
    ox_target:addGlobalPlayer(options)
end

function Core.Target.AddLocalEntity(entities, options)
    ox_target:addLocalEntity(entities, options)
end

function Core.Target.AddModel(models, options)
    ox_target:addModel(models, options)
end

function Core.Target.AddBoxZone(name, coords, size, heading, options, drawPoly)
    local target = ox_target:addBoxZone({
        coords = coords,
        size = size,
        rotation = heading,
        debug = drawPoly,
        options = options,
    })
    table.insert(targetZones, { name = name, id = target, creator = GetInvokingResource() })
    return target
end

function Core.Target.RemoveGlobalPeds(name)
    ox_target:removeGlobalPed(name)
end

function Core.Target.RemoveGlobalPlayer(name)
    ox_target:removeGlobalPlayer(name)
end

function Core.Target.RemoveLocalEntity(entity)
    ox_target:removeLocalEntity(entity)
end

function Core.Target.RemoveModel(model)
    ox_target:removeModel(model)
end

function Core.Target.RemoveZone(name)
    for _, data in pairs(targetZones) do
        if data.name == name then
            ox_target:removeZone(data.id)
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
                ox_target:removeZone(target.id)
                table.remove(targetZones, _)
                removed = removed + 1
            end
        end
        if removed > 0 then print('[DEBUG] - removed targets for:', resource) end
    end
end)
