--[[
AdiBags_ZoneItems - Groups  items for specific zones, expansions or activities together, an addition to Adirelle's fantastic bag addon AdiBags.
Copyright 2020 Ggreg Taylor
All rights reserved.
--]]

local addon = LibStub('AceAddon-3.0'):GetAddon('AdiBags')
local L = setmetatable({}, {__index = addon.L})
local addonName, data = ...
local setFilter = addon:RegisterFilter("ZoneItems", 47, 'ABEvent-1.0')
setFilter.uiName = L['Zone Specific Items']
setFilter.uiDesc = L['Group zone specific items together.']

-- debugging values
local Ggbug = true
local debugBagSlot = {0,5}

local kCategory = 'Zone Item'
local kPfx = '|cff00ffff'  -- teal
--local kPfx2 = '|cffFF99FF' -- bright PINK
local kPfx2 = '|cff3CE13F' -- bright green1
local kPfx3 = '|cff2FEB77' -- bright green2

local kSfx = '|r'
local kCurrBoAMin = 385

local kzVale = 1
local kzUldum = 2
local kz83Zones = 3
local kzTimeless = 4
local kzMechagon = 5
local kzNazjatar = 6
local kzBrokenIsles = 7
local kzVisions = 8
local kzLegionMissions = 9
local kzEssence = 10
local kzGarrison = 11

local currZoneId, currMap, currMapID, mapName, parentMapID, parentMapName
local dataIsLoaded = false
local tooltip
local currSubset = {}
local ZoneGroupList = {}

-- Expansion #: 1-Vanilla, 2-TBC, 3-LK, 4-MoP, 5-Cata, 6-WoD, 7-Legion, 8-BFA, 9-Shadowlands

local function gPrint(msgText, bag, slot)
  if Ggbug and ((bag == 0 and slot==0) or (bag == debugBagSlot[1] and slot==debugBagSlot[2])) then
    print(msgText)
  end
end

local function loadMapIDs()
  currZoneId = C_Map.GetBestMapForUnit("player")
  if currZoneId ~= nil then
    currMap = C_Map.GetMapInfo(currZoneId)
    currMapID = currMap.mapID
    mapName = currMap.name
    parentMapID = C_Map.GetMapInfo(currMapID).parentMapID
    parentMapName = C_Map.GetMapInfo(parentMapID).name
  end
  -- loop ZoneGroupList to check if current zone match for sequencing
  local zMatch, groupLabel
  for r = 1, #ZoneGroupList do
    zMatch = ZoneGroupList[r][3]
      for c in zMatch:gmatch('([^,]+)') do 
      if tonumber(currZoneId) == tonumber(c) then
         groupLabel = kPfx2 .. ZoneGroupList[r][2] .. kSfx
         --addon:SetCategoryOrder   NEEDS DEBUGGING TO MAKE ORDER PROPERLY
         addon:SetCategoryOrder(groupLabel,80)
      end
    end
  end
end

local function ttCreate()
  local tip, leftside = CreateFrame("GameTooltip"), {}
  for i = 1,6 do
    local L,R = tip:CreateFontString(), tip:CreateFontString()
    L:SetFontObject(GameFontNormal)
    R:SetFontObject(GameFontNormal)
    tip:AddFontStrings(L,R)
    leftside[i] = L
  end
  tip.leftside = leftside
  return tip
end


function setFilter:OnInitialize(b)
  self.db = addon.db:RegisterNamespace('ZoneItems', {
    profile = { 
      enable = true ,
      groupBoATokens = true,
      groupEssences = true,
      groupMechagon = true,
      groupMission = true,
      groupNazjatar = true,
      groupPatch8_3 = true,
		groupRepItems  = true,
		zonePriority = true,
  },
    char = {  },
  })
end
function setFilter:Update()
  self:SendMessage('AdiBags_FiltersChanged')
end
function setFilter:OnEnable()
  dataIsLoaded = false
  checkDataLoaded()
	addon:UpdateFilters()
end
function setFilter:OnDisable()
  addon:UpdateFilters()
