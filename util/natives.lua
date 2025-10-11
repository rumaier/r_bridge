Core.Natives = {}

-- MAP

local blips = {}

local function saveBlip(blip, resource)
    blips[resource] = blips[resource] or {}
    table.insert(blips[resource], blip)
end

Core.Natives.createBlip = function(coords, sprite, color, scale, label, longRange)
    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(blip, sprite)
    SetBlipColour(blip, color)
    SetBlipScale(blip, scale)
    SetBlipAsShortRange(blip, not longRange)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(label)
    EndTextCommandSetBlipName(blip)
    saveBlip(blip, GetInvokingResource())
    return blip
end

Core.Natives.removeBlip = function(blip)
    local resource = GetInvokingResource()
    if not blips[resource] then return end
    for i, id in pairs(blips[resource]) do
        if id == blip then
            table.remove(blips[resource], i)
            RemoveBlip(blip)
            break
        end
    end
end

AddEventHandler('onResourceStop', function(resource)
    local blips = blips[resource]
    if not blips then return end
    for _, blip in pairs(blips) do RemoveBlip(blip) end
    blips[resource] = nil
end)

Core.Natives.setGpsRoute = function(render, coords, color)
    if not render then SetGpsMultiRouteRender(false) return end
    ClearGpsMultiRoute()
    StartGpsMultiRoute(color, true, true)
    AddPointToGpsMultiRoute(coords.x, coords.y, coords.z)
    SetGpsMultiRouteRender(true)
end

-- ENTITIES

Core.Natives.createObject = function(model, coords, heading, networked)
    model = type(model) == 'number' and model or joaat(model)
    RequestModel(model)
    repeat Wait(0) until HasModelLoaded(model)
    local object = CreateObject(model, coords.x, coords.y, coords.z, networked, false, false)
    SetEntityHeading(object, heading)
    SetModelAsNoLongerNeeded(model)
    return object
end

Core.Natives.createPed = function(model, coords, heading, networked)
    model = type(model) == 'number' and model or joaat(model)
    RequestModel(model)
    repeat Wait(0) until HasModelLoaded(model)
    local ped = CreatePed(0, model, coords.x, coords.y, coords.z, heading, networked, false)
    SetModelAsNoLongerNeeded(model)
    return ped
end

Core.Natives.createVehicle = function(model, coords, heading, networked)
    model = type(model) == 'number' and model or joaat(model)
    RequestModel(model)
    repeat Wait(0) until HasModelLoaded(model)
    local vehicle = CreateVehicle(model, coords.x, coords.y, coords.z, heading, networked, false)
    SetModelAsNoLongerNeeded(model)
    return vehicle
end

Core.Natives.setEntityProperties = function(entity, frozen, invincible, oblivious)
    if not DoesEntityExist(entity) then return end
    FreezeEntityPosition(entity, frozen or false)
    SetEntityInvincible(entity, invincible or false)
    SetBlockingOfNonTemporaryEvents(entity, oblivious or false)
end

-- ANIMATIONS/PTFX

Core.Natives.playAnimation = function(entity, dictionary, animation, duration, flag, playbackRate)
    if not DoesEntityExist(entity) then return end
    RequestAnimDict(dictionary)
    repeat Wait(0) until HasAnimDictLoaded(dictionary)
    TaskPlayAnim(entity, dictionary, animation, 3.0, 1.0, duration, flag or 0, playbackRate or 0.0, false, false, false)
    RemoveAnimDict(dictionary)
end

Core.Natives.triggerParticleFx = function(coords, rotation, asset, effect, scale, looped, duration)
    RequestNamedPtfxAsset(asset)
    repeat Wait(0) until HasNamedPtfxAssetLoaded(asset)
    UseParticleFxAsset(asset)
    if looped then
        local fx = StartParticleFxLoopedAtCoord(effect, coords.x, coords.y, coords.z, rotation.x, rotation.y, rotation.z, scale, false, false, false, false)
        SetTimeout(duration, function()
            StopParticleFxLooped(fx, false)
            RemoveNamedPtfxAsset(asset)
        end)
    else
        StartParticleFxNonLoopedAtCoord(effect, coords.x, coords.y, coords.z, rotation.x, rotation.y, rotation.z, scale, false, false, false)
        RemoveNamedPtfxAsset(asset)
    end
end
