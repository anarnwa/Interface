local AddonName, Addon = ...

-- Libs
local DCL = Addon.Libs.DCL

-- Modules
local Utils = Addon.Utils
local Game = Addon.Game
local Spritesheet = Addon.Spritesheet

-- Upvalues
local CreateFrame, unpack = CreateFrame, unpack

-- ============================================================================
-- Utils
-- ============================================================================

-- Creates a frame for constructing a UI.
-- @param {string} name
function Utils:CreateUIFrame(name, level)
  local frame = CreateFrame("Frame", AddonName..name.."Frame", Game.Frame)
  frame:SetFrameLevel(Game.Frame:GetFrameLevel() + (level or 1))
  frame:SetAllPoints()
  return frame
end

do -- Button utils
  local function setButtonTexture(button)
    local texture = button:CreateTexture("$parentTexture", "BACKGROUND")
    texture:SetColorTexture(1, 1, 1, 0.1)
    texture:SetAllPoints()
    texture:SetAlpha(0.6)
    button.Texture = texture

    button:SetScript("OnEnter", function() texture:SetAlpha(1) end)
    button:SetScript("OnLeave", function() texture:SetAlpha(0.6) end)
  end

  --[[
    Creates a generic button.

    config = {
      parent,
      name = "$parentButton",
      width = 25,
      height = 25,
      point,
      onClick
    }
  --]]
  function Utils:CreateButton(config)
    local button = CreateFrame(
      "Button",
      "$parent" .. (config.name or "Button"),
      config.parent
    )

    button:SetSize(config.width or 25, config.height or 25)

    if config.point then button:SetPoint(unpack(config.point)) end

    setButtonTexture(button)

    -- Scripts
    if config.onClick then button:SetScript("OnClick", config.onClick) end
    button:SetScript("OnEnable", function(self) self:SetAlpha(1) end)
    button:SetScript("OnDisable", function(self) self:SetAlpha(0.3) end)
    button:SetScript("OnUpdate", function(self)
      self:SetEnabled(not Game:IsTransitioning())
    end)

    return button
  end
end

--[[
  Creates a generic font string.

  config = {
    parent,
    name = "$parentFontString",
    layer = "ARTWORK",
    font = "GameFontNormal",
    size,
    text,
    point,
    color = DCL.CSS.Ivory
  }
]]
function Utils:CreateFontString(config)
  local fontString = config.parent:CreateFontString(
    "$parent" .. (config.name or "FontString"),
    config.layer or "ARTWORK",
    config.font or "GameFontNormal"
  )

  if config.size then fontString:SetFont(fontString:GetFont(), config.size) end
  if config.text then fontString:SetText(config.text) end
  if config.point then fontString:SetPoint(unpack(config.point)) end
  fontString:SetTextColor(unpack(config.color or DCL.CSS.Ivory))
  fontString:SetShadowOffset(0, 0) -- hide shadow

  return fontString
end

--[[
  Creates a spritesheet texture.

  config = {
    parent,
    name = "$parentSprite",
    layer = "ARTWORK",
    spriteKey,
    width = Addon.TILE_SIZE,
    height = Addon.TILE_SIZE,
    point
  }
]]
function Utils:CreateSprite(config)
  local sprite = config.parent:CreateTexture(
    "$parent" .. (config.name or "Sprite"),
    config.layer or "ARTWORK"
  )

  sprite:SetTexture(Spritesheet.Path)
  sprite:SetTexCoord(unpack(Spritesheet.Sprites[config.spriteKey].Coords))

  sprite:SetSize(
    config.width or Addon.TILE_SIZE,
    config.height or Addon.TILE_SIZE
  )

  if config.point then sprite:SetPoint(unpack(config.point)) end

  return sprite
end

--[[
  Creates a button with a sprite icon.

  config = {
    parent,
    name,
    point,
    width = 50,
    height = 30,
    onClick,
    spriteKey,
    spriteWidth = 25,
    spriteHeight = 25
  }
]]
function Utils:CreateSpriteButton(config)
  local button = Utils:CreateButton({
    parent = config.parent,
    name = config.name,
    point = config.point,
    width = config.width or 50,
    height = config.height or 30,
    onClick = config.onClick
  })

  button.Sprite = Utils:CreateSprite({
    parent = button,
    spriteKey = config.spriteKey,
    width = config.spriteWidth or 25,
    height = config.spriteHeight or 25,
    point = { "CENTER" }
  })

  return button
end
