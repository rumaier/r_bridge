---@diagnostic disable: duplicate-set-field, undefined-global
local ESX = exports['es_extended']:getSharedObject()

local Framework = {}

Framework.getDetected = function()
    return 'es_extended'
end

Framework.isPlayerLoaded = function()
    return ESX.IsPlayerLoaded()
end

Framework.getPlayerName = function()
    local player = ESX.GetPlayerData()
    return player and {
        first = player.firstName,
        last = player.lastName,
    }
end

Framework.getPlayerMetadata = function(key)
    local player = ESX.GetPlayerData()
    return player and player.metadata[key]
end

Framework.setSkin = function(outfits)
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
        local outfit = skin.sex == 1 and outfits.Female or outfits.Male
        if outfit then
            TriggerEvent('skinchanger:loadClothes', skin, outfit)
        end
    end)
end

Framework.restoreSkin = function()
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
        TriggerEvent('skinchanger:loadSkin', skin)
    end)
end

RegisterNetEvent('esx:playerLoaded', function()
    if GetCurrentResourceName() == 'r_bridge' then
        TriggerEvent('r_bridge:playerLoaded')
    end
end)

return Framework
