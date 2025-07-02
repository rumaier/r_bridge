if GetResourceState('es_extended') ~= 'started' then return end

Core.Info.Framework = 'ESX'
local ESX = exports["es_extended"]:getSharedObject()

Core.Framework = {}

function Core.Framework.Notify(src, message, type)
    local src = src or source
    local resource = Cfg.Notification
    if resource == 'default' then
        TriggerClientEvent('esx:showNotification', src, message, type)
    elseif resource == 'ox' then
        TriggerClientEvent('ox_lib:notify', src, { description = message, type = type, position = 'top' })
    elseif resource == 'custom' then
        -- insert your notification export here
    end
end

function Core.Framework.GetPlayerIdentifier(src)
    local src = src or source
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return end
    return xPlayer.getIdentifier()
end

function Core.Framework.GetPlayerName(src)
    local src = src or source
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return end
    return xPlayer.variables.firstName, xPlayer.variables.lastName
end

function Core.Framework.GetPlayerJob(src)
    local src = src or source
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return end
    return xPlayer.getJob().name, xPlayer.getJob().label
end

function Core.Framework.GetPlayerJobGrade(src)
    local src = src or source
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return end
    return xPlayer.getJob().grade, xPlayer.getJob().grade_label
end

function Core.Framework.GetAccountBalance(src, account)
    local src = src or source
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return end
    return xPlayer.getAccount(account).money
end

function Core.Framework.AddAccountBalance(src, account, amount)
    local src = src or source
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return end
    xPlayer.addAccountMoney(account, amount)
end

function Core.Framework.RemoveAccountBalance(src, account, amount)
    local src = src or source
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return end
    xPlayer.removeAccountMoney(account, amount)
end

function Core.Framework.SetPlayerMetadata(src, meta, value)
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return end
    xPlayer.setMeta(meta, value)
end

function Core.Framework.GetPlayerMetadata(src, meta)
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return end
    return xPlayer.getMeta(meta) or nil
end

function Core.Framework.AddSocietyBalance(job, amount)
    local society = exports['esx_society']:GetSociety(job)
    if not society then return end
    TriggerEvent('esx_addonaccount:getSharedAccount', society.account, function(account)
        account.addMoney(amount)
    end)
end

function Core.Framework.RemoveSocietyBalance(job, amount)
    local society = exports['esx_society']:GetSociety(job)
    if not society then return end
    TriggerEvent('esx_addonaccount:getSharedAccount', society.account, function(account)
        account.removeMoney(amount)
    end)
end

function Core.Framework.RegisterUsableItem(item, cb)
    ESX.RegisterUsableItem(item, cb)
end
