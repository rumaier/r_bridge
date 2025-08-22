---@diagnostic disable: duplicate-set-field
if GetResourceState('qb-core') ~= 'started' or GetResourceState('qbx_core') == 'started' then return end

Core.Framework = {}
Core.Framework.Current = 'qb-core'

local QBCore = exports['qb-core']:GetCoreObject()

Core.Framework.getPlayerIdentifier = function(src)
    local playerData = QBCore.Functions.GetPlayer(src).PlayerData
    if not playerData then return end
    local identifier = playerData.citizenid
    return identifier
end

Core.Framework.getPlayerCharacterName = function(src)
    local playerData = QBCore.Functions.GetPlayer(src).PlayerData
    if not playerData then return end
    local firstName = playerData.charinfo.firstname or ''
    local lastName = playerData.charinfo.lastname or ''
    return { first = firstName, last = lastName }
end

Core.Framework.getPlayerJob = function(src)
    local playerData = QBCore.Functions.GetPlayer(src).PlayerData
    if not playerData then return end
    local job = playerData.job
    return { name = job.name, label = job.label, grade = job.grade.level, gradeLabel = job.grade.name }
end

Core.Framework.getPlayerMetadata = function(src, meta)
    local playerData = QBCore.Functions.GetPlayer(src).PlayerData
    if not playerData then return end
    local metadata = playerData.metadata[meta]
    return metadata
end

Core.Framework.setPlayerMetadata = function(src, meta, value)
    local player = QBCore.Functions.GetPlayer(src)
    if not player then return end
    player.Functions.SetMeta(meta, value)
end

Core.Framework.getAccountBalance = function(src, account)
    local playerData = QBCore.Functions.GetPlayer(src).PlayerData
    if not playerData then return end
    if account == 'money' then account = 'cash' end
    local balance = playerData.money[account]
    return balance
end

Core.Framework.addAccountBalance = function(src, account, amount)
    local player = QBCore.Functions.GetPlayer(src)
    if not player then return end
    if account == 'money' then account = 'cash' end
    player.Functions.AddMoney(account, amount)
end

Core.Framework.removeAccountBalance = function(src, account, amount)
    local player = QBCore.Functions.GetPlayer(src)
    if not player then return end
    if account == 'money' then account = 'cash' end
    player.Functions.RemoveMoney(account, amount)
end

Core.Framework.addSocietyBalance = function(job, amount)
    local society = exports['qb-banking']:GetAccount(job)
    if not society then return end
    exports['qb-banking']:AddMoney(society, amount, '')
end

Core.Framework.removeSocietyBalance = function(job, amount)
    local society = exports['qb-banking']:GetAccount(job)
    if not society then return end
    exports['qb-banking']:RemoveMoney(society, amount, '')
end

Core.Framework.registerUsableItem = function(item, cb)
    if not item or not cb then return end
    QBCore.Functions.CreateUseableItem(item, cb)
end