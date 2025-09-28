---@diagnostic disable: duplicate-set-field
if GetResourceState('qb-target') ~= 'started' or GetResourceState('ox_target') == 'started' then return end

Core.Target = {}
Core.Target.Current = 'qb-target'