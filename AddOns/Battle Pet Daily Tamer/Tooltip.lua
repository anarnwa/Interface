--[[
	Tooltip.lua handles the map tooltip.

	Sometimes paws are so close they overlap. The world map is a busy place where many
	POIs can share the space with a paw. Also, other addons like TomTom add click
	behavior to the world map that can be intercepted by paws in the way.

	So instead of paws having the mouse enabled to show/hide tooltips on OnEnter/OnLeave,
	an OnUpdate will run while the world map is up that will look for paws underneath the
	mouse. This has the added benefit of letting multiple paws share the same tooltip when
	two paws overlap.

	For debugging purposes, to see the questID on the tooltip:
		BattlePetDailyTamer.ShowQuestIDsOnTooltips = true
]]

local tamer = BattlePetDailyTamer
local tooltip = tamer.MapTooltip -- the frame that will be shown

local mouseTimer = 0 -- accumulated elapsed time in the WatchForMouseover OnUpdate
local mouseSlow = 0.25 -- frequency when mouse is not over a paw
local mouseFast = 0.1 -- frequency when mouse is over a paw
local mouseFrequency = mouseSlow -- how often to check if mouse is over a paw

local positionTimer = 0 -- accumulated elapsed time for the tooltip's positioning OnUpdate
local positionFrequency = 0.02 -- how often to run the tooltip's positioning OnUpdate

local questIDsUnderMouse = {} -- unordered table of questIDs that are under the mouse
local retrievingData = false -- true when a tooltip is waiting for a name; periodically update tooltip while true

tooltip.Lines = {} -- parentArray of FontStrings that make up the text lines of a tooltip
local currentLine = 0 -- when building a tooltip, this is the current index into tooltip.Lines[]
local maxWidth = 0 -- maximum width of a tooltip line
local padding = 6 -- the inset space around the border of the tooltip

--[[ tooltip script handlers ]]

-- when the tooltip is shown
function tooltip:OnShow()
	mouseFrequency = mouseFast -- increase polling frequency of mouseover OnUpdate
	tooltip:SetScale(GameTooltip:GetEffectiveScale()) -- in case scale has changed
	tamer:PositionTooltipAtMouse()
end

-- when tooltip is hidden
function tooltip:OnHide()
	mouseFrequency = mouseSlow -- decrease polling frequency of mouseover OnUpdate
	wipe(questIDsUnderMouse) -- and forget all questIDs that were under the mouse
	currentLine = 0 -- next tooltip should restart from first line
end

-- this is the tooltip's direct OnUpdate to only position the tooltip under the mouse
function tooltip:OnUpdate(elapsed)
	positionTimer = positionTimer + elapsed
	if positionTimer > positionFrequency then
		positionTimer = 0
		tamer:PositionTooltipAtMouse()
	end
end

--[[ tooltip monitoring and positioning ]]

-- this runs periodically (OnUpdate) while the world map is on the screen, watching
-- for paws to appear/disappear from under the mouse
function tamer:WatchForMouseover(elapsed)
	mouseTimer = mouseTimer + elapsed
	if mouseTimer > mouseFrequency then
		mouseTimer = 0

		local needsUpdate = false -- true if a questIDs under the mouse changed

		-- only do any real work if there's paws on the map
		if #tamer.pawsOnMap > 0 then -- if any paws are on the map

			-- flag all quests already under the mouse as not there
			for questID in pairs(questIDsUnderMouse) do
				questIDsUnderMouse[questID] = false
			end

			-- go through all paws on the map to see if the mouse is over it
			for _,paw in ipairs(tamer.pawsOnMap) do
				if MouseIsOver(paw) then
					if questIDsUnderMouse[paw.questID]==nil then -- this questID wasn't seen before
						needsUpdate = true -- flag that a new quest was added
					end
					questIDsUnderMouse[paw.questID] = true
				end
			end

			-- in addition to new questIDs appearing under the mouse, look for any existing ones
			-- that failed to flip false to true (meaning a questID is no longer under the mouse)
			for questID in pairs(questIDsUnderMouse) do
				if questIDsUnderMouse[questID]==false then -- questID failed to show up under mouse
					needsUpdate = true
					questIDsUnderMouse[questID] = nil
				end
			end

			-- if a quest was added or removed under mouse, update tooltip
			if needsUpdate or retrievingData then
				tamer:UpdateTooltip()
			end

		end

	end
end

