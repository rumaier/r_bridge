if GetResourceState('es_extended') ~= 'started' then return end

Core.Framework = {}
Core.Framework.Current = 'ESX'

local ESX = exports['es_extended']:getSharedObject()

Core.Framework.GetCharacterName = function()
    local firstName = ESX.PlayerData.firstName or ''
    local lastName = ESX.PlayerData.lastName or ''
    return { first = firstName, last = lastName }
end

Core.Framework.GetPlayerMetadata = function(meta)
    local metadata = ESX.PlayerData.metadata[meta]
    return metadata
end