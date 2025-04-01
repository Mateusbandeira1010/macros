Follow = macro(1000,"Follow",function()

    nome = storage.followLeader
    end)
    
    UI.Label("Follow Player:")
    addTextEdit("playerToFollow", storage.followLeader or "Blitzzone", function(widget, text)
        storage.followLeader = text
        target = tostring(text)
    end)
    
    nome = storage.followLeader
    pos_p = player:getPosition()
    
    p = getCreatureByName(nome)
    
    onCreaturePositionChange(function(creature, newPos, oldPos)
        if Follow.isOn() then
        
            if creature:getName()==player:getName() and getCreatureByName(nome) == nil and newPos.z>oldPos.z then
            
                say('exani tera')
                for i = -1,1 do
                  for j = -1,1 do
                
                    local useTile = g_map.getTile({x=posx()+i,y=posy()+j,z=posz()})
                     g_game.use(useTile:getTopUseThing())
                    
                
                  end
                end
            end
            if creature:getName()==nome then
              
                
                if newPos==nil then
                    
                    
                    lastPos = oldPos
                    
                    schedule(200,function()
                     autoWalk(oldPos)
                    end)
                    
                    schedule(1000,function()
                        for i = -1,1 do
                          for j = -1,1 do
                        
                            local useTile = g_map.getTile({x=posx()+i,y=posy()+j,z=posz()})
                            g_game.use(useTile:getTopUseThing())
                            
                        
                          end
                        end
                    end)
                
                
                end
                
                if oldPos.z == newPos.z then
                         
                    schedule(300,function()
                     local useTile = g_map.getTile({x=oldPos.x,y=oldPos.y,z=oldPos.z})
                     topThing = useTile:getTopThing()
                     
                     if not useTile:isWalkable() then
                       use(topThing)
                     end
                    
                    end)
                
                
                    autoWalk({x=oldPos.x,y=oldPos.y,z=oldPos.z})
                else
                
                    lastPos = oldPos
                    autoWalk(oldPos)
                    for i = 1,6 do
                        schedule(i*200,function()
                          autoWalk(oldPos)
                        
                          if getDistanceBetween(pos(), oldPos) == 0 and (posz()>newPos.z and getCreatureByName(nome) == nil) then
                            say('exani tera')
                          end
                        end)
                    end
                    local useTile = g_map.getTile({x=newPos.x,y=newPos.y-1,z=oldPos.z})
                     g_game.use(useTile:getTopUseThing())
                                
                
                end
              
            
            end
        
        end
    end)
    
    
    
    local m = macro(1000, "Enable combo", function() end)
    UI.Label("Leader:"):setColor("#c934eb")
    addTextEdit("leader", storage.comboLeader or "Player name", function(widget, text)
        storage.comboLeader = text
    end)
    UI.Label("Rune ID:"):setColor("#5beb34")
    addTextEdit("attack", storage.comboAttack or "3155", function(widget, text)
        storage.comboAttack = text
    end)
    addSeparator()
    
    onMissle(function(missle)
        if m.isOff() then return end
        local src = missle:getSource()
        if src.z ~= posz() then return end
    
        local from = g_map.getTile(src)
        local to = g_map.getTile(missle:getDestination())
        if not from or not to then return end
    
        local fromCreatures = from:getCreatures()
        local toCreatures = to:getCreatures()
        if #fromCreatures ~= 1 or #toCreatures ~= 1 then
            return
        end
    
        local c1 = fromCreatures[1]
        local t1 = toCreatures[1]
        if c1:getName():lower() == storage.comboLeader:lower() then
            useWith(tonumber(storage.comboAttack), t1)
            g_game.attack(t1)
        end
    end)