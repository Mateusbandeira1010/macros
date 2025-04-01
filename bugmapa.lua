local function checkPos(x, y)
    xyz = g_game.getLocalPlayer():getPosition()
    xyz.x = xyz.x + x
    xyz.y = xyz.y + y
    tile = g_map.getTile(xyz)
    if tile then
        return g_game.use(tile:getTopUseThing())  
    else
        return false
    end
end

consoleModule = modules.game_console
macro(200, 'Bug Map', function() 
    -- Remove delay entre as ações
    if modules.corelib.g_keyboard.isKeyPressed('w') and not consoleModule:isChatEnabled() then
        checkPos(0, -90) -- Passo muito maior para frente
    elseif modules.corelib.g_keyboard.isKeyPressed('e') and not consoleModule:isChatEnabled() then
        checkPos(90, -100) -- Passo maior diagonal
    elseif modules.corelib.g_keyboard.isKeyPressed('d') and not consoleModule:isChatEnabled() then
        checkPos(90, 0) -- Passo ainda mais largo para a direita
    elseif modules.corelib.g_keyboard.isKeyPressed('c') and not consoleModule:isChatEnabled() then
        checkPos(0, 90) -- Passo maior diagonal
    elseif modules.corelib.g_keyboard.isKeyPressed('s') and not consoleModule:isChatEnabled() then
        checkPos(0, 90) -- Passo muito maior para trás
    elseif modules.corelib.g_keyboard.isKeyPressed('z') and not consoleModule:isChatEnabled() then
        checkPos(0, 90) -- Passo maior diagonal
    elseif modules.corelib.g_keyboard.isKeyPressed('a') and not consoleModule:isChatEnabled() then
        checkPos(0, 90) -- Passo mais largo para a esquerda
    elseif modules.corelib.g_keyboard.isKeyPressed('q') and not consoleModule:isChatEnabled() then
        checkPos(0, -90) -- Passo maior diagonal
    end
end)