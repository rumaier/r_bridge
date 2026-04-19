---@diagnostic disable: duplicate-set-field
if GetResourceState('ox_target') ~= 'started' then return end

Core.Target = {}
Core.Target.Current = 'ox_target'