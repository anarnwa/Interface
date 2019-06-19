local frame = CreateFrame("FRAME", nil, UIParent)
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript(
  "OnEvent",
  function()
    if IsAddOnLoaded("Blizzard_Collections") then
      if IsAddOnLoaded("CollectMe") then
        if CollectMeOpen2Button then
          CollectMeOpen2Button:Hide()
          CollectMeOpen2Button = nil
        end

        if IsAddOnLoaded("Rematch") then
          if RematchJournal.CollectMeButton then
            RematchJournal.CollectMeButton:Hide()
          end
        end

        local CollectMe = LibStub("AceAddon-3.0"):GetAddon("CollectMe")
        if CollectMe.db.profile.macro.companion then
          CollectMe.db.profile.macro.companion = false
          local idx = GetMacroIndexByName("CollectMeRC")
          if idx then
            DeleteMacro(idx)
          end
        end
        if CollectMe.db.profile.macro.mount then
          CollectMe.db.profile.macro.mount = false
          local idx = GetMacroIndexByName("CollectMeRM")
          if idx then
            DeleteMacro(idx)
          end
        end
        if CollectMe.db.profile.macro.title then
          CollectMe.db.profile.macro.title = false
          local idx = GetMacroIndexByName("CollectMeRT")
          if idx then
            DeleteMacro(idx)
          end
        end
      end
    end
  end
)
