--[[
	Map.lua handles the placement of paws on the maps.

	It uess the new map data providers in the Battle for Azeroth client.

	BattlePetDailyTamerPinTemplate is defined in Frames.xml
]]


local tamer = BattlePetDailyTamer

tamer.pawsOnMap = {} -- ordered list of all paws on the map
tamer.incompleteObjectives = {} -- lookup table of questIDs with objectives that need done (questIDs as in "32869:1")

local currentMapID -- mapID of the current map, as noticed by the data provider
local firstAzerothView = false -- becomes true the first time the azeroth map is viewed

--[[ data provider ]]

BattlePetDailyTamerDataProviderMixin = CreateFromMixins(MapCanvasDataProviderMixin)
tamer.dataProvider = BattlePetDailyTamerDataProviderMixin

-- this is called before the map is first shown and on every map change; its purpose is to
-- show all paws on the map that need shown
function tamer.dataProvider:RefreshAllData()

	tamer.MapTooltip:Hide() -- hide any tooltip when changing maps
	self:RemoveAllData() -- remove our pins from the map in preparation for showing them
	tamer:HideDefaultTamerPins() -- also remove all of the default's green paws from the map
	tamer.MenuFrame.timer = 10 -- if menu on screen, this will cause menu to hide if mouse isn't over menu

	-- if showTamers cvar is disabled, don't show anything and leave
	if not GetCVarBool("showTamers") then
		return
	end

	local mapID = self:GetMap():GetMapID()
	local parentMapID = tamer:GetParentMapID(mapID)

	-- if we're on any Pandaria map or the Azeroth world map, update objectives
	if parentMapID == 424 or mapID == 947 then
		tamer:UpdateIncompleteObjectives() -- only Beasts of Fable uses objectives so far
	end

	currentMapID = mapID -- note for use outside this function

	-- if TrackCompleted is enabled ("Inactive Dailies") then they show as grey paws on the map
	local showInactive = BattlePetDailyTamerSettings.TrackCompleted

	-- if the parentMapID ("continent") has quests, go through them and post pins
	if parentMapID and tamer.parentMapIDs[parentMapID] then
		local worldPos = CreateVector2D(0, 0) -- reusing vector to minimize garbage creation
		for _,questID in ipairs(tamer.questIDsByParentMapID[parentMapID]) do
			local info = tamer.dailyInfo[questID]

			-- info[10] is the reward type; if the reward type is known, and the settings for that
			-- reward type are enabled, then this paw is okay to be shown
			local isTracked = tamer.pawInfo[info[10]] and BattlePetDailyTamerSettings[tamer.pawInfo[info[10]][2]]
			-- if the type is not only tracked but quest has not been completed/is active,
			-- paw should be definitely be shown
			local showPaw = isTracked and tamer:QuestNeedsShown(questID)

			if (showPaw or showInactive) and isTracked then
				worldPos:SetXY(info[5], info[6]) -- set worldPos from dailyInfo
				-- info[4] is instanceID (fourth return of UnitPosition)
				-- this converts the worldPos (same continent) to the mapPos of the currently-viewed mapID
				local _,mapPos = C_Map.GetMapPosFromWorldPos(info[4], worldPos, mapID)
				if mapPos then
					local x,y = mapPos:GetXY()
					-- only need to show paws that are within 0,0->1,1 mapPos
					if x >= 0 and x <= 1 and y >=0 and y <= 1 then
						local isInactive = (not showPaw) and showInactive
						local paw = self:GetMap():AcquirePin("BattlePetDailyTamerPinTemplate", questID, x, y, isInactive)
						tinsert(tamer.pawsOnMap, paw)
					end
				end
			end
		end
	end

	-- if we're on the azeroth world map, it requires special handling
	-- only active quests are shown for all questIDs that have a parentMapID in azerothTransforms
	-- (and while OnAzerothMap settings is enabled)
	if mapID == 947 and BattlePetDailyTamerSettings.OnAzerothMap then
		local transforms = tamer.azerothTransforms
		-- going through all quests in dailyInfo
		for questID,info in pairs(tamer.dailyInfo) do
			if transforms[info[3]] then
				local isTracked = tamer.pawInfo[info[10]] and BattlePetDailyTamerSettings[tamer.pawInfo[info[10]][2]]
				local showPaw = isTracked and tamer:QuestNeedsShown(questID)
				if showPaw then -- only showing active quests
					local x, y = tamer:GetAzerothMapPos(info[5], info[6], transforms[info[3]])
					if x >= 0 and x <= 1 and y >=0 and y <= 1 then
						local paw = self:GetMap():AcquirePin("BattlePetDailyTamerPinTemplate", questID, x, y)
						tinsert(tamer.pawsOnMap, paw)
					end
				end
			end
		end
		-- if this is the first time looking at the azeroth map, request world quest data for Broken Isles
		-- and refresh the map half a second later. otherwise if viewed from another continent, the world quests
		-- may not show up. (this may need done for kul tiras and zandalar too if they use world quests)
		if not firstAzerothView then
			firstAzerothView = true
			C_TaskQuest.GetQuestsForPlayerByMapID(619) -- 619 is mapID for broken isles
			C_Timer.After(0.5,function() self:RefreshAllData() end)
		end
	end

end

-- this converts y,x from UnitPosition (5th and 6th fields of dailyInfo) to a mapPos for the azeroth map,
-- using the given azerothTransforms sub-table. (the y,x argument order is intentional! it matches UnitPosition's
-- returns!)
-- transforms is a table where [1] is x translation, [2] is x scale, [3] is y translation, [4] is y scale
function tamer:GetAzerothMapPos(y, x, transforms)
	x = transforms[1] + x / transforms[2]
	y = transforms[3] + y / transforms[4]
	return x, y
