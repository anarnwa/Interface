-- Modules: initializes all module tables to circumvent load order issues.

local AddonName, Addon = ...

-- Consts
Addon.GAME_ICON = ("Interface\\AddOns\\%s\\Assets\\Icon"):format(AddonName) --132761 -- Inv_crate_01
Addon.GRID_WIDTH = 12
Addon.GRID_HEIGHT = 12
Addon.TILE_SIZE = 32
Addon.TITLE_COLOR = "2ECC71"

Addon.GROUND_SUBLAYER = -1
Addon.TILE_SUBLAYER = 0
Addon.MARKER_SUBLAYER = 1

-- Libs
local DGL = DethsLibLoader("DethsGameLib", "1.1")

Addon.Libs = {
  L = LibStub('AceLocale-3.0'):GetLocale(AddonName),
  LDB = LibStub("LibDataBroker-1.1"),
  LDBIcon = LibStub("LibDBIcon-1.0"),
  DCL = DethsLibLoader("DethsColorLib", "1.1"),
  DGL = DGL,
}

-- Initialize module tables
Addon.Core = DethsLibLoader("DethsAddonLib", "1.0"):Create(AddonName)
Addon.DB = {}
Addon.Levels = {}
Addon.MinimapIcon = {}
Addon.Utils = {}

Addon.Game = DGL:Create(
  Addon.GRID_WIDTH * Addon.TILE_SIZE,
  Addon.GRID_HEIGHT * Addon.TILE_SIZE
)

Addon.GameStates = {
  MainMenu = {},
  LevelSelection = {},
  Playing = {},
  Paused = {}
}

Addon.GameObjects = {
  Grid = {},
  Tile = {}
}
