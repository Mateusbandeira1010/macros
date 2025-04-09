macro(200, "Auto Attack Fixo", function()
    local target = g_game.getAttackingCreature()
  
    if target and target:getHealthPercent() > 0 then
      return
    end

    for _, spec in ipairs(getSpectators()) do
      if spec:isCreature() and not spec:isPlayer() and spec:getHealthPercent() > 0 then
        g_game.attack(spec)
        break
      end
    end
  end)