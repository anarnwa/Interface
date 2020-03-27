-- https://github.com/moody/DethsGameLib

local LibName, LibVersion = "DethsGameLib", "1.1"
local PREFIX = format("%s_%s_", LibName, LibVersion)

-- DethsLibLoader
local DGL = DethsLibLoader:Create(LibName, LibVersion)
if not DGL then return end

-- Modules
DGL.Event = {}
DGL.GameObject = {}
DGL.GameState = {}
DGL.Input = {}
DGL.Libs = {}

-- Upvalues
local assert, ceil, floor, next, min, max, type, unpack, tremove =
      assert, ceil, floor, next, min, max, type, unpack, table.remove

local CreateFrame, GetTime, UIParent, UISpecialFrames =
      CreateFrame, GetTime, UIParent, UISpecialFrames

-- Mixins
local GameMixins = {}
local FrameScripts = {}

-- Consts
local DEFAULT_WIDTH, DEFAULT_HEIGHT = 800, 600

-- ============================================================================
-- General Functions
-- ============================================================================

do -- DGL:Create()
  local count = 0

  -- Returns a new game.
  -- @number width - the width of the game
  -- @number height - the height of the game
  function DGL:Create(width, height)
    count = count + 1

    -- Create game
    local game = { _gameObjects = {} }

    -- Initalize frame
    game.Frame = CreateFrame("Frame", PREFIX.."Frame"..count, UIParent)
    game.Frame.Game = game
    game.Frame.accumulator = 0
    game.Frame.currentTime = GetTime()
    game.Frame:SetClipsChildren(true)
    game.Frame:SetPoint("CENTER")

    -- Initialize world frame
    game.WorldFrame = CreateFrame("Frame", PREFIX.."WorldFrame"..count, game.Frame)
    game.WorldFrame:SetPoint("TOPLEFT")

    -- Add background texture
    game.Texture = game.Frame:CreateTexture(nil, "BACKGROUND")
    game.Texture:SetColorTexture(0.03, 0.03, 0.03, 1)
    game.Texture:SetAllPoints()

    -- Add mixins
    for k, v in next, GameMixins do game[k] = v end
    for k, v in next, FrameScripts do game.Frame:SetScript(k, v) end
    self.Event:AddMixins(game)
    self.GameState:AddMixins(game)
    self.Input:AddMixins(game)
    
    -- Initialize Frame and WorldFrame size
    game:SetWidth(width)
    game:SetHeight(height)
    game:SetWorldWidth(width)
    game:SetWorldHeight(height)
    game:SetCameraPoint(0, 0)

    return game
  end
end

