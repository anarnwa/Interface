-- Playing: the playing state for the game.

local AddonName, Addon = ...

-- Libs
local L = Addon.Libs.L
local DCL = Addon.Libs.DCL
local DGL = Addon.Libs.DGL

-- Modules
local Playing = Addon.GameStates.Playing
local Game = Addon.Game
local Grid = Addon.GameObjects.Grid
local DB = Addon.DB
local Utils = Addon.Utils

-- Upvalues
local GameTooltip = GameTooltip

-- ============================================================================
-- GameState Functions
-- ============================================================================

function Playing:Initialize()
  Game.Event:Register(self,
    "LEVEL_COMPLETE",
    "TRANSITION_START",
    "TRANSITION_END"
  )

  -- UI frame
  local parent = Utils:CreateUIFrame("Playing")
  self.Frame = parent

  -- Level Text
  parent.LevelText = Utils:CreateFontString({
    parent = parent,
    name = "LevelText",
    size = 18,
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

  -- Reset button
  parent.ResetButton = Utils:CreateSpriteButton({
    parent = parent,
    name = "ResetButton",
    point = { "BOTTOM", 0, 10 },
    spriteKey = "Reset",
    onClick = function()
      Game:Transition(function() Grid:ResetLevel() end)
    end
  })

  do -- Help button
    parent.HelpButton = Utils:CreateSpriteButton({
      parent = parent,
      name = "HelpButton",
      point = { "BOTTOMRIGHT", -10, 10 },
      spriteKey = "Question"
    })

    parent.HelpButton:HookScript("OnEnter", function(self)
      GameTooltip:SetOwner(self, "ANCHOR_TOP")

      -- How to play
      GameTooltip:SetText(L.HOW_TO_PLAY_TEXT, 1, 0.82, 0)
      GameTooltip:AddLine(L.GAME_OBJECTIVE_TEXT, 1, 1, 1)
      GameTooltip:AddLine(" ")

      -- Controls
      GameTooltip:AddLine(L.CONTROLS_TEXT, 1, 0.82, 0.2)
      GameTooltip:AddDoubleLine(L.MOVEMENT_TEXT, L.WASD_TEXT, 1, 1, 1)
      GameTooltip:AddDoubleLine(L.RESET_LEVEL_TEXT, L.R_KEY_TEXT, 1, 1, 1)
      GameTooltip:AddDoubleLine(L.PAUSE_TEXT, L.RIGHT_CLICK_TEXT, 1, 1, 1)
      GameTooltip:AddDoubleLine(L.MAIN_MENU_TEXT, L.ESC_KEY_TEXT, 1, 1, 1)

      GameTooltip:Show()
    end)

    parent.HelpButton:HookScript("OnLeave", function() GameTooltip:Hide() end)
  end

  -- Disable buttons when paused or transitioning
  for _, button in pairs({
    parent.HelpButton,
    parent.HomeButton,
    parent.ResetButton
  }) do
    button:SetScript("OnUpdate", function(self)
      self:SetEnabled(
        (Game:GetState() == Playing) and
        not Game:IsTransitioning()
      )
    end)
  end
end

function Playing:OnEnter(lastState, ...)
  local level = ...
  self.Frame:Show()
  self.Frame.LevelText:SetText(L.LEVEL_TEXT:format(level))
  Grid:SetLevel(level)
end

function Playing:OnLeave()
  self.Frame:Hide()
end

-- function Playing:OnPause() end
-- function Playing:OnResume(lastState, ...) end

function Playing:OnUpdate(elapsed)
  if Game:IsTransitioning() then return end

  -- Main Menu
  if Game.Input:IsKeyJustDown("ESCAPE") then
    return Game:Transition(function()
      Game:SetState(Addon.GameStates.MainMenu)
    end)
  end

  -- Pause
  if Game.Input:IsMouseJustDown("RightButton") then
    return Game:PushState(Addon.GameStates.Paused)
  end

  -- Reload
  if Game.Input:IsKeyJustDown("R") then
    return Game:Transition(function() Grid:ResetLevel() end)
  end

  -- Player Movement
  if Game.Input:IsKeyJustDown("W", "UP") then Grid:MovePlayer("UP")
  elseif Game.Input:IsKeyJustDown("A", "LEFT") then Grid:MovePlayer("LEFT")
  elseif Game.Input:IsKeyJustDown("S", "DOWN") then Grid:MovePlayer("DOWN")
  elseif Game.Input:IsKeyJustDown("D", "RIGHT") then Grid:MovePlayer("RIGHT") end
end

-- ============================================================================
-- Event Handler
-- ============================================================================

function Playing:OnGameEvent(event, ...)
  if (event == "LEVEL_COMPLETE") then
    local level = ...
    local nextLevel = next(Addon.Levels, level)

    -- Save as completed
    DB.Profile.CompletedLevels[tostring(level)] = true

    if nextLevel then
      -- Save progress
      DB.Profile.CurrentLevel = nextLevel

      -- Go to next level
      local text = L.LEVEL_TEXT:format(nextLevel)
      Game:TextTransition(text, function()
        self.Frame.LevelText:SetText(text)
        Grid:SetLevel(nextLevel)
      end)
    else
      -- Reset current level
      DB.Profile.CurrentLevel = nil

      -- Go to main menu
      Game:TextTransition(L.NO_MORE_LEVELS_TEXT, function()
        Game:SetState(Addon.GameStates.MainMenu)
      end)
    end
  elseif (event == "TRANSITION_START") then
    Game.Input:SetEnabled(false)
  elseif (event == "TRANSITION_END") then
    if (Game:GetState() == self) then
      Game.Input:SetEnabled(true)
    end
  end
end
