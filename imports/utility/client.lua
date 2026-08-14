---@diagnostic disable: undefined-global
local Utility = {}

-------------------
-- Object Placer --
-------------------
local placerState = {
    active = false,
    entity = nil
}

Utility.isObjectPlacerActive = function()
    return placerState.active
end

Utility.useObjectPlacer = function(model, offset, rotation, minDistance, snapToGround, allowedTerrain)
    if placerState.active then return end
    local inbounds = true
    local maxDistance = (minDistance or 1.0) + 5.0
    offset = offset or vec3(0, 0, 0)
    rotation = rotation or vec3(0, 0, 0)
    local heading = (GetGameplayCamRot(0).z + 360) % 360 - rotation.z
    placerState.active = true
    placerState.entity = bridge.natives.createObject(model, vec3(0, 0, 0), heading, false)
    SetEntityAlpha(placerState.entity, 150, false)
    SetEntityDrawOutlineColor(255, 0, 0, 255)
    SetEntityCompletelyDisableCollision(placerState.entity, false, true)
    SetEntityInvincible(placerState.entity, true)
    bridge.interface.showTextUi('[E] Place  \n[X] Cancel  \n[Scroll Up] Turn Left  \n[Scroll Down] Turn Right')
    while placerState.active and DoesEntityExist(placerState.entity) do
        local hit, _, coords, _, terrain = lib.raycast.fromCamera(1, 4)
        if hit then
            SetEntityCoords(placerState.entity, coords.x, coords.y, coords.z, false, false, false, false)
            SetEntityRotation(placerState.entity, rotation.x, rotation.y, heading, 2, true)
            local playerCoords = GetEntityCoords(cache.ped)
            local distance = #(playerCoords - coords)

            if snapToGround then
                PlaceObjectOnGroundOrObjectProperly(placerState.entity)
            end

            if not inbounds then
                inbounds = true
                SetEntityDrawOutline(placerState.entity, false)
            end

            if distance > maxDistance and distance < minDistance or (allowedTerrain and not allowedTerrain[terrain]) and inbounds then
                inbounds = false
                SetEntityDrawOutline(placerState.entity, true)
            end

            if IsControlJustReleased(0, 14) then
                heading = (heading + 10) % 360
            end

            if IsControlJustReleased(0, 15) then
                heading = (heading - 10) % 360
            end

            if IsControlJustPressed(0, 73) or IsControlJustReleased(0, 73) then
                SetEntityDrawOutlineColor(255, 0, 0, 255)
                DeleteEntity(placerState.entity)
                bridge.interface.hideTextUi()
                placerState.active = false
                placerState.entity = nil
                return nil
            end

            if IsControlJustPressed(0, 38) or IsControlJustReleased(0, 38) and inbounds then
                SetEntityDrawOutlineColor(255, 0, 255, 255)
                bridge.interface.hideTextUi()
                DeleteEntity(placerState.entity)
                placerState.active = false
                placerState.entity = nil
                return coords, heading
            end
        end
    end
end

return Utility
