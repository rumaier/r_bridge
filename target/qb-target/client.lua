if GetResourceState('qb-target') ~= 'started' or GetResourceState('ox_target') == 'started' then return end

local targetZones = {}

Core.Target = {}

---@param entities string | table
---@param options table
function Core.Target.AddLocalEntity(entities, options)
    for k, v in pairs(options) do
        options[k].action = v.onSelect
    end
    exports['qb-target']:AddTargetEntity(entities, {
        options = options,
        distance = 1.5
    })
end

---@param models string | table
---@param options table
function Core.Target.AddModel(models, options)
    for k, v in pairs(options) do
        options[k].action = v.onSelect
    end
    exports['qb-target']:AddTargetModel(models, {
        options = options,
        distance = 1.5, 
    })
end

---@param name string
---@param coords table |vector3
---@param size table | vector3
---@param heading number
---@param options table
---@param debug boolean
---@return number | nil
function Core.Target.AddBoxZone(name, coords, size, heading, options, debug)
    for k, v in pairs(options) do
        options[k].action = v.onSelect
    end
    exports['qb-target']:AddBoxZone(name, coords, size.x, size.y, {
        name = name,
        debugPoly = debug or Cfg.Debug,
        heading = heading,
        minZ = coords.z - (size.x * 0.5),
        maxZ = coords.z + (size.x * 0.5),
    }, {
        options = options,
        distance = 1.5,
    })
    table.insert(targetZones, { name = name, creator = GetInvokingResource() })
end

---@param entity number
function Core.Target.RemoveLocalEntity(entity)
    exports['qb-target']:RemoveTargetEntity(entity)
end

---@param model number
function Core.Target.RemoveModel(model)
    exports['qb-target']:RemoveTargetModel(model)
end

---@param id number
---@param name string
function Core.Target.RemoveZone(id, name)
    exports['qb-target']:RemoveZone(name)
    for i = 1, #targetZones do
        if targetZones[i] == name then
            table.remove(targetZones, i)
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