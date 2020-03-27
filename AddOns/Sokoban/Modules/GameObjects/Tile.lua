-- Tile: the grid for the game.

local AddonName, Addon = ...

-- Libs
local DGL = Addon.Libs.DGL

-- Modules
local Tile = Addon.GameObjects.Tile
local Game = Addon.Game
local Spritesheet = Addon.Spritesheet

-- Texture coordinates by Type
Tile.Coords = {
  -- Crates
  CRATE_BLACK = Spritesheet.Sprites.Crate_Black.Coords,
  CRATE_BLUE = Spritesheet.Sprites.Crate_Blue.Coords,
  CRATE_BROWN = Spritesheet.Sprites.Crate_Brown.Coords,
  CRATE_GREEN = Spritesheet.Sprites.Crate_Green.Coords,
  CRATE_GREY = Spritesheet.Sprites.Crate_Grey.Coords,
  CRATE_RED = Spritesheet.Sprites.Crate_Red.Coords,
  -- Face
  FACE = Spritesheet.Sprites.Face.Coords,
  -- Ground
  GROUND = Spritesheet.Sprites.Ground.Coords,
  -- Marker
  MARKER = Spritesheet.Sprites.Marker.Coords,
  -- Player
  PLAYER_DOWN = Spritesheet.Sprites.Player_Down.Coords,
  PLAYER_LEFT = Spritesheet.Sprites.Player_Left.Coords,
  PLAYER_RIGHT = Spritesheet.Sprites.Player_Right.Coords,
  PLAYER_UP = Spritesheet.Sprites.Player_Up.Coords,
  -- Wall
  WALL = Spritesheet.Sprites.Wall.Coords,
}

-- Types
Tile.Types = {}
for k in pairs(Tile.Coords) do Tile.Types[k] = k end

-- Types by ID (see Converter.py)
Tile.TypeByID = {
  [1] = "GROUND",
  [2] = "WALL",
  [3] = "CRATE_BROWN",
  [4] = "MARKER",
  [5] = "PLAYER_DOWN",
}

-- Mixins
local Mixins = {}

-- ============================================================================
-- General Functions
-- ============================================================================

-- Returns a new tile.
function Tile:Create(x, y, layer)
  local tile = DGL.GameObject:Create(Game, "Tile", x, y, nil, layer)
  tile:SetWidth(Addon.TILE_SIZE)
  tile:SetHeight(Addon.TILE_SIZE)
  tile.Texture:SetTexture(Spritesheet.Path)
  for k, v in pairs(Mixins) do tile[k] = v end
  return tile
end

-- ============================================================================
-- Mixins
-- ============================================================================

-- Sets the type of the tile.
function Mixins:SetType(type)
  if not type or (type == 0) then
    self.type = nil
    self.Texture:Hide()
    return
  end

  if Tile.TypeByID[type] then type = Tile.TypeByID[type] end
  assert(Tile.Types[type], "invalid type: "..type)

  self.Texture:SetTexCoord(unpack(Tile.Coords[type]))
  self.Texture:Show()

  self.type = type
  self.prefix = type:match("([^_]+)")
  self.suffix = type:match("_(.+)")
end

function Mixins:IsCrate() return self.type and self.type:find("CRATE", 1, true) end
function Mixins:IsMarker() return (self.type == "MARKER") end
function Mixins:IsPlayer() return self.type and self.type:find("PLAYER", 1, true) end
function Mixins:IsWall() return (self.type == "WALL") end