do -- DGL:CreateWindow()
  local WINDOW_COLOR = {45/255, 125/255, 154/255, 1}
  local BUTTON_HI_COLOR = {220/255, 20/255, 60/255, 1} -- CSS Crimson
  local BACKDROP = {
    bgFile = "Interface/Buttons/WHITE8X8",
    edgeFile = "Interface/Buttons/WHITE8X8",
    edgeSize = 1,
  }

  local count = 0

  local mixins = {}
  function mixins:SetTitle(title) self.title:SetText(title) end
  function mixins:SetIcon(icon) self.icon.texture:SetTexture(icon) end
  function mixins:Toggle() if self:IsShown() then self:Hide() else self:Show() end end

  local scripts = {}
  function scripts:OnDragStart() self:StartMoving() end
  function scripts:OnDragStop() self:StopMovingOrSizing() end
  function scripts:OnHide() if self.Game.OnWindowClosed then self.Game:OnWindowClosed() end end

  local closeScripts = {}
  function closeScripts:OnEnter() self.texture:SetColorTexture(unpack(BUTTON_HI_COLOR)) end
  function closeScripts:OnLeave() self.texture:SetColorTexture(0, 0, 0, 0) end
  function closeScripts:OnClick() self:GetParent():Hide() end

  -- Creates a simple window equipped with an icon, title, and close button to nest the game in.
  -- Game:OnWindowClosed() is attempted to be called whenever the window is hidden.
  -- @table game - the game to create the window for
  -- @string title - the title text for window
  -- @string|number icon - the icon to display in the window [optional]
  -- @table color - an array of color values (e.g. { r, g, b[, a] }) [optional]
  -- @table borderColor - an array of color values (e.g. { r, g, b[, a] }) [optional]
  function DGL:CreateWindow(game, title, icon, color, borderColor)
    assert(type(game) == "table", "game must be a table")
    assert(type(title) == "string", "title must be a string")
    if icon then assert((type(icon) == "string") or (type(icon) == "number"), "icon must be a string or number") end
    if color then assert((type(color) == "table"), "color must be a table") else color = WINDOW_COLOR end
    if borderColor then assert((type(borderColor) == "table"), "borderColor must be a table") else borderColor = WINDOW_COLOR end

    count = count + 1
    
    -- Frame
    local window = CreateFrame("Frame", PREFIX.."Window"..count, UIParent)
    window:SetPoint("CENTER")
    window:SetFrameStrata("FULLSCREEN_DIALOG")
    window:SetToplevel(true)
    -- Make draggable
    window:SetClampedToScreen(true)
    window:EnableMouse(true)
    window:SetMovable(true)
    window:RegisterForDrag("LeftButton")
    -- Allow WoW to handle hiding window when necessary
    UISpecialFrames[#UISpecialFrames+1] = window:GetName()
    -- Backdrop
    window:SetBackdrop(BACKDROP)
    window:SetBackdropColor(unpack(color))
    window:SetBackdropBorderColor(unpack(borderColor))

    -- Window <-> Game
    window.Game = game
    game.Window = window

    -- Position game
    game.Frame:SetParent(window)
    game.Frame:ClearAllPoints()
    game.Frame:SetPoint("BOTTOM", 0, 1)

    -- Children
    window.icon = window:CreateTexture(nil, "OVERLAY", nil, 7)
    window.title = window:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    window.close = CreateFrame("Button", nil, window)

    do -- Title
      window.title:SetTextColor(1, 1, 1, 1)
      window.title:SetShadowColor(0, 0, 0, 0)
      window.title:SetText(title)
      window.title:SetPoint("LEFT", window.icon, "RIGHT", 1, 0)
      window.title:SetPoint("RIGHT", window.close, "LEFT", -3, 0)
      window.title:SetJustifyH("LEFT")
    end

    do -- Icon
      local size = ceil(window.title:GetStringHeight()) + 10
      window.icon:SetWidth(size)
      window.icon:SetHeight(size)
      window.icon:SetPoint("TOPLEFT", 1, -1)
      -- Texture
      window.icon.texture = window:CreateTexture(nil, "OVERLAY", nil, 7)
      if icon then window.icon.texture:SetTexture(icon) end
      window.icon.texture:SetWidth(size-5)
      window.icon.texture:SetHeight(size-5)
      window.icon.texture:SetPoint("CENTER", window.icon)
    end

    do -- Close button
      -- "X"
      window.close.text = window.close:CreateFontString(nil, "OVERLAY", "GameFontNormal")
      window.close.text:SetTextColor(1, 1, 1, 1)
      window.close.text:SetShadowColor(0, 0, 0, 0)
      window.close.text:SetText("X")
      window.close:SetFontString(window.close.text)
      -- Texture
      window.close.texture = window.close:CreateTexture()
      window.close.texture:SetAllPoints()
      window.close.texture:SetColorTexture(0, 0, 0, 0)
      -- Set point and size
      window.close:SetPoint("TOPRIGHT", -1, -1)
      window.close:SetWidth(max(ceil(window.close.text:GetStringWidth()) + 10, 35))
      window.close:SetHeight(window.icon:GetHeight())
      -- Mixins
      for k, v in pairs(closeScripts) do window.close:SetScript(k, v) end
    end
    
    -- +2 for 1px horizontal padding
    window:SetWidth(ceil(game.WIDTH + 2))
    -- +3 for 1px vertical padding and 1px space between title and game
    window:SetHeight(ceil(game.HEIGHT + window.icon:GetHeight() + 3))

    -- Mixins
    for k, v in pairs(mixins) do window[k] = v end
    for k, v in pairs(scripts) do window:SetScript(k, v) end

    -- Return
    return window
  end
end

do -- DGL.GetTable(), DGL.ReleaseTable()
  local pool = {}

  -- Returns an empty table from the pool, or a new one.
  function DGL.GetTable()
    local t = next(pool)
    if t then pool[t] = nil else t = {} end
    return t
  end

  -- Recursively cleans and releases a table into the pool.
  -- @table t - the table to release
  function DGL.ReleaseTable(t)
    if (t == DGL) then error("Attempt to pass DGL to DGL.ReleaseTable(t)!") end
    for k, v in next, t do
      if (type(v) == "table") then DGL.ReleaseTable(v) end
      t[k] = nil
    end
    pool[t] = true
  end
end

-- ============================================================================
-- GameMixins
-- ============================================================================

-- Returns the width of the game.
function GameMixins:GetWidth() return self.WIDTH end

-- Sets the width of the game.
-- @number width - the new width
function GameMixins:SetWidth(width)
  if not (type(width) == "number") or (width <= 0) then width = DEFAULT_WIDTH end
  self.WIDTH = width
  self.HALF_WIDTH = width * 0.5
  self.Frame:SetWidth(width)
end

-- Returns the height of the game.
function GameMixins:GetHeight() return self.HEIGHT end

-- Sets the height of the game.
-- @number height - the new height
function GameMixins:SetHeight(height)
  if not (type(height) == "number") or (height <= 0) then height = DEFAULT_HEIGHT end
  self.HEIGHT = height
  self.HALF_HEIGHT = height * 0.5
  self.Frame:SetHeight(height)
end

-- Returns the width of the game world.
function GameMixins:GetWorldWidth() return self.WORLD_WIDTH end

-- Sets the width of the game world.
-- @number width - the new width
function GameMixins:SetWorldWidth(width)
  if not (type(width) == "number") or (width <= 0) then width = DEFAULT_WIDTH end
  self.WORLD_WIDTH = width
  self.WORLD_HALF_WIDTH = width * 0.5
  self.WorldFrame:SetWidth(width)
end

-- Returns the height of the game world.
function GameMixins:GetWorldHeight() return self.WORLD_HEIGHT end

-- Sets the height of the game world.
-- @number height - the new height
function GameMixins:SetWorldHeight(height)
  if not (type(height) == "number") or (height <= 0) then height = DEFAULT_HEIGHT end
  self.WORLD_HEIGHT = height
  self.WORLD_HALF_HEIGHT = height * 0.5
  self.WorldFrame:SetHeight(height)
end

-- Returns the xy coordinates of the game world centered in the game frame.
function GameMixins:GetCameraPoint() return self._cameraPoint_x, self._cameraPoint_y end

-- Sets the xy coordinates of the game world to be centered in the game frame.
-- @number x - the x coordinate
-- @number y - the y coordinate
-- @boolean noClamp - if true the game world will not be clamped within the game frame
function GameMixins:SetCameraPoint(x, y, noClamp)
  if not x then x = 0 end
  if not y then y = 0 end
  if noClamp then
    self._cameraPoint_x = x - self.HALF_WIDTH
    self._cameraPoint_y = y - self.HALF_HEIGHT
  else
    self._cameraPoint_x = max(min(x - self.HALF_WIDTH, self.WORLD_WIDTH - self.WIDTH), 0)
    self._cameraPoint_y = max(min(y - self.HALF_HEIGHT, self.WORLD_HEIGHT - self.HEIGHT), 0)
  end
end

-- ============================================================================
-- FrameScripts
-- ============================================================================

local DT = 0.01

-- Default OnUpdate script for all games' Frame.
function FrameScripts:OnUpdate(elapsed)
  local game = self.Game
  local newTime = GetTime()
  local frameTime = newTime - self.currentTime
  self.currentTime = newTime

  -- Update game and input
  self.accumulator = self.accumulator + frameTime
  while (self.accumulator >= DT) do
    game:UpdateState(DT)
    DGL.Input:OnUpdate(game)
    self.accumulator = self.accumulator - DT
  end

  -- Render game objects
  DGL.GameObject:Render(game)

  -- Update position of WorldFrame
  game.WorldFrame:SetPoint("TOPLEFT", -game._cameraPoint_x, game._cameraPoint_y)
end
