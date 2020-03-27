-- MainMenu: the main menu state for the game.

local AddonName, Addon = ...

-- Libs
local L = Addon.Libs.L
local DCL = Addon.Libs.DCL
local DGL = Addon.Libs.DGL

-- Modules
local MainMenu = Addon.GameStates.MainMenu
local Game = Addon.Game
local Grid = Addon.GameObjects.Grid
local Tile = Addon.GameObjects.Tile
local Utils = Addon.Utils

-- Variables
local tiles = {}

-- ============================================================================
-- GameState Functions
-- ============================================================================

function MainMenu:Initialize()
  local parent = Utils:CreateUIFrame("MainMenu")
  self.Frame = parent

  -- Title
  parent.TitleText = Utils:CreateFontString({
    parent = parent,
    name = "TitleText",
    size = 58,
    text = strupper(AddonName),
    point = { "TOP", 0, -10 }
  })

  do -- Play button
    parent.PlayButton = Utils:CreateButton({
      parent = parent,
      width = Game.WIDTH * 0.75,
      name = "PlayButton",
      onClick = function()
        Game:TextTransition(L.LEVEL_SELECT_TEXT, function()
          Game:SetState(Addon.GameStates.LevelSelection)
        end)
      end
    })

    local fs = Utils:CreateFontString({
      parent = parent.PlayButton,
      size = 28,
      text = L.PLAY_TEXT
    })

    parent.PlayButton:SetHeight(fs:GetStringHeight() + 20)
    parent.PlayButton:SetFontString(fs)
  end

  do -- Quit button
    parent.QuitButton = Utils:CreateButton({
      parent = parent,
      width = Game.WIDTH * 0.75,
      name = "QuitButton",
      point = { "BOTTOM", 0, 10 },
      onClick = function() Game.Window:Hide() end
    })

    local fs = Utils:CreateFontString({
      parent = parent.QuitButton,
      size = 16,
      text = L.QUIT_TEXT
    })

    parent.QuitButton:SetHeight(fs:GetStringHeight() + 15)
    parent.QuitButton:SetFontString(fs)
  end

  parent.PlayButton:SetPoint("BOTTOM", parent.QuitButton, "TOP", 0, 7)
end

function MainMenu:OnEnter(lastState, ...)
  self.Frame:Show()
  Grid:Clear()

  do -- Add background tiles
    local minX, maxX = 2, 9
    local minY, maxY = 3, 7
    local groundLayer = -8
    local wallLayer = groundLayer + 1
    local topLayer = wallLayer + 1

    do -- GROUND
      for x=minX+1, maxX-1 do
        for y=minY+1, maxY-1 do
          local tile = Tile:Create(
            x * Addon.TILE_SIZE,
            y * Addon.TILE_SIZE,
            groundLayer
          )
          tile:SetType("GROUND")
          tiles[tile] = true
        end
      end
    end

    do -- WALL
      for x=minX, maxX do
        for y=minY, maxY do
          if (y == minY or y == maxY) or (x == minX or x == maxX) then
            local tile = Tile:Create(
              x * Addon.TILE_SIZE,
              y * Addon.TILE_SIZE,
              wallLayer
            )
            tile:SetType("WALL")
            tiles[tile] = true
          end
        end
      end
    end

    do -- Player
      local tile = Tile:Create(
        (minX + 2) * Addon.TILE_SIZE,
        (minY + 2) * Addon.TILE_SIZE,
        topLayer
      )
      tile:SetType("PLAYER_RIGHT")
      tiles[tile] = true
    end

    do -- Crate
      local tile = Tile:Create(
        (minX + 3) * Addon.TILE_SIZE,
        (minY + 2) * Addon.TILE_SIZE,
        topLayer
      )
      tile:SetType("CRATE_BROWN")
      tiles[tile] = true
    end

    do -- Marker
      local tile = Tile:Create(
        (maxX - 2) * Addon.TILE_SIZE,
        (minY + 2) * Addon.TILE_SIZE,
        topLayer
      )
      tile:SetType("MARKER")
      tiles[tile] = true
    end
  end
end

function MainMenu:OnLeave()
  self.Frame:Hide()

  -- Clear tiles
  for tile in pairs(tiles) do tiles[tile] = nil; tile:Dispose() end
end

-- function MainMenu:OnResume(lastState, ...) end
-- function MainMenu:OnPause() end

-- function MainMenu:OnUpdate(elapsed) end
