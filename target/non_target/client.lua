---@diagnostic disable: duplicate-set-field

local hasTarget = GetResourceState('ox_target') == 'started' or GetResourceState('qb-target') == 'started'

if hasTarget then
    return
end

Core.Target = Core.Target or {}
Core.Target.Current = 'non_target'

local textUiVisible = false
local currentPrompt = nil

local zones = {}
local localEntities = {}
local modelTargets = {}
local globalPedOptions = {}
local globalPlayerOptions = {}

local zoneIdCounter = 0

local function ensureArray(value)
    if type(value) ~= 'table' then return {} end
    return value
end

local function isEntityValid(entity)
    return entity and entity ~= 0 and DoesEntityExist(entity)
end

local function getOptionLabel(option)
    if option.label and option.label ~= '' then
        return ('[E] %s'):format(option.label)
    end

    if option.name and option.name ~= '' then
        return ('[E] %s'):format(option.name)
    end

    return '[E] Interact'
end

local function runCanInteract(option, entity, coords, distance)
    if not option.canInteract then return true end

    local ok, result = pcall(option.canInteract, entity, distance, coords, option.name)
    if not ok then
        return false
    end

    return result
end

local function executeOption(option, entity, coords, distance)
    local data = {
        entity = entity,
        coords = coords,
        distance = distance
    }

    if option.onSelect then
        option.onSelect(data)
        return
    end

    if option.event then
        TriggerEvent(option.event, data)
        return
    end

    if option.serverEvent then
        TriggerServerEvent(option.serverEvent, data)
        return
    end

    if option.command then
        ExecuteCommand(option.command)
        return
    end
end

local function getBoxZoneDistance(playerCoords, zone)
    local halfSizeX = (zone.size.x or zone.size[1] or 1.0) / 2
    local halfSizeY = (zone.size.y or zone.size[2] or 1.0) / 2

    local dx = math.max(math.abs(playerCoords.x - zone.coords.x) - halfSizeX, 0.0)
    local dy = math.max(math.abs(playerCoords.y - zone.coords.y) - halfSizeY, 0.0)
    local dz = math.abs(playerCoords.z - zone.coords.z)

    return math.sqrt(dx * dx + dy * dy + dz * dz)
end

local function showPrompt(text)
    if currentPrompt == text
        and textUiVisible
        and Core.Interface
        and Core.Interface.isTextUiActive
        and Core.Interface.isTextUiActive() then
        return
    end

    currentPrompt = text
    textUiVisible = true

    if Core.Interface and Core.Interface.showTextUI then
        Core.Interface.showTextUI(text)
    else
        lib.showTextUI(text)
    end
end

local function hidePrompt()
    if not textUiVisible then return end

    textUiVisible = false
    currentPrompt = nil

    if Core.Interface and Core.Interface.hideTextUI then
        Core.Interface.hideTextUI()
    else
        lib.hideTextUI()
    end
end

local function findBestZoneOption(playerCoords)
    local best = nil

    for _, zone in pairs(zones) do
        local dist = getBoxZoneDistance(playerCoords, zone)

        if dist <= zone.maxDistance then
            for _, option in ipairs(zone.options) do
                local optionDistance = option.distance or zone.maxDistance

                if dist <= optionDistance and runCanInteract(option, nil, zone.coords, dist) then
                    if not best or dist < best.distance then
                        best = {
                            option = option,
                            entity = nil,
                            coords = zone.coords,
                            distance = dist,
                            label = getOptionLabel(option)
                        }
                    end
                end
            end
        end
    end

    return best
end

local function findBestLocalEntityOption(playerCoords)
    local best = nil

    for entity, options in pairs(localEntities) do
        if isEntityValid(entity) then
            local entityCoords = GetEntityCoords(entity)
            local dist = #(playerCoords - entityCoords)

            for _, option in ipairs(options) do
                local optionDistance = option.distance or 2.0

                if dist <= optionDistance and runCanInteract(option, entity, entityCoords, dist) then
                    if not best or dist < best.distance then
                        best = {
                            option = option,
                            entity = entity,
                            coords = entityCoords,
                            distance = dist,
                            label = getOptionLabel(option)
                        }
                    end
                end
            end
        end
    end

    return best
end

local function findClosestModelEntity(playerCoords, modelMap, maxDistance)
    local bestEntity, bestCoords, bestDist

    local pools = { 'CObject', 'CVehicle', 'CPed' }

    for _, poolName in ipairs(pools) do
        local pool = GetGamePool(poolName)

        for i = 1, #pool do
            local entity = pool[i]
            if isEntityValid(entity) then
                local model = GetEntityModel(entity)

                if modelMap[model] then
                    local coords = GetEntityCoords(entity)
                    local dist = #(playerCoords - coords)

                    if dist <= maxDistance and (not bestDist or dist < bestDist) then
                        bestEntity = entity
                        bestCoords = coords
                        bestDist = dist
                    end
                end
            end
        end
    end

    return bestEntity, bestCoords, bestDist
end

local function findBestModelOption(playerCoords)
    local best = nil

    for _, entry in pairs(modelTargets) do
        local entity, entityCoords, dist = findClosestModelEntity(playerCoords, entry.models, entry.maxDistance)

        if entity then
            for _, option in ipairs(entry.options) do
                local optionDistance = option.distance or entry.maxDistance

                if dist <= optionDistance and runCanInteract(option, entity, entityCoords, dist) then
                    if not best or dist < best.distance then
                        best = {
                            option = option,
                            entity = entity,
                            coords = entityCoords,
                            distance = dist,
                            label = getOptionLabel(option)
                        }
                    end
                end
            end
        end
    end

    return best
end

