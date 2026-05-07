---@diagnostic disable: duplicate-set-field
if GetResourceState('qbx_core') ~= 'started' then return end
local QBX = exports.qbx_core

Framework = {}

Framework.getDetected = function()
    return 'qbx_core'
end

Framework.getPlayerIdentifier = function(src)
    local player = QBX:GetPlayer(src)
    return player and player.PlayerData.citizenid
end

Framework.getPlayerName = function(src)
    local player = QBX:GetPlayer(src)
    return player and {
        first = player.PlayerData.charinfo.firstname,
        last = player.PlayerData.charinfo.lastname,
    }
end

Framework.getPlayerJob = function(src)
    local player = QBX:GetPlayer(src)
    local job = player and player.PlayerData.job
    return job and {
        name = job.name,
        label = job.label,
        grade = job.grade.level,
        gradeLabel = job.grade.name
    }
end

Framework.getPlayerMetadata = function(src, key)
    local player = QBX:GetPlayer(src)
    return player and player.PlayerData.metadata[key]
end

Framework.setPlayerMetadata = function(src, key, value)
    local player = QBX:GetPlayer(src)
    if player then
        player.Functions.SetMetaData(key, value)
    end
end

Framework.getBalance = function(src, account)
    if account == 'money' then account = 'cash' end
    local player = QBX:GetPlayer(src)
    return player and player.PlayerData.money[account]
end

Framework.addBalance = function(src, account, amount)
    if account == 'money' then account = 'cash' end
    local player = QBX:GetPlayer(src)
    if player then
        player.Functions.AddMoney(account, amount)
    end
end

Framework.removeBalance = function(src, account, amount)
    if account == 'money' then account = 'cash' end
    local player = QBX:GetPlayer(src)
    if player then
        player.Functions.RemoveMoney(account, amount)
    end
end

Framework.addSocietyBalance = function(society, amount)
    local society = exports['Renewed-Banking']:getAccountMoney(society)
    if society then
        exports['Renewed-Banking']:addAccountMoney(society, amount)
    end
end

Framework.removeSocietyBalance = function(society, amount)
    local society = exports['Renewed-Banking']:getAccountMoney(society)
    if society then
        exports['Renewed-Banking']:removeAccountMoney(society, amount)
    end
end

Framework.registerUsableItem = function(item, cb)
    if item and cb then
        QBX:CreateUseableItem(item, cb)
    end
end
