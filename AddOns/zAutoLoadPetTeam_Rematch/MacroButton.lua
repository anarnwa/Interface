local frame = CreateFrame("FRAME", nil, UIParent)
local AutoTeam = AutoLoadPetTeamRematch
local buttonInited = false
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript(
  "OnEvent",
  function()
    frame:CreateButtons()
  end
)
local function GetItemName(itemID)
  local itemName = GetItemInfo(itemID)
  return itemName
end

function frame:CreateButtons()
  if buttonInited then
    return
  end

  local buttonTarget = CreateFrame("Button", "ALPTButtonTarget", UIParent, "SecureActionButtonTemplate")
  buttonTarget:SetAttribute("macrotext", "")
  buttonTarget:SetAttribute("type", "macro")
  buttonTarget:Hide()
  buttonTarget:SetScript(
    "PreClick",
    function(btn, button)
      local npcName, npcWithTeam = AutoTeam:GetLastNpcData()
      if npcName then
        btn:SetAttribute("macrotext", "/targetexact " .. npcName)
      end
    end
  )

  local buttonWM = CreateFrame("Button", "ALPTButtonWM", UIParent, "SecureActionButtonTemplate")
  buttonWM:SetAttribute("type", "item")
  buttonWM:SetAttribute("item", nil)
  buttonWM:Hide()
  buttonWM:SetScript(
    "PreClick",
    function(btn, button)
      local item = btn:GetAttribute("item")
      if not item then
        btn:SetAttribute("item", GetItemInfo(122681))
      end
      if C_PetBattles.IsInBattle() or C_Map.GetBestMapForUnit("player") ~= 630 then
        btn:SetAttribute("type", nil)
      else
        local startTime, duration = GetItemCooldown(122681)
        if duration > 0 then
          btn:SetAttribute("type", nil)
        end
      end
    end
  )
  buttonWM:SetScript(
    "PostClick",
    function(btn, button)
      btn:SetAttribute("type", "item")
    end
  )

  local buttonHeal = CreateFrame("Button", "ALPTButtonHeal", UIParent, "SecureActionButtonTemplate")
  buttonHeal:SetAttribute("type", "spell")
  buttonHeal:SetAttribute("spell", "125439")
  buttonHeal:Hide()
  buttonHeal:SetScript(
    "PreClick",
    function(btn, button)
      if C_PetBattles.IsInBattle() then
        btn:SetAttribute("type", nil)
      else
        local startTime, duration = GetSpellCooldown(125439)
        if duration > 0 then
          btn:SetAttribute("type", nil)
        end
      end
    end
  )
  buttonHeal:SetScript(
    "PostClick",
    function(btn, button)
      btn:SetAttribute("type", "spell")
    end
  )

  local buttonAll = CreateFrame("Button", "ALPTButtonAll", UIParent, "SecureActionButtonTemplate")
  buttonAll:SetAttribute("macrotext", "")
  buttonAll:SetAttribute("type", "macro")
  buttonAll:Hide()
  buttonAll:SetScript(
    "PreClick",
    function(btn, button)
      local npcName, npcWithTeam = AutoTeam:GetLastNpcData()

      local macro = "/click ALPTButtonHeal"
      if npcWithTeam then
        macro = macro .. "\n/targetexact " .. npcWithTeam
      end
      if UnitExists("target") and GossipFrame and GossipFrame:IsVisible() then
        macro = macro .. "\n/script SelectGossipOption(1)"
      end
      if StaticPopup1Button1 and StaticPopup1Button1:IsVisible() then
        macro = macro .. "\n/click StaticPopup1Button1"
      end
      btn:SetAttribute("macrotext", macro)
    end
  )

  local buttonMagic = CreateFrame("Button", "ALPTButtonAuto", UIParent, "SecureActionButtonTemplate")
  buttonMagic:SetAttribute("macrotext", "")
  buttonMagic:SetAttribute("type", "macro")
  buttonMagic:Hide()
  buttonMagic:SetScript(
    "PreClick",
    function(btn, button)
      local npcName, npcWithTeam = AutoTeam:GetLastNpcData()
      local targetName = UnitName("target")
      local macro = "/click ALPTButtonHeal"

      if npcWithTeam and npcWithTeam ~= targetName then
        macro = macro .. "\n/targetexact " .. npcWithTeam
      end

      if UnitExists("target") and GossipFrame and GossipFrame:IsVisible() then
        local isTeamOk = AutoTeam:IsTeamAvailable()
        if isTeamOk then
          macro = macro .. "\n/script SelectGossipOption(1)"
        end
      end
      if StaticPopup1Button1 and StaticPopup1Button1:IsVisible() then
        macro = macro .. "\n/click StaticPopup1Button1"
      end
      btn:SetAttribute("macrotext", macro)
    end
  )

  local buttonCLM = CreateFrame("Button", "ALPTButtonCLM", UIParent, "SecureActionButtonTemplate")
  buttonCLM:SetAttribute("macrotext", "")
  buttonCLM:SetAttribute("type", "macro")
  buttonCLM:Hide()
  buttonCLM:SetScript(
    "PreClick",
    function(btn, button)
      if InCombatLockdown() then
        return
      end
      local macro = "/stopmacro [combat]\n"
      if C_Scenario.IsInScenario() then
        local sname, step = C_Scenario.GetInfo()
        local isCast = (CastingBarFrame and (CastingBarFrame.casting or CastingBarFramechanneling))
        if isCast then
          ----
        elseif step == 1 then
          if not UnitExists("target") then
            macro = macro .. "/target 克罗米"
          elseif GossipFrame and GossipFrame:IsVisible() then
            macro = macro .. "/script SelectGossipOption(2)"
          end
        elseif QuestChoiceFrame and QuestChoiceFrame:IsVisible() then
          --选择物品
          local item1 = QuestChoiceFrameOption1Item.itemID
          local item2 = QuestChoiceFrameOption2Item.itemID
          -- 时光,钱包,宝箱
          if item1 == 151483 or item1 == 151482 or item1 == 151554 then
            macro = macro .. "/script QuestChoiceFrameOption1.OptionButtonsContainer.OptionButton1:OnClick()"
          else
            --青铜之翼 青铜之牙
            if item2 == 151489 or item2 == 151487 then
              macro = macro .. "/script QuestChoiceFrameOption2.OptionButtonsContainer.OptionButton1:OnClick()"
            else
              macro = macro .. "/script QuestChoiceFrameOption1.OptionButtonsContainer.OptionButton1:OnClick()"
            end
          end
        else
           if GetItemCount(151553) > 0 then
            macro = macro .. "/use " .. GetItemName(151553)
            print(GREEN_FONT_COLOR_CODE .. "已获得安多哈尔道具" .. FONT_COLOR_CODE_CLOSE)
          elseif GetItemCount(151552) > 0 then
            macro = macro .. "/use " .. GetItemName(151552)
            print(GREEN_FONT_COLOR_CODE .. "已获得永恒之井道具" .. FONT_COLOR_CODE_CLOSE)
          elseif GetItemCount(151551) > 0 then
            macro = macro .. "/use " .. GetItemName(151551)
            print(GREEN_FONT_COLOR_CODE .. "已获得海加尔山道具" .. FONT_COLOR_CODE_CLOSE)
          elseif GetItemCount(151550) > 0 then
            macro = macro .. "/use " .. GetItemName(151550)
            print(GREEN_FONT_COLOR_CODE .. "已获得斯坦索姆道具" .. FONT_COLOR_CODE_CLOSE)
          elseif GetItemCount(151482) > 0 then
            macro = macro .. "/use " .. GetItemName(151482)
          elseif GetItemCount(151493) > 0 then
            macro = macro .. "/click ExtraActionButton1"
          end
        end
      end
      btn:SetAttribute("macrotext", macro)
    end
  )
 
  buttonInited = true
end
