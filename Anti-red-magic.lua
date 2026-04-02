setDefaultTab("Target")
local distance = 1
local amountOfMonsters = 2
macro(1000, "ATK Safe",  function()
    local isSafe = true
    local specAmount = 0
    if not g_game.isAttacking() then
        return
    end
for i,mob in ipairs(getSpectators()) do
        if (getDistanceBetween(player:getPosition(), mob:getPosition()) <= distance and mob:isMonster()) then
            specAmount = specAmount + 1
        end
        if (mob:isPlayer() and (player:getName() ~= mob:getName()) and g_game.isAttacking (storage.Spell1)) then
            isSafe = false
        end
    end
    if (specAmount >= amountOfMonsters) and isSafe then
        say(storage.Spell2, 1000)
    else
        say(storage.Spell1, 1000)
    end
end)
addTextEdit("Spell1", storage.Spell1 or "Single target", function(widget, text) 
storage.Spell1 = text
end)
addTextEdit("Spell2", storage.Spell2 or "Multi target", function(widget, text) 
storage.Spell2 = text
end)