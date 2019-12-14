local rematch = Rematch
local saved, settings
local CFG = ALPTRematch.alptconfig

local alptconfig
local conf
local teamKey
local tdBattlePetScriptAddon = tdBattlePetScript and tdBattlePetScript:GetPlugin("Rematch")
local settingButtons =
  setmetatable(
  {},
  {
    __index = function(t, parent)
      local button = CreateFrame("Button", nil, parent, "RematchFootnoteButtonTemplate")
      do
        if parent.slim then
          button:SetSize(18, 18)
        end
        button:SetPoint("CENTER")
        button:SetNormalTexture("Interface\\AddOns\\zAutoLoadPetTeam_Rematch\\Textures\\setting")
        button:SetPushedTexture("Interface\\AddOns\\zAutoLoadPetTeam_Rematch\\Textures\\setting")
        button:SetScript(
          "OnClick",
          function(button)
            ALPTRematch:OpenSetting(button.key)
          end
        )
        button:SetScript(
          "OnEnter",
          function(button)
            GameTooltip:SetOwner(button, "ANCHOR_RIGHT")
            GameTooltip:SetText("换队参数")
            GameTooltip:Show()
          end
        )
        button:SetScript("OnLeave", GameTooltip_Hide)
      end
      t[parent] = button
      return button
    end
  }
)

function ALPTRematch:deleteConfig()
  settings.alpt[teamKey] = nil
  rematch:HideDialog()
  rematch:UpdateUI()
end

local function ALPT_InitInputValue(key, value)
  conf[key]:SetText(value)
  conf[key].var = value
end

local function InitConfiDialog()
  RematchDialog:RegisterWidget("ALPTCConfigs")
  conf = rematch.Dialog.ALPTCConfigs
  conf.Disable.text:SetText("停用队伍")
  for i = 1, 3 do
    conf["HP" .. i].Label:SetText("有效血线")
    conf["HP" .. i].LabelR:SetText("%")
    conf["Breed" .. i].text:SetText("忽略属性")
    conf["MinLvl" .. i].Label:SetText("（最低")
    conf["MinLvl" .. i].LabelR:SetText("级）")

    conf["NoAlt" .. i].text:SetText("禁用替补")
    conf["Highest" .. i].text:SetText("最高血量")

    conf["UseGroup" .. i].text:SetText("使用宠物组")

    conf["FilterHP" .. i .. "_1"].Label:SetText("血")
    conf["FilterHP" .. i .. "_2"].Label:SetText("-")

    conf["FilterAttack" .. i .. "_1"].Label:SetText("攻")
    conf["FilterAttack" .. i .. "_2"].Label:SetText("-")

    conf["FilterSpeed" .. i .. "_1"].Label:SetText("速")
    conf["FilterSpeed" .. i .. "_2"].Label:SetText("-")
  end
end

function ALPTRematch:OpenSetting(key)
  teamKey = key
  if rematch:IsDialogOpen("ALPTCConfigs") then
    rematch:HideDialog()
  end
  local dialog =
    rematch:ShowDialog(
    "ALPTCConfigs",
    490,
    500,
    "换队参数设置",
    nil,
    SAVE,
    ALPTRematch.ConfigSave,
    CANCEL,
    nil,
    DELETE,
    ALPTRematch.deleteConfig
  )

  local titlename = rematch:GetTeamTitle(key, true)
  local alpt = ALPTRematch:FixTeamConfig(teamKey)
  if alpt.avg1 and alpt.avg2 then
    titlename = titlename .."( "..alpt.avg1.." - "..alpt.avg2.." 秒)"
  end

  conf.TeamName:SetText(titlename)

  
  conf.Disable:SetChecked(alpt.disabled)
  for i = 1, 3 do
    ALPT_InitInputValue("HP" .. i, alpt.healthCheck[i])

    conf["Breed" .. i]:SetChecked(alpt.ignoreBreed[i])
    conf["MinLvl" .. i]:SetText(alpt.minLvl[i])
    conf["NoAlt" .. i]:SetChecked(alpt.noAlt[i])
    conf["Highest" .. i]:SetChecked(alpt.highest[i])
    conf["UseGroup" .. i]:SetChecked(alpt.useGroup[i])

    UIDropDownMenu_SetText(conf["Groups" .. i], alpt.groups[i] or "无")

    ALPT_InitInputValue("FilterHP" .. i .. "_1", alpt.hp[i][1])
    ALPT_InitInputValue("FilterHP" .. i .. "_2", alpt.hp[i][2])

    ALPT_InitInputValue("FilterAttack" .. i .. "_1", alpt.attack[i][1])
    ALPT_InitInputValue("FilterAttack" .. i .. "_2", alpt.attack[i][2])

    ALPT_InitInputValue("FilterSpeed" .. i .. "_1", alpt.speed[i][1])
    ALPT_InitInputValue("FilterSpeed" .. i .. "_2", alpt.speed[i][2])
  end

  conf:SetPoint("TOP", 0, -36)
  conf:Show()
