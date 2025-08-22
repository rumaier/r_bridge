---@diagnostic disable: duplicate-set-field
if GetResourceState('qbx_core') ~= 'started' then return end

Core.Framework = {}
Core.Framework.Current = 'qbx_core'

local QBX = exports.qbx_core

Core.Framework.GetCharacterName = function()
    local playerData = QBX:GetPlayerData()
    local firstName = playerData.charinfo.firstname or ''
    local lastName = playerData.charinfo.lastname or ''
    return { first = firstName, last = lastName }
end

Core.Framework.GetPlayerMetadata = function(meta)
    local playerData = QBX:GetPlayerData()
    local metadata = playerData.metadata[meta]
    return metadata
end

Core.Framework.ToggleOutfit = function(wear, outfits)
    if wear then
        local playerData = QBX:GetPlayerData()
        if not playerData then return end
        local gender = playerData.charinfo.gender
        local outfit = gender == 1 and outfits.Female or outfits.Male
        if not outfit then return end
        TriggerEvent('qb-clothing:client:loadOutfit', { outfitData = outfit })
    else
        TriggerServerEvent('qb-clothing:loadPlayerSkin')
    end
end
