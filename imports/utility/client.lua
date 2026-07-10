---@diagnostic disable: undefined-global

local active = false
local entity = nil

local helpText = '[E] Place  \n[X] Cancel  \n[Scroll Up] Turn Left  \n[Scroll Down] Turn Right'

local function cleanup()
    if not active or not entity then return end
    SetEntityDrawOutlineColor(255, 0, 255, 255)
    bridge.interface.hideTextUi()
    DeleteEntity(entity)
    active = false
    entity = nil
end

local function useObjectPlacer(model, offset, rotation, minDistance, snapToGround, allowedTerrain)
    if active then return end
    local inbounds = true
    local maxDistance = minDistance + 5.0
    offset = offset or vec3(0, 0, 0)
    rotation = rotation or vec3(0, 0, 0)
    local heading = (GetGameplayCamRot(0).z + 360) % 360 - rotation.z
    entity = bridge.natives.createObject(model, vec3(0, 0, 0), 0, false)
    SetEntityAlpha(entity, 150, false)
    SetEntityDrawOutlineColor(255, 0, 0, 255)
    SetEntityCompletelyDisableCollision(entity, false, true)
    SetEntityInvincible(entity, true)
    bridge.interface.showTextUi(helpText)
    active = true
    while active and DoesEntityExist(entity) do
        local hit, _, coords, _, terrain = lib.raycast.fromCamera(1, 4)
        if hit then
            SetEntityCoords(entity, coords.x, coords.y, coords.z, false, false, false, false)
            SetEntityRotation(entity, rotation.x, rotation.y, heading, 2, true)
            local playerCoords = GetEntityCoords(cache.ped)
            local distance = #(playerCoords - coords)

            if snapToGround then
                PlaceObjectOnGroundOrObjectProperly(entity)
            end

            if not inbounds then
                inbounds = true
                SetEntityDrawOutline(entity, false)
            end

            if distance > maxDistance and distance < minDistance or (allowedTerrain and not allowedTerrain[terrain]) and inbounds then
                inbounds = false
                SetEntityDrawOutline(entity, true)
            end

            if IsControlJustReleased(0, 14) then
                heading = (heading + 10) % 360
            end

            if IsControlJustReleased(0, 15) then
                heading = (heading - 10) % 360
            end

            if IsControlJustPressed(0, 73) or IsControlJustReleased(0, 73) then
                cleanup()
                break
            end

            if IsControlJustPressed(0, 38) or IsControlJustReleased(0, 38) and inbounds then
                cleanup()
                return coords, heading
            end
        end
    end
end

local Utility = {}

Utility.useObjectPlacer = useObjectPlacer

return Utility
