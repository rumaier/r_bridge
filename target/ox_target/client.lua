if GetResourceState('ox_target') ~= 'started' then return end

local ox_target = exports.ox_target
local targetZones = {}

Core.Target = {}

---@param entities string | table
---@param options table
function Core.Target.AddLocalEntity(entities, options)
    ox_target:addLocalEntity(entities, options)
end

---@param models string | table
---@param options table
function Core.Target.AddModel(models, options)
    ox_target:addModel(models, options)
end

---@param name string
---@param coords table |vector3
---@param size table | vector3
---@param heading number
---@param options table
---@param debug boolean
---@return number | nil
function Core.Target.AddBoxZone(name, coords, size, heading, options, debug)
    local target = ox_target:addBoxZone({
        coords = coords,
        size = size,
        rotation = heading,
        debug = debug or Cfg.Debug,
        options = options,
    })
    table.insert(targetZones, { id = target, creator = GetInvokingResource() })
    return target
end

---@param entity number
function Core.Target.RemoveLocalEntity(entity)
    ox_target:removeLocalEntity(entity)
end

---@param model number
function Core.Target.RemoveModel(model)
    ox_target:removeModel(model)
end

---@param id number
---@param name string
function Core.Target.RemoveZone(id, name)
    ox_target:removeZone(id)
    for i = 1, #targetZones do
        if targetZones[i].id == id then
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
                ox_target:removeZone(target.id)
                removed = removed + 1
            end
        end
        if removed > 0 then print('[DEBUG] - removed targets for:', resource) end
    end
end)
