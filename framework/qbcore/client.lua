if GetResourceState('qb-core') ~= 'started' then return end

local QBCore = exports['qb-core']:GetCoreObject()

Core.Framework = {}

function Core.Framework.Notify(message, type)
    local resource = Cfg.Notification or 'default'
    if resource == 'default' then
        TriggerEvent('QBCore:Notify', message, 'primary', 3000)
    elseif resource == 'ox' then
        lib.notify({ description = message, type = type, position = 'top' })
    elseif resource == 'custom' then
        -- insert your notification export here
    end
end

function Core.CarKeys.GiveKeys(vehicle)
    if not Cfg.CarLock then return end
    local plate = GetVehicleNumberPlateText(vehicle)
    local resource = Cfg.CarLock
    if resource == 'qb' then
        TriggerEvent("qb-vehiclekeys:client:AddKeys", plate)
    elseif resource == 'wasabi' then
        exports.wasabi_carlock:GiveKey(plate)
    elseif resource == 'mrnewb' then
        exports.MrNewbVehicleKeys:GiveKeys(vehicle)
    elseif resource == 'quasar' then
        exports['qs-vehiclekeys']:GiveKeys(plate, vehicle, true)
    elseif resource == 'custom' then
        -- insert your car lock sytem here
    end
end

function Core.Framework.GetPlayerName()
    local playerData = QBCore.Functions.GetPlayerData()
    return playerData.charinfo.firstname, playerData.charinfo.lastname
end

function Core.Framework.ToggleOutfit(wear, outfits)
    if wear then
        local gender = QBCore.Functions.GetPlayerData().charinfo
        local outfit = gender == 1 and outfits.Female or outfits.Male
        if not outfit then return end
        TriggerEvent('qb-clothing:client:loadOutfit', { outfitData = outfit })
    else
        TriggerServerEvent('qb-clothing:loadPlayerSkin')
    end
end

