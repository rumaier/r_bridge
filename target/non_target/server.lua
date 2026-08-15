---@diagnostic disable: duplicate-set-field

local hasTarget = GetResourceState('ox_target') == 'started' or GetResourceState('qb-target') == 'started'

if hasTarget then
    return
end

Core.Target = Core.Target or {}
Core.Target.Current = 'non_target'