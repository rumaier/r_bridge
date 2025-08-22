---@diagnostic disable: duplicate-set-field
if GetResourceState('es_extended') ~= 'started' then return end

Core.Framework = {}
Core.Framework.Current = 'es_extended'

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

Core.Framework.ToggleOutfit = function(wear, outfits)
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