local function findClosestPed(playerCoords, maxDistance, playersOnly)
    local myPed = PlayerPedId()
    local bestPed, bestCoords, bestDist
    local pool = GetGamePool('CPed')

    for i = 1, #pool do
        local ped = pool[i]
        if ped ~= myPed and isEntityValid(ped) and not IsEntityDead(ped) then
            local isPlayer = IsPedAPlayer(ped)

            if (playersOnly and isPlayer) or ((not playersOnly) and (not isPlayer)) then
                local coords = GetEntityCoords(ped)
                local dist = #(playerCoords - coords)

                if dist <= maxDistance and (not bestDist or dist < bestDist) then
                    bestPed = ped
                    bestCoords = coords
                    bestDist = dist
                end
            end
        end
    end

    return bestPed, bestCoords, bestDist
end

local function findBestGlobalPedOption(playerCoords)
    local best = nil
    local ped, coords, dist = findClosestPed(playerCoords, 3.0, false)

    if not ped then return nil end

    for _, option in ipairs(globalPedOptions) do
        local optionDistance = option.distance or 3.0

        if dist <= optionDistance and runCanInteract(option, ped, coords, dist) then
            if not best or dist < best.distance then
                best = {
                    option = option,
                    entity = ped,
                    coords = coords,
                    distance = dist,
                    label = getOptionLabel(option)
                }
            end
        end
    end

    return best
end

local function findBestGlobalPlayerOption(playerCoords)
    local best = nil
    local ped, coords, dist = findClosestPed(playerCoords, 3.0, true)

    if not ped then return nil end

    for _, option in ipairs(globalPlayerOptions) do
        local optionDistance = option.distance or 3.0

        if dist <= optionDistance and runCanInteract(option, ped, coords, dist) then
            if not best or dist < best.distance then
                best = {
                    option = option,
                    entity = ped,
                    coords = coords,
                    distance = dist,
                    label = getOptionLabel(option)
                }
            end
        end
    end

    return best
end

local function getBestInteraction()
    local playerCoords = GetEntityCoords(PlayerPedId())
    local candidates = {
        findBestZoneOption(playerCoords),
        findBestLocalEntityOption(playerCoords),
        findBestModelOption(playerCoords),
        findBestGlobalPedOption(playerCoords),
        findBestGlobalPlayerOption(playerCoords)
    }

    local best = nil

    for i = 1, #candidates do
        local entry = candidates[i]
        if entry and (not best or entry.distance < best.distance) then
            best = entry
        end
    end

    return best
end

CreateThread(function()
    while true do
        local waitTime = 1000
        local best = getBestInteraction()

        if best then
            waitTime = 0
            showPrompt(best.label)

            if IsControlJustReleased(0, 38) then
                executeOption(best.option, best.entity, best.coords, best.distance)
                Wait(150)
            end
        else
            hidePrompt()
        end

        Wait(waitTime)
    end
end)

AddEventHandler('onResourceStop', function(resourceName)
    if resourceName ~= GetCurrentResourceName() then return end
    hidePrompt()
end)

Core.Target.addGlobalPedOptions = function(options)
    globalPedOptions = ensureArray(options)
end

Core.Target.removeGlobalPedOptions = function(optionName)
    for i = #globalPedOptions, 1, -1 do
        if globalPedOptions[i].name == optionName then
            table.remove(globalPedOptions, i)
        end
    end
end

Core.Target.addGlobalPlayerOptions = function(options)
    globalPlayerOptions = ensureArray(options)
end

Core.Target.removeGlobalPlayerOptions = function(optionName)
    for i = #globalPlayerOptions, 1, -1 do
        if globalPlayerOptions[i].name == optionName then
            table.remove(globalPlayerOptions, i)
        end
    end
end

Core.Target.addLocalEntity = function(entity, options)
    if not entity then return end
    localEntities[entity] = ensureArray(options)
end

Core.Target.removeLocalEntity = function(entity)
    localEntities[entity] = nil
end

Core.Target.addModel = function(models, options)
    zoneIdCounter = zoneIdCounter + 1
    local id = ('model_%s'):format(zoneIdCounter)

    if type(models) ~= 'table' then
        models = { models }
    end

    local modelMap = {}
    for i = 1, #models do
        local model = models[i]
        if type(model) == 'string' then
            model = joaat(model)
        end
        modelMap[model] = true
    end

    local maxDistance = 2.0
    local opts = ensureArray(options)

    for i = 1, #opts do
        if opts[i].distance and opts[i].distance > maxDistance then
            maxDistance = opts[i].distance
        end
    end

    modelTargets[id] = {
        models = modelMap,
        options = opts,
        maxDistance = maxDistance
    }

    return id
end

Core.Target.removeModel = function(models)
    if type(models) ~= 'table' then
        models = { models }
    end

    local hashes = {}
    for i = 1, #models do
        local model = models[i]
        if type(model) == 'string' then
            model = joaat(model)
        end
        hashes[model] = true
    end

    for id, entry in pairs(modelTargets) do
        local allMatch = true
        for modelHash in pairs(entry.models) do
            if not hashes[modelHash] then
                allMatch = false
                break
            end
        end

        if allMatch then
            modelTargets[id] = nil
        end
    end
end

Core.Target.addBoxZone = function(coords, size, heading, options, debug)
    zoneIdCounter = zoneIdCounter + 1
    local id = ('zone_%s'):format(zoneIdCounter)

    local maxDistance = 2.0
    local opts = ensureArray(options)

    for i = 1, #opts do
        if opts[i].distance and opts[i].distance > maxDistance then
            maxDistance = opts[i].distance
        end
    end

    zones[id] = {
        id = id,
        coords = coords,
        size = size,
        heading = heading,
        options = opts,
        debug = debug,
        maxDistance = maxDistance
    }

    return id
end

Core.Target.removeZone = function(id)
    zones[id] = nil
end