-- Grid: the grid for the game.

local AddonName, Addon = ...

-- Libs
local DGL = Addon.Libs.DGL

-- Modules
local Grid = Addon.GameObjects.Grid
local Tile = Addon.GameObjects.Tile
local Game = Addon.Game

Grid.Positioner = CreateFrame("Frame", AddonName.."GridPositioner", Game.Frame)
Grid.Positioner:SetPoint("CENTER")

-- Variables
local player_cx, player_cy = 0, 0
local tiles = {}
local markers = {}
local ground = {}

-- ============================================================================
-- Helper Functions
-- ============================================================================

-- Converts xy coordinates to cell coordinates.
local function toCell(x, y)
  return (x / Addon.TILE_SIZE), (y / Addon.TILE_SIZE)
end

-- Converts cell coordinates to xy coordinates.
local function toCoords(cx, cy)
  return ((cx - 1) * Addon.TILE_SIZE), ((cy - 1) * Addon.TILE_SIZE)
end

-- Returns tile cell coordinates based on array index.
local function getCell(i, width)
  local cx, cy = i, 1
  while (cx > width) do
    cx = cx - width
    cy = cy + 1
  end
  return cx, cy
end

-- ============================================================================
-- General Functions
-- ============================================================================

function Grid:Clear()
  for k, v in pairs(tiles)   do tiles[k]   = nil; v:Dispose() end
  for k, v in pairs(markers) do markers[k] = nil; v:Dispose() end
  for k, v in pairs(ground)  do ground[k]  = nil; v:Dispose() end
  player_cx, player_cy = 0, 0
end

function Grid:ResetLevel()
  self:SetLevel(self.level_index)
end

function Grid:GetLevel()
  return self.level_index or 1
end

function Grid:SetLevel(level_index)
  local level = Addon.Levels[level_index] or Addon.Levels[1]
  assert(level.width <= Addon.GRID_WIDTH)
  assert(level.height <= Addon.GRID_HEIGHT)

  self.level_index = level_index
  self:Clear()

  -- Positioner
  self.Positioner:SetWidth(level.width * Addon.TILE_SIZE)
  self.Positioner:SetHeight(level.height * Addon.TILE_SIZE)

  -- Load tiles
  for i, tileID in ipairs(level.tiles) do
    if (tileID ~= 0) then
      local cx, cy = getCell(i, level.width)
      local x, y = toCoords(cx, cy)
      local tile = Tile:Create(x, y, Addon.TILE_SUBLAYER)
      tile:SetType(tileID)
      tile.Texture:SetParent(self.Positioner)
      tiles[cx..","..cy] = tile
      if tile:IsPlayer() then player_cx, player_cy = cx, cy end
    end
  end

  -- Load markers
  for i, tileID in ipairs(level.markers) do
    if (tileID ~= 0) then
      local cx, cy = getCell(i, level.width)
      local x, y = toCoords(cx, cy)
      local tile = Tile:Create(x, y, Addon.MARKER_SUBLAYER)
      tile:SetType(tileID)
      tile.Texture:SetParent(self.Positioner)
      markers[cx..","..cy] = tile
    end
  end

  -- Load ground
  for i, tileID in ipairs(level.ground) do
    if (tileID ~= 0) then
      local cx, cy = getCell(i, level.width)
      local x, y = toCoords(cx, cy)
      local tile = Tile:Create(x, y, Addon.GROUND_SUBLAYER)
      tile:SetType(tileID)
      tile.Texture:SetParent(self.Positioner)
      ground[cx..","..cy] = tile
    end
  end
end

function Grid:MovePlayer(dir)
  local new_cx, new_cy = player_cx, player_cy
  local new_box_cx, new_box_cy = player_cx, player_cy
  local player = tiles[player_cx..","..player_cy]

  player.Texture:SetTexCoord(unpack(Tile.Coords["PLAYER_"..dir]))

  if (dir == "UP") then
    if (player_cy == 1) then return end
    new_cy = new_cy - 1
    new_box_cy = new_cy - 1
  elseif (dir == "LEFT") then
    if (player_cx == 1) then return end
    new_cx = new_cx - 1
    new_box_cx = new_cx - 1
  elseif (dir == "DOWN") then
    if (player_cy == Addon.GRID_HEIGHT) then return end
    new_cy = new_cy + 1
    new_box_cy = new_cy + 1
  elseif (dir == "RIGHT") then
    if (player_cx == Addon.GRID_WIDTH) then return end
    new_cx = new_cx + 1
    new_box_cx = new_cx + 1
  end

  -- Don't move unless tile is empty or is a box
  local tile = tiles[new_cx..","..new_cy]
  if not tile or tile:IsCrate() then
    if not tile then
      -- Move player
      self:MoveTile(player_cx, player_cy, new_cx, new_cy)
      player_cx, player_cy = new_cx, new_cy
    elseif self:CanMoveCrate(new_box_cx, new_box_cy) then
      -- Move box
      self:MoveTile(new_cx, new_cy, new_box_cx, new_box_cy)
      -- Move player
      self:MoveTile(player_cx, player_cy, new_cx, new_cy)
      player_cx, player_cy = new_cx, new_cy
    end
  end

  if self:IsLevelComplete() then Game.Event:Emit("LEVEL_COMPLETE", self.level_index) end
end

function Grid:CanMoveCrate(new_cx, new_cy)
  -- Tile location must be empty, and we cannot move off screen
  local validTile = not tiles[new_cx..","..new_cy]
  local canMoveHorizontal = (new_cx >= 1) and (new_cx <= Addon.GRID_WIDTH)
  local canMoveVertical = (new_cy >= 1) and (new_cy <= Addon.GRID_HEIGHT)
	return validTile and canMoveHorizontal and canMoveVertical
end

function Grid:MoveTile(cx, cy, new_cx, new_cy)
  local cell = cx..","..cy
  local tile = tiles[cell] or error(("No tile to move: (%s, %s)"):format(cx, cy))
  tiles[cell] = nil
  tile.X, tile.Y = toCoords(new_cx, new_cy)
  tiles[new_cx..","..new_cy] = tile
end

-- Returns true if all marker locations contain a crate.
function Grid:IsLevelComplete()
  for cell, marker in pairs(markers) do
    local tile = tiles[cell]
    if not tile or (tile.prefix ~= "CRATE") then return false end
  end
  return true
end
