--[[
AdiBags_PriorExpansions - Seperates items from current expansion from those from prior ones, an addition to Adirelle's fantastic bag addon AdiBags.
Copyright 2019 Ggreg Taylor
All rights reserved.
--]]

local addon = LibStub('AceAddon-3.0'):GetAddon('AdiBags')
local L = setmetatable({}, {__index = addon.L})

local kCategory = 'Zone Item'
local kPfx = '|cff00ffff' 
local kSfx = '|r'
local arrZoneItems = {'166846:Mechagon','166970:Mechagon','166971:Mechagon','166973:Mechagon','167012:Nazjatar','167077:Nazjatar','167562:Mechagon','167649:Mechagon','167893:Nazjatar','167896:Nazjatar','167902:Nazjatar','167902:Nazjatar','167903:Nazjatar','167903:Nazjatar','167904:Nazjatar','167905:Nazjatar','167906:Nazjatar','167907:Nazjatar','167908:Nazjatar','167909:Nazjatar','167910:Nazjatar','167911:Nazjatar','167912:Nazjatar','167913:Nazjatar','167914:Nazjatar','167915:Nazjatar','167916:Nazjatar','167923:Nazjatar','168045:Mechagon','168161:Nazjatar','168213:Mechagon','168215:Mechagon','168216:Mechagon','168217:Mechagon','168233:Mechagon','168261:Nazjatar','168262:Mechagon','168327:Mechagon','168832:Mechagon','168950:Mechagon','168951:Mechagon','168952:Mechagon','168961:Mechagon','169218:Mechagon','169332:Nazjatar','169333:Nazjatar','169334:Nazjatar','169477:Benthic','169478:Benthic','169479:Benthic','169480:Benthic','169481:Benthic','169482:Benthic','169483:Benthic','169484:Benthic','169485:Benthic','169610:Mechagon','169674:Mechagon','169675:Mechagon','169780:Nazjatar','169781:Nazjatar','169782:Nazjatar','169783:Nazjatar','169868:Mechagon','169872:Mechagon','169873:Mechagon','169878:Mechagon','170100:Nazjatar','170180:Nazjatar','170186:Nazjatar','170189:Nazjatar','170191:Nazjatar','170472:Nazjatar','170512:Nazjatar','170547:Nazjatar'}
local Ggbug = false

local tooltip
local function create()
  local tip, leftTip = CreateFrame("GameTooltip"), {}
  for x = 1,6 do
    local L,R = tip:CreateFontString(), tip:CreateFontString()
    L:SetFontObject(GameFontNormal)
    R:SetFontObject(GameFontNormal)
    tip:AddFontStrings(L,R)
    leftTip[x] = L
  end
  tip.leftTip = leftTip
  return tip
end

local setFilter = addon:RegisterFilter("ZoneItems", 47, 'ABEvent-1.0')
setFilter.uiName = L['Zone Specific Items']
setFilter.uiDesc = L['Group zone specific items together.']

function setFilter:OnInitialize()
  self.db = addon.db:RegisterNamespace('ZoneItems', {
    profile = { enable = true },
    char = {  },
  })
end

function setFilter:Update()
  self:SendMessage('AdiBags_FiltersChanged')
end
function setFilter:OnEnable()
  addon:UpdateFilters()
end
function setFilter:OnDisable()
  addon:UpdateFilters()
end

local setNames = {}

function setFilter:GetOptions()
  return {
    enableZoneItem = {
      name = L['Enable Zone Item groups'],
      desc = L['Check this if you want to automatically seperate Nazjatar and Mechagon items.'],
      type = 'toggle',
      order = 25,
    },
    groupBenthic = {
      name = L['Group Benthic BoA gear'],
      desc = L['Check this if you want group Benthic Bind on Account not Soulbound, items.'],
      type = 'toggle',
      order = 26,
    },
  }, addon:GetOptionHandler(self, false, function() return self:Update() end)
end


function setFilter:Filter(slotData)
  -- Exit if profile not enabled
  if (self.db.profile.enableZoneItem == false) or (slotData.itemId == false) then 
    return
  end
  
  local item = Item:CreateFromBagAndSlot(slotData.bag, slotData.slot)
  --Check for slotData.itemId in the array
  local currCategory, currSubCategory, currID, currVal, delim
  for index,value in ipairs(arrZoneItems) do
    delim = string.find(value,':')
    currID = tonumber(string.sub(value, 1, delim-1))
    currVal =  string.sub(value, delim+1)
    if slotData.itemId == currID then  
        if (self.db.profile.groupBenthic) and (currVal == 'Benthic') then
        currCategory = 'Zone Items'
        currSubCategory = 'Benthic'
        return kPfx .. currSubCategory.. kSfx, currCategory
      elseif currVal ~= 'Benthic' then
        currCategory = 'Zone Items'
        currSubCategory = currVal
        return kPfx .. currSubCategory.. kSfx, currCategory
      end
    end 
  end
end


