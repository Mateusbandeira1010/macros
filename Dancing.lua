
local directions = {0, 1, 2, 3}
local currentIndex = 1

local m_example = macro(1, function(m)
    turn(directions[currentIndex])
    currentIndex = currentIndex + 1
    if currentIndex > #directions then currentIndex = 1 end
end)

addIcon("exampleIcon", {item={id=2526, count=1}, text="Dancing"}, m_example)