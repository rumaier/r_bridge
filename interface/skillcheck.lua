Core.Interface = Core.Interface or {}

Core.Interface.skillCheck = function(difficuly, inputs)
    local skillCheck = lib.skillCheck(difficuly, inputs)
    return skillCheck
end

Core.Interface.cancelSkillCheck = function()
    lib.cancelSkillCheck()
end