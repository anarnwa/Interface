-- GameObject: module for creating and maintaining game objects.

local LibName, LibVersion = "DethsGameLib", "1.1"
local PREFIX = format("%s_%s_", LibName, LibVersion)

-- DethsLibLoader
local DGL = DethsLibLoader(LibName, LibVersion)
if not DGL.__initial_load then return end
local GameObject = DGL.GameObject
GameObject.Mixins = {}

-- Upvalues
local error, floor, next, pairs, tonumber, type, unpack =
      error, floor, next, pairs, tonumber, type, unpack

local CreateFrame, UIParent = CreateFrame, UIParent

local get, release = DGL.GetTable, DGL.ReleaseTable

-- ============================================================================
-- GameObject Pool
-- ============================================================================

local pool = {}
local count = 0
local ignoreKeys = {
    -- Keys we must ignore when releasing a GameObject
    Game = true,
    Texture = true,
    _animation_parent = true,
    _animation_table = true
  }

-- Returns a game object from the pool.
local function getGameObject(game, name, x, y, layer, level)
  local object = next(pool)
  if object then
    pool[object] = nil
  else
    count = count + 1
    object = get()
    object.Texture = game.WorldFrame:CreateTexture(PREFIX.."Texture"..count)
  end
  
  -- Initialize object
  object.Game = game
  object.Name = name
  object.X = x or 0
  object.Y = y or 0
  object.OFFSET_X = 0
  object.OFFSET_Y = 0

  object.Texture:SetParent(game.WorldFrame)
  object.Texture:SetPoint("TOPLEFT", game.WorldFrame, object.X, -object.Y)
  object.Texture:SetAlpha(1)
  object.Texture:SetRotation(0)
  object.Texture:SetDrawLayer(layer or "ARTWORK", level or 0)
  object.Texture:Show()

  -- Add mixins
  for k, v in pairs(GameObject.Mixins) do object[k] = v end

  return object
end

local function releaseGameObject(object)
  object.Texture:ClearAllPoints()
  object.Texture:SetParent(UIParent)
  object.Texture:Hide()

  -- Clear non-ignored keys
  for k, v in pairs(object) do
    if not ignoreKeys[k] then
      if (type(v) == "table") then release(v) end
      object[k] = nil
    end
  end

  -- Manual clear
  object.Game = nil
  object._animation_parent = nil
  object._animation_table = nil

  -- Release into pool
  pool[object] = true
end

-- ============================================================================
-- GameObject Functions
-- ============================================================================

-- Returns a GameObject.
function GameObject:Create(game, name, x, y, layer, level)
  local gameObject = getGameObject(game, name, x, y, layer, level)
  game._gameObjects[gameObject] = true
  return gameObject
end

-- Updates the game's GameObjects.
-- @table game - the game
-- @number elapsed - the elapsed update time
function GameObject:OnUpdate(game, elapsed)
  for object in pairs(game._gameObjects) do
    object:OnUpdate(elapsed)

    -- Animate
    if object._animation_playing then
      object._animation_timer = object._animation_timer + elapsed
      if (object._animation_timer >= object._animation_table.FrameRate) then
        object._animation_timer = 0

        local nextFrame = object._animation_frame + 1
        if (nextFrame > #object._animation_table.Frames) then
          if object._animation_table.Callback then object._animation_table.Callback(object) end
          if object._animation_looping then
            object._animation_frame = 1
            object.Texture:SetTexCoord(unpack(object._animation_table.Frames[1]))
          else
            object._animation_playing = false
          end
        else
          object._animation_frame = nextFrame
          object.Texture:SetTexCoord(unpack(object._animation_table.Frames[nextFrame]))
        end
      end
    end
  end
end

-- "Renders" the game's GameObjects by repositioning them.
-- @table game - the game
function GameObject:Render(game)
  for object in pairs(game._gameObjects) do
    object.Texture:SetPoint(
      "TOPLEFT",
      floor(object.X - object.OFFSET_X),
      floor(-(object.Y - object.OFFSET_Y))
    )
  end
end

-- ============================================================================
-- GameObject Mixins
-- ============================================================================

do -- Mixins
  local Mixins = GameObject.Mixins
  Mixins.OnUpdate = nop

  -- Disposes the object from the game, hides its texture, and calls its
  -- `OnDispose()` handler if it exists.
  function Mixins:Dispose()
    if self.OnDispose then self:OnDispose() end
    self.Texture:Hide()
    self.Game._gameObjects[self] = nil
    releaseGameObject(self)
  end

  -- ===================================================
  -- Getters & Setters
  -- ===================================================

  -- Returns the object's width.
  function Mixins:GetWidth() return self.WIDTH end

  -- Sets the object's width.
  -- @number width - the new width
  function Mixins:SetWidth(width)
    if (width < 0) then width = 0 end
    self.WIDTH = width
    self.HALF_WIDTH = width * 0.5
    self.Texture:SetWidth(width)
  end
  
  -- Returns the object's height.
  function Mixins:GetHeight() return self.HEIGHT end

  -- Sets the object's height.
  -- @number height - the new height
  function Mixins:SetHeight(height)
    if (height < 0) then height = 0 end
    self.HEIGHT = height
    self.HALF_HEIGHT = height * 0.5
    self.Texture:SetHeight(height)
  end

  -- Returns the offset for the object's texture.
  function Mixins:GetOffset() return self.OFFSET_X, self.OFFSET_Y end

  -- Sets the offset for the object's texture.
  -- @number x - the horizontal offset
  -- @number y - the vertical offset
  function Mixins:SetOffset(x, y)
    self.OFFSET_X = tonumber(x) or 0
    self.OFFSET_Y = tonumber(y) or 0
  end

  -- Returns the xy coordinates representing the center of the object.
  -- @boolean applyOffset - if true the object's offset will be applied
  function Mixins:GetCenter(applyOffset)
    if applyOffset then return
      (self.X + self.HALF_WIDTH) - self.OFFSET_X,
      (self.Y + self.HALF_HEIGHT) - self.OFFSET_Y
    else return
      self.X + self.HALF_WIDTH,
      self.Y + self.HALF_HEIGHT
    end
  end

  -- ===================================================
  -- Animation Functions
  -- ===================================================

  -- Sets the table of animations for the object.
  -- @table animations - the table of animations
  function Mixins:SetAnimations(animations)
    self.Texture:SetTexture(animations.Path)
    self._animation_parent = animations
    self._animation_table = nil
    self._animation_key = nil
    self._animation_playing = false
    self._animation_looping = false
    self._animation_frame = 1
    self._animation_timer = 0
  end

  -- Plays the animation by key.
  -- @string key - the key of the animation to play
  -- @boolean noLoop - if true the animation will not loop
  function Mixins:PlayAnimation(key, noLoop)
    if key then
      self._animation_table = self._animation_parent[key] or error("Invalid animation key.")
      self._animation_key = key
    end
    self.Texture:SetTexCoord(unpack(self._animation_table.Frames[1]))
    self._animation_playing = true
    self._animation_looping = not noLoop
    self._animation_frame = 1
    self._animation_timer = 0
  end

  -- Stops the current animation.
  -- @number frame - the frame number to set the texture to after stopping
  function Mixins:StopAnimation(frame)
    if frame then
      self.Texture:SetTexCoord(unpack(self._animation_table[frame]))
      self._animation_frame = frame
      self._animation_timer = 0
    end
    self._animation_playing = false
  end

  -- Resumes the current animation.
  function Mixins:ResumeAnimation()
    self._animation_playing = true
  end
end
