---@diagnostic disable: duplicate-set-field
if GetResourceState('qb-core') ~= 'started' or GetResourceState('qbx_core') == 'started' then return end

Core.Framework = {}
Core.Framework.Current = 'qb-core'

local QBCore = exports['qb-core']:GetCoreObject()

Core.Framework.getCharacterName = function()
    local playerData = QBCore.Functions.GetPlayerData()
    local firstName = playerData.charinfo.firstname or ''
    local lastName = playerData.charinfo.lastname or ''
    return { first = firstName, last = lastName }
end

Core.Framework.getPlayerMetadata = function(meta)
    local playerData = QBCore.Functions.GetPlayerData()
    local metadata = playerData.metadata[meta]
    return metadata
end

Core.Framework.toggleOutfit = function(wear, outfits)
    if wear then
        local playerData = QBCore.Functions.GetPlayerData()
        if not playerData then return end
        local gender = playerData.charinfo
        local outfit = gender == 1 and outfits.Female or outfits.Male
        if not outfit then return end
        TriggerEvent('qb-clothing:client:loadOutfit', { outfitData = outfit })
    else
        TriggerServerEvent('qb-clothing:loadPlayerSkin')
    end
end
