-- DethsLibLoader
local DGL = DethsLibLoader("DethsGameLib", "1.1")
if not DGL.__initial_load then return end
local Event = DGL.Event

-- Upvalues
local assert, next, select, type = assert, next, select, type

-- Mixins
local EventMixins = {}

-- ============================================================================
-- General Functions
-- ============================================================================

-- Adds the Event module to the specified game.
-- @table game - the game
function Event:AddMixins(game)
  game.Event = { _listeners = {} }
  for k, v in next, EventMixins do game.Event[k] = v end
end

-- ============================================================================
-- Mixin Functions
-- ============================================================================

-- Registers a table for the specified events.
-- @table listener - a table which implements a function: OnGameEvent(event, ...)
-- @varargs ... - events to listen for
function EventMixins:Register(listener, ...)
  assert(type(listener) == "table", "listener must be a table")
  assert(type(listener.OnGameEvent) == "function", "listener must have function \"listener:OnGameEvent(event, ...)\"")
  for i=1, select("#", ...) do
    local event = select(i, ...)
    if not self._listeners[event] then self._listeners[event] = {} end
    self._listeners[event][listener] = true
  end
end

-- Unregisters a table from the specified events. If no events are specified
-- then all events are unregistered.
-- @table listener - the event listener
-- @varargs ... - the events to unregister [optional]
function EventMixins:Unregister(listener, ...)
  if (select("#", ...) == 0) then -- Unregister all
    for event in next, self._listeners do
      self._listeners[event][listener] = nil
    end
  else -- Unregister specified
    for i=1, select("#", ...) do
      local event = select(i, ...)
      if self._listeners[event] then
        self._listeners[event][listener] = nil
      end
    end
  end
end

-- Emits an event with the specified parameters.
-- @var event - the event to emit
-- @varargs ... - the parameters to pass to the event's listeners [optional]
function EventMixins:Emit(event, ...)
  if self._listeners[event] then
    for listener in next, self._listeners[event] do
      listener:OnGameEvent(event, ...)
    end
  end
end
