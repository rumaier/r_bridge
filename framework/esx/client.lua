if GetResourceState('es_extended') ~= 'started' then return end

Core.Info.Framework = 'ESX'
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

function Core.Framework.GetPlayerName()
    local first = ESX.PlayerData.firstName
    local last = ESX.PlayerData.lastName
    return first, last
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

function Core.Framework.GetPlayerMetadata(meta)
    return ESX.GetPlayerData().metadata[meta]
end