end
------------------------------------------------------------------------------
function setFilter:GetOptions()
  return {
    enableZoneItem = {
      name = L['Enable Zone Item groups'],
      desc = L['Check this if you want to automatically seperate Nazjatar and Mechagon items.'],
      type = 'toggle',
      order = 25,
    },
    groupSetZoneItemSubgroups = {
      name = L['Further Zone Item Sub-Grouping Options'],
      type = L['group'],
      inline = true,
      order = 26,
      args = {
        _desc = {
          name = L['Select optional additional sub-groupings.'],
          type = 'description',
          order = 10,
        }, 
        groupBoATokens = {
          name = L['BoA Gear Tokens'],
          desc = L['Group Benthic and Black Empire Bind on Account gear tokens seperately.'],
          type = 'toggle',
          order = 25,
        },
        groupMechagon = {
          name = L['Mechagon'],
          desc = L['Group items specific to Mechagon seperately.'],
          type = 'toggle',
          order = 26,
        },
        groupNazjatar = {
          name = L['Nazjatar'],
          desc = L['Group items specific to Nazjatar seperately.'],
          type = 'toggle',
          order = 27,
        },
        groupRepItems = {
          name = L['Reputation Items'],
          desc = L['Group Reputation on-use and repeatable turn-in items seperately.'],
          type = 'toggle',
          order = 28,
        },
        groupEssences = {
          name = L['Heart Essences'],
          desc = L['Group Heart of Azeroth essences seperately.'],
          type = 'toggle',
          order = 29,
        },
        groupPatch8_3 = {
          name = L['8.3: Uldum, Vale, Visions'],
          desc = L['Group items added in Patch 8.3 for Uldum, Horrific Visions, and Vale of Eternal Blossoms. They really should leave that poor Vale alone.'],
          type = 'toggle',
          order = 30,
        },
        groupMission = {
          name = L['Garrison & Class Hall'],
          desc = L['Group Garrison and Class Hall-specific items.'],
          type = 'toggle',
          order = 31,
        },
        groupTimeless = {
          name = L['Pandaria Timeless Isle'],
          desc = L['Pandaria Timeless Isle-specific items.'],
          type = 'toggle',
          order = 32,
        },
        zonePriority = {
          name = L['Current Zone First'],
          desc = L['Group current zone\'s items first in bags.'],
          type = 'toggle',
          order = 33,
        },
--[[
        groupCorrupted = {
          name = L['Corrupted Gear'],
          desc = L['Group corrupted items.'],
          type = 'toggle',
          order = 33,
        },  --]]
      }
    },
  }, addon:GetOptionHandler(self, false, function() return self:Update() end)
end

function setFilter:setOrder(doIt, groupLabel, seq)
  if doIt then
    addon:SetCategoryOrder(groupLabel,seq)
  end
end

------------------------------------------------------------------------------
function LoadArrayData(groupEnabled, original, additional)
  if groupEnabled == nil then
    return original
  elseif groupEnabled then
    if next(original) == nil then
      return additional
    else
      for _, v in pairs(additional) do
        table.insert(original, v)
      end
      return original
    end
  end
end

function checkDataLoaded()
  if dataIsLoaded == false then 
    dataIsLoaded = true
    ZONE_ITEMS = {}
    -- Only load items seleted to be grouped from options
    ZONE_ITEMS = LoadArrayData(setFilter.db.profile.groupMechagon , ZONE_ITEMS, data.arrMechagon)
    ZONE_ITEMS = LoadArrayData(setFilter.db.profile.groupPatch8_3 , ZONE_ITEMS, data.arrPatch8_3)
    ZONE_ITEMS = LoadArrayData(setFilter.db.profile.groupMission , ZONE_ITEMS, data.arrMissions)
    ZONE_ITEMS = LoadArrayData(setFilter.db.profile.groupEssences , ZONE_ITEMS, data.arrEssence)
    ZONE_ITEMS = LoadArrayData(setFilter.db.profile.groupNazjatar , ZONE_ITEMS, data.arrNazjatar)
    ZONE_ITEMS = LoadArrayData(setFilter.db.profile.groupTimeless , ZONE_ITEMS, data.arrTimeless)
    arrZoneCodes = {
      "1^Vale^1530,1570,380",
      "2^Uldum^1571,249,1527",
      "3^Vale/Uldum^1571,249,1527,1530,1570,380",
      "4^Timeless Isle^554",
      "5^Mechagon^1462",
      "6^Nazjatar^1355",
      "7^BfA Zones^2161,2162,2160,2156,2103,2158,1504,1462",
      "8^Horrific Visions^1469,1470,1473",
      "9^Legion Missions^647,648,626,717,734,735,24,702,695,747,719,831,883,887,726,739",
      "10^Heart Essence^1473",
      "11^Garrison^582,590",
    }
    local currRow
    local i
    for r = 1, #arrZoneCodes do -- load ZoneGroupList array
      i = 1
      currRow = arrZoneCodes[r]
      ZoneGroupList[r] = {}
      for v in currRow:gmatch('([^^]+)') do
        ZoneGroupList[r][i] = v
        i = i + 1
      end 
    end
  end
end
------------------------------------------------------------------------------
function setLabel(groupSubcat, itemZone)
  --set color is zone = curr zone
  nItemZone = tonumber(itemZone)
  nCurrZoneId = tonumber(currZoneId)
  for w in ZoneGroupList[nItemZone][3]:gmatch('([^,]+)') do 
    if nCurrZoneId == tonumber(w) then
      if setFilter.db.profile.zonePriority then
        return kPfx2 .. ZoneGroupList[nItemZone][2] .. kSfx, 'New'
      else
        return kPfx2 .. ZoneGroupList[nItemZone][2] .. kSfx, kCategory
      end
    end 
  end
  return ZoneGroupList[nItemZone][2], kCategory