end

function ALPTRematch:ConfigSave()
  cfg = settings.alpt[teamKey]
  cfg.disabled = conf["Disable"]:GetChecked()
  for i = 1, 3 do
    cfg.noAlt[i] = conf["NoAlt" .. i]:GetChecked()
    cfg.healthCheck[i] = tonumber(conf["HP" .. i]:GetText()) or 100
    if cfg.healthCheck[i]>100 then
      cfg.healthCheck[i] = 100
    end
    cfg.ignoreBreed[i] = conf["Breed" .. i]:GetChecked()
    cfg.highest[i] = conf["Highest" .. i]:GetChecked()
    cfg.minLvl[i] = tonumber(conf["MinLvl" .. i]:GetText()) or 25
    if cfg.minLvl[i]>25 then
      cfg.minLvl[i] = 25
    end
    cfg.useGroup[i] = conf["UseGroup" .. i]:GetChecked()
    cfg.groups[i] = UIDropDownMenu_GetText(conf["Groups" .. i])
    cfg.hp[i] = {
      tonumber(conf["FilterHP" .. i .. "_1"]:GetText()) or 0,
      tonumber(conf["FilterHP" .. i .. "_2"]:GetText()) or 9999
    }

    cfg.speed[i] = {
      tonumber(conf["FilterSpeed" .. i .. "_1"]:GetText()) or 0,
      tonumber(conf["FilterSpeed" .. i .. "_2"]:GetText()) or 999
    }

    cfg.attack[i] = {
      tonumber(conf["FilterAttack" .. i .. "_1"]:GetText()) or 0,
      tonumber(conf["FilterAttack" .. i .. "_2"]:GetText()) or 999
    }
  end
  settings.alpt[teamKey] = cfg

  ALPTRematch:CheckCFG(teamKey)
  rematch:HideDialog()
  rematch:UpdateUI()
end

function ALPTRematch_DropDown(func)
  local info = UIDropDownMenu_CreateInfo()
  info.text = "无"
  info.value = 0
  info.func = func
  UIDropDownMenu_AddButton(info)

  if CFG.petGroups then
    for k, v in pairs(CFG.petGroups) do
      local info = UIDropDownMenu_CreateInfo()
      info.text = k
      info.value = k
      info.func = func
      UIDropDownMenu_AddButton(info)
    end
  end
end

function ALPTRematch_DropDown1()
  ALPTRematch_DropDown(ALPTRematch_OnSelect1)
end

function ALPTRematch_OnSelect1(self)
  UIDropDownMenu_SetSelectedValue(conf.Groups1, self.value)
end

function ALPTRematch_DropDown2()
  ALPTRematch_DropDown(ALPTRematch_OnSelect2)
end

function ALPTRematch_OnSelect2(self)
  UIDropDownMenu_SetSelectedValue(conf.Groups2, self.value)
end

function ALPTRematch_DropDown3()
  ALPTRematch_DropDown(ALPTRematch_OnSelect3)
end

function ALPTRematch_OnSelect3(self)
  UIDropDownMenu_SetSelectedValue(conf.Groups3, self.value)
