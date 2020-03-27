local AddonName, Addon = ...

-- Lib
local DGL = Addon.Libs.DGL
local DCL = Addon.Libs.DCL

-- Modules
local Game = Addon.Game
local Utils = Addon.Utils

-- Upvalues
local C_Timer, UIFrameFadeIn, UIFrameFadeOut =
      C_Timer, UIFrameFadeIn, UIFrameFadeOut

-- Consts
local BG_COLOR = { 30 / 255, 34 / 255, 42 / 255 }

-- Variables
local transitionFrame = nil
local transitioning = false

-- ============================================================================
-- General Functions
-- ============================================================================

function Game:Initialize()
  self.Texture:SetColorTexture(unpack(BG_COLOR))

  -- Create window
  DGL:CreateWindow(self, AddonName, Addon.GAME_ICON)

  -- Set initial state
  Game:SetState(Addon.GameStates.MainMenu)

  -- Transition frame
  transitionFrame = Utils:CreateUIFrame("Transition", 10)

  local texture = transitionFrame:CreateTexture("$parentTexture", "OVERLAY")
  texture:SetColorTexture(unpack(BG_COLOR))
  texture:SetAllPoints()
  texture:Hide()
  transitionFrame.Texture = texture

  local text = Utils:CreateFontString({
    parent = transitionFrame,
    name = "Text",
    layer = "OVERLAY",
    size = 36
  })
  text:SetPoint("TOPLEFT", texture, 10, -10)
  text:SetPoint("BOTTOMRIGHT", texture, -10, 10)
  text:SetJustifyH("CENTER")
  text:SetJustifyV("CENTER")
  text:Hide()
  transitionFrame.Text = text
end

-- function Game:OnWindowClosed() end

function Game:IsTransitioning()
  return transitioning
end

-- Fades to black, performs a callback, and fades back out.
-- @param {function} callback - called halfway through the transition
function Game:Transition(callback)
  assert(not transitioning, "Transition already in progress.")
  self.Event:Emit("TRANSITION_START")
  transitioning = true
  -- Fade in texture
  UIFrameFadeIn(transitionFrame.Texture, 0.5)
  C_Timer.After(0.5, function()
    -- Fade out and perform callback
    UIFrameFadeOut(transitionFrame.Texture, 0.5)
    callback()
    -- After texture has faded, set transitioning to false
    C_Timer.After(0.5, function()
      self.Event:Emit("TRANSITION_END")
      transitioning = false
    end)
  end)
end

-- Fades to black, fades in text, performs a callback, and fades back out.
-- @param {string} text - the text to display
-- @param {function} callback - called halfway through the transition
function Game:TextTransition(text, callback)
  assert(not transitioning, "Transition already in progress.")
  self.Event:Emit("TRANSITION_START")
  transitioning = true
  -- Fade in texture
  UIFrameFadeIn(transitionFrame.Texture, 0.5)
  C_Timer.After(0.5, function()
    -- Fade in text
    transitionFrame.Text:SetText(text)
    UIFrameFadeIn(transitionFrame.Text, 0.5)
    C_Timer.After(1, function()
      -- Fade out text and perform callback
      UIFrameFadeOut(transitionFrame.Text, 0.5)
      callback()
      C_Timer.After(0.5, function()
        UIFrameFadeOut(transitionFrame.Texture, 0.5)
        -- After texture has faded, set transitioning to false
        C_Timer.After(0.5, function()
          self.Event:Emit("TRANSITION_END")
          transitioning = false
        end)
      end)
    end)
  end)
end