end

------------------------------------------------------------------------------
function setFilter:Filter(slotData)
  --Exit zoneItem addon if not enabled
  if self.db.profile.enableZoneItem == false then return end
  if dataIsLoaded == false then checkDataLoaded() end
  if currZoneId == nil or currZoneId ~= C_Map.GetBestMapForUnit("player") then loadMapIDs() end

	local ziID, ziZone, ziCat, ziSubcat, ziName, currSubCategory, bagItemID
	bagItemID = slotData.itemId
	local itemName,itemLink, itemRarity, itemLevel,itemMinLevel, itemType, itemSubType,itemStackCount,itemEquipLoc, itemIcon, itemSellPrice, itemClassID, itemSubClassID, bindType, expacID = GetItemInfo(slotData.itemId)
	-- filter toolTip functions
	tooltip = tooltip or ttCreate()
	tooltip:SetOwner(UIParent,"ANCHOR_NONE")
	tooltip:ClearLines()
	if slotData.bag == BANK_CONTAINER then
		tooltip:SetInventoryItem("player", BankButtonIDToInvSlotID(slotData.slot, nil))
	else
		tooltip:SetBagItem(slotData.bag, slotData.slot)
	end
	local bindType = tooltip.leftside[3]:GetText()
	tooltip:Hide()
	tooltip:SetParent(nil)

  currSubset = {}
  local retLabel, retCat
-- Start checking groupings
	-- Group Heart of Azeroth Essences
	if self.db.profile.groupEssences and (itemClassID == 0 and itemSubClassID == 8 and itemRarity == 6 and expacID ==7) then
    --return kPfx .. 'Heart Essence'.. kSfx, 'Essence'
    retLabel, retCat = setLabel('',ziZone)
    return retLabel, retCat
-- Group current BoA Gear Tokens
	elseif self.db.profile.groupBoATokens and itemLevel >=kCurrBoAMin and (bindType ==ITEM_ACCOUNTBOUND or bindType ==ITEM_BNETACCOUNTBOUND) then
		currSubCategory = 'Current BoA'
    return currSubCategory, kCategory
--[[
  --elseif self.db.profile.groupCorrupted and IsCorruptedItem(itemLink) then
  elseif self.db.profile.groupCorrupted and IsCorruptedItem(bagItemID) then
    --print (itemName)
    currSubCategory = 'Corrupted'
    return currSubCategory, kCategory
elseif self.db.profile.groupCorrupted and IsItemCorrupted(SetBagAndSlot(slotData.bag, slotData.slot)) then
		currSubCategory = 'Corrupted 2'
    return currSubCategory, kCategory
    --]]    
	else
		for x = 1, #ZONE_ITEMS do
			local currSubset = {}
			local currZoneItem = ZONE_ITEMS[x]
			local index = 1
			for w in currZoneItem:gmatch('([^^]+)') do 
				currSubset[index]  = w 
				index = index +1
			end
			--ID^Category^Subcat^Zone(s) Match^Item,
			ziID = currSubset[1]
			ziCat = currSubset[2]
			ziSubcat = currSubset[3]
			if currSubset[4] == nil then
				ziZone = ''
			else
				ziZone = tonumber(currSubset[4])
			end
      if tonumber(bagItemID) == tonumber(ziID) then
        if self.db.profile.groupMission and (ziZone == kzGarrison or ziZone == kzLegionMissions) then
          --Garrison and Order Hall goodies
          return  setLabel(ziSubcat, ziZone)
  			elseif (self.db.profile.groupMechagon) and ziZone==kzMechagon then
          --reputation self.db.profile.groupRepItems
          return setLabel(ziSubcat, ziZone)
         elseif (self.db.profile.groupNazjatar) and ziZone==kzNazjatar then
          --reputation self.db.profile.groupRepItems
          --check priority
          if ziSubcat == 'Reputation' then
            return kPfx .. ziSubcat .. kSfx, 'Nazjatar: Rep'
          else
            return setLabel(ziSubcat, ziZone)
          end
        elseif (self.db.profile.groupEssences) and ziZone == kzEssence then
          --return kPfx .. 'Heart Essence'.. kSfx, 'Essence'
          return  setLabel(ziSubcat, ziZone)
        elseif self.db.profile.groupPatch8_3 and (ziZone == kzUldum or ziZone == kzVale or ziZone == kz83Zones  or ziZone == kzVisions ) then
            --first is deplayed, 2nd is hidden label
            return  setLabel(ziSubcat, ziZone)
				elseif  self.db.profile.groupTimeless and ziZone == kzTimeless then
					return  setLabel(ziSubcat, ziZone)
				end -- category matching from #Zone_Items
			end -- end bagItemID = ziID
		end -- end for #ZONE_ITEMS
	end -- end checking groupings
end 




