local AutoTeam = AutoLoadPetTeamRematch
local rematch = Rematch
local saved, settings

rematch.loadSimilarTeam = function(key)
end

hooksecurefunc(
  Rematch,
  "SaveAsAccept",
  function()
    AutoTeam:UpdateTeam()
  end
)

hooksecurefunc(
  Rematch,
  "ShowSaveAsDialog",
  function()
    if RematchDialog.SaveAs.Name:GetText() == "新增队伍" then
      local npcName = rematch:GetTeamTitle(RematchSettings.loadedTeam) or AutoTeam:getCurrentTarget()
      if npcName then
        RematchDialog.SaveAs.Name:SetText(npcName)
      end
    end
  end
)

local Org_PetListButtonOnClick = rematch.PetListButtonOnClick

rematch.PetListButtonOnClick = function(self, button)
  if
    IsControlKeyDown() and button == "RightButton" and self and self.petID and C_PetJournal.PetIsTradable(self.petID) and
      self.Name
   then
    local petName = self.Name:GetText()
    C_PetJournal.CagePetByID(self.petID)
    print(YELLOW_FONT_COLOR_CODE .. petName .. "已装笼" .. FONT_COLOR_CODE_CLOSE)
  else
    Org_PetListButtonOnClick(self, button)
  end
end

local frame = CreateFrame("FRAME", "ALPTRematch", UIParent)
local conf
local Inited = false
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
            frame:OpenSetting(button.key)
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

function frame:OpenSetting(key)
  teamKey = key
  if rematch:IsDialogOpen("ALPTCConfigs") then
    rematch:HideDialog()
  end
  local dialog =
    rematch:ShowDialog(
    "ALPTCConfigs",
    300,
    364,
    "换队参数设置",
    nil,
    SAVE,
    frame.ConfigSave,
    CANCEL,
    nil,
    DELETE,
    frame.deleteConfig
  )

  conf.Top.PrefKey:SetText(rematch:GetTeamTitle(key, true))
  local alpt = settings.alpt and settings.alpt[teamKey]
  if alpt then
    local hc = alpt.healthCheck or {}
    local ib = alpt.ignoreBreed or {}
    conf["HP1"]:SetText(hc[1] or "100")
    conf["HP2"]:SetText(hc[2] or "100")
    conf["HP3"]:SetText(hc[3] or "100")
    conf.Breed1:SetChecked(ib[1] or false)
    conf.Breed2:SetChecked(ib[2] or false)
    conf.Breed3:SetChecked(ib[3] or false)
    conf.Disable1:SetChecked(alpt.disabled or false)
    conf.Disable2:SetChecked(alpt.noAlt or false)
  else
    conf["HP1"]:SetText("100")
    conf["HP2"]:SetText("100")
    conf["HP3"]:SetText("100")
    conf.Breed1:SetChecked(false)
    conf.Breed2:SetChecked(false)
    conf.Breed3:SetChecked(false)
    conf.Disable1:SetChecked(false)
    conf.Disable2:SetChecked(false)
  end

  conf:SetPoint("TOP", 0, -36)
  conf:Show()
end

local teamMenu = {
  text = "换队参数设置",
  func = function(_, key, ...)
    frame:OpenSetting(key)
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
      alpt = {disabled = false, healthCheck = {}}
      settings.alpt[key] = alpt
    end
    alpt.disabled = not alpt.disabled
    checkCFG(key)
    rematch:HideDialog()
    rematch:UpdateUI()
  end
}

function checkCFG(teamKey)
  local cfg = settings.alpt[teamKey]
  if
    not cfg.disabled and not cfg.noAlt and
      (not cfg.healthCheck or (cfg.healthCheck[1] == 100 and cfg.healthCheck[2] == 100 and cfg.healthCheck[3] == 100)) and
      (not cfg.ignoreBreed or (not cfg.ignoreBreed[1] and not cfg.ignoreBreed[2] and not cfg.ignoreBreed[3]))
   then
    settings.alpt[teamKey] = nil
  end
end

function frame:deleteConfig()
  settings.alpt[teamKey] = nil
  rematch:HideDialog()
  rematch:UpdateUI()
end

function frame:ConfigSave()
  if not settings.alpt then
    settings.alpt = {}
  end
  settings.alpt[teamKey] = {
    disabled = conf["Disable1"]:GetChecked(),
    noAlt = conf["Disable2"]:GetChecked(),
    healthCheck = {
      tonumber(conf["HP1"]:GetText()) or 100,
      tonumber(conf["HP2"]:GetText()) or 100,
      tonumber(conf["HP3"]:GetText() or 100)
    },
    ignoreBreed = {conf["Breed1"]:GetChecked(), conf["Breed2"]:GetChecked(), conf["Breed3"]:GetChecked()}
  }
  checkCFG(teamKey)
  rematch:HideDialog()
  rematch:UpdateUI()
end

rematch:InitModule(
  function()
    RematchSettings["AutoLoad"] = false
    saved = RematchSaved
    settings = RematchSettings
    
    RematchDialog:RegisterWidget("ALPTCConfigs")
    frame:CreateMenu()
    conf = rematch.Dialog.ALPTCConfigs
    conf.HP1.Label:SetText("一号宠血线(%)")
    conf.HP2.Label:SetText("二号宠血线(%)")
    conf.HP3.Label:SetText("三号宠血线(%)")

    conf["HP1"]:SetText("100")
    conf["HP1"].Clear:SetShown(true)

    conf["HP2"]:SetText("100")
    conf["HP2"].Clear:SetShown(true)

    conf["HP3"]:SetText("100")
    conf["HP3"].Clear:SetShown(true)

    conf.Breed1.text:SetText("一号宠忽略属性加载替补")
    conf.Breed2.text:SetText("二号宠忽略属性加载替补")
    conf.Breed3.text:SetText("三号宠忽略属性加载替补")

    conf.Disable1.text:SetText("停用队伍")
    conf.Disable2.text:SetText("禁用替补")

    
  end
)

function frame:FindMenuItem(menu, text)
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

function frame:CreateMenu()

  if not settings.alpt then
    settings.alpt = {}
  end

  local menu = Rematch:GetMenu("TeamMenu")
  if menu then
    tinsert(menu, 4, teamMenu)
    tinsert(menu, 4, teamDisableMenu)
    local deleteItem = self:FindMenuItem(menu, DELETE)
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

    hooksecurefunc(
      Rematch,
      "SaveAsAccept",
      function(...)
        local team, key = Rematch:GetSideline()
        if not RematchSaved[key] or not Rematch:SidelinePetsDifferentThan(key) then
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
        if aplt and aplt.disabled ~= nil and aplt.healthCheck then
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

          button.Name:SetPoint("TOPRIGHT", setBtn:GetLeft() - button:GetRight(), -4)

          if aplt.disabled then
            button.Name:SetText(GRAY_FONT_COLOR_CODE .. Rematch:GetTeamTitle(button.key) .. FONT_COLOR_CODE_CLOSE)
          end
        else
          setBtn:Hide()
        end
      end
    )

    if AutoLoadPetTeamConfig.useRematchLoadingDone then
      rematch.UnloadTeam = function()
 
      end
    end

    Inited = true
  end
end
function frame:PreferencesOnChar()
  rematch:HideTooltip()
  if not tonumber(self:GetText()) then
    self:SetText("")
  end
end

function frame:PreferencesOnTextChanged()
  local value = tonumber(self:GetText())
  self.Clear:SetShown(value and true or self:HasFocus())
end