end

local Org_PetListButtonOnClick = rematch.PetListButtonOnClick

function ALPTRematch:FindMenuItem(menu, text)
  for i, v in ipairs(menu) do
    if v.text == text then
      return v
    end
  end
end

local function rename(oldkey, newkey)
  if not oldkey then
    return
  end
  if oldkey == newkey then
    return
  end
  if settings.alpt[oldkey] then
    if newkey then
      settings.alpt[newkey] = settings.alpt[oldkey]
    end
    settings.alpt[oldkey] = nil
  end
end

local teamMenu = {
  text = "换队参数设置",
  func = function(_, key, ...)
    ALPTRematch:OpenSetting(key)
  end
}

local teamDisableMenu = {
  text = function(self, key)
    local alpt = settings.alpt[key]
    if alpt and alpt.disabled then
      return "启用"
    else
      return "停用"
    end
  end,
  func = function(_, key, ...)
    local alpt = settings.alpt[key]
    if not alpt then
      alpt = {disabled = false}
      settings.alpt[key] = alpt
    end
    alpt.disabled = not alpt.disabled
    ALPTRematch:CheckCFG(key)
    rematch:HideDialog()
    rematch:UpdateUI()
  end
}

local function PetCantBattle(petID)
  local idType = rematch:GetIDType(petID)
  if idType == "pet" then
    return select(15, C_PetJournal.GetPetInfoByPetID(petID))
  end
  return false
end

local PetGroupMenu = {}
local addToGroupName = {
  text = "添加到宠物组",
  hidden = function(entry, petID)
    return not PetCantBattle(petID) or not ALPTRematch:HasGroup()
  end,
  subMenu = "PetGroupMenu"
}

function ALPTRematch:InitGroupMenu()
  PetGroupMenu = {}
  local petGroups = ALPTRematch:GetPeGroups()
  for groupName, _ in pairs(petGroups) do
    tinsert(
      PetGroupMenu,
      {
        text = groupName,
        func = function(entry, petID)
          local speciesID, _, _, _, _, _, _, speciesName = C_PetJournal.GetPetInfoByPetID(petID)
          ALPTRematch:AddGroupPet(groupName, speciesID, speciesName)
          ALPTRematch:NotifyChange()
        end
      }
    )
  end

  rematch:RegisterMenu("PetGroupMenu", PetGroupMenu)
end

function ALPTRematch:PreferencesOnChar()
  rematch:HideTooltip()
  if not tonumber(self:GetText()) then
    self:SetText(self.var or "0")
  end
end

function ALPTRematch:PreferencesOnTextChanged()
  local value = tonumber(self:GetText())
  self.var = value
end

