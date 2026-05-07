---@diagnostic disable: duplicate-set-field
if GetResourceState('qbx_core') ~= 'started' then return end
local QBX = exports.qbx_core

Framework = {}
local playerLoaded = false

Framework.getDetected = function()
    return 'qbx_core'
end

Framework.isPlayerLoaded = function()
    return playerLoaded
end

Framework.getPlayerName = function()
    local player = QBX:GetPlayerData()
    return player and {
        first = player.charinfo.firstname,
        last = player.charinfo.lastname,
    }
end

Framework.getPlayerMetadata = function(key)
    local player = QBX:GetPlayerData()
    return player and player.metadata[key]
end

Framework.setSkin = function(outfits)
    local player = QBX:GetPlayerData()
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
