local ring = {ringequip = 3007, hpequip = 70, ringunequip = 3051, hpunequip = 50}

macro(200, "Energy Ring: Equip", function()
    local id
    if hppercent() >= ring.hpequip then
        id = ring.ringequip
    elseif hppercent() <= ring.hpunequip then
        id = ring.ringunequip
    end
    
    if id then
        if not getFinger() or getFinger():getId() ~= id then
            moveToSlot(id, SlotFinger) 
        end
    end
end)