rematch:InitModule(
  function()
    RematchSettings["AutoLoad"] = false
    saved = RematchSaved
    settings = RematchSettings
    alptconfig =
      (settings.alptconfig and settings.alptconfig.rematchEx) or
      {
        useTeamMenu = true,
        showSetButton = 1,
        useGroupMenu = true,
        fillSaveAsTeamName = true,
        useRigthCage = true
      }
    InitConfiDialog()

    if alptconfig.fillSaveAsTeamName then
      hooksecurefunc(
        Rematch,
        "ShowSaveAsDialog",
        function()
          if RematchDialog.SaveAs.Name:GetText() == "新增队伍" then
            local npcName = rematch:GetTeamTitle(RematchSettings.loadedTeam) or ALPTRematch:getCurrentTarget()
            if npcName then
              RematchDialog.SaveAs.Name:SetText(npcName)
            end
          end
        end
      )
    end
    if alptconfig.useRigthCage then
      rematch.PetListButtonOnClick = function(self, button)
        if
          C_PetJournal.IsJournalUnlocked() and IsControlKeyDown() and button == "RightButton" and self and self.petID and
            C_PetJournal.PetIsTradable(self.petID) and
            self.Name
         then
          local petName = self.Name:GetText()
          C_PetJournal.CagePetByID(self.petID)
          print(YELLOW_FONT_COLOR_CODE .. petName .. "已装笼" .. FONT_COLOR_CODE_CLOSE)
        else
          Org_PetListButtonOnClick(self, button)
        end
      end
    end

    if alptconfig.useTeamMenu then
      local menu = Rematch:GetMenu("TeamMenu")
      if menu then
        tinsert(menu, 4, teamMenu)
        tinsert(menu, 4, teamDisableMenu)
        local deleteItem = ALPTRematch:FindMenuItem(menu, DELETE)
        hooksecurefunc(
          deleteItem,
          "func",
          function(_, key, ...)
            local origAccept = RematchDialog.acceptFunc
            RematchDialog.acceptFunc = function(...)
              if settings.alpt[key] then
                settings.alpt[key] = nil
              end
              return origAccept(...)
            end
          end
        )
      end

      if alptconfig.useGroupMenu then
        local petMenu = Rematch:GetMenu("PetMenu")
        if petMenu then
          tinsert(petMenu, 3, addToGroupName)
          ALPTRematch:InitGroupMenu()
        end
      end

      if alptconfig.useTeamMenu or alptconfig.showSetButton > 0 then
        hooksecurefunc(
          Rematch,
          "SaveAsAccept",
          function(...)
            local team, key = Rematch:GetSideline()
            if team and not RematchSaved[key] or not Rematch:SidelinePetsDifferentThan(key) then
              rename(Rematch:GetSidelineContext("originalKey"), key)
            end
          end
        )

        hooksecurefunc(
          Rematch,
          "OverwriteAccept",
          function(...)
            rename(Rematch:GetSidelineContext("originalKey"), select(2, Rematch:GetSideline()))
          end
        )
        hooksecurefunc(
          RematchTeamPanel.List,
          "callback",
          function(button, key)
            local setBtn = settingButtons[button]
            local aplt = settings.alpt[key]

            if alptconfig.showSetButton == 1 or (aplt and aplt.changed and alptconfig.showSetButton == 2) then
              setBtn.key = key
              setBtn:Show()
              setBtn:ClearAllPoints()

              local relative =
                button.Preferences:IsShown() and button.Preferences or button.Notes:IsShown() and button.Notes or
                button.compact and button.WinRecordBack:IsShown() and button.WinRecordBack

              local relative2 = tdBattlePetScriptAddon and tdBattlePetScriptAddon:GetScript(key)
              if relative then
                local x = relative == button.WinRecordBack and -3 or 0
                if relative2 then
                  x = x - 22
                end
                setBtn:SetPoint("RIGHT", relative, "LEFT", x, 0)
              else
                local x = -2
                if relative2 then
                  x = x - 22
                end
                setBtn:SetPoint("TOPRIGHT", x, -3)
              end

              if aplt and aplt.changed and alptconfig.showSetButton == 1 then
                setBtn:SetNormalTexture("Interface\\AddOns\\zAutoLoadPetTeam_Rematch\\Textures\\setting_ok")
                setBtn:SetPushedTexture("Interface\\AddOns\\zAutoLoadPetTeam_Rematch\\Textures\\setting_ok")
              else
                setBtn:SetNormalTexture("Interface\\AddOns\\zAutoLoadPetTeam_Rematch\\Textures\\setting")
                setBtn:SetPushedTexture("Interface\\AddOns\\zAutoLoadPetTeam_Rematch\\Textures\\setting")
              end
               
              button.Name:SetPoint("TOPRIGHT", setBtn:GetLeft() - button:GetRight(), -4)
            else
              setBtn:Hide()
            end

            if aplt and aplt.disabled then
              button.Name:SetText(GRAY_FONT_COLOR_CODE .. Rematch:GetTeamTitle(button.key) .. FONT_COLOR_CODE_CLOSE)
            end
          end
        )
      end

      if CFG.useRematchLoadingDone then
        rematch.UnloadTeam = function()
        end
      end
    end
    rematch.loadSimilarTeam = function(key)
      if CFG.debug  then
        print("loadSimilarTeam已拦截")
      end
    end

  end
)