end

-- wipes all pins off the map (called at the start of RefreshAllData)
function tamer.dataProvider:RemoveAllData()
	self:GetMap():RemoveAllPinsByTemplate("BattlePetDailyTamerPinTemplate")
	wipe(tamer.pawsOnMap)
end

-- when the world map is pulled up on screen (canvas, specifically)
-- note: this is called AFTER a RefreshAllData/OnMapChanged!
function tamer.dataProvider:OnShow()
	tamer:StartWatchingForTooltip() -- start polling for mouse over a paw
end

-- when the world map is dismissed off screen
function tamer.dataProvider:OnHide()
	tamer:StopWatchingForTooltip() -- stop polling for mouse over a paw
	wipe(tamer.pawsOnMap) -- wipe list of shown paws
end

--[[ pins ]]

BattlePetDailyTamerPinMixin = CreateFromMixins(MapCanvasPinMixin)
tamer.pinProvider = BattlePetDailyTamerPinMixin

function tamer.pinProvider:OnLoad()
	self:UseFrameLevelType("PIN_FRAME_LEVEL_AREA_POI")
	self:SetScalingLimits(1, 1.0, 1.2)
end

-- this is called just before a pin is shown and modifies the frame (self)
-- to the appropriate paw for the given questID
function tamer.pinProvider:OnAcquired(questID, x, y, isInactive)
	self:SetPosition(x, y)
	self.questID = questID

	local info = tamer.dailyInfo[questID]
	if info then
		local pawInfo = tamer.pawInfo[info[10]] -- info[10] is daily/reward type
		if pawInfo then
			self.Texture:SetTexture(pawInfo[4])
			if isInactive then -- if quest is inactive, color it grey
				self.Texture:SetVertexColor(0.75,0.75,0.75)
			else -- otherwise use color from pawInfo
				self.Texture:SetVertexColor(pawInfo[5],pawInfo[6],pawInfo[7])
			end
		end
	end

end

--[[ support methods ]]

-- small recursive function to find the first validParentMapID from the given mapID
function tamer:GetParentMapID(mapID)
	-- if mapID is nil, we've hit a map that can't use worldPos, not valid: return nil
	if not mapID or tamer.badParentMapIDs[mapID] then
		return nil
	end
	-- if map is one of the valid parents, return the found mapID
	if tamer.parentMapIDs[mapID] then
		return mapID
	end
	-- inconclusive at this point still, try again with this map's parent
	local info = C_Map.GetMapInfo(mapID)
	if info and info.parentMapID then
		return tamer:GetParentMapID(info.parentMapID)
	end
	-- if we reached here, ended up at cosmic map likely, no valid parent
	return nil
end

-- this hides the default's paws (called during a RefreshAllData)
function tamer:HideDefaultTamerPins()
	-- hide the default pet tamer pins
	WorldMapFrame:RemoveAllPinsByTemplate("PetTamerPinTemplate")
	-- TODO: enumerate pins and set them to 0 alpha so they don't blink after first time shown
	-- since no guarantee that our pins are processed after default, come back next frame to hide default again
	C_Timer.After(0, function()
		WorldMapFrame:RemoveAllPinsByTemplate("PetTamerPinTemplate")
	end)	
end

-- returns whether the questID should be shown on the map
function tamer:QuestNeedsShown(questID)
	local info = tamer.dailyInfo[questID]
	if info then

		if info[4] == 1669 then -- argus pets (instanceID 1669) are always on the map and never inactive
			return true
		elseif info[10] == 4 then -- if this is a world quest
			local timeLeft = C_TaskQuest.GetQuestTimeLeftMinutes(questID)
			-- if world quest is not up, or we're at the zone-level map, don't show paw
			-- (zone-level excluded because world quests have their own world quest pin)
			-- (also don't show if world quest is up but it's been completed)
			if not timeLeft or timeLeft == 0 or info[7] == currentMapID or (type(questID)=="number" and IsQuestFlaggedCompleted(questID)) then
				return false
			end
		elseif type(questID) == "string" then -- if this is a questID:objective
			-- if quest is either not in log or objective is complete, then don't show paw
			-- this returns true if the questID is in the log with this objective not done
			if tamer.incompleteObjectives[questID] then
				return true
			else -- this string may be "Alliance:32604", see if quest is in log
				-- if it's "32604:2" we want to return false, if it's "Alliance:32604" we want to see if it's in log
				local maybeID = tonumber(questID:match(":(%d+)$") or "") -- %d+$ will grab trailing number after :
				if maybeID and GetQuestLogIndexByID(maybeID) == 0 then
					return false -- questID is not in log, don't show paw
				else
					return true -- questID is in the log, show paw
				end
			end
		elseif type(questID) == "number" then -- this is a regular questID
			-- if quest is complete, don't show it
			if IsQuestFlaggedCompleted(questID) then
				return false
			end
		end
		-- if we passed through all reasons not to show the quest, then show the quest
		return true
	end
end

-- this repopulates the incompleteObjectives table with questIDs (as indexed in dailyInfo,
-- like "32869:1") that are an objective to a quest that is not complete yet
function tamer:UpdateIncompleteObjectives()
	wipe(tamer.incompleteObjectives)
	for _,questID in ipairs(tamer.questIDsWithObjectives) do
		local logIndex = GetQuestLogIndexByID(questID)
		-- if questID isn't in logs, then logIndex is 0 and following loop doesn't run
		for i=1,GetNumQuestLeaderBoards(logIndex) do
			-- if i'th objective is not complete, then note it in incompleteObjectives
			if not select(3, GetQuestLogLeaderBoard(i, logIndex)) then
				tamer.incompleteObjectives[questID..":" .. i] = true
			end
		end
	end
end
