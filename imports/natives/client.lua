---@diagnostic disable: undefined-global

local blips = {}

local function clearBlips()
    for _, blip in pairs(blips) do
        RemoveBlip(blip)
    end
    blips = {}
end

local Natives = {}

Natives.createBlip = function(coords, sprite, color, scale, label, longRange)
    local id = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(id, sprite)
    SetBlipColour(id, color)
    SetBlipScale(id, scale)
    SetBlipAsShortRange(id, not longRange)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString(label)
    EndTextCommandSetBlipName(id)
    blips[#blips + 1] = id
    return id
end

Natives.removeBlip = function(id)
    for k, v in pairs(blips) do
        if v == id then
            table.remove(blips, k)
            RemoveBlip(id)
            break
        end
    end
end

Natives.setGpsRoute = function(coords, color)
    StartGpsMultiRoute(color, true, true)
    AddPointToGpsMultiRoute(coords.x, coords.y, coords.z)
    SetGpsMultiRouteRender(true)
end

Natives.clearGpsRoute = function()
    SetGpsMultiRouteRender(false)
    ClearGpsMultiRoute()
end

Natives.setPedInert = function(id, toggle)
    FreezeEntityPosition(id, toggle)
    SetEntityInvincible(id, toggle)
    SetBlockingOfNonTemporaryEvents(id, toggle)
end

Natives.teleportPlayer = function(coords, heading)
    DoScreenFadeOut(750)
    Wait(800)
    StartPlayerTeleport(cache.playerId, coords.x, coords.y, coords.z, heading, false, true, false)
    Wait(200)
    DoScreenFadeIn(325)
end

Natives.isPedFacingEntity = function(ped, entity, maxAngle)
    local coords = GetEntityCoords(entity)
    local offset = GetOffsetFromEntityGivenWorldCoords(ped, coords.x, coords.y, coords.z)
    local angle = math.abs(math.deg(math.atan(offset.x, offset.y)))
    return offset.y > 0.0 and angle <= (maxAngle or 5.0)
end

Natives.isPedFacingCoord = function(ped, coords, maxAngle)
    local offset = GetOffsetFromEntityGivenWorldCoords(ped, coords.x, coords.y, coords.z)
    local angle = math.abs(math.deg(math.atan(offset.x, offset.y)))
    return offset.y > 0.0 and angle <= (maxAngle or 5.0)
end

Natives.createObject = function(model, coords, heading, network)
    model = type(model) ~= 'number' and joaat(model) or model
    RequestModel(model)
    repeat Wait(0) until HasModelLoaded(model)
    local id = CreateObject(model, coords.x, coords.y, coords.z, network, true, true)
    SetEntityHeading(id, heading)
    SetModelAsNoLongerNeeded(model)
    return id
end

Natives.createPed = function(model, coords, heading, network)
    model = type(model) ~= 'number' and joaat(model) or model
    RequestModel(model)
    repeat Wait(0) until HasModelLoaded(model)
    local id = CreatePed(0, model, coords.x, coords.y, coords.z, heading, network, true)
    SetModelAsNoLongerNeeded(model)
    return id
end

Natives.createVehicle = function(model, coords, heading, network)
    model = type(model) ~= 'number' and joaat(model) or model
    RequestModel(model)
    repeat Wait(0) until HasModelLoaded(model)
    local id = CreateVehicle(model, coords.x, coords.y, coords.z, heading, network, false)
    SetModelAsNoLongerNeeded(model)
    return id
end

Natives.playAnimation = function(entity, dict, anim, duration, flag, rate)
    RequestAnimDict(dict)
    repeat Wait(0) until HasAnimDictLoaded(dict)
    TaskPlayAnim(entity, dict, anim, 3.0, 1.0, duration, flag, rate or 0.0, false, false, false)
    RemoveAnimDict(dict)
end

Natives.ptFx = function(coords, rotation, asset, fx, scale, loop, duration)
    RequestNamedPtfxAsset(asset)
    repeat Wait(0) until HasNamedPtfxAssetLoaded(asset)
    UseParticleFxAsset(asset)
    if loop then
        local id = StartParticleFxLoopedAtCoord(fx, coords.x, coords.y, coords.z, rotation.x, rotation.y, rotation.z, scale, false, false, false, false)
        SetTimeout(duration, function()
            StopParticleFxLooped(id, false)
            RemoveNamedPtfxAsset(asset)
        end)
    else
        StartParticleFxNonLoopedAtCoord(fx, coords.x, coords.y, coords.z, rotation.x, rotation.y, rotation.z, scale, false, false, false)
        RemoveNamedPtfxAsset(asset)
    end
end

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        clearBlips()
    end
end)

return Natives
