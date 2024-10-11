if GetResourceState('qbx_core') ~= 'started' then return end

Core.Info.Framework = 'QBox'
local QBox = exports.qbx_core

Core.Framework = {}

---@param message string
---@param type string
function Core.Framework.Notify(message, type)
    local resource = Cfg.Notification or 'default'
    if resource == 'default' then
        QBox:Notify(message, type)
    elseif resource == 'ox' then
        lib.notify({ description = message, type = type, position = 'top' })
    elseif resource == 'custom' then
        -- insert your notification export here
    end
end

---@return string, string
function Core.Framework.GetPlayerName()
    return QBX.PlayerData.charinfo.firstname, QBX.PlayerData.charinfo.lastname
end

---@param wear boolean
---@param outfits table
function Core.Framework.ToggleOutfit(wear, outfits)
    if wear then
        local gender = QBX.PlayerData.charinfo.gender
        local outfit = gender == 1 and outfits.Female or outfits.Male
        if not outfit then return end
        TriggerEvent('qb-clothing:client:loadOutfit', { outfitData = outfit })
    else
        TriggerServerEvent('qb-clothing:loadPlayerSkin')
    end
end
