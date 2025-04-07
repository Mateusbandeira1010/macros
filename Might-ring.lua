local amuletID =  3081
local mightID = 3048
local belowHealamulet = 100
local belowHealring = 100

local ssa = macro(200, "MACRO SSA/MIGHT RING ", function()
  if hppercent() <= belowHealamulet then
    if getNeck() == nil or (getNeck():getId() ~= amuletID and getNeck():getId() ~= 9302) then
      g_game.equipItemId(amuletID)
    end
    if hppercent() <= belowHealring then
      if getFinger() == nil or getFinger():getId() ~= mightID then
        g_game.equipItemId(mightID)
      end
    end
  end
end)