---@diagnostic disable: duplicate-set-field
if GetResourceState('qb-core') ~= 'started' then return end
if GetResourceState('qbx_core') == 'started' then return end
local QB = exports['qb-core']:GetCoreObject()

Framework = {}
local playerLoaded = false

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
    TriggerEvent('r_bridge:playerLoaded')
    playerLoaded = true
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    playerLoaded = false
end)
