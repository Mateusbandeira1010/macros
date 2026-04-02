local SD_ID = 3155

macro(200, "Auto SD", function()
    if not g_game.isAttacking() then return end

    local target = g_game.getAttackingCreature()
    if not target then return end

    useWith(SD_ID, target)
end)