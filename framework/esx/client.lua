if GetResourceState('es_extended') ~= 'started' then return end

local ESX = exports["es_extended"]:getSharedObject()

Core.Framework = {}

function Core.Framework.Notify(message, type)
    local resource = Cfg.Notification or 'default'
    if resource == 'default' then
        ESX.ShowNotification(message, type)
    elseif resource == 'ox' then
        lib.notify({ description = message, type = type, position = 'top' })
    elseif resource == 'custom' then
        -- insert your notification system here
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
    return ESX.PlayerData.firstName, ESX.PlayerData.lastName
end

function Core.Framework.ToggleOutfit(wear, outfits)
    if wear then
        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
            local gender = skin.sex
            local outfit = gender == 1 and outfits.Female or outfits.Male
            if not outfit then return end
            TriggerEvent('skinchanger:loadClothes', skin, outfit)
        end)
    else
        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
            TriggerEvent('skinchanger:loadSkin', skin)
        end)
    end
end
