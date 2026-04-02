local mnparar = 50 -- porcentagem de mana que vai desativar
local mnvoltar = 70 -- porcentagem de mana que vai ativar

macro(10, "parar cavebot % mana", function()
     if (manapercent() <= mnparar) then
        CaveBot.setOff()
    elseif (manapercent() >= mnvoltar) then
        CaveBot.setOn()
    end
end)