setDefaultTab("HP")
local m_antiExausted = macro(10000, "Anti-Exausted", function() end)


macro(120000, "Comer (Brown Mush)", function()
  use(3725)
  delay(120000)
end)

macro(500, "Auto Haste", nil, function()
    if not hasHaste() and storage.autoHasteText:len() > 0 then
      if saySpell(storage.autoHasteText) then
        delay(5000)
      end
    end
  end)
  addTextEdit("autoHasteText", storage.autoHasteText or "utani gran hur", function(widget, text) 
    storage.autoHasteText = text
end)

addLabel("texto", "->  MAGIA DE CURA  <-"):setColor("#DFFF00")
  
if type(storage.healingVar1) ~= "table" then
  storage.healingVar1 = {on=false, title="HP%", text="exura", min=0, max=70}
end
if type(storage.healingVar2) ~= "table" then
  storage.healingVar2 = {on=false, title="HP%", text="exura vita", min=0, max=90}
end

-- create 2 healing widgets
for _, healingInfo in ipairs({storage.healingVar1, storage.healingVar2}) do
  local healingMacroVar1 = macro(20, function()
    local hp = player:getHealthPercent()
    if healingInfo.max >= hp and hp >= healingInfo.min then
      if TargetBot then 
        TargetBot.saySpell(healingInfo.text) -- sync spell with targetbot if available
      else
        say(healingInfo.text)
      end
    end
  end)
  healingMacroVar1.setOn(healingInfo.on)

  UI.DualScrollPanel(healingInfo, function(widget, newParams) 
    healingInfo = newParams
    healingMacroVar1.setOn(healingInfo.on)
  end)
end







setDefaultTab("HP")
addLabel("texto", " ")
UI.Separator()
-- XX -- Heal e Haste
addLabel("texto", "->  ITENS DE CURA  <-"):setColor("#DFFF00")

if type(storage.hpitem1) ~= "table" then
    storage.hpitem1 = {on=false, title="HP%", item=3160, min=0, max=90}
end
if type(storage.hpitem2) ~= "table" then
    storage.hpitem2 = {on=false, title="HP%", item=3160, min=0, max=90}
end
if type(storage.manaitem1) ~= "table" then
    storage.manaitem1 = {on=false, title="MP%", item=23373, min=0, max=50}
end
if type(storage.manaitem2) ~= "table" then
    storage.manaitem2 = {on=false, title="MP%", item=238, min=0, max=60}
end

for i, healingInfo2 in ipairs({storage.hpitem1, storage.hpitem2, storage.manaitem1, storage.manaitem2}) do
    local healingmacro2 = macro(20, function()
        local hp = i <= 2 and player:getHealthPercent() or math.min(100, math.floor(100 * (player:getMana() / player:getMaxMana())))
        if healingInfo2.max >= hp and hp >= healingInfo2.min then
            if TargetBot then 
                TargetBot.useItem(healingInfo2.item, healingInfo2.subType, player) -- sync spell with targetbot if available
            else
                local thing = g_things.getThingType(healingInfo2.item)
                local subType = g_game.getClientVersion() >= 860 and 0 or 1
                if thing and thing:isFluidContainer() then
                    subType = healingInfo2.subType
                end
                g_game.useInventoryItemWith(healingInfo2.item, player, subType)
            end
        end
    end)
    healingmacro2.setOn(healingInfo2.on)
  
    UI.DualScrollItemPanel(healingInfo2, function(widget, newParams) 
        healingInfo2 = newParams
        healingmacro2.setOn(healingInfo2.on and healingInfo2.item > 100)
    end)
end
  
if g_game.getClientVersion() < 780 then
    UI.Label("In old tibia potions & runes work only when you have backpack with them opened")
end

-- Auto Stamina Up
function staminaItems(parent)
  if not parent then
    parent = panel
  end
  local panelName = "staminaItemsUser"
  local ui = setupUI([[
Panel
  height: 65
  margin-top: 2
  SmallBotSwitch
    id: title
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.top: parent.top
    text-align: center
  HorizontalScrollBar
    id: scroll1
    anchors.left: parent.left
    anchors.right: parent.horizontalCenter
    anchors.top: title.bottom
    margin-right: 2
    margin-top: 2
    minimum: 0
    maximum: 42
    step: 1
  HorizontalScrollBar
    id: scroll2
    anchors.left: parent.horizontalCenter
    anchors.right: parent.right
    anchors.top: prev.top
    margin-left: 2
    minimum: 0
    maximum: 42
    step: 1    
  ItemsRow
    id: items
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.top: prev.bottom
  ]], parent)
  ui:setId(panelName)
  if not storage[panelName] then
    storage[panelName] = {
      min = 0,
      max = 40,
    }
  end
  local updateText = function()
    ui.title:setText("" .. storage[panelName].min .. " <= Stamina <= " .. storage[panelName].max .. "")  
  end
  ui.scroll1.onValueChange = function(scroll, value)
    storage[panelName].min = value
    updateText()
  end
  ui.scroll2.onValueChange = function(scroll, value)
    storage[panelName].max = value
    updateText()
  end
  ui.scroll1:setValue(storage[panelName].min)
  ui.scroll2:setValue(storage[panelName].max)
 
  ui.title:setOn(storage[panelName].enabled)
  ui.title.onClick = function(widget)
    storage[panelName].enabled = not storage[panelName].enabled
    widget:setOn(storage[panelName].enabled)
  end
  if type(storage[panelName].items) ~= 'table' then
    storage[panelName].items = { 11588 }
  end
  for i=1,5 do
    ui.items:getChildByIndex(i).onItemChange = function(widget)
      storage[panelName].items[i] = widget:getItemId()
    end
    ui.items:getChildByIndex(i):setItemId(storage[panelName].items[i])    
  end
  macro(500, function()
    if not storage[panelName].enabled or stamina() / 60 < storage[panelName].min or stamina() / 60 > storage[panelName].max then
      return
    end
    local candidates = {}
    for i, item in pairs(storage[panelName].items) do
      if item >= 100 then
        table.insert(candidates, item)
      end
    end
    if #candidates == 0 then
      return
    end    
    use(candidates[math.random(1, #candidates)])
  end)
end
staminaItems(toolsTab)
UI.Separator()