local AddonName, Addon = ...

-- Libs
local L = Addon.Libs.L
local DCL = Addon.Libs.DCL
local LDB = Addon.Libs.LDB
local LDBIcon = Addon.Libs.LDBIcon

-- Modules
local MinimapIcon = Addon.MinimapIcon
local DB = Addon.DB

-- Variables
local OBJECT_NAME = AddonName.."MinimapIcon"

-- ============================================================================
-- General Functions
-- ============================================================================

-- Initializes the minimap icon.
function MinimapIcon:Initialize()
  self.LDB = LDB:NewDataObject(OBJECT_NAME, {
  	icon = Addon.GAME_ICON,

    OnClick = function(_, button)
      if (button == "LeftButton") then
        Addon.Game.Window:Toggle()
      end
    end,

    OnTooltipShow = function(tooltip)
			tooltip:AddLine(DCL:ColorString(AddonName, Addon.TITLE_COLOR))
			tooltip:AddLine(DCL:ColorString(L.MINIMAP_ICON_TOOLTIP_1, DCL.CSS.White))
      tooltip:AddLine(DCL:ColorString(L.MINIMAP_ICON_TOOLTIP_2, DCL.CSS.White))
		end,
  })

  LDBIcon:Register(OBJECT_NAME, self.LDB, DB.Global.Minimap)

  self.Initialize = nil
end

-- Displays the minimap icon.
function MinimapIcon:Show()
  DB.Global.Minimap.hide = false
  LDBIcon:Show(OBJECT_NAME)
end

-- Hides the minimap icon.
function MinimapIcon:Hide()
  DB.Global.Minimap.hide = true
  LDBIcon:Hide(OBJECT_NAME)
end

-- Toggles the minimap icon.
function MinimapIcon:Toggle()
  if DB.Global.Minimap.hide then
    self:Show()
  else
    self:Hide()
  end
end
