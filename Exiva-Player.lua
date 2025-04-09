macro(50, "Exiva Last", function(m)
    if not lastTargetName then return end
    
    if now > nextSay then
      say(storage.ExivaSpell..' "'..lastTargetName)
      nextSay = now + storage.ExivaDelay
    end
    
    schedule(50, function()
      if m.isOff() then
        lastTargetName = nil
      end
    end)
  end)
  
  onAttackingCreatureChange(function(creature, oldCreature)
    if creature and creature:isPlayer() then
      lastTargetName = creature:getName()
    end
  end)