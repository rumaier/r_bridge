if GetResourceState('qb-core') ~= 'started' then return end
if GetResourceState('qbx_core') == 'started' then return end

Core.Info.Framework = 'QBCore'
local QBCore = exports['qb-core']:GetCoreObject()

Core.Framework = {}

function Core.Framework.Notify(src, message, type)
    local src = src or source
    local resource = Cfg.Notification
    if resource == 'default' then
        TriggerClientEvent('QBCore:Notify', src, message, type)
    elseif resource == 'ox' then
        TriggerClientEvent('ox_lib:notify', src, { description = message, type = type, position = 'top' })
    elseif resource == 'custom' then
        -- insert your notification export here
    end
end

function Core.Framework.GetPlayerIdentifier(src)
    local src = src or source
    local playerData = QBCore.Functions.GetPlayer(src).PlayerData
    if not playerData then return end
    return playerData.citizenid
end

function Core.Framework.GetPlayerName(src)
    local src = src or source
    local playerData = QBCore.Functions.GetPlayer(src).PlayerData
    if not playerData then return end
    return playerData.charinfo.firstname, playerData.charinfo.lastname
end

function Core.Framework.GetPlayerJob(src)
    local src = src or source
    local playerData = QBCore.Functions.GetPlayer(src).PlayerData
    if not playerData then return end
    return playerData.job.name, playerData.job.label
end

function Core.Framework.GetPlayerJobGrade(src)
    local src = src or source
    local playerData = QBCore.Functions.GetPlayer(src).PlayerData
    if not playerData then return end
    return playerData.job.grade.level, playerData.job.grade.name
end

function Core.Framework.GetAccountBalance(src, account)
    local src = src or source
    local playerData = QBCore.Functions.GetPlayer(src).PlayerData
    if not playerData then return end
    if account == 'money' then account = 'cash' end
    return playerData.money[account]
end

function Core.Framework.AddAccountBalance(src, account, amount)
    local src = src or source
    local player = QBCore.Functions.GetPlayer(src)
    if not player then return end
    if account == 'money' then account = 'cash' end
    player.Functions.AddMoney(account, amount)
end

function Core.Framework.RemoveAccountBalance(src, account, amount)
    local src = src or source
    local player = QBCore.Functions.GetPlayer(src)
    if not player then return end
    if account == 'money' then account = 'cash' end
    player.Functions.RemoveMoney(account, amount)
end

function Core.Framework.SetPlayerMetadata(src, meta, value)
    local player = QBCore.Functions.GetPlayer(src)
    if not player then return end
    player.Functions.SetMetaData(meta, value)
end

function Core.Framework.GetPlayerMetadata(src, meta)
    local player = QBCore.Functions.GetPlayer(src)
    if not player then return end
    return player.PlayerData.metadata[meta] or nil
end

function Core.Framework.AddSocietyBalance(job, amount)
    local society = exports['qb-banking']:GetAccount(job)
    if not society then return end
    exports['qb-banking']:AddMoney(job, amount, 'cause qb')
end

function Core.Framework.RemoveSocietyBalance(job, amount)
    local society = exports['qb-banking']:GetAccount(job)
    if not society then return end
    exports['qb-banking']:RemoveMoney(job, amount, 'cause qb')
end

function Core.Framework.RegisterUsableItem(item, cb)
    QBCore.Functions.CreateUseableItem(item, cb)
end
