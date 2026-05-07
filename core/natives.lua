local blips = {}

local function saveBlip(resource, id)
    blips[resource] = blips[resource] or {}
    table.insert(blips[resource], id)
end

local function clearBlips(resource)
    local blips = blips[resource]
    if not blips then return end
    for _, blip in pairs(blips) do
        RemoveBlip(blip)
    end
    blips[resource] = nil
end

Natives = {}

Natives.createBlip = function(coords, sprite, color, scale, label, longRange)
    local resource = GetInvokingResource()
    local id = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(id, sprite)
    SetBlipColour(id, color)
    SetBlipScale(id, scale)
    SetBlipAsShortRange(id, not longRange)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString(label)
    EndTextCommandSetBlipName(id)
    saveBlip(resource, id)
    return id
end

Natives.removeBlip = function(id)
    local resource = GetInvokingResource()
    local blips = blips[resource]
    if not blips then return end
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

Natives.setPedInert = function(id, toggle)
    FreezeEntityPosition(id, toggle)
    SetEntityInvincible(id, toggle)
    SetBlockingOfNonTemporaryEvents(id, toggle)
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

AddEventHandler('onResourceStop', clearBlips)