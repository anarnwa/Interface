-- DethsLibLoader
local DGL = DethsLibLoader("DethsGameLib", "1.1")
if not DGL.__initial_load then return end
local Input = DGL.Input

-- Upvalues
local next, select = next, select

local GetCursorPosition = GetCursorPosition

-- Mixins
local InputMixins = {}
local GameScripts = {}

-- ============================================================================
-- General Functions
-- ============================================================================

-- Adds the Input module to the specified game.
-- @table game - the game
function Input:AddMixins(game)
  local input = {
    Game = game,
    Frame = game.Frame,

    mouse_down = {},
    mouse_just_down = {},
    mouse_just_up = {},
    keys_down = {},
    keys_just_down = {},
    keys_just_up = {},
  }

  -- Mixins
  for k, v in next, InputMixins do input[k] = v end
  for k, v in next, GameScripts do game.Frame:SetScript(k, v) end

  game.Frame:EnableMouse(true)
  game.Frame:EnableKeyboard(false)
  game.Frame:SetPropagateKeyboardInput(false)
  game.Input = input
end

-- Updates the specified game's Input module.
-- @table game - the game
function Input:OnUpdate(game)
  local input = game.Input
  if not input then return end
  -- Wipe all "just" inputs
  for k in next, input.mouse_just_down do input.mouse_just_down[k] = nil end
  for k in next, input.mouse_just_up do input.mouse_just_up[k] = nil end
  for k in next, input.keys_just_down do input.keys_just_down[k] = nil end
  for k in next, input.keys_just_up do input.keys_just_up[k] = nil end
end

-- ============================================================================
-- InputMixins
-- ============================================================================

-- Enables or disables keyboard input for the game.
-- @boolean enabled - if true keyboard input will be enabled
function InputMixins:SetEnabled(enabled)
  self.Frame:EnableKeyboard(enabled)
  if not enabled then -- Clear cached input
    for k in next, self.mouse_down do self.mouse_down[k] = nil end
    for k in next, self.keys_down do self.keys_down[k] = nil end
  end
end

do
  -- Returns true if the specified table contains at least one specified key.
  -- @table t - the table to check
  -- @varargs ... - the keys to check
  local function check(t, ...)
    for i=1, select("#", ...) do
      local k = select(i, ...)
      if t[k] then return true end
    end
    return false
  end
  
  -- Returns true if a specified mouse button is down.
  -- @string button - the button to check for
  -- @varargs ... - additional buttons to check for
  function InputMixins:IsMouseDown(button, ...) return check(self.mouse_down, button, ...) end

  -- Returns true if a specified mouse button was just pressed.
  -- @string button - the button to check for
  -- @varargs ... - additional buttons to check for
  function InputMixins:IsMouseJustDown(button, ...) return check(self.mouse_just_down, button, ...) end

  -- Returns true if a specified mouse button was just released.
  -- @string button - the button to check for
  -- @varargs ... - additional buttons to check for
  function InputMixins:IsMouseJustUp(button, ...) return check(self.mouse_just_up, button, ...) end

  -- Returns true if a specified key is down.
  -- @string key - the key to check for
  -- @varargs ... - additional keys to check for
  function InputMixins:IsKeyDown(key, ...) return check(self.keys_down, key, ...) end

  -- Returns true if a specified key was just pressed.
  -- @string key - the key to check for
  -- @varargs ... - additional keys to check for
  function InputMixins:IsKeyJustDown(key, ...) return check(self.keys_just_down, key, ...) end

  -- Returns true if a specified key was just released.
  -- @string key - the key to check for
  -- @varargs ... - additional keys to check for
  function InputMixins:IsKeyJustUp(key, ...) return check(self.keys_just_up, key, ...) end
end

-- Returns the mouse position relative to the game's top left corner.
function InputMixins:GetMouse()
  local scale = self.Frame:GetEffectiveScale()
  local x, y = GetCursorPosition()
  return -(self.Frame:GetLeft() - (x / scale)), (self.Frame:GetTop() - (y / scale))
end

-- Returns the x-coordinate for the mouse relative to the game's top left corner.
function InputMixins:GetMouseX()
  local x = GetCursorPosition() / self.Frame:GetEffectiveScale()
  return -(self.Frame:GetLeft() - x)
end

-- Returns the y-coordinate for the mouse relative to the game's top left corner.
function InputMixins:GetMouseY()
  local y = select(2, GetCursorPosition()) / self.Frame:GetEffectiveScale()
  return (self.Frame:GetTop() - y)
end

-- ============================================================================
-- GameScripts
-- ============================================================================

function GameScripts:OnMouseDown(button)
  self.Game.Input.mouse_down[button] = true
  self.Game.Input.mouse_just_down[button] = true
end

function GameScripts:OnMouseUp(button)
  self.Game.Input.mouse_down[button] = nil
  self.Game.Input.mouse_just_up[button] = true
end

function GameScripts:OnKeyDown(key)
  self.Game.Input.keys_down[key] = true
  self.Game.Input.keys_just_down[key] = true
end

function GameScripts:OnKeyUp(key)
  self.Game.Input.keys_down[key] = nil
  self.Game.Input.keys_just_up[key] = true
end
