-- GameState: handles the state for a DGL Game.

-- This code was heavily inspired by hump's gamestate:
-- https://github.com/vrld/hump/blob/master/gamestate.lua

local LibName, LibVersion = "DethsGameLib", "1.1"
local PREFIX = format("%s_%s_", LibName, LibVersion)

-- DethsLibLoader
local DGL = DethsLibLoader(LibName, LibVersion)
if not DGL.__initial_load then return end
local GameState = DGL.GameState

-- Upvalues
local assert, error, pairs, setmetatable = assert, error, pairs, setmetatable

-- Mixins
local GameMixins = {}

-- Consts
local WEAK_KEY_MT = { __mode = "k" }

-- ============================================================================
-- General Functions
-- ============================================================================

-- A default game state.
local default_state = setmetatable({OnLeave = nop}, {
  __index = function() error("Initial game state not set.") end
})

function GameState:AddMixins(game)
  local gameState = {
    stack = { default_state },
    initialized_states = setmetatable({}, WEAK_KEY_MT)
  }

  -- Add mixins
  for k, v in pairs(GameMixins) do game[k] = v end

  game.GameState = gameState
end

-- ============================================================================
-- GameMixins
-- ============================================================================

-- Changes the current state either by setting or pushing the specified state.
-- Calls the new state's `Initialize()` handler (if necessary), followed by its
-- `OnEnter()` handler.
-- @number stack_offset - 0 to set the state, 1 to push
-- @table state - the new state
-- @varargs ... - additional parameters for the new state's `OnEnter()` handler
local function change_state(gameState, stack_offset, state, ...)
  local initialized_states = gameState.initialized_states
  local stack = gameState.stack
  local lastState = stack[#stack]
  
  if not initialized_states[state] and state.Initialize then state:Initialize() end
  initialized_states[state] = true
  
  stack[#stack+stack_offset] = state
  if state.OnEnter then return state:OnEnter(lastState, ...) end
end

-- Returns the current state.
function GameMixins:GetState()
  local stack = self.GameState.stack
  return stack[#stack]
end

-- Sets the current state to the one specified after calling the current state's
-- `OnLeave()` handler.
-- @table state - the new state
-- @varargs ... - additional parameters for the new state's `OnEnter()` handler
function GameMixins:SetState(state, ...)
  if (state == self) then error("Attempt to set the game as state.") end
  local stack = self.GameState.stack
  local lastState = stack[#stack]
  if lastState.OnLeave then lastState:OnLeave() end
  return change_state(self.GameState, 0, state, ...)
end

-- Pushes the specified state onto the stack after calling the current state's
-- `OnPause()` handler.
-- @table state - the new state
-- @varargs ... - additional parameters for the new state's `OnEnter()` handler
function GameMixins:PushState(state, ...)
  if (state == self) then error("Attempt to push the game as state.") end
  local stack = self.GameState.stack
  local lastState = stack[#stack]
  if lastState.OnPause then lastState:OnPause() end
  return change_state(self.GameState, 1, state, ...)
end

-- Pops the current state from the stack and calls its `OnLeave()` handler,
-- followed by a call to the previous state's `OnResume()` handler.
-- @varargs ... - additional parameters for the previous state's `OnResume()` handler
function GameMixins:PopState(...)
  local stack = self.GameState.stack
  assert(#stack > 1, "No states to pop.")
  local lastState, state = stack[#stack], stack[#stack-1]
  stack[#stack] = nil
  if lastState.OnLeave then lastState:OnLeave() end
  if state.OnResume then return state:OnResume(lastState, ...) end
end

-- Calls `OnUpdate()` on the current state. This function is automatically
-- called in the default OnUpdate script for a Game.Frame.
-- @number elapsed - the elapsed update time
function GameMixins:UpdateState(elapsed)
  local state = self.GameState.stack[#self.GameState.stack]
  if state.OnUpdate then state:OnUpdate(elapsed) end
end
