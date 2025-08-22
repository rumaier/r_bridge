---@diagnostic disable: duplicate-set-field
if GetResourceState('qbx_core') ~= 'started' then return end

Core.Framework = {}
Core.Framework.Current = 'qbx_core'

local QBX = exports.qbx_core

Core.Framework.GetPlayerIdentifier = function(src)
    local player = QBX.Functions.GetPlayer(src)
    if not player then return end
    local identifier = player.PlayerData.citizenid
    return identifier
end

Core.Framework.GetPlayerCharacterName = function(src)
    local player = QBX:GetPlayer(src)
    if not player then return end
    local playerData = player.PlayerData
    local firstName = playerData.charinfo.firstname or ''
    local lastName = playerData.charinfo.lastname or ''
    return { first = firstName, last = lastName }
end

Core.Framework.GetPlayerJob = function(src)
    local player = QBX.Functions.GetPlayer(src)
    if not player then return end
    local playerData = player.PlayerData
    local job = playerData.job
    return { name = job.name, label = job.label, grade = job.grade.level, gradeLabel = job.grade.name }
end

Core.Framework.GetPlayerMetadata = function(src, meta)
    local player = QBX.Functions.GetPlayer(src)
    if not player then return end
    local playerData = player.PlayerData
    local metadata = playerData.metadata[meta]
    return metadata
end

Core.Framework.SetPlayerMetadata = function(src, meta, value)
    local player = QBX.Functions.GetPlayer(src)
    if not player then return end
    player.Functions.SetMeta(meta, value)
end

Core.Framework.GetAccountBalance = function(src, account)
    local player = QBX.Functions.GetPlayer(src)
    if not player then return end
    local playerData = player.PlayerData
    if account == 'money' then account = 'cash' end
    local balance = playerData.money[account]
    return balance
end

Core.Framework.AddAccountBalance = function(src, account, amount)
    local player = QBX.Functions.GetPlayer(src)
    if not player then return end
    if account == 'money' then account = 'cash' end
    player.Functions.AddMoney(account, amount)
end

Core.Framework.RemoveAccountBalance = function(src, account, amount)
    local player = QBX.Functions.GetPlayer(src)
    if not player then return end
    if account == 'money' then account = 'cash' end
    player.Functions.RemoveMoney(account, amount)
end

Core.Framework.AddSocietyBalance = function(job, amount)
    local society = exports['Renewed-Banking']:getAccountMoney(job)
    if not society then return end
    exports['Renewed-Banking']:addAccountMoney(job, amount)
end

Core.Framework.RemoveSocietyBalance = function(job, amount)
    local society = exports['Renewed-Banking']:getAccountMoney(job)
    if not society then return end
    exports['Renewed-Banking']:removeAccountMoney(job, amount)
end

Core.Framework.RegisterUsableItem = function(item, cb)
    if not item or not cb then return end
    QBX:CreateUseableItem(item, cb)
end