-- this is called when the world map is shown and begins watching for mouseover
function tamer:StartWatchingForTooltip()
	mouseTimer = 0
	tamer:SetScript("OnUpdate", tamer.WatchForMouseover)
end

-- called when the world map is closed and stops watching for mouseover
function tamer:StopWatchingForTooltip()
	tamer:SetScript("OnUpdate", nil)
	tooltip:Hide()
end

-- when changing maps, stop and start the watch for mouse being over paws
function tamer:ResetTooltip()
	tamer:StopWatchingForTooltip() -- this will wipe questIDsUnderMouse in tooltip's OnHide
	tamer:StartWatchingForTooltip()
end

-- moves the tooltip frame to the cursor
function tamer:PositionTooltipAtMouse()
	local x,y = GetCursorPosition()
	local scale = UIParent:GetEffectiveScale()
	tooltip:SetPoint("BOTTOMRIGHT",UIParent,"BOTTOMLEFT",x/scale-4,y/scale+4)
end

--[[ tooltip contents ]]

-- this is called when the paws under the mouse have changed: either a new paw was
-- added or one was removed. there can be multiple paws under the mouse
function tamer:UpdateTooltip()

	retrievingData = false -- assume data is complete unless found otherwise

	-- if there's no questID under the mouse, then hide the tooltip
	if not next(questIDsUnderMouse) then
		tooltip:Hide()
	else
		currentLine = 0 -- start tooltip over
		-- add all questIDs (paws) under the mouse to the tooltip
		for questID in pairs(questIDsUnderMouse) do
			tamer:AddQuestToTooltip(questID)
		end
		-- only show tooltip if a quest was added (currentLine advanced)
		if currentLine > 0 then
			-- size the tooltip depending on content added to it
			tooltip:SetSize(maxWidth + padding*2, (currentLine-1)*16 + padding + 2)
			tooltip:Show()
		end
	end
end

-- this adds a line of text to the map tooltip
function tamer:AddLineToTooltip(text)

	-- if starting new tooltip, wipe contents of old one and setup for new
	if currentLine==0 then
		for _,line in ipairs(tooltip.Lines) do
			line:Hide()
		end
		maxWidth = 0
		currentLine = 1
	end

	local line = tooltip.Lines[currentLine]

	-- create a new line(FontString) if one wasn't made for currentLine yet
	if not line then
		tooltip.Lines[currentLine] = tooltip:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
		line = tooltip.Lines[currentLine]
		line:SetPoint("TOPLEFT", padding, -(padding+(currentLine-1)*16))
	end

	line:SetText(text)
	line:Show()
	maxWidth = max(line:GetStringWidth(), maxWidth)
	currentLine = currentLine + 1
end

