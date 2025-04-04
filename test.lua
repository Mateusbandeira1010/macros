local ATTACK_SPEED = 100 macro() 
local currentTarget = nil
local isAttacking = false


onKeyDown(function(key)
    if key == "F2" then
        
        local tile = g_map.getTile(getCursorPosition())
        if tile then
            currentTarget = tile:getTopCreature()
        end
        
        
        isAttacking = true
        scheduleEvent(function()
            if isAttacking and currentTarget and not currentTarget:isDead() then
                g_game.attack(currentTarget)
                return true 
            end
            return false 
        end, ATTACK_SPEED)
    end
end)


onKeyUp(function(key)
    if key == "F2" then
        isAttacking = false
    end
end)


UI.Label("Hotkey de Ataque Rápido:"):setColor("#00FF00")
UI.Label("Pressione F2 para atacar rápido"):setColor("#FFFFFF")