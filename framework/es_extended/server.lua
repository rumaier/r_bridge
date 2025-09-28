---@diagnostic disable: duplicate-set-field
if GetResourceState('es_extended') ~= 'started' then return end

Core.Framework = {}
Core.Framework.Current = 'es_extended'

local ESX = exports['es_extended']:getSharedObject()

Core.Framework.getPlayerIdentifier = function(src)
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return end
    local identifier = xPlayer.getIdentifier()
    return identifier
end

Core.Framework.getPlayerCharacterName = function(src)
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return end
    local firstName = xPlayer.variables.firstName or ''
    local lastName = xPlayer.variables.lastName or ''
    return { first = firstName, last = lastName }
end

Core.Framework.getPlayerJob = function(src)
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return end
    local job = xPlayer.getJob()
    return { name = job.name, label = job.label, grade = job.grade, gradeLabel = job.grade_label }
end

Core.Framework.getPlayerMetadata = function(src, meta)
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return end
    local metadata = xPlayer.getMeta(meta)
    return metadata
end

Core.Framework.setPlayerMetadata = function(src, meta, value)
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return end
    xPlayer.setMeta(meta, value)
end

Core.Framework.getAccountBalance = function(src, account)
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return end
    if account == 'cash' then account = 'money' end
    local balance = xPlayer.getAccount(account).money
    return balance
end

Core.Framework.addAccountBalance = function(src, account, amount)
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return end
    if account == 'cash' then account = 'money' end
    xPlayer.addAccountMoney(account, amount)
end

Core.Framework.removeAccountBalance = function(src, account, amount)
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return end
    if account == 'cash' then account = 'money' end
    xPlayer.removeAccountMoney(account, amount)
end

Core.Framework.addSocietyBalance = function(job, amount)
    local society = exports['esx_society']:GetSociety(job)
    if not society then return end
    TriggerEvent('esx_addonaccount:getSharedAccount', society.account, function(account)
        account.addMoney(amount)
    end)
end

Core.Framework.removeSocietyBalance = function(job, amount)
    local society = exports['esx_society']:GetSociety(job)
    if not society then return end
    TriggerEvent('esx_addonaccount:getSharedAccount', society.account, function(account)
        account.removeMoney(amount)
    end)
end

Core.Framework.registerUsableItem = function(item, cb)
    if not item or not cb then return end
    ESX.RegisterUsableItem(item, cb)
end
