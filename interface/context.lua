Core.Interface = Core.Interface or {}

Core.Interface.registerContext = function(data)
    -- data follows the ox_lib format
    
    lib.registerContext(data)
end

Core.Interface.showContext = function(id)
    lib.showContext(id)
end

Core.Interface.hideContext = function()
    lib.hideContext()
end