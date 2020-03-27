-- LevelSelection: the level selection screen.

local AddonName, Addon = ...

-- Libs
local L = Addon.Libs.L
local DCL = Addon.Libs.DCL

-- Modules
local LevelSelection = Addon.GameStates.LevelSelection
local Game = Addon.Game
local Grid = Addon.GameObjects.Grid
local DB = Addon.DB
local Utils = Addon.Utils

-- Upvalues
local IsShiftKeyDown = IsShiftKeyDown

-- ============================================================================
-- Helpers
-- ============================================================================

local function setLevel(level)
  local parent = LevelSelection.Frame
  parent.LevelText:SetText(L.LEVEL_TEXT:format(level))

  -- Show/hide checkmark
  if DB.Profile.CompletedLevels[tostring(level)] then
    parent.Checkmark:Show()
  else
    parent.Checkmark:Hide()
  end

  Grid:SetLevel(level)
end

local function createArrowButton(isPrev)
  local parent = LevelSelection.Frame
  local name = isPrev and "PrevButton" or "NextButton"
  local modifier = isPrev and -1 or 1

  -- Button
  local button = Utils:CreateSpriteButton({
    parent = parent,
    name = name,
    point = isPrev and {
      "BOTTOMRIGHT", parent, "BOTTOM", -5, 10
    } or {
      "BOTTOMLEFT", parent, "BOTTOM", 5, 10
    },
    spriteKey = isPrev and "Arrow_Left" or "Arrow_Right",
  })
  parent[name] = button

  -- Scripts
  button:SetScript("OnClick", function(self)
    local level

    if IsShiftKeyDown() then
      level = isPrev and 1 or #Addon.Levels
    else
      level = Grid:GetLevel() + modifier
    end

    setLevel(level)
  end)

  button:SetScript("OnUpdate", function(self)
    self:SetEnabled(
      not Game:IsTransitioning() and
      (Addon.Levels[Grid:GetLevel() + modifier] ~= nil)
    )
  end)
end

-- ============================================================================
-- GameState Functions
-- ============================================================================

function LevelSelection:Initialize()
  local parent = Utils:CreateUIFrame("LevelSelection")
  self.Frame = parent

  -- Level Text
  parent.LevelText = Utils:CreateFontString({
    parent = parent,
    name = "LevelText",
    size = 24,
    point = { "TOP", 0, -10 }
  })

  -- Home button
  parent.HomeButton = Utils:CreateSpriteButton({
    parent = parent,
    name = "HomeButton",
    point = { "BOTTOMLEFT", 10, 10 },
    spriteKey = "Home",
    onClick = function()
      Game:Transition(function()
        Game:SetState(Addon.GameStates.MainMenu)
      end)
    end
  })

  -- Arrow Buttons
  createArrowButton(true)
  createArrowButton(false)
  createArrowButton = nil

  -- Checkmark
  parent.Checkmark = Utils:CreateSprite({
    parent = parent,
    name = "CheckmarkSprite",
    point = { "BOTTOM", 0, parent.PrevButton:GetHeight() + 20 },
    spriteKey = "Checkmark",
    width = 25,
    height = 25
  })

  -- Play button
  parent.PlayButton = Utils:CreateSpriteButton({
    parent = parent,
    name = "PlayButton",
    point = { "BOTTOMRIGHT", -10, 10 },
    spriteKey = "Play",
    onClick = function()
      local level = Grid:GetLevel()
      Game:TextTransition(L.LEVEL_TEXT:format(level), function()
        Game:SetState(Addon.GameStates.Playing, level)
      end)
    end
  })
end

function LevelSelection:OnEnter(lastState, ...)
  self.Frame:Show()
  Grid.Positioner:SetScale(0.5)
  setLevel(DB.Profile.CurrentLevel or 1)
end

function LevelSelection:OnLeave()
  self.Frame:Hide()
  Grid.Positioner:SetScale(1)
end

-- function LevelSelection:OnResume(lastState, ...) end
-- function LevelSelection:OnPause() end

-- function LevelSelection:OnUpdate(elapsed) end
