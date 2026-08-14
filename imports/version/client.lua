---@diagnostic disable: undefined-global

local Version = {}

Version.current = GetResourceMetadata('r_bridge', 'version', 0)

return Version
