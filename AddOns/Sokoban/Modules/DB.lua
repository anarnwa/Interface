-- DB: provides addon modules easy access to saved variables.

local AddonName, Addon = ...

-- Modules
local DB = Addon.DB

-- Default database values
local defaults = {
  Global = {
    Version = 1, -- SV version
    Minimap = { hide = false }
  },
  Profile = {
    CurrentLevel = nil, -- Determines level upon "Continue"
    CompletedLevels = {
      -- ["#"] = true
    }
  }
}

-- ============================================================================
-- Database Functions
-- ============================================================================

-- Initializes the database.
function DB:Initialize()
  self.Initialize = nil
  local db = Addon.DethsDBLib(AddonName, defaults)
  setmetatable(self, {__index = db})
  -- Maintain one profile across all characters for now
  self:SetProfile("Global")
  self:DeleteProfile(self:GetPlayerKey())

  -- If CurrentLevel is higher than current number of levels, reset it
  if self.Profile.CurrentLevel and (self.Profile.CurrentLevel > #Addon.Levels) then
    self.Profile.CurrentLevel = nil
  end
end
