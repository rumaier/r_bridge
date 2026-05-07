Interface = Interface or {}

Interface.skillCheck = function(difficulty, inputs)
    return lib.skillCheck(difficulty, inputs)
end

Interface.cancelSkillCheck = function()
    lib.cancelSkillCheck()
end