function tamer:AddQuestToTooltip(questID)
	local info = tamer.dailyInfo[questID]

	if info then

		-- don't show a tooltip for active world quests when at the zone-level (there's already one there from default)
		if info[10]==4 then -- info[10] is 4 if this is a world quest
			local timeLeft = C_TaskQuest.GetQuestTimeLeftMinutes(questID)
			if info[7]==tamer.dataProvider:GetMap():GetMapID() and type(questID)=="number" and timeLeft and timeLeft>0 then
				return
			end
		end

		-- if there's already a quest on the tooltip, add a blank line to space next one out
		if currentLine > 0 then
			tamer:AddLineToTooltip("")
		end

		local npcID = info[1] -- first field of dailyInfo is npcID
		local name, subName
		if type(npcID)=="number" then -- if npcID is a number then it's a traditional npcID
			-- first line is the name of the tamer
			name = tamer:GetNameFromNpcID(npcID)
			if not name then -- name not cached yet
				retrievingData = npcID and true -- flag to try again on next update if there is an npcID
			end
			-- second line is the name of the tamer's quest (if it exists and it's different than tamer name)
			subName = tamer:GetNameFromQuestID(questID)
			if subName==name then
				subName = nil -- if quest name is precisely same as name, then don't show it
			end
		else -- if it's not an npcID then get a name from the questID
			name = tamer:GetNameFromQuestID(questID)
			if not name then
				retrievingData = true
			end
		end
		-- if subName not defined dailyInfo has detail like "Beasts of Fable III" use it as subName
		if not subName and info[2] then
			subName = info[2]
		end

		-- if no name defined after all that, use subName as name if defined or "Retrieving Data" otherwise
		if not name then
			if subName then
				name = subName
				subName = nil
			else
				name = RETRIEVING_DATA
			end
		end

		-- if setting to display inactive dailies is enabled, then grey out title of inactive dailies
		if BattlePetDailyTamerSettings.TrackCompleted and not tamer:QuestNeedsShown(questID) then
			name = "\124cffd0d0d0" .. name .. " (" .. FACTION_INACTIVE .. ")"
		else
			name = "\124cffffd200" ..name -- standard gold text for active name
		end
		tamer:AddLineToTooltip(name)
		if subName then
			tamer:AddLineToTooltip("\124cffd0d0d0"..subName)
		end

		-- if this is a world quest, add duration to tooltip
		if info[10] == 4 then -- 4 is world quest reward type (these should probably be made constants)
			local timeLeft = type(questID)=="number" and C_TaskQuest.GetQuestTimeLeftMinutes(questID)
			if timeLeft and timeLeft > 0 then -- this is an active world quest with duration left
				local timeString
				local color = "\124cffd0d0d0"
				if timeLeft <= WORLD_QUESTS_TIME_CRITICAL_MINUTES then
					color = "\124cffff4444"
					timeString = SecondsToTime(timeLeft*60)
				elseif timeLeft <= 60 + WORLD_QUESTS_TIME_CRITICAL_MINUTES then
					timeString = SecondsToTime((timeLeft - WORLD_QUESTS_TIME_CRITICAL_MINUTES) * 60)
				elseif timeLeft < 24 * 60 + WORLD_QUESTS_TIME_CRITICAL_MINUTES then
					timeString = D_HOURS:format(math.floor(timeLeft - WORLD_QUESTS_TIME_CRITICAL_MINUTES) / 60)
				else
					timeString = D_DAYS:format(math.floor(timeLeft - WORLD_QUESTS_TIME_CRITICAL_MINUTES) / 1440)
				end
				tamer:AddLineToTooltip(format("%s%s",color,BONUS_OBJECTIVE_TIME_LEFT:format(timeString)))
			end
		end

		-- debugging
		if tamer.ShowQuestIDsOnTooltips then
			tamer:AddLineToTooltip(format("\124cffd0d0d0questID %s",questID or nil))
		end

		-- add pets to the tooltip
		local pets = tamer:GetPetsAsText(info[12],info[13],info[14])
		if pets:len()>0 then
			tamer:AddLineToTooltip(pets..(info[11] and format(" \124cffcfcfcfLevel %d",info[11]) or ""))
		end

	end
end

-- takes an npcID and returns the name of the npc
-- if the return is nil, the npcID is invalid or it's not been cached yet
function tamer:GetNameFromNpcID(npcID)
	local tooltip = BattlePetDailyTamerScanTooltip
	tooltip:SetOwner(UIParent, "ANCHOR_NONE")
	tooltip:SetHyperlink(format("unit:Creature-0-0-0-0-%d-0000000000", npcID))
	if tooltip:NumLines() > 0 then
		local name = BattlePetDailyTamerScanTooltipTextLeft1:GetText()
		tooltip:Hide()
		return name
	end
end

-- takes a questID and returns the name of the quest
-- if the return is nil, the questID is invalid or it's not been cached yet
function tamer:GetNameFromQuestID(questID)
	-- first see if this is a world quest
	if type(questID)=="number" then
		local name = C_TaskQuest.GetQuestInfoByQuestID(questID)
		if name then
			return name
		end
	end
	-- wasn't a world quest, try a tooltip scan
	local tooltip = BattlePetDailyTamerScanTooltip
	tooltip:SetOwner(UIParent, "ANCHOR_NONE")
	tooltip:SetHyperlink(format("quest:%d", questID))
	if tooltip:NumLines() > 0 then
		local name = BattlePetDailyTamerScanTooltipTextLeft1:GetText()
		tooltip:Hide()
		return name
	end
end

-- convert a variable number of speciesIDs to a string of pet type icons
function tamer:GetPetsAsText(...)
	local pets = ""
	for i=1,select("#", ...) do
		local speciesID = select(i, ...)
		if speciesID then
			local _,_,petType = C_PetJournal.GetPetInfoBySpeciesID(speciesID)
			if petType then
				local petType = format("\124TInterface\\Icons\\Pet_Type_%s:16\124t",PET_TYPE_SUFFIX[petType])
				pets = pets .. petType
			end
		end
	end
	return pets
end
