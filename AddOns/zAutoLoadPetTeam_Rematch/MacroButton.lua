local CFG = ALPTRematch.alptconfig
local rematch = Rematch
local function GetItemName(itemID)
  local itemName = GetItemInfo(itemID)
  return itemName
end

local buttonQuitGame
local buttonHeal
local macroButtons = {}
local buttonInited = false
local config
local lastCheckTime = 0
local lastBundTime = 0
local function CreateHelpButtons()
  buttonHeal = CreateFrame("Button", "ALPTButtonHeal", UIParent, "SecureActionButtonTemplate")
  buttonHeal:SetAttribute("type", "spell")
  buttonHeal:SetAttribute("spell", "125439")
  buttonHeal:Hide()

  buttonQuitGame = CreateFrame("Button", "ALPTQuitGame", UIParent, "SecureActionButtonTemplate")
  buttonQuitGame:SetAttribute("macrotext", "")
  buttonQuitGame:SetAttribute("type", "macro")
  buttonQuitGame:Hide()
  buttonQuitGame:SetScript(
    "PreClick",
    function(btn, button)
      if UnitLevel("player")==120 then
        btn:SetAttribute("macrotext", "/quit")
      else
        btn:SetAttribute("macrotext", "")
      end
    end
  )
 
end
local function DebugPrint(msg)
  if config and config.debug then
    print(msg)
  end
end

local function createMacroText(btn)
  local macro = ""
  repeat
    config = btn.config
    if not C_PetJournal.IsJournalUnlocked() then
      break
    end
    if config.autointeract and not C_PetBattles.IsInBattle() then
      local org = GetCVar("autointeract")
      if org ~= "1" then
        DebugPrint("开启点击移动")
        ConsoleExec("autointeract 1")
      end
    end
    if InCombatLockdown() then
      return
    end

    if C_PetBattles.IsInBattle() then
      if config.useTdScript then
        macro = macro .. "\n/click tdBattlePetScriptAutoButton"
      end
      break
    end

    --useTdScript

    --自定义buff
    if config.checkItemId and config.checkItemId ~= "" and config.customScript and config.customScript ~= "" then
      local buff = GetItemSpell(config.checkItemId)
      if buff and not rematch:UnitBuff(buff) then
        if config.customScript == "use" then
          DebugPrint("使用物品BUFF" .. buff)
          macro = macro .. "\n/use item:" .. config.checkItemId
        else
          DebugPrint("执行脚本" .. config.customScript)
          macro = macro .. config.customScript
        end
        break
      end
    end

    --复活
    local startTime, duration = GetSpellCooldown(125439)
    if config.healPet and duration == 0 then
      DebugPrint("复活战斗宠物")
      macro = macro .. "\n/click ALPTButtonHeal"
    else
      --绷带
      if config.useBandage and not ALPTRematch:HasValidTeam() and duration > 5 and GetItemCount(86143) > 0 then
        if not ALPTRematch:IsTeamAvailable() then
          --防止延时误使用，等待1秒
          local timenow = time()
          if lastBundTime == 0 then
            lastBundTime = timenow
          end
          if timenow - lastBundTime >= 1 then
            print(GREEN_FONT_COLOR_CODE .. "使用绷带" .. FONT_COLOR_CODE_CLOSE)
            macro = macro .. "\n/use item:86143"
            lastBundTime = 0
            break
          end
        end
      end
    end

    --尾锚
    if config.summonWM and C_Map.GetBestMapForUnit("player") == 630 then
      local startTime, duration = GetItemCooldown(122681)
      if duration < 1 then
        DebugPrint("召唤尾锚")
        macro = macro .. "\n/use item:122681"
      end
    end

    local npcName, npcWithTeam, npcIdWithTeam = ALPTRematch:GetLastNpcData()
    local hasNpc = npcWithTeam and npcWithTeam ~= ""
    if hasNpc and config.target then
      if UnitExists("target") then
        local unit_type, npcid = ALPTRematch:GetTargetNPC()
        if npcid and npcid ~= npcIdWithTeam then
          DebugPrint("目标错误，清除目标")
          macro = macro .. "\n/cleartarget "
        end
      else
        if npcWithTeam then
          DebugPrint("尝试选中" .. npcWithTeam)
          macro = macro .. "\n/targetexact " .. npcWithTeam
        end
      end
    end

    if config.autoConfirm then
      if StaticPopup1Button1 and StaticPopup1Button1:IsVisible() then
        DebugPrint("点击确定")
        macro = macro .. "\n/click StaticPopup1Button1"
      end
    end

    local isTeamOk = true
    if hasNpc and config.waitTeam then
      isTeamOk = ALPTRematch:IsTeamAvailable()
      if config.waitTimeout == nil then
        config.waitTimeout = 0
      end
      if not isTeamOk and config.waitTimeout > 0 then
        local time = time()
        if lastCheckTime == 0 then
          lastCheckTime = time
        end
        if lastCheckTime > 0 and (time - lastCheckTime) > config.waitTimeout then
          DebugPrint("队伍未生效，尝试重新激活")
          ALPTRematch:ActiveTeam()
          lastCheckTime = time
        end
      end
    end

    if config.selectGossip and isTeamOk and UnitExists("target") and GossipFrame and GossipFrame:IsVisible() then
      DebugPrint("执行对话")
      macro = macro .. "\n/script SelectGossipOption(1)"
    end
    DebugPrint(config.extraScriptCmd)
    if config.extraScript and config.extraScriptCmd and config.extraScriptCmd ~= nil then
      DebugPrint("执行额外命令" .. config.extraScriptCmd)
      macro = macro .. "\n" .. config.extraScriptCmd
    end
  until true
  if macro ~= "" then
    macro = "/stopmacro [combat]" .. macro
    DebugPrint(macro)
  else
    --DebugPrint("无动作")
  end
  btn:SetAttribute("macrotext", macro)
end

local function CreateMacroButtons()
  for key, cf in pairs(CFG.macros) do
    repeat
      local macroButton = CreateFrame("Button", key, UIParent, "SecureActionButtonTemplate")
      macroButton:SetAttribute("macrotext", "")
      macroButton:SetAttribute("type", "macro")
      macroButton:Hide()
      macroButton.config = cf
      macroButton:SetScript("PreClick", createMacroText)
      macroButtons[key] = macroButton
    until true
  end
end
rematch:InitModule(
  function()
    if buttonInited then
      return
    end
    CreateHelpButtons()
    CreateMacroButtons()
    buttonInited = true
  end
)
