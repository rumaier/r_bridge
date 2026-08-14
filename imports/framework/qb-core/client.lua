---@diagnostic disable: duplicate-set-field, undefined-global
local QB = exports['qb-core']:GetCoreObject()

local Framework = {}
local playerData = QB.Functions.GetPlayerData()
local playerLoaded = playerData and playerData.citizenid ~= nil

Framework.getDetected = function()
    return 'qb-core'
end

Framework.isPlayerLoaded = function()
    return playerLoaded
end

Framework.getPlayerName = function()
    local player = QB.Functions.GetPlayerData()
    return player and {
        first = player.charinfo.firstname,
        last = player.charinfo.lastname,
    }
end

Framework.getPlayerMetadata = function(key)
    local player = QB.Functions.GetPlayerData()
    return player and player.metadata[key]
end

Framework.setSkin = function(outfits)
    local player = QB.Functions.GetPlayerData()
    local outfit = player.charinfo.gender == 1 and outfits.Female or outfits.Male
    if outfit then
        TriggerEvent('qb-clothing:client:loadOutfit', { outfitData = outfit })
    end
end

Framework.restoreSkin = function()
    TriggerServerEvent('qb-clothing:loadPlayerSkin')
end

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    if GetCurrentResourceName() == 'r_bridge' then
        TriggerEvent('r_bridge:playerLoaded')
    end
    playerLoaded = true
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    if GetCurrentResourceName() == 'r_bridge' then
        TriggerEvent('r_bridge:playerUnloaded')
    end
    playerLoaded = false
end)

return Framework
