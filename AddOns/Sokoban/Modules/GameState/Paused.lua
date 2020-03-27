-- Paused: the paused state for the game.

local AddonName, Addon = ...

-- Libs
local L = Addon.Libs.L
local DCL = Addon.Libs.DCL
local DGL = Addon.Libs.DGL

-- Modules
local Paused = Addon.GameStates.Paused
local Game = Addon.Game
local Utils = Addon.Utils

-- ============================================================================
-- GameState Functions
-- ============================================================================

function Paused:Initialize()
  local parent = Utils:CreateUIFrame("Paused", 2)
  self.Frame = parent

  -- Dark overlay
  parent.Texture = parent:CreateTexture("$parentTexture", "OVERLAY")
  parent.Texture:SetColorTexture(0, 0, 0, 0.85)
  parent.Texture:SetAllPoints()

  -- Text
  parent.Text = Utils:CreateFontString({
    parent = parent,
    name = "Text",
    layer = "OVERLAY",
    size = 46,
    text = strupper(L.PAUSED_TEXT),
    point = { "CENTER", parent.Texture }
  })
end

function Paused:OnEnter(lastState, ...)
  self.Frame:Show()
  Game.Input:SetEnabled(false)
end

function Paused:OnLeave()
  self.Frame:Hide()
  Game.Input:SetEnabled(true)
end

-- function Paused:OnResume(lastState, ...) end
-- function Paused:OnPause() end

function Paused:OnUpdate(elapsed)
  if Game.Input:IsMouseJustDown("RightButton") then Game:PopState() end
end
