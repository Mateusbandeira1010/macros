

setDefaultTab("Macros")

addLabel("texto", " ")
addLabel("texto", "-> MACROS <-"):setColor("#DFFF00")
macro(1000, "Main BP Open", function()
    bpItem = getBack()
    bp = getContainer(0)

    if not bp and bpItem ~= nil then
        g_game.open(bpItem)
    end

end)


UI.Label("USAR_ITEM"):setColor("red")
macro(4500, "Auto Imbui Life/Mana", function()
  if getLeft():getId() == 7669 then -- WEAPON ID
    usewith(7854, getLeft()) -- ID DO IMBUI MANA
    delay(1500)
    usewith(7855, getLeft()) -- ID DO IMBUI LIFE
  end
end)
-- START CONFIG
local macroName = "[AUTO] EXP 25%"
local itemId = 8212 -- ID do item de EXP
local wait = 1 -- minutos
-- END CONFIG

macro(100, macroName, function()
  local target = g_game.getAttackingCreature()
  if not target then return end -- evita erro caso esteja sem target

  -- se tiver alvo válido e for monstro, usa o item
  if target:isMonster() then
    g_game.useInventoryItem(itemId)
    delay(wait * 60 * 1000)
  end
end)



-- START CONFIG
local macroName = "[AUTO] EXP 50%"
local itemId = 8213 -- ID do item de EXP
local wait = 1 -- minutos
-- END CONFIG

macro(100, macroName, function()
  local target = g_game.getAttackingCreature()
  if not target then return end -- evita erro caso esteja sem target

  -- se tiver alvo válido e for monstro, usa o item
  if target:isMonster() then
    g_game.useInventoryItem(itemId)
    delay(wait * 60 * 1000)
  end
end)
-----------------------------------------------------------
-- Contador de exp/h
function comma_value(amount)
  local formatted = amount
  while true do  
    formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
    if (k==0) then
      break
    end
  end
  return formatted
end

local i_exp = nil
i_exp = addIcon("expIcon", {item={id=3341, count=1}, text="Enable For Exp/h"}, macro(100, function(m)
  if player.expSpeed then
    local expHour = comma_value(math.floor(player.expSpeed * 3600))
    i_exp.text:setText(expHour.." exp/h")
  else
    i_exp.text:setText("Waiting Exp...")
  end
end))

