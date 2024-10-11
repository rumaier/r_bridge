if GetResourceState('es_extended') ~= 'started' then return end

Core.Info.Framework = 'ESX'
local ESX = exports["es_extended"]:getSharedObject()

Core.Framework = {}

---@param src number
---@param message string
---@param type string
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

---@param src number
---@return string | nil
function Core.Framework.GetPlayerIdentifier(src)
    local src = src or source
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return end
    return xPlayer.getIdentifier()
end

---@param src number
---@return string, string
function Core.Framework.GetPlayerJob(src)
    local src = src or source
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return end
    return xPlayer.getJob().name, xPlayer.getJob().label
end

---@param src number
---@return number, string
function Core.Framework.GetPlayerJobGrade(src)
    local src = src or source
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return end
    return xPlayer.getJob().grade, xPlayer.getJob().grade_label
end

---@param src number
---@param account string
---@return number
function Core.Framework.GetAccountBalance(src, account)
    local src = src or source
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return end
    return xPlayer.getAccount(account).money
end

---@param src number
---@param account string
---@param amount number
function Core.Framework.AddAccountBalance(src, account, amount)
    local src = src or source
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return end
    xPlayer.addAccountMoney(account, amount)
end

---@param src number
---@param account string
---@param amount number
function Core.Framework.RemoveAccountBalance(src, account, amount)
    local src = src or source
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return end
    xPlayer.removeAccountMoney(account, amount)
end

---@param item string
---@param cb function
function Core.Framework.RegisterUsableItem(item, cb)
    ESX.RegisterUsableItem(item, cb)
end
