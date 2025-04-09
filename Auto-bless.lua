local UIBlessing = setupUI([[
Panel
  anchors.left: parent.left
  anchors.top: parent.top
  margin-left: 200
  margin-top: 250
  width: 230
  height: 40

  Label
    id: Label
    anchors.top: parent.top
    anchors:left: parent.left
    font: terminus-14px-bold
    text-auto-resize: true
]], g_ui.getRootWidget())

local BLESS_COMMAND = "!bless"
local BLESS_MESSAGE = "You are already blessed" 
local DELAY_LOGOUT = 10000 
local AUTO_LOGOUT = true 

local function scheduleLogout()
  schedule(DELAY_LOGOUT, function()
    if not storage.bless and AUTO_LOGOUT then
      modules.game_interface.tryLogout(false)
    end
  end)
end

local function updateBlessStatus(isBlessed)
  local statusText = isBlessed and "True" or "False"
  local statusColor = isBlessed and "green" or "red"
  UIBlessing.Label:setColoredText({"Bless:", "white", statusText, statusColor})
end

local function checkAndActivateBless()
  if storage.bless or player:getBlessings() > 0 then
    updateBlessStatus(true)
  else
    NPC.say(BLESS_COMMAND)
    updateBlessStatus(false)
    CaveBot.setOff()
    scheduleLogout()
  end
end

storage.bless = false
local blessMacro = macro(1000, "Auto Blessing", checkAndActivateBless)

onTextMessage(function(mode, text)
  if blessMacro.isOff() then 
    return 
  end

  if text:lower():find(BLESS_MESSAGE:lower()) then
    storage.bless = true
  end
end)

onCreatureHealthPercentChange(function(creature, healthPercent)
  if blessMacro.isOff() then 
    return 
  end
  
  if creature == player and healthPercent <= 0 then
    storage.bless = false
  end
end)