i_exp:setWidth(150)
UI.Separator()
---------------------------------------------------------
UI.Label("STAMINA"):setColor("yellow")
function staminaItems(parent)
  if not parent then
    parent = panel
  end
  local panelName = "staminaItemsUser"
  local ui = setupUI([[
Panel
  height: 70
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
      min = 25,
      max = 40,
    }
  end

  local updateText = function()
    ui.title:setText("" .. storage[panelName].min .. " <= stamina >= " .. storage[panelName].max .. "")  
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
staminaItems(CelinTab)


atkLowhp = macro(100, "Attack LOW HP", function() 
  local battlelist = getSpectators();
  local closest = 2
  local lowesthpc = 101
  for key, val in pairs(battlelist) do
    if val:isMonster() and not val:isPlayer() and not val:isNpc() 
and val:getName():lower() ~= 'emberwing'
and val:getName():lower() ~= 'grovebeast' 
and val:getName():lower() ~= 'skullfrost'
and val:getName():lower() ~= 'jollypher snowlan'
and val:getName():lower() ~= 'zodom'
and val:getName():lower() ~= 'blade' 
and val:getName():lower() ~= 'coelho malvado' then
      if getDistanceBetween(player:getPosition(), val:getPosition()) <= closest then
        closest = getDistanceBetween(player:getPosition(), val:getPosition())
        if val:getHealthPercent() < lowesthpc then
          lowesthpc = val:getHealthPercent()
        end
      end
    end
  end
  for key, val in pairs(battlelist) do
    if val:isMonster() and not val:isPlayer() and not val:isNpc() 
and val:getName():lower() ~= 'emberwing'
and val:getName():lower() ~= 'grovebeast' 
and val:getName():lower() ~= 'skullfrost'
and val:getName():lower() ~= 'jollypher snowlan'
and val:getName():lower() ~= 'zodom'
and val:getName():lower() ~= 'blade' 
and val:getName():lower() ~= 'coelho malvado' then
      if getDistanceBetween(player:getPosition(), val:getPosition()) <= closest then
        if g_game.getAttackingCreature() ~= val and val:getHealthPercent() <= lowesthpc then
          g_game.attack(val)
          break
        end
      end
    end
  end
end, macros)

--[[esconder MAGIAS(SPRITES)]]--
sprh = macro(100, "Esconder Sprite", function() end)
onAddThing(function(tile, thing)
    if sprh.isOff() then return end
    if thing:isEffect() then
        thing:hide()
    end
end)

------------------------------------------------

--[[Esconder Nomes Laranjas da tela]]--
TH = macro(100, "Esconder Msg Laranja", function() end)
onStaticText(function(thing, text)
    if TH.isOff() then return end
    if not text:find('says:') then
        g_map.cleanTexts()
    end
end)


macro(5000, "Montaria", function() 
    if not player:isMounted() then player:mount() 
      end
 end)

macro(1000, "Stack items", function()
  local containers = g_game.getContainers()
  local toStack = {}
  for index, container in pairs(containers) do
    if not container.lootContainer then -- ignore monster containers
      for i, item in ipairs(container:getItems()) do
        if item:isStackable() and item:getCount() < 100 then
          local stackWith = toStack[item:getId()]
          if stackWith then
            g_game.move(item, stackWith[1], math.min(stackWith[2], item:getCount()))
            return
          end
          toStack[item:getId()] = {container:getSlotPosition(i - 1), 100 - item:getCount()}
        end
      end
    end
  end
end)



storage.followLeader = storage.followLeader or "Quentin"

FollowMacro = macro(1231321321, "Follow", function() end)

addTextEdit("playerToFollow", storage.followLeader, function(widget, text)
  storage.followLeader = text
end)


onCreaturePositionChange(function(creature, newPos, oldPos)
  if FollowMacro:isOff() then return end

  if newPos and oldPos and creature:getName() == player:getName() and getCreatureByName(storage.followLeader) == nil and newPos.z > oldPos.z then
    say('exani tera')
    for i = -1, 1 do
      for j = -1, 1 do
        local useTile = g_map.getTile({ x = posx() + i, y = posy() + j, z = posz() })
        g_game.use(useTile:getTopUseThing())
      end
    end
  end
  if creature:getName() == storage.followLeader then
    if not newPos then
      if oldPos then
        lastPos = oldPos

        schedule(200, function()
          autoWalk(oldPos)
        end)
      end

      schedule(1000, function()
        for i = -1, 1 do
          for j = -1, 1 do
            local useTile = g_map.getTile({ x = posx() + i, y = posy() + j, z = posz() })
            if useTile then
              local top useTile:getTopUseThing()
              if top then
                g_game.use(top)
              end
            end
          end
        end
      end)
    end

    if not newPos or not oldPos then return end
    if oldPos.z == newPos.z then
      schedule(300, function()
        local useTile = g_map.getTile({ x = oldPos.x, y = oldPos.y, z = oldPos.z })
        topThing = useTile:getTopThing()

        if not useTile:isWalkable() then
          use(topThing)
        end
      end)


      autoWalk({ x = oldPos.x, y = oldPos.y, z = oldPos.z })
    else
      lastPos = oldPos
      autoWalk(oldPos)
      for i = 1, 6 do
        schedule(i * 200, function()
          autoWalk(oldPos)

          if getDistanceBetween(pos(), oldPos) == 0 and (posz() > newPos.z and getCreatureByName(storage.followLeader) == nil) then
            say('exani tera')
          end
        end)
      end
      local useTile = g_map.getTile({ x = newPos.x, y = newPos.y - 1, z = oldPos.z })
      g_game.use(useTile:getTopUseThing())
    end
  end
end)

local afkMsg = false

addSwitch("afkMsg", "Responder PM AFK", function(widget)

    afkMsg = not afkMsg

    widget:setOn(afkMsg)

end)



onTalk(function(name, level, mode, text, channelId, pos) --quando receber uma pm vai responder com a mensagem escolhida abaixo

    if mode == 4 and afkMsg == true then

        g_game.talkPrivate(5, name, storage.afkMsg)

        delay(5000)

    end

end)

UI.TextEdit(storage.afkMsg or "Estou AFK no momento.", function(widget, newText)

storage.afkMsg = newText

end)


local showhp = macro(20000, "Monster HP %", function() end)
onCreatureHealthPercentChange(function(creature, healthPercent)
    if showhp:isOff() then  return end
    if creature:isMonster() or creature:isPlayer() and creature:getPosition() and pos() then
        if getDistanceBetween(pos(), creature:getPosition()) <= 5 then
            creature:setText(healthPercent .. "%")
        else
            creature:clearText()
        end
    end
end)



 addLabel("texto", " ")
UI.Separator()
-- XX -- Heal e Haste
addLabel("texto", "->  RUNAR E TREINO ML  <-"):setColor("#DFFF00")

UI.Label("Mana training")
if type(storage.manaTrain) ~= "table" then
  storage.manaTrain = {on=false, title="MP%", text="utevo lux", min=80, max=100}
end

local manatrainmacro = macro(1000, function()
  if TargetBot and TargetBot.isActive() then return end -- pause when attacking
  local mana = math.min(100, math.floor(100 * (player:getMana() / player:getMaxMana())))
  if storage.manaTrain.max >= mana and mana >= storage.manaTrain.min then
    say(storage.manaTrain.text)
  end
end)
manatrainmacro.setOn(storage.manaTrain.on)

UI.DualScrollPanel(storage.manaTrain, function(widget, newParams) 
  storage.manaTrain = newParams
  manatrainmacro.setOn(storage.manaTrain.on)
end)

UI.Separator()


local rainbowOutfitTime = 250 
 
rainbowOutfit = macro(rainbowOutfitTime, "Rainbow Outfit", function ()   rainbowOutfit() end) 
 
function rainbowOutfit()     local randomColor = math.random(1,132)     local pOutfit = player:getOutfit() 
    local rainbowOutfit = { type = pOutfit.type, head = blackColor, body = randomColor, legs = randomColor, feet = randomColor, addons = pOutfit.addons}     setOutfit(rainbowOutfit)   return true 
end
