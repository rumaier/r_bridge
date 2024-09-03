Core.Natives = {}

function Core.Natives.CreateBlip(coords, sprite, color, scale, label, shortRange)
    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(blip, sprite)
    SetBlipColour(blip, color)
    SetBlipScale(blip, scale)
    SetBlipAsShortRange(blip, shortRange)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(label)
    EndTextCommandSetBlipName(blip)
    return blip
end

function Core.Natives.SetGpsRoute(render, coords, color)
    if not render then SetGpsMultiRouteRender(render) return end
    ClearGpsMultiRoute()
    StartGpsMultiRoute(color, true, true)
    AddPointToGpsMultiRoute(coords.x, coords.y, coords.z)
    SetGpsMultiRouteRender(render)
end

function Core.Natives.CreateProp(model, coords, heading, networked)
    RequestModel(model)
    while not HasModelLoaded(model) do Wait(10) end
    local prop = CreateObject(model, coords.x, coords.y, coords.z, networked, false, false)
    SetEntityHeading(prop, heading)
    SetModelAsNoLongerNeeded(model)
    return prop
end

function Core.Natives.CreateNpc(model, coords, heading, networked)
    RequestModel(model)
    while not HasModelLoaded(model) do Wait(10) end
    local npc = CreatePed(0, model, coords.x, coords.y, coords.z, heading, networked, false)
    SetModelAsNoLongerNeeded(model)
    return npc
end

function Core.Natives.CreateVeh(model, coords, heading, networked)
    RequestModel(model)
    while not HasModelLoaded(model) do Wait(10) end
    local veh = CreateVehicle(model, coords.x, coords.y, coords.z, heading, networked, false)
    SetModelAsNoLongerNeeded(model)
    return veh
end

function Core.Natives.SetEntityProperties(entity, frozen, invincible, oblivious)
    if not DoesEntityExist(entity) then return end
    FreezeEntityPosition(entity, frozen)
    SetEntityInvincible(entity, invincible)
    SetBlockingOfNonTemporaryEvents(entity, oblivious)
end

function Core.Natives.PlayAnim(ped, dict, anim, duration, flag, playback)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do Wait(10) end
    TaskPlayAnim(ped, dict, anim, 8.0, 8.0, duration, flag, playback, false, false, false)
    RemoveAnimDict(dict)
end