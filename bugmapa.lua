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
    if modules.corelib.g_keyboard.isKeyPressed('w') and not consoleModule:isChatEnabled() then
        checkPos(0, -90) 
    elseif modules.corelib.g_keyboard.isKeyPressed('e') and not consoleModule:isChatEnabled() then
        checkPos(90, -100) 
    elseif modules.corelib.g_keyboard.isKeyPressed('d') and not consoleModule:isChatEnabled() then
        checkPos(90, 0) 
    elseif modules.corelib.g_keyboard.isKeyPressed('c') and not consoleModule:isChatEnabled() then
        checkPos(0, 90) 
    elseif modules.corelib.g_keyboard.isKeyPressed('s') and not consoleModule:isChatEnabled() then
        checkPos(0, 90) 
    elseif modules.corelib.g_keyboard.isKeyPressed('z') and not consoleModule:isChatEnabled() then
        checkPos(0, 90) 
    elseif modules.corelib.g_keyboard.isKeyPressed('a') and not consoleModule:isChatEnabled() then
        checkPos(0, 90) 
    elseif modules.corelib.g_keyboard.isKeyPressed('q') and not consoleModule:isChatEnabled() then
        checkPos(0, -90) 
    end
end)