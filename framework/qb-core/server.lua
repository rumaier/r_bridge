---@diagnostic disable: duplicate-set-field
if GetResourceState('qb-core') ~= 'started' then return end
if GetResourceState('qbx_core') == 'started' then return end

Core.Framework = {}
Core.Framework.Current = 'qb-core'

local QBCore = exports['qb-core']:GetCoreObject()

Core.Framework.GetPlayerIdentifier = function(src)
    local playerData = QBCore.Functions.GetPlayer(src).PlayerData
    if not playerData then return end
    local identifier = playerData.citizenid
    return identifier
end

Core.Framework.GetPlayerCharacterName = function(src)
    local playerData = QBCore.Functions.GetPlayer(src).PlayerData
    if not playerData then return end
    local firstName = playerData.charinfo.firstname or ''
    local lastName = playerData.charinfo.lastname or ''
    return { first = firstName, last = lastName }
end

Core.Framework.GetPlayerJob = function(src)
    local playerData = QBCore.Functions.GetPlayer(src).PlayerData
    if not playerData then return end
    local job = playerData.job
    return { name = job.name, label = job.label, grade = job.grade.level, gradeLabel = job.grade.name }
end

Core.Framework.GetPlayerMetadata = function(src, meta)
    local playerData = QBCore.Functions.GetPlayer(src).PlayerData
    if not playerData then return end
    local metadata = playerData.metadata[meta]
    return metadata
end

Core.Framework.SetPlayerMetadata = function(src, meta, value)
    local player = QBCore.Functions.GetPlayer(src)
    if not player then return end
    player.Functions.SetMeta(meta, value)
end

Core.Framework.GetAccountBalance = function(src, account)
    local playerData = QBCore.Functions.GetPlayer(src).PlayerData
    if not playerData then return end
    if account == 'money' then account = 'cash' end
    local balance = playerData.money[account]
    return balance
end

Core.Framework.AddAccountBalance = function(src, account, amount)
    local player = QBCore.Functions.GetPlayer(src)
    if not player then return end
    if account == 'money' then account = 'cash' end
    player.Functions.AddMoney(account, amount)
end

Core.Framework.RemoveAccountBalance = function(src, account, amount)
    local player = QBCore.Functions.GetPlayer(src)
    if not player then return end
    if account == 'money' then account = 'cash' end
    player.Functions.RemoveMoney(account, amount)
end

Core.Framework.AddSocietyBalance = function(job, amount)
    local society = exports['qb-banking']:GetAccount(job)
    if not society then return end
    exports['qb-banking']:AddMoney(society, amount, '')
end

Core.Framework.RemoveSocietyBalance = function(job, amount)
    local society = exports['qb-banking']:GetAccount(job)
    if not society then return end
    exports['qb-banking']:RemoveMoney(society, amount, '')
end

Core.Framework.RegisterUsableItem = function(item, cb)
    if not item or not cb then return end
    QBCore.Functions.CreateUseableItem(item, cb)
end