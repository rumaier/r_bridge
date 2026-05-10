---@diagnostic disable: duplicate-set-field
if GetResourceState('es_extended') ~= 'started' then return end
local ESX = exports['es_extended']:getSharedObject()

Framework = {}

Framework.getDetected = function()
    return 'es_extended'
end

Framework.getPlayerIdentifier = function(src)
    return ESX.GetIdentifier(src)
end

Framework.getPlayerName = function(src)
    local xPlayer = ESX.GetPlayerFromId(src)
    return xPlayer and {
        first = xPlayer.variables.firstName,
        last = xPlayer.variables.lastName
    }
end

Framework.getPlayerJob = function(src)
    local xPlayer = ESX.GetPlayerFromId(src)
    local job = xPlayer and xPlayer.getJob()
    return job and {
        name = job.name,
        label = job.label,
        grade = job.grade,
        gradeLabel = job.grade_label
    }
end

Framework.getPlayerMetadata = function(src, key)
    local xPlayer = ESX.GetPlayerFromId(src)
    return xPlayer and xPlayer.getMeta(key)
end

Framework.setPlayerMetadata = function(src, key, value)
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer then
        xPlayer.setMeta(key, value)
    end
end

Framework.getBalance = function(src, account)
    if account == 'cash' then account = 'money' end
    local xPlayer = ESX.GetPlayerFromId(src)
    return xPlayer and xPlayer.getAccount(account).money
end

Framework.addBalance = function(src, account, amount)
    if account == 'cash' then account = 'money' end
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer then
        xPlayer.addAccountMoney(account, amount)
    end
end

Framework.removeBalance = function(src, account, amount)
    if account == 'cash' then account = 'money' end
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer then
        xPlayer.removeAccountMoney(account, amount)
    end
end

Framework.addSocietyBalance = function(society, amount)
    society = exports['esx_society']:GetSociety(society)
    if society then
        TriggerEvent('esx_addonaccount:getSharedAccount', society.account, function(account)
            account.addMoney(amount)
        end)
    end
end

Framework.removeSocietyBalance = function(society, amount)
    society = exports['esx_society']:GetSociety(society)
    if society then
        TriggerEvent('esx_addonaccount:getSharedAccount', society.account, function(account)
            account.removeMoney(amount)
        end)
    end
end

Framework.registerUsableItem = function(item, cb)
    if item and cb then
        ESX.RegisterUsableItem(item, cb)
    end
end
