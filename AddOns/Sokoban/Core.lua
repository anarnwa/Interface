-- Core: handles initialization and provides useful functions.

local AddonName, Addon = ...

-- Libs
local L = Addon.Libs.L
local DCL = Addon.Libs.DCL

-- Upvalues
local print = print

-- Modules
local Core = Addon.Core
local DB = Addon.DB
local Game = Addon.Game
local MinimapIcon = Addon.MinimapIcon

-- ============================================================================
-- DethsAddonLib Functions
-- ============================================================================

-- Initializes modules.
function Core:OnInitialize()
  DB:Initialize()
  MinimapIcon:Initialize()
  Game:Initialize()

  -- Setup slash command
  DethsLibLoader("DethsCmdLib", "1.0"):Create(AddonName, function(cmd, ...)
    if (cmd == "icon") then
      MinimapIcon:Toggle()
      self:Print(
        DB.Global.Minimap.hide and
        L.MINIMAP_ICON_DISABLED_TEXT or
        L.MINIMAP_ICON_ENABLED_TEXT
      )
    elseif (cmd == "level") then
      if Game:IsTransitioning() or (select("#", ...) == 0) then return end

      local level = tonumber(...)
      if not (level and Addon.Levels[level]) then
        self:Print(L.LEVEL_DOES_NOT_EXIST_TEXT)
        return
      end

      Game.Window:Show()
      Game:TextTransition(L.LEVEL_TEXT:format(level), function()
        Game:SetState(Addon.GameStates.Playing, level)
      end)
    elseif (cmd == "reset") then
      if Game:IsTransitioning() then return end

      Game:Transition(function()
        Game:SetState(Addon.GameStates.MainMenu)
        DB.Profile.CurrentLevel = nil
        DB.Profile.CompletedLevels = {}
      end)

      self:Print(L.PROGRESS_RESET_TEXT)
    else
      Game.Window:Toggle()
    end
  end)
end

-- function Core:OnEvent(event, ...) end
-- function Core:OnUpdate(elapsed) end

-- ============================================================================
-- General Functions
-- ============================================================================

-- Prints a formatted message ("[AddonName] msg").
-- @param ... - the messages to print
function Core:Print(...)
  print(DCL:ColorString(("[%s]"):format(AddonName), Addon.TITLE_COLOR), ...)
end

--[[
-- Prints a debug message ("[AddonName Debug] title: ...").
-- @param title - the title of the debug message
-- @param ... - the messages to print
function Core:Debug(title, ...)
  print(
    DCL:ColorString(("[%s Debug]"):format(AddonName), DCL.CSS.Crimson),
    (select("#", ...) > 0) and
    DCL:ColorString(title, DCL.CSS.LightGreen)..":" or
    title,
    ...
  )
end
--]] Core.Debug = nop
