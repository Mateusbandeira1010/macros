local idz = {2644, 3043} 
macro(100, "Coletar itens do chão", function()
local z = posz()
for _, tile in ipairs(g_map.getTiles(z)) do
    if z ~= posz() then return end
        if getDistanceBetween(pos(), tile:getPosition()) <= 10 then
            if table.find(idz, tile:getTopLookThing():getId()) then
                g_game.move(tile:getTopLookThing(), {x = 65535, y=SlotBack, z=0}, tile:getTopLookThing():getCount())
            end
        end
    end
end)