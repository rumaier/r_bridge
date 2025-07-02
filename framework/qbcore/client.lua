if GetResourceState('qb-core') ~= 'started' then return end
if GetResourceState('qbx_core') == 'started' then return end

Core.Info.Framework = 'QBCore'
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

function Core.Framework.GetPlayerMetadata(meta)
    return QBCore.Functions.GetPlayerData().metadata[meta]
end

