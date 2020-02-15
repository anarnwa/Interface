-----------------------------------------------------------------------------
--  Faction Addict - FactionAddict.lua
--
--  This file contains the majority of the functionality for the addon.
--
--  functions:
--			local function sortedpairs(t) 
--			local function fa_FindChatWindow(windowname)
--			local function fa_DebugOut(outString)
--			local function fa_ShowFactions()
--			local function fa_HideFactions()
--			local function fa_ShowLogging()
--			local function fa_HideLogging()
--			function fa_IsFactionInactive(factionID) - Phanx
--			function fa_IsFactionInReputationDisplay(factionID) - Phanx
--			function fa_UpdateInactiveFactionsList() - Phanx
--			function fa_SetWatchedFactionByID(watchID) - Phanx
--			local function fa_BuildTooltipData()
--			local function fa_StandingText(factionID, standingID)
--			local function fa_GetNextAchievementValue(exaltedCount)
--			local function fa_PopulateLoggingTable()
--			local function fa_RollLogData()
--			local function fa_AddToRepLog(faction, rep)
--			local function fa_orderby1(a,b)
--			local function fa_orderby2(a,b)
--			local function fa_orderby3(a,b)
--			local function fa_orderbyInactive1(a,b)
--			local function fa_orderbyInactive2(a,b)
--			local function fa_SortDisplayTable()
--			local function fa_PopulateAllFactionDataTable()
--			local function fa_PopulateDisplayTable()
--			local function fa_SetStatusBarText(offset)
--			local function fa_SetStatusBarText_ByFactionName(faction_name)
--			local function fa_CleanConfigVars()
--			local function fa_SetConfigShowHideDefaults()
--			local function fa_UpdateLogVersion()
--			function FactionAddict_DisplayTooltip(self)
--			local function fa_GetDDConfigValue(param)
--			local function fa_SetDDConfigValue(self, arg1, arg2, checked)
--          local function fa_UpdateParagonLogValue()
--			function FactionAddict_AchText_OnEnter(self)
--			function FactionAddict_ScrollBar_Update()
--			function FactionAddict_LogEntry_OnClick(self)
--			function FactionAddict_LoggingScrollBar_Update()
--			function FactionAddict_SetConfigVariables(self)
--			function FactionAddict_FactionEntrySB_OnClick(self)
--			function FactionAddict_FactionEntry_OnClick(self)
--			function FactionAddict_Tab_OnClick(self)
--			function FactionAddict_StatusBar_OnEnter(self)
--			function FactionAddict_StatusBar_OnLeave(self)
--			function FactionAddictLauncher_OnClick(self)
--			local function fa_InfoWindow_LoadInfo(self)
--			local function fa_InfoWindow_Update()
--			function FactionAddict_InfoWindow_OnShow(self)
--			function FactionAddict_InfoWindow_Btn1_OnClick(self)
--			function FactionAddict_OnShow(self)
--			function FactionAddict_OnHide(self)
--			function FactionAddict_OnEvent(self, event, ...)
--			function FactionAddict_ConfigMenuButton_OnClick(self)
--			function FactionAddict_SearchToggle_OnClick(self)
--			function FactionAddict_SearchClear_OnClick(self)
--			function FactionAddict_OnTextChanged(self, userInput)
--			function FactionAddict_ConfigMenu_OnLoad()
--			function FactionAddict_OnLoad(self)
--			
--
--  (c) 2011-2020 gmz323(Greg)
-----------------------------------------------------------------------------


-- Constants
local FACTION_ADDICT_VERSION = "1.58"
local FACTION_ADDICT_LOGGING_VERSION = 1
local FACTION_ADDICT_LOGGING_DAYS = 20
local GUILD_FACTION_ID = 1168
local FACTION_ADDICT_PARAGON_COLOR = {r = 0.00, g = 0.82, b = 1.00}
-- Locals
local tempDisplayData = {} -- temp table built to show subset of data
local tempDisplayData_rowcount
local tempAllFactionData = {} -- table built to store all faction data - info window population
local tempAllFactionData_rowcount
local tempAllParagonData = {} -- table built to store all paragon data
local tempLoggingData = {} -- temp table to show log data
local tempLoggingData_rowcount
local tempFactionIDsByName = {} -- temp table mapping factin names to IDs
local tempAchievementTooltipData = {} -- table holding achievement tooltip data
local tempTruncNamesTable = {} -- table holding truncated names - end in '...'
local doServerFactionQuery = 0
local faUpdateDisplayTable
local faNumFactions
local faNumFactionsExalted
local faClickedFactionName -- holds clicked faction name for info window
local faLastRepGainStr
local faSessionRepGain
local faSessionDate
local faStartTime = GetTime()
local faPlayerGuildName
local lfgBonusFactionID
local faNameFilter = "" -- search box

-- Phanx vars
local running
local isInactive = {}
local isInReputationDisplay = {}

-- Debugging
local debugMode = false

-- Localized Strings
local L = FactionAddictLocalization

-- config table defaults - saved per character
local FactionAddictConfigDefaults = 
	{
		CB_STANDING_PARAGON = true,
		CB_STANDING_EXALTED = true,
		CB_STANDING_REVERED = true,
		CB_STANDING_HONORED = true,
		CB_STANDING_FRIENDLY = true,
		CB_STANDING_NEUTRAL1 = true,
		CB_STANDING_NEUTRAL0 = true,
		CB_STANDING_UNFRIENDLY = true,
		CB_STANDING_HOSTILE = true,
		CB_STANDING_HATED = true,
		CB_CATEGORY_CF = true,
		CB_CATEGORY_BC = true,
		CB_CATEGORY_WOTLK = true,
		CB_CATEGORY_CATA = true,
		CB_CATEGORY_MOP = true,
		CB_CATEGORY_WOD = true,
		CB_CATEGORY_LG = true,
		CB_CATEGORY_BFA = true,
		RB_ORDERBY = 1,
		CB_FILTER_SHOW_AO = true,
		CB_FILTER_SHOW_HO = true,
		CB_OPTION_AUTOBAR = true,
		CB_OPTION_HIDEINACTIVE_V2 = false,
	}
	
local faGender = UnitSex("player")
local ConfigMenuInfo = {
		-- Paragon (Exalted+)
		{ ["text"] = L.MISC_PARAGON_TXT .. " (".. GetText("FACTION_STANDING_LABEL".."8", faGender) .. "+)",   ["arg1"] = "CB_STANDING_PARAGON",  },
		{ ["text"] = GetText("FACTION_STANDING_LABEL".."8", faGender) .. " "..L.STANDING_FILTER_LABEL_8_TXT,  ["arg1"] = "CB_STANDING_EXALTED",  },
		{ ["text"] = GetText("FACTION_STANDING_LABEL".."7", faGender) .. " "..L.STANDING_FILTER_LABEL_7_TXT,  ["arg1"] = "CB_STANDING_REVERED",  },
		{ ["text"] = GetText("FACTION_STANDING_LABEL".."6", faGender) .. " "..L.STANDING_FILTER_LABEL_6_TXT,  ["arg1"] = "CB_STANDING_HONORED",  },
		{ ["text"] = GetText("FACTION_STANDING_LABEL".."5", faGender) .. " "..L.STANDING_FILTER_LABEL_5_TXT,  ["arg1"] = "CB_STANDING_FRIENDLY", },
		{ ["text"] = GetText("FACTION_STANDING_LABEL".."4", faGender) .. " "..L.STANDING_FILTER_LABEL_4B_TXT, ["arg1"] = "CB_STANDING_NEUTRAL1", },
		{ ["text"] = GetText("FACTION_STANDING_LABEL".."4", faGender) .. " "..L.STANDING_FILTER_LABEL_4A_TXT, ["arg1"] = "CB_STANDING_NEUTRAL0", },
		{ ["text"] = GetText("FACTION_STANDING_LABEL".."3", faGender) .. " "..L.STANDING_FILTER_LABEL_3_TXT,  ["arg1"] = "CB_STANDING_UNFRIENDLY", },
		{ ["text"] = GetText("FACTION_STANDING_LABEL".."2", faGender) .. " "..L.STANDING_FILTER_LABEL_2_TXT,  ["arg1"] = "CB_STANDING_HOSTILE", },
		{ ["text"] = GetText("FACTION_STANDING_LABEL".."1", faGender) .. " "..L.STANDING_FILTER_LABEL_1_TXT,  ["arg1"] = "CB_STANDING_HATED", },
	}

local InfoWindow_Backdrop_Default = {
	bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background-Dark",  
	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
	tile = true, tileSize = 32, edgeSize = 16,
	insets = { left = 4, right = 4, top = 4, bottom = 4 } }
local InfoWindow_Backdrop_Inactive = {
	bgFile = "Interface\\GLUES\\Models\\UI_Alliance\\RedFlag",  
	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
	tile = true, tileSize = 32, edgeSize = 16,
	insets = { left = 4, right = 4, top = 4, bottom = 4 } }
local InfoWindow_Inactive_RGBA = {0.77, 0.12, 0.23, 0.90}

-- Slash commands
SLASH_FACTIONADDICT1 = "/fa"
SLASH_FACTIONADDICT2 = "/factionaddict"
BINDING_HEADER_FACTIONADDICT = L.ADDON_TITLE
BINDING_NAME_FACTIONADDICT_TOGGLE = L.LAUNCHER_TT


SlashCmdList["FACTIONADDICT"] = function(msg, editbox)
	if frameFactionAddict:IsShown() then
		frameFactionAddict:Hide()
	else
		frameFactionAddict:Show()
	end
end

-- example message: Reputation with Lower City increased by 300.
-- example generic: Reputation with The Nightfallen increased.
-- globalstrings - FACTION_STANDING_DECREASED - FACTION_STANDING_INCREASED 
local pattern_standing_inc = string.gsub(string.gsub(FACTION_STANDING_INCREASED, "(%%s)", "(.+)"), "(%%d)", "(%%d+)")
local pattern_standing_dec = string.gsub(string.gsub(FACTION_STANDING_DECREASED, "(%%s)", "(.+)"), "(%%d)", "(%%d+)")
local pattern_standing_inc_generic = string.gsub(FACTION_STANDING_INCREASED_GENERIC, "(%%s)", "(.+)")

-----------------------------------------------------------------------------
-- Sorts table keys
--
-- @param table  		array of keys.
-- @return 				ordered keys.
-----------------------------------------------------------------------------
local function sortedpairs(t)
  local keys = {}
  for k in pairs(t) do
	table.insert(keys, k)
  end
  table.sort(keys, function(a,b)
	  if tonumber(a) and tonumber(b) then
		return a < b
	  else
		return tostring(a)<tostring(b)
	  end
  end)
  local i = 0
  return function()
	if i < #keys then
	  i = i + 1
	  return keys[i], t[keys[i]]
	end
  end
end


-----------------------------------------------------------------------------
-- Looks through all the chat windows for one named 'windowname'.
--
-- @param windowname	string name of window to look for.
-- @return 				number of found chat window - or 1 if not found.
-----------------------------------------------------------------------------
local function fa_FindChatWindow(windowname)
	local x
	
	for x=1,NUM_CHAT_WINDOWS
	do
	  local name, fontSize, r, g, b, alpha, shown, locked, docked, uninteractable = GetChatWindowInfo(x)
	  if (name == windowname) then
		return x
	  end
	end
	-- Default to main chat window if DEBUG window not found
	return 1
end


-----------------------------------------------------------------------------
-- Prints out a debug message if debugMode is on.
--
-- @param outString  	string to print to debug window.
-----------------------------------------------------------------------------
local function fa_DebugOut(outString)
	if (debugMode) then
		-- calc delta time
		local prefixStr, deltaTime
		deltaTime = GetTime() - faStartTime
		prefixStr = string.format("[%.3f] ", deltaTime)
		-- print to chatframe named "DEBUG" else main chatframe
		getglobal("ChatFrame"..(fa_FindChatWindow("DEBUG"))):AddMessage(prefixStr..outString)
	end
end
-- Example debugstack
-- ChatFrame1:AddMessage(debugstack(1, 8, 1))

-----------------------------------------------------------------------------
-- Shows all FactionAddictEntry rows.
-----------------------------------------------------------------------------
local function fa_ShowFactions()
	local line
	for line=1,7 do
		getglobal("FactionAddictEntry"..line):Show()
	end
end


-----------------------------------------------------------------------------
-- Hides all FactionAddictEntry rows.
-----------------------------------------------------------------------------
local function fa_HideFactions()
	local line
	for line=1,7 do
		getglobal("FactionAddictEntry"..line):Hide()
	end
end


-----------------------------------------------------------------------------
-- Show Logging Entries.
-----------------------------------------------------------------------------
local function fa_ShowLogging()
	local line
	for line=1,17 do
		getglobal("FactionAddictLogEntry"..line):Show()
	end
end


-----------------------------------------------------------------------------
-- Hide logging entries.
-----------------------------------------------------------------------------
local function fa_HideLogging()
	local line
	for line=1,17 do
		getglobal("FactionAddictLogEntry"..line):Hide()
	end
end


-----------------------------------------------------------------------------
-- Collection of functions from Phanx that get and set UI elements for the 
-- default character faction windows.
--
-- Function Credit: Phanx
-----------------------------------------------------------------------------
local fa_IsFactionInactive, fa_SetWatchedFactionByID, fa_UpdateInactiveFactionsList
do
		function fa_IsFactionInactive(factionID)
				return isInactive[factionID]
		end
		function fa_IsFactionInReputationDisplay(factionID)
			return isInReputationDisplay[factionID]
		end
		function fa_UpdateInactiveFactionsList()
				if (running) then 
					fa_DebugOut("fa_UpdateInactiveFactionsList() - running flag is already set!")
					return
				end
				running = true
				wipe(isInactive)
				local i = 1
				local inactive
				local wasCollapsed = {}
				while i <= GetNumFactions() do
						local name, _, _, _, _, _, _, _, isHeader, isCollapsed, _, _, _, factionID, _, _ = GetFactionInfo(i)

						if isHeader then
								if isCollapsed then
										ExpandFactionHeader(i)
										wasCollapsed[name] = true
										if name == FACTION_INACTIVE then
											inactive = true
										end
								elseif name == FACTION_INACTIVE then
										inactive = true
								end
						elseif inactive then
								isInactive[factionID] = true
						end
						i = i + 1
						if (factionID ~= nil) then
							isInReputationDisplay[factionID] = true
						end
				end
				i = 1
				while i <= GetNumFactions() do
						local name, _, _, _, _, _, _, _, isHeader, isCollapsed, _, _, _, factionID, _, _ = GetFactionInfo(i)
						if isHeader and not isCollapsed and wasCollapsed[name] then
								CollapseFactionHeader(i)
								wasCollapsed[name] = nil
						end
						i = i + 1
				end
				running = nil
		end
		function fa_SetWatchedFactionByID(watchID)
				if running then 
					fa_DebugOut("fa_SetWatchedFactionByID() - running flag is already set!")
					return 
				end
				running = true
				local i = 1
				local wasCollapsed = {}
				while i <= GetNumFactions() do
						local name, _, _, _, _, _, _, _, isHeader, isCollapsed, _, _, _, factionID, _, _ = GetFactionInfo(i)
						if isHeader then
								if isCollapsed then
										ExpandFactionHeader(i)
										wasCollapsed[name] = true
								elseif name == FACTION_INACTIVE then
										break
								end
						elseif factionID == watchID then
								local _, _, _, _, _, currentlyWatchedID = GetWatchedFactionInfo()
								if (currentlyWatchedID ~= watchID) then
									SetWatchedFactionIndex(i)
									local tempDebugStr = "SetWatchedFactionIndex(); index:" .. tostring(i) .. "; watchID:" .. tostring(watchID)
									fa_DebugOut(tempDebugStr)
								else
									local tempDebugStr = "Faction already watched; watchID:" .. tostring(watchID)
									fa_DebugOut(tempDebugStr)
								end
								break
						end
						i = i + 1
				end
				i = 1
				while i <= GetNumFactions() do
						local name, _, _, _, _, _, _, _, isHeader, isCollapsed, _, _, _, factionID, _, _ = GetFactionInfo(i)
						if isHeader and not isCollapsed and wasCollapsed[name] then
								CollapseFactionHeader(i)
								wasCollapsed[name] = nil
						end
						i = i + 1
				end
				running = nil
		end
end


-----------------------------------------------------------------------------
-- Loops through the serious of faction achievements and builds a displayable
-- tooltip.
-----------------------------------------------------------------------------
local function fa_BuildTooltipData()

	-- MOP Change - exalted achievements account wide now

	-- 522 - first faction achievement
	local achievementID = 522
	local i = 1

	fa_DebugOut("BuildTooltipData")

	while (achievementID ~= nil) do
		fa_DebugOut("achievementID: " .. tostring(achievementID))
		local id, name, points, completed, month, day, year, description, flags, icon, rewardText, isGuildAch,  wasEarnedByMe, earnedBy = GetAchievementInfo(achievementID)
		if (id ~= nil) then
			if (tempAchievementTooltipData[i] == nil) then
				tempAchievementTooltipData[i] = {}
			end
			tempAchievementTooltipData[i][1] = completed
			fa_DebugOut("completed: " .. tostring(completed))
			tempAchievementTooltipData[i][2] = name
			tempAchievementTooltipData[i][3] = earnedBy
			if (completed) then
				tempAchievementTooltipData[i][4] = string.format(SHORTDATE, day, month, year)
			end
			i = i + 1
			local nextID, completed = GetNextAchievement(id)
			achievementID = nextID
		else
			achievementID = nil
		end
	end
	
end


-----------------------------------------------------------------------------
-- Returns the localized standing label for the current player.
--
-- @param standingID  	standing value (1-8).
-- @return 				standing text.
-----------------------------------------------------------------------------
local function fa_StandingText(factionID, standingID)

	local standingTxt, friendID, friendTxtLevel

	-- Check for friendshipRepuation text
	if (factionID ~= nil) then
		friendID, _, _, _, _, _, friendTextLevel, _, _ = GetFriendshipReputation(factionID)
	end
	-- Set friend text
	if (friendID ~= nil) then
		standingTxt = friendTextLevel
	-- set paragon text
	elseif (standingID == 9) then
		standingTxt = L.MISC_PARAGON_TXT
	-- set normal standing level text
	else
		standingTxt = GetText("FACTION_STANDING_LABEL"..standingID, UnitSex("player"))
	end
	return(standingTxt)
end


-----------------------------------------------------------------------------
-- Gets next achievement value based on current exalted count.
--
-- @param exaltedCount  current could of exalted reputations.
-- @return 				number (string) of exalted reputation for NEXT achievement.
-----------------------------------------------------------------------------
local function fa_GetNextAchievementValue(exaltedCount)
	
	local stringOut
	
	if (exaltedCount == 0) then
		stringOut = tostring(1)
	elseif (exaltedCount >= 60) then
		stringOut = "NA"
	else -- between 0 and 60
		stringOut = tostring(((math.floor(exaltedCount/5)) + 1) * 5)
	end
	
	return(stringOut)
end


-----------------------------------------------------------------------------
-- Populate the global tempLoggingData table.
-----------------------------------------------------------------------------
local function fa_PopulateLoggingTable()
 
	local x,k,v
	
	-- init vars before rebuilding table
	wipe(tempLoggingData)
	tempLoggingData_rowcount = 0
	
	-- DEBUG
	fa_DebugOut("fa_PopulateLoggingTable: Start")
	
	-- always populate first line as last reputation gain
	tempLoggingData_rowcount = tempLoggingData_rowcount + 1
	tempLoggingData[tempLoggingData_rowcount] = {}
	tempLoggingData[tempLoggingData_rowcount][1] = faLastRepGainStr
	tempLoggingData[tempLoggingData_rowcount][2] = 2
	
	-- nothing in table - return
	if (FactionAddictLogData == nil or FactionAddictLogEntries == nil) then
		return
	end
	
	for x=1,FACTION_ADDICT_LOGGING_DAYS do
		-- check for nil date or entry
		if (FactionAddictLogData[x] == nil or FactionAddictLogEntries[x] == nil) then
			return
		end
		if (FactionAddictLogData[x]["date"] == nil or FactionAddictLogData[x]["rows"] == nil) then
			return
		end
		--check for no rows in the group
		if (FactionAddictLogData[x]["rows"] > 0) then
			-- insert the date if made it this far
			tempLoggingData_rowcount = tempLoggingData_rowcount + 1
			tempLoggingData[tempLoggingData_rowcount] = {}
			-- row text
			tempLoggingData[tempLoggingData_rowcount][1] = FactionAddictLogData[x]["date"]
			-- row header indicator
			tempLoggingData[tempLoggingData_rowcount][2] = 1
			fa_DebugOut("PopulateLoggingTable: rowcount: " ..  tostring(tempLoggingData_rowcount) .. " data: " .. tempLoggingData[tempLoggingData_rowcount][1])
			
			-- Loop through the entries table and build new table
			for k,v in sortedpairs(FactionAddictLogEntries[x]) do 
				tempLoggingData_rowcount = tempLoggingData_rowcount + 1
				tempLoggingData[tempLoggingData_rowcount] = {}
				-- row text
				if (tempFactionIDsByName[k] ~= nil) then 
					if (v < 0) then
						tempLoggingData[tempLoggingData_rowcount][1] = "[" .. k .. "]" .. ": " .. RED_FONT_COLOR_CODE .. tostring(v) .. FONT_COLOR_CODE_CLOSE
					else
						tempLoggingData[tempLoggingData_rowcount][1] = "[" .. k .. "]" .. ": " .. tostring(v)
					end
				else
					fa_DebugOut("PopulateLoggingTable: faction not found - " .. k)
					if (v < 0) then
						tempLoggingData[tempLoggingData_rowcount][1] = k .. ": " .. RED_FONT_COLOR_CODE .. tostring(v) .. FONT_COLOR_CODE_CLOSE
					else
						tempLoggingData[tempLoggingData_rowcount][1] = k .. ": " .. tostring(v)
					end
				end
				-- row header indicator
				tempLoggingData[tempLoggingData_rowcount][2] = 0
				fa_DebugOut("PopulateLoggingTable: rowcount: " ..  tostring(tempLoggingData_rowcount) .. " data: " .. tempLoggingData[tempLoggingData_rowcount][1])
			end
		end
	end
end


-----------------------------------------------------------------------------
-- Rolls the reputation log when adding a new entry for the session.
-----------------------------------------------------------------------------
local function fa_RollLogData()
	local x
	-- logs stored from 1-FACTION_ADDICT_LOGGING_DAYS; 1 is most current
	for x=FACTION_ADDICT_LOGGING_DAYS,2,-1 do
		fa_DebugOut("RollLogData: " .. tostring(x))
		if (FactionAddictLogData[x-1] ~= nil) then
			FactionAddictLogData[x] = {}
			FactionAddictLogData[x] = FactionAddictLogData[x-1]
		end
		if (FactionAddictLogEntries[x-1] ~= nil) then
			FactionAddictLogEntries[x] = {}
			FactionAddictLogEntries[x] = FactionAddictLogEntries[x-1]
		end
	end
	-- clear [1]
	FactionAddictLogData[1] = {}
	FactionAddictLogEntries[1] = {}
end


-----------------------------------------------------------------------------
-- Add entry to the reputation log.
--
-- @param faction  		faction to add to rep log.
-- @param rep           amount of rep to add to rep log for faction.
-----------------------------------------------------------------------------
local function fa_AddToRepLog(faction, rep)
	-- faSessionDate - set on addon load
	
	--Check if no data - add new entry for today and new rep
	if (FactionAddictLogData == nil) then
		FactionAddictLogData = {}
	end
	if (FactionAddictLogData[1] == nil) then
		FactionAddictLogData[1] = {}
	end
	if (FactionAddictLogData[1]["date"] == nil) then
		FactionAddictLogData[1]["date"] = faSessionDate
		FactionAddictLogData[1]["rows"] = 0
	end
	
	-- If adding a new day roll the log tables
	if (FactionAddictLogData[1]["date"] ~= faSessionDate) then
		fa_RollLogData()
		-- overwrite [1] after rolling
		FactionAddictLogData[1]["date"] = faSessionDate
		FactionAddictLogData[1]["rows"] = 0
	end
	-- add or increment rep for today
	if (FactionAddictLogEntries == nil) then
		FactionAddictLogEntries = {}
	end
	if (FactionAddictLogEntries[1] == nil) then
		FactionAddictLogEntries[1] = {}
	end
	if (FactionAddictLogEntries[1][faction] == nil) then
		FactionAddictLogEntries[1][faction] = rep
		FactionAddictLogData[1]["rows"] = FactionAddictLogData[1]["rows"] + 1
	else
		FactionAddictLogEntries[1][faction] = FactionAddictLogEntries[1][faction] + rep
	end
	fa_PopulateLoggingTable()
	
	if (FactionAddictTab2:IsShown()) then
		FactionAddict_LoggingScrollBar_Update()
	end
end


-----------------------------------------------------------------------------
-- Ordering functions.
--
-- @param a      		desc.
-- @param b             desc.
-- @return 				ordered table.
-----------------------------------------------------------------------------
-- order by barValue, then name
local function fa_orderby1(a,b)
	if a[7] == b[7] then
		return a[3] < b[3]
	else 
		return a[7] > b[7]
	end
end
-- order by name, then barValue
local function fa_orderby2(a,b)
	if a[3] == b[3] then
		return a[7] < b[7]
	else 
		return a[3] < b[3]
	end
end
-- sort by standingId, then barValue, then name
-- with 5.4 - Tillers subFactions cap at 6 Honored
-- workaround from first orderby function
local function fa_orderby3(a,b)
	if a[4] == b[4] then
		if a[7] == b[7] then
			return a[3] < b[3]
		else 
			return a[7] > b[7]
		end
	else 
		return a[4] > b[4]
	end
end
-- order by inactive flag, then standingId, then barValue, then name
local function fa_orderbyInactive1(a,b)
	-- [1] is factionid
	if FactionAddictConfigIsInactive[a[1]] == FactionAddictConfigIsInactive[b[1]] then
		if a[4] == b[4] then
			if a[7] == b[7] then
				return a[3] < b[3]
			else 
				return a[7] > b[7]
			end
		else 
			return a[4] > b[4]
		end
	else
		fa_DebugOut("factionid: ".. a[1] .. " a[inactive]: "..tostring(FactionAddictConfigIsInactive[a[1]]) .. " b[inactive]: "..tostring(FactionAddictConfigIsInactive[b[1]]))
		return not FactionAddictConfigIsInactive[a[1]] and FactionAddictConfigIsInactive[b[1]]
	end
end
-- order by inactive flag, then name, then barValue
local function fa_orderbyInactive2(a,b)
	-- [1] is factionid
	if FactionAddictConfigIsInactive[a[1]] == FactionAddictConfigIsInactive[b[1]] then
		if a[3] == b[3] then
			return a[7] < b[7]
		else 
			return a[3] < b[3]
		end
	else
		fa_DebugOut("factionid: ".. a[1] .. " a[inactive]: "..tostring(FactionAddictConfigIsInactive[a[1]]) .. " b[inactive]: "..tostring(FactionAddictConfigIsInactive[b[1]]))
		return not FactionAddictConfigIsInactive[a[1]] and FactionAddictConfigIsInactive[b[1]]
	end
end


-----------------------------------------------------------------------------
-- Sort the display table bt name then rep value.
-----------------------------------------------------------------------------
local function fa_SortDisplayTable()

	-- name in [3], reputation value in [7]
	if (FactionAddictConfig.RB_ORDERBY == 1) then
		table.sort(tempDisplayData, fa_orderbyInactive1)
	else
		table.sort(tempDisplayData, fa_orderbyInactive2)
	end
	
end


-----------------------------------------------------------------------------
-- Creates a "master" table of all the faction data.
--
-- Built table columns - global tempAllFactionData
--      column 1 - faction id
--      column 2 - faction icon
--      column 3 - faction name
--      column 4 - faction standingID
--      column 5 - faction barMin
--      column 6 - faction barMax
--      column 7 - faction barValue
--      column 8 - faction pctToExalted
--      column 9 - faction description
--      column 10 - faction expansion
--      column 11 - faction side
--      column 12 - faction category
--      column 13 - hasBonusRepGain
--      column 14 - canBeLFGBonus
--
--  global tempAllParagonData
--      column 1 - current paragon value
--      column 2 - paragon threshold - max
--      column 3 - paragon quest id
--      column 4 - paragon reward pending flag
--      column 5 - paragon logging value
-----------------------------------------------------------------------------
local function fa_PopulateAllFactionDataTable()

	local maintableRow
	
	-- avoid unnecessary rebuilding of table
	if (doServerFactionQuery == 0) then
		return
	end
	
	-- init vars before rebuilding table
	tempAllFactionData_rowcount = 0
	doServerFactionQuery = 0
	faUpdateDisplayTable = true
	faNumFactions = 0
	faNumFactionsExalted = 0
	faPlayerGuildName = ""
	--wipe(tempAllFactionData)

	-- Update list of inactive factions
	fa_UpdateInactiveFactionsList()

	-- This creates a temp table by joining local faction data and server results
	for maintableRow in ipairs(faFactionData) do
		-- Get Faction Info
		local name, description, standingID, barMin, barMax, barValue, atWarWith, canToggleAtWar, isHeader, isCollapsed, hasRep, isWatched, isChild, factionID, hasBonusRepGain, canBeLFGBonus = GetFactionInfoByID(faFactionData[maintableRow][1])

		if (name ~= nil) then
		
			-- DEBUG -- 
			fa_DebugOut("Faction Addict: Got info for - " .. name .. " id: " ..  tostring(faFactionData[maintableRow][1]) )
		
			-- build a temp table mapping faction names to faction ids
			tempFactionIDsByName[name] = faFactionData[maintableRow][1]
		
			-- calculate percent to exalted
			local percentToExalted = (barValue / 42000)*100
			-- cap at 100
			if (percentToExalted > 100) then
				percentToExalted = 100
			end

			-- PARAGON REP
			if (C_Reputation.IsFactionParagon(faFactionData[maintableRow][1])) then
				local paraValue, paraThreshold, paraQuestId, paraRewardPending = C_Reputation.GetFactionParagonInfo(faFactionData[maintableRow][1])
				barMin = 0
				barMax = paraThreshold
				-- assuming paraValue never resets - based on ReputationFrame.lua usage
				barValue = mod(paraValue, paraThreshold) 
				if (paraRewardPending) then
					barValue = barValue + paraThreshold
				end
				-- 9 will represent Paragon in addon - not a client value
				standingID = 9 
				-- overwrite percentToExalted with NextParagonReward
				percentToExalted = (barValue / barMax)*100
				-- preload data
				C_Reputation.RequestFactionParagonPreloadRewardData(faFactionData[maintableRow][1])
				
				-- save paragon data
				if (tempAllParagonData[faFactionData[maintableRow][1]] == nil) then
					tempAllParagonData[faFactionData[maintableRow][1]] = {}
				end
				-- column 1 - current paragon value
				tempAllParagonData[faFactionData[maintableRow][1]][1] = paraValue
				-- column 2 - paragon threshold - max
				tempAllParagonData[faFactionData[maintableRow][1]][2] = paraThreshold
				-- column 3 - paragon quest id
				tempAllParagonData[faFactionData[maintableRow][1]][3] = paraQuestId
				-- column 4 - paragon reward pending flag
				tempAllParagonData[faFactionData[maintableRow][1]][4] = paraRewardPending
				-- column 5 - paragon logging value - set in PLAYER_LOGIN and modified in CHAT_MSG_COMBAT_FACTION_CHANGE
				-- ONLY set column 5 if it is nil - means faction became exalted since login
				if (tempAllParagonData[faFactionData[maintableRow][1]][5] == nil) then
					tempAllParagonData[faFactionData[maintableRow][1]][5] = paraValue
				end
			end
			-- END PARAGON REP

			-- Determine if capped
			if (standingID == 8) then
				--barMin, barMax, barValue = 0, 1, 1
				barMin = 0
			end
			-- check if this is a friendship faction 
			local friendID, friendRep, friendMaxRep, friendName, friendText, friendTexture, friendTextLevel, friendThreshold, nextFriendThreshold = GetFriendshipReputation(faFactionData[maintableRow][1])
			if (friendID ~= nil) then
				if ( nextFriendThreshold ) then
					barMin, barMax, barValue = friendThreshold, nextFriendThreshold, friendRep
				else
					barMin, barMax, barValue = 0, friendMaxRep, friendRep
				end
				-- Bug with api?? Chromie shows maxrep of 42000 when 15000 is the cap for Timelord
				-- Chromie workaround 15000 cap - overwrite percent
				if (friendID == 2135) then
					percentToExalted = (barValue / 15000)*100
					if (percentToExalted > 100) then
						percentToExalted = 100
					end
				end
			end

			-- increase exalted count
			if (standingID == 8 or standingID == 9) then
				faNumFactionsExalted = faNumFactionsExalted + 1
			end
			faNumFactions = faNumFactions + 1
			
			if (tempAllFactionData[name] == nil) then
				tempAllFactionData[name] = {}
			end
			tempAllFactionData_rowcount = tempAllFactionData_rowcount + 1
			
			-- column 1 - faction id
			tempAllFactionData[name][1] = faFactionData[maintableRow][1]
			-- column 2 - faction icon
			tempAllFactionData[name][2] = faFactionData[maintableRow][2]
			-- column 3 - faction name
			tempAllFactionData[name][3] = name
			-- column 4 - faction standingID
			tempAllFactionData[name][4] = standingID
			-- column 5 - faction barMin
			tempAllFactionData[name][5] = barMin
			-- column 6 - faction barMax
			tempAllFactionData[name][6] = barMax
			-- column 7 - faction barValue
			tempAllFactionData[name][7] = barValue
			-- column 8 - faction pctToExalted
			tempAllFactionData[name][8] = string.format("%4.2f%%", percentToExalted)
			-- column 9 - faction description
			tempAllFactionData[name][9] = description
			-- column 10 - faction expansion
			tempAllFactionData[name][10] = faFactionData[maintableRow][3]
			-- column 11 - faction side
			tempAllFactionData[name][11] = faFactionData[maintableRow][4]
			-- column 12 - faction category
			tempAllFactionData[name][12] = faFactionData[maintableRow][5]
			-- column 13 - hasBonusRepGain
			tempAllFactionData[name][13] = hasBonusRepGain
			-- column 14 - canBeLFGBonus
			tempAllFactionData[name][14] = canBeLFGBonus
			
			-- Save players guild name
			if (tempAllFactionData[name][1] == GUILD_FACTION_ID) then
				faPlayerGuildName = tempAllFactionData[name][3]
			end

			-- Handle long faction names
			if (strlen(name) > 25) then
				local tempTruncFactionName = strsub(name, 1, 23) .. "..."
				fa_DebugOut("Truncated Name: " .. tempTruncFactionName)
				tempTruncNamesTable[tempTruncFactionName] = name
			end
		
		end

	end
	fa_DebugOut("NumFactions: ".. tostring(faNumFactions))
	fa_DebugOut("NumFactionsExalted: ".. tostring(faNumFactionsExalted))
	-- populate logging table - workaround for guildname issue
	fa_PopulateLoggingTable()
	-- populate achievement tooltip table
	fa_BuildTooltipData()

end


-----------------------------------------------------------------------------
-- Populate the global Display table based on config settings and options.
-----------------------------------------------------------------------------
local function fa_PopulateDisplayTable()
	
	local maintableRow
	local displayThisRow
	
	fa_DebugOut("fa_PopulateDisplayTable - doServerFactionQuery: " .. tostring(doServerFactionQuery) .. " - faUpdateDisplayTable: " .. tostring(faUpdateDisplayTable))

		-- if the suggest table is nil force an update
	if (tempDisplayData == nil) then
		faUpdateDisplayTable = true
	end
	

	-- populate all faction data - serveryquery flag used here
	-- if doServerFactionQuery is true - UpdateDisplayTable flag will be set to true in here
	fa_PopulateAllFactionDataTable()


	-- Only need to populate this table once - and when server data is rechecked or config change
	if (faUpdateDisplayTable == false) then
		return
	end

	-- init vars before rebuilding table
	wipe(tempDisplayData)
	tempDisplayData_rowcount = 0
	faUpdateDisplayTable = false

	faNumFactions = 0

	-- This creates a temp table by joining local faction data and server results
	for maintableRow in pairs(tempAllFactionData) do

		-- Determine if row should be displayed based on config settings
		displayThisRow = false
		
		local factionID  = tempAllFactionData[maintableRow][1]
		local standingID = tempAllFactionData[maintableRow][4]
		local barValue   = tempAllFactionData[maintableRow][7]
		local expansion  = tempAllFactionData[maintableRow][10]
		local aoho       = tempAllFactionData[maintableRow][11]
		
		-- Check standing filter for displayed factions
		if (standingID == 8 and FactionAddictConfig.CB_STANDING_EXALTED == true) then
			displayThisRow = true
		elseif (standingID == 7 and FactionAddictConfig.CB_STANDING_REVERED == true) then
			-- May need to add a filter for Chromie - modify handling of Tillers filtering at same time?
			displayThisRow = true
		-- Workaround due to capping of Tillers SubFaction at standing 6
		elseif (standingID == 6) then
			if (barValue >= 42000 and FactionAddictConfig.CB_STANDING_EXALTED == true) then
				displayThisRow = true
			elseif (barValue >= 21000 and barValue < 42000 and FactionAddictConfig.CB_STANDING_REVERED == true) then
				displayThisRow = true
			elseif (barValue >= 9000 and barValue < 21000 and FactionAddictConfig.CB_STANDING_HONORED == true) then
				displayThisRow = true
			elseif (barValue >= 3000 and barValue < 9000 and FactionAddictConfig.CB_STANDING_FRIENDLY == true) then
				displayThisRow = true
			end
		elseif (standingID == 5 and FactionAddictConfig.CB_STANDING_FRIENDLY == true) then
			displayThisRow = true
		elseif (standingID == 4 and barValue > 0 and FactionAddictConfig.CB_STANDING_NEUTRAL1 == true) then
			displayThisRow = true
		elseif (standingID == 4 and barValue == 0 and FactionAddictConfig.CB_STANDING_NEUTRAL0 == true) then
			displayThisRow = true
		elseif (standingID == 3 and FactionAddictConfig.CB_STANDING_UNFRIENDLY == true) then
			displayThisRow = true
		elseif (standingID == 2 and FactionAddictConfig.CB_STANDING_HOSTILE == true) then
			displayThisRow = true
		elseif (standingID == 1 and FactionAddictConfig.CB_STANDING_HATED == true) then
			displayThisRow = true
		elseif (standingID == 9 and FactionAddictConfig.CB_STANDING_PARAGON == true) then
			displayThisRow = true
		else
			displayThisRow = false
		end
		
		-- Check expansion type filter
		if (displayThisRow) then
			if (expansion == 0 and FactionAddictConfig.CB_CATEGORY_CF == true) then
				displayThisRow = true
			elseif (expansion == 1 and FactionAddictConfig.CB_CATEGORY_BC == true) then
				displayThisRow = true
			elseif (expansion == 2 and FactionAddictConfig.CB_CATEGORY_WOTLK == true) then
				displayThisRow = true
			elseif (expansion == 3 and FactionAddictConfig.CB_CATEGORY_CATA == true) then
				displayThisRow = true
			elseif (expansion == 4 and FactionAddictConfig.CB_CATEGORY_MOP == true) then
				displayThisRow = true
			elseif (expansion == 5 and FactionAddictConfig.CB_CATEGORY_WOD == true) then
				displayThisRow = true
			elseif (expansion == 6 and FactionAddictConfig.CB_CATEGORY_LG == true) then
				displayThisRow = true
			elseif (expansion == 7 and FactionAddictConfig.CB_CATEGORY_BFA == true) then
				displayThisRow = true
			else
				displayThisRow = false
			end
		end
		
		-- Check alliance/horde filter
		if (displayThisRow) then
			if (aoho == 1 and FactionAddictConfig.CB_FILTER_SHOW_AO == true) then
				displayThisRow = true
			elseif (aoho == 2 and FactionAddictConfig.CB_FILTER_SHOW_HO == true) then
				displayThisRow = true
			elseif (aoho == 0) then
				displayThisRow = true
			else
				displayThisRow = false
			end
		end

		-- Check inactive faction
		if (displayThisRow) then
			if ((FactionAddictConfig.CB_OPTION_HIDEINACTIVE_V2 == true) and (FactionAddictConfigIsInactive[factionID] == true)) then
				displayThisRow = false
			else
				displayThisRow = true
			end
		end

		-- handle search box
		if ((displayThisRow == true) and (faNameFilter ~= "")) then
			local tempDebugStr = "fa_PopulateDisplayTable - name: " .. tempAllFactionData[maintableRow][3] .. "; Filter: " .. faNameFilter
			fa_DebugOut(tempDebugStr)
			if( string.find(string.lower(tempAllFactionData[maintableRow][3]),string.lower(faNameFilter)) == nil ) then
				displayThisRow = false
			end
		end

		if (displayThisRow) then
			-- inc num factions
			faNumFactions = faNumFactions + 1
			-- inc rowcount for display table
			tempDisplayData_rowcount = tempDisplayData_rowcount + 1
			-- create a new row
			tempDisplayData[tempDisplayData_rowcount] = {}
			-- copy row from alldata table
			tempDisplayData[tempDisplayData_rowcount] = tempAllFactionData[maintableRow]
		end
		
	end
	
	-- set text
	fa_DebugOut("NumFactions: ".. tostring(faNumFactions))
	fa_DebugOut("NumFactionsExalted: ".. tostring(faNumFactionsExalted))
	FactionAddictTab1.faFactionsText1:SetText(L.NEXT_ACHIEV_TXT .. HIGHLIGHT_FONT_COLOR_CODE .. fa_GetNextAchievementValue(faNumFactionsExalted) .. FONT_COLOR_CODE_CLOSE)
	FactionAddictTab1.faFactionsText2:SetText(L.SHOWN_TXT .. HIGHLIGHT_FONT_COLOR_CODE .. tostring(faNumFactions) .. FONT_COLOR_CODE_CLOSE .. " - " .. L.EXALTED_TXT .. HIGHLIGHT_FONT_COLOR_CODE .. tostring(faNumFactionsExalted) .. FONT_COLOR_CODE_CLOSE)

end


-----------------------------------------------------------------------------
-- Returns a string of status bar text.
--
-- @param offset  		offset into DisplayData table.
-- @return 				string of faction info for status bar.
-----------------------------------------------------------------------------
local function fa_SetStatusBarText(offset)

	local outString
	outString = tostring(tempDisplayData[offset][7]) .. " / " .. tostring(tempDisplayData[offset][6])
	return outString

end


-----------------------------------------------------------------------------
-- Returns a string of status bar text based on faction name.
--
-- @param faction_name 	name of faction to set text for.
-- @return 				string of status bar text.
-----------------------------------------------------------------------------
local function fa_SetStatusBarText_ByFactionName(faction_name)

	local outString
	outString = tostring(tempAllFactionData[faction_name][7]) .. " / " .. tostring(tempAllFactionData[faction_name][6])
	return outString
end


-----------------------------------------------------------------------------
-- Remove old unused config variables by setting them to nil.
-----------------------------------------------------------------------------
local function fa_CleanConfigVars()
	
	local key, value

	-- loop through the client stored variables - remove those no longer used
	for key,value in pairs(FactionAddictConfig) do 
		if (FactionAddictConfigDefaults[key] == nil) then
			FactionAddictConfig[key] = nil
			fa_DebugOut("Faction Addict - Removing old config value: " .. key)
		end
	end
	
end


-----------------------------------------------------------------------------
-- Set ShowHide default values. If exists leave value else set to false. 
-- False means faction will be shown.
-----------------------------------------------------------------------------
local function fa_SetConfigShowHideDefaults()

	local key, value

	-- create array if doesnt exist
	if (FactionAddictConfigIsInactive == nil) then
		FactionAddictConfigIsInactive = {}
	end

	-- Create or Add to config settings from data table
	for maintableRow in ipairs(faFactionData)
	do
		if (FactionAddictConfigIsInactive[faFactionData[maintableRow][1]] == nil) then
			FactionAddictConfigIsInactive[faFactionData[maintableRow][1]] = false
		end
	end
	
	-- Remove any configs that no longer exist
	for key, value in pairs(FactionAddictConfigIsInactive)
	do
		if (faFactionDataRow[key] == nil) then
			FactionAddictConfigIsInactive[key] = nil
			fa_DebugOut("Faction Addict - Removing old show/hide config value: " .. key)
		end
	end
end


-----------------------------------------------------------------------------
-- If log data needs any updates due to version change it is done here.
-----------------------------------------------------------------------------
local function fa_UpdateLogVersion()

	-- FactionAddictLogVersion - version stored in saved variables 
	-- FACTION_ADDICT_LOGGING_VERSION - version for current version of addon

	-- use this function to do any required log data updates
	fa_DebugOut("Faction Addict - Updating Log Version From: " .. FactionAddictLogVersion .. "To: " .. FACTION_ADDICT_LOGGING_VERSION)
	
	-- TODOFUTURE - add update functionality when necessary
	
	-- update stored version
	FactionAddictLogVersion = FACTION_ADDICT_LOGGING_VERSION
	
end


-----------------------------------------------------------------------------
-- Displays a tooltip.
-----------------------------------------------------------------------------
function FactionAddict_DisplayTooltip(self)

	local name = self:GetName()
	
	fa_DebugOut("DisplayTooltip: " .. name)
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	
	-- Show tooltip based on config item name
	GameTooltip:SetText(faFactionAddictTooltips[name], 1.0,1.0,1.0,1,1)
end


-----------------------------------------------------------------------------
-- Get the drop down config value.
--
-- @param param  		the drop down item.
-- @return 				CB config value for param - else false.
-----------------------------------------------------------------------------
local function fa_GetDDConfigValue(param)
	
	if (FactionAddictConfig == nil) then
		return
	end
	
	if (param == "CB_STANDING_EXALTED") then
		return(FactionAddictConfig.CB_STANDING_EXALTED)
	elseif (param == "CB_STANDING_PARAGON") then
		return(FactionAddictConfig.CB_STANDING_PARAGON)
	elseif (param == "CB_STANDING_REVERED") then
		return(FactionAddictConfig.CB_STANDING_REVERED)
	elseif (param == "CB_STANDING_HONORED") then
		return(FactionAddictConfig.CB_STANDING_HONORED)
	elseif (param == "CB_STANDING_FRIENDLY") then
		return(FactionAddictConfig.CB_STANDING_FRIENDLY)
	elseif (param == "CB_STANDING_NEUTRAL1") then
		return(FactionAddictConfig.CB_STANDING_NEUTRAL1)
	elseif (param == "CB_STANDING_NEUTRAL0") then
		return(FactionAddictConfig.CB_STANDING_NEUTRAL0)
	elseif (param == "CB_STANDING_UNFRIENDLY") then
		return(FactionAddictConfig.CB_STANDING_UNFRIENDLY)
	elseif (param == "CB_STANDING_HOSTILE") then
		return(FactionAddictConfig.CB_STANDING_HOSTILE)
	elseif (param == "CB_STANDING_HATED") then
		return(FactionAddictConfig.CB_STANDING_HATED)
	else
		return(false)
	end
end


-----------------------------------------------------------------------------
-- Set the drop down config value.
--
-- @param arg1  		CB config value.
-- @param arg2          not used.
-- @param checked       checked value to be set for CB item.
-- @return 				false if arg1 invalid.
-----------------------------------------------------------------------------
local function fa_SetDDConfigValue(self, arg1, arg2, checked)
	PlaySound(SOUNDKIT.IG_INVENTORY_ROTATE_CHARACTER)
	
	if (arg1 == "CB_STANDING_EXALTED") then
		FactionAddictConfig.CB_STANDING_EXALTED = checked
		faUpdateDisplayTable = true
	elseif (arg1 == "CB_STANDING_PARAGON") then
		FactionAddictConfig.CB_STANDING_PARAGON = checked
		faUpdateDisplayTable = true
	elseif (arg1 == "CB_STANDING_REVERED") then
		FactionAddictConfig.CB_STANDING_REVERED = checked
		faUpdateDisplayTable = true
	elseif (arg1 == "CB_STANDING_HONORED") then
		FactionAddictConfig.CB_STANDING_HONORED = checked
		faUpdateDisplayTable = true
	elseif (arg1 == "CB_STANDING_FRIENDLY") then
		FactionAddictConfig.CB_STANDING_FRIENDLY = checked
		faUpdateDisplayTable = true
	elseif (arg1 == "CB_STANDING_NEUTRAL1") then
		FactionAddictConfig.CB_STANDING_NEUTRAL1 = checked
		faUpdateDisplayTable = true
	elseif (arg1 == "CB_STANDING_NEUTRAL0") then
		FactionAddictConfig.CB_STANDING_NEUTRAL0 = checked
		faUpdateDisplayTable = true
	elseif (arg1 == "CB_STANDING_UNFRIENDLY") then
		FactionAddictConfig.CB_STANDING_UNFRIENDLY = checked
		faUpdateDisplayTable = true
	elseif (arg1 == "CB_STANDING_HOSTILE") then
		FactionAddictConfig.CB_STANDING_HOSTILE = checked
		faUpdateDisplayTable = true
	elseif (arg1 == "CB_STANDING_HATED") then
		FactionAddictConfig.CB_STANDING_HATED = checked
		faUpdateDisplayTable = true
	else
		return(false)
	end
	
	-- after updating config refresh display
	-- populate the display table
	fa_PopulateDisplayTable()
	-- order the display
	fa_SortDisplayTable()
	-- display the data
	if (FactionAddictTab1:IsShown()) then
		FactionAddict_ScrollBar_Update()
	end
	
end


-----------------------------------------------------------------------------
-- Set the stored Paragon Log Value (total)
--
-- assumption: tempAllParagonData has been initially populated
-----------------------------------------------------------------------------
local function fa_UpdateParagonLogValue()

	-- column 1 - current paragon value
	-- column 2 - paragon threshold - max
	-- column 3 - paragon quest id
	-- column 4 - paragon reward pending flag
	-- column 5 - paragon logging value

	for key,value in pairs(tempAllParagonData) do      
		-- copy paraValue to logging value
		tempAllParagonData[key][5] = tempAllParagonData[key][1]
		fa_DebugOut("FactionID: " .. key .. " - Initial Paragon: " .. tempAllParagonData[key][5])
	end
end 

-----------------------------------------------------------------------------
-- Handles OnEnter event from xml. Shows a tooltip.
-----------------------------------------------------------------------------
function FactionAddict_AchText_OnEnter(self)

	local tableRow

	-- Populate Achievement Completion tooltip
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 15, -95)
	GameTooltip:SetText(YELLOW_FONT_COLOR_CODE..L.ACHIEVEMENT_TT_TITLE..FONT_COLOR_CODE_CLOSE)
	GameTooltip:AddLine(" ")
	
	-- NOTE - there is currently a limit of 10 textures in the GameToolTip
	-- since this needs 11 show none at this time

	for tableRow in ipairs(tempAchievementTooltipData) do
		-- there is a case where not all data is present when tooltip data was built
		-- clients that load quickly - low level chars with not many addons
		if ((tempAchievementTooltipData[tableRow][1] == true) and 
			(tempAchievementTooltipData[tableRow][3] == nil or tempAchievementTooltipData[tableRow][3] == '')) then
			fa_BuildTooltipData()
		end

		-- build string - also show which character earned achievement
		local displayString = tempAchievementTooltipData[tableRow][2]
		if (tempAchievementTooltipData[tableRow][3] ~= nil and tempAchievementTooltipData[tableRow][3] ~= '') then
			displayString = displayString .. " (" .. tempAchievementTooltipData[tableRow][3] .. ")"
		end
		-- also show date completed
		if (tempAchievementTooltipData[tableRow][4] ~= nil) then
			displayString = displayString .. " [" .. tempAchievementTooltipData[tableRow][4] .. "]"
		end
		
		-- Check if achievement completed
		if (tempAchievementTooltipData[tableRow][1] == true) then
			GameTooltip:AddLine(displayString, GREEN_FONT_COLOR.r, GREEN_FONT_COLOR.g, GREEN_FONT_COLOR.b, false)
			--GameTooltip:AddTexture("Interface\\RAIDFRAME\\ReadyCheck-Ready")
		else
			GameTooltip:AddLine(displayString, GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b, false)
			--GameTooltip:AddTexture(" ")
		end
	end
	GameTooltip:Show()
end


-----------------------------------------------------------------------------
-- Handles refresh of the ScrollBar element from xml.
-----------------------------------------------------------------------------
function FactionAddict_ScrollBar_Update()
	local line           -- 1 through 7 of our window to scroll
	local lineplusoffset -- an index into our data calculated from the scroll offset
	local color          -- status bar color

	fa_DebugOut("FactionAddict_ScrollBar_Update() - display rowcount: " .. tempDisplayData_rowcount)

	FauxScrollFrame_Update(FactionAddictScrollBar,tempDisplayData_rowcount,7,44)
	for line=1,7 do
		lineplusoffset = line + FauxScrollFrame_GetOffset(FactionAddictScrollBar)
		
		-- set alpha values for each row
		if (tempDisplayData_rowcount == 0) then
			getglobal("FactionAddictEntry"..line).FactionAddictButtonBack:Hide()
			getglobal("FactionAddictEntry"..line).FactionAddictButtonHighlight:Hide()
		else
			getglobal("FactionAddictEntry"..line).FactionAddictButtonBack:Show()
			getglobal("FactionAddictEntry"..line).FactionAddictButtonHighlight:Show()
			getglobal("FactionAddictEntry"..line).FactionAddictButtonBack:SetAlpha(0.35)
			getglobal("FactionAddictEntry"..line).FactionAddictButtonHighlight:SetAlpha(0.70)
		end
		
		if lineplusoffset <= tempDisplayData_rowcount then
			getglobal("FactionAddictEntry"..line):Enable()
			getglobal("FactionAddictEntry"..line).FactionNameTxt:SetText(tempDisplayData[lineplusoffset][3])
			getglobal("FactionAddictEntry"..line).FactionNameTxt:Show()
			
			-- set faction icon texture
			getglobal("FactionAddictEntry"..line).FactionIcon:SetTexture(tempDisplayData[lineplusoffset][2])
			getglobal("FactionAddictEntry"..line).FactionIcon:Show()
			
			-- set faction icon overlay texture
			if (tempDisplayData[lineplusoffset][4] == 8 or tempDisplayData[lineplusoffset][4] == 9) then
				getglobal("FactionAddictEntry"..line).FactionIconOverlay:Show()
			else
				getglobal("FactionAddictEntry"..line).FactionIconOverlay:Hide()
			end
			
			-- set faction side icon
			if (tempDisplayData[lineplusoffset][11] == 2) then
				getglobal("FactionAddictEntry"..line).SideFactionIcon:SetTexture("Interface\\BattlefieldFrame\\Battleground-Horde.png")
				getglobal("FactionAddictEntry"..line).SideFactionIcon:Show()
				getglobal("FactionAddictEntry"..line).SideFactionIcon:SetDrawLayer("OVERLAY",7)
			elseif (tempDisplayData[lineplusoffset][11] == 1) then
				getglobal("FactionAddictEntry"..line).SideFactionIcon:SetTexture("Interface\\BattlefieldFrame\\Battleground-Alliance.png")
				getglobal("FactionAddictEntry"..line).SideFactionIcon:Show()
				getglobal("FactionAddictEntry"..line).SideFactionIcon:SetDrawLayer("OVERLAY",7)
			else
				getglobal("FactionAddictEntry"..line).SideFactionIcon:Hide()
			end
			
			
			-- set percent
			getglobal("FactionAddictEntry"..line).FactionPctTxt:SetText(tempDisplayData[lineplusoffset][8])
			getglobal("FactionAddictEntry"..line).FactionPctTxt:Show()
			
			-- set progress bar
			getglobal("FactionAddictEntry"..line).FAReputationBar:SetMinMaxValues(tempDisplayData[lineplusoffset][5], tempDisplayData[lineplusoffset][6])
			getglobal("FactionAddictEntry"..line).FAReputationBar:SetValue(tempDisplayData[lineplusoffset][7])
			getglobal("FactionAddictEntry"..line).FAReputationBar:Show()
			
			-- set bar color
			if (tempDisplayData[lineplusoffset][4] == 9) then
				color = FACTION_ADDICT_PARAGON_COLOR
			else
				color = FACTION_BAR_COLORS[tempDisplayData[lineplusoffset][4]]
			end
			
			getglobal("FactionAddictEntry"..line).FAReputationBar:SetStatusBarColor(color.r, color.g, color.b)
			-- set progress bar text
			getglobal("FactionAddictEntry"..line).FAReputationBar.text:SetText(fa_StandingText(tempDisplayData[lineplusoffset][1],tempDisplayData[lineplusoffset][4]))
			getglobal("FactionAddictEntry"..line).FAReputationBar.text:Show()
			
			getglobal("FactionAddictEntry"..line).FAReputationBar.text2:SetText(fa_SetStatusBarText(lineplusoffset))
			getglobal("FactionAddictEntry"..line).FAReputationBar.text2:Hide()
			
			-- set bonus icon
			if (tempDisplayData[lineplusoffset][13] == true) then
				getglobal("FactionAddictEntry"..line).FAReputationBar.FABonusIcon:Show()
			else
				getglobal("FactionAddictEntry"..line).FAReputationBar.FABonusIcon:Hide()
			end

			-- set paragon reward icon
			if (tempDisplayData[lineplusoffset][4] == 9) then
				getglobal("FactionAddictEntry"..line).FAReputationBar.FAParagonIcon:Show()
				getglobal("FactionAddictEntry"..line).FAReputationBar.FAParagonIcon.Glow:SetShown(tempAllParagonData[tempDisplayData[lineplusoffset][1]][4])
				getglobal("FactionAddictEntry"..line).FAReputationBar.FAParagonIcon.Check:SetShown(tempAllParagonData[tempDisplayData[lineplusoffset][1]][4])
			else
				getglobal("FactionAddictEntry"..line).FAReputationBar.FAParagonIcon:Hide()
			end

			-- set LFG Bonus Rep button
			if (fa_IsFactionInReputationDisplay(tempDisplayData[lineplusoffset][1])) then 
				getglobal("FactionAddictEntry"..line).FALFGBonusRepButton.factionID = tempDisplayData[lineplusoffset][1]
				getglobal("FactionAddictEntry"..line).FALFGBonusRepButton:SetShown(tempDisplayData[lineplusoffset][14])
				getglobal("FactionAddictEntry"..line).FALFGBonusRepButton:SetChecked(lfgBonusFactionID == tempDisplayData[lineplusoffset][1])
				getglobal("FactionAddictEntry"..line).FALFGBonusRepButton:SetEnabled(lfgBonusFactionID ~= tempDisplayData[lineplusoffset][1])
				getglobal("FactionAddictEntry"..line).FALFGBonusRepButton.Glow:Show()
				getglobal("FactionAddictEntry"..line).FALFGBonusRepButton.Glow:SetAlpha(0.18)
				getglobal("FactionAddictEntry"..line).FALFGBonusRepButton.GlowAnim:Stop()
			else
				getglobal("FactionAddictEntry"..line).FALFGBonusRepButton:Disable()
				getglobal("FactionAddictEntry"..line).FALFGBonusRepButton:Hide()
			end

			-- set expansion icon (ExpansionIcon)
			if (tempDisplayData[lineplusoffset][10] == 1) then -- BC
				getglobal("FactionAddictEntry"..line).ExpansionIcon:SetTexCoord(0.0, 0.546875, 0.0, 0.1171875)
				getglobal("FactionAddictEntry"..line).ExpansionIcon:Show()
			elseif (tempDisplayData[lineplusoffset][10] == 2) then -- WOTLK
				getglobal("FactionAddictEntry"..line).ExpansionIcon:SetTexCoord(0.0, 0.546875, 0.1171875, 0.234375)
				getglobal("FactionAddictEntry"..line).ExpansionIcon:Show()
			elseif (tempDisplayData[lineplusoffset][10] == 3) then -- Cata
				getglobal("FactionAddictEntry"..line).ExpansionIcon:SetTexCoord(0.0, 0.546875, 0.234375, 0.3515625)
				getglobal("FactionAddictEntry"..line).ExpansionIcon:Show()
			elseif (tempDisplayData[lineplusoffset][10] == 4) then -- MOP
				getglobal("FactionAddictEntry"..line).ExpansionIcon:SetTexCoord(0.0, 0.546875, 0.3515625, 0.46875)
				getglobal("FactionAddictEntry"..line).ExpansionIcon:Show()
			elseif (tempDisplayData[lineplusoffset][10] == 5) then -- WOD 
				getglobal("FactionAddictEntry"..line).ExpansionIcon:SetTexCoord(0.0, 0.546875, 0.46875, 0.5859375)
				getglobal("FactionAddictEntry"..line).ExpansionIcon:Show()
			elseif (tempDisplayData[lineplusoffset][10] == 6) then -- LG
				getglobal("FactionAddictEntry"..line).ExpansionIcon:SetTexCoord(0.0, 0.546875, 0.59375, 0.703125)
				getglobal("FactionAddictEntry"..line).ExpansionIcon:Show()
			elseif (tempDisplayData[lineplusoffset][10] == 7) then -- BfA
				getglobal("FactionAddictEntry"..line).ExpansionIcon:SetTexCoord(0.0, 0.546875, 0.703125, 0.828125)
				getglobal("FactionAddictEntry"..line).ExpansionIcon:Show()
			else -- classic
				getglobal("FactionAddictEntry"..line).ExpansionIcon:Hide()
			end

			-- set background color of entry based on Inactive flag
			if (FactionAddictConfigIsInactive[tempDisplayData[lineplusoffset][1]] == false) then  
				getglobal("FactionAddictEntry"..line).FactionAddictButtonBack:SetTexCoord(0.00195313,0.57421875,0.0078125,0.3671875)

			else
				getglobal("FactionAddictEntry"..line).FactionAddictButtonBack:SetTexCoord(0.00195313,0.57421875,0.390625,0.7578125)
			end

		else
			getglobal("FactionAddictEntry"..line):Disable()
			getglobal("FactionAddictEntry"..line).FactionNameTxt:Hide()
			getglobal("FactionAddictEntry"..line).FactionIcon:Hide()
			getglobal("FactionAddictEntry"..line).FactionIconOverlay:Hide()
			getglobal("FactionAddictEntry"..line).FactionPctTxt:Hide()
			getglobal("FactionAddictEntry"..line).FAReputationBar:Hide()
			getglobal("FactionAddictEntry"..line).FAReputationBar.FABonusIcon:Hide()
			getglobal("FactionAddictEntry"..line).FAReputationBar.FAParagonIcon:Hide()
			getglobal("FactionAddictEntry"..line).SideFactionIcon:Hide()
			getglobal("FactionAddictEntry"..line).ExpansionIcon:Hide()
			getglobal("FactionAddictEntry"..line).FALFGBonusRepButton:Disable()
			getglobal("FactionAddictEntry"..line).FALFGBonusRepButton:Hide()
			getglobal("FactionAddictEntry"..line).FactionAddictButtonBack:Hide()
		end
	end
	
	-- inform user nothing to show
	if (tempDisplayData_rowcount == 0) then
		-- Show error message
		FactionAddictTab1.faErrorText1:Show()
		FactionAddictTab1.faErrorText1:SetText(L.ERROR1)
		-- Hide scroll bar -- 
		FactionAddictTab1FactionAddictScrollBar:Hide()
	else
		FactionAddictTab1.faErrorText1:Hide()
		FactionAddictTab1FactionAddictScrollBar:Show()
	end
end


-----------------------------------------------------------------------------
-- Handles OnClick of log entries and sets ClickedFactionName global
-----------------------------------------------------------------------------
function FactionAddict_LogEntry_OnClick(self)
	-- returns the log row that was clicked 1-17
	local clickedEntry = tonumber(strsub(self:GetName(),strlen("FactionAddictLogEntry")+1))
	local tablerow
	fa_DebugOut("Clicked log row: " .. tostring(clickedEntry))
	-- tempLoggingData
	tablerow = clickedEntry + FauxScrollFrame_GetOffset(FactionAddictLoggingScrollBar)
	if (tablerow <= tempLoggingData_rowcount) then
		local logText = tempLoggingData[tablerow][1]
		local s1, e1 = string.find(logText, "%[")
		local s2, e2 = string.find(logText, "%]")
		-- Make sure faction name is found in string
		if (e1 ~= nil and s2 ~= nil) then
			local factionText = string.sub(logText, e1+1, s2-1)
			fa_DebugOut("faction name: " .. factionText)

			-- check if the name has been truncated
			if (tempTruncNamesTable[factionText] ~= nil) then
				faClickedFactionName = tempTruncNamesTable[factionText]
			else
				faClickedFactionName = factionText
			end

			PlaySound(SOUNDKIT.IG_INVENTORY_ROTATE_CHARACTER)
			frameFactionAddictInfoFrame:Hide()
			frameFactionAddictInfoFrame:Show()
		end
	end
end


-----------------------------------------------------------------------------
-- Handles Update event on Logging tab.
-----------------------------------------------------------------------------
function FactionAddict_LoggingScrollBar_Update()
	local line -- 1 through 17 of our window to scroll
	local lineplusoffset -- an index into our data calculated from the scroll offset
	
	FauxScrollFrame_Update(FactionAddictLoggingScrollBar,tempLoggingData_rowcount,17,16)
	
	for line=1,17 do
		lineplusoffset = line + FauxScrollFrame_GetOffset(FactionAddictLoggingScrollBar)
		
		--fa_DebugOut("Updating Logging - line/lineplusoffset: " .. tostring(line) .. "/" .. tostring(lineplusoffset))
		
		if lineplusoffset <= tempLoggingData_rowcount then
			-- check if row is a header
			if (tempLoggingData[lineplusoffset][2] == 1) then
				getglobal("FactionAddictLogEntry"..line).LogEntryIcon:Hide()
				getglobal("FactionAddictLogEntry"..line).LogEntryHdr:Show()
				getglobal("FactionAddictLogEntry"..line).LogEntryTxt:Show()
				getglobal("FactionAddictLogEntry"..line).LogEntryTxt:SetText(tempLoggingData[lineplusoffset][1])
				getglobal("FactionAddictLogEntry"..line).LogEntryTxt:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b)
			-- check if row is message
			elseif (tempLoggingData[lineplusoffset][2] == 2) then
				getglobal("FactionAddictLogEntry"..line).LogEntryIcon:Show()
				getglobal("FactionAddictLogEntry"..line).LogEntryHdr:Hide()
				getglobal("FactionAddictLogEntry"..line).LogEntryTxt:Show()
				getglobal("FactionAddictLogEntry"..line).LogEntryTxt:SetText(tempLoggingData[lineplusoffset][1])
				getglobal("FactionAddictLogEntry"..line).LogEntryTxt:SetTextColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b)
			-- else row is info
			else
				getglobal("FactionAddictLogEntry"..line).LogEntryIcon:Hide()
				getglobal("FactionAddictLogEntry"..line).LogEntryHdr:Hide()
				getglobal("FactionAddictLogEntry"..line).LogEntryTxt:Show()
				getglobal("FactionAddictLogEntry"..line).LogEntryTxt:SetText("  - " .. tempLoggingData[lineplusoffset][1])
				getglobal("FactionAddictLogEntry"..line).LogEntryTxt:SetTextColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b)
			end
		-- else blank
		else
			getglobal("FactionAddictLogEntry"..line).LogEntryHdr:Hide()
			getglobal("FactionAddictLogEntry"..line).LogEntryIcon:Hide()
			getglobal("FactionAddictLogEntry"..line).LogEntryTxt:Hide()
		end
	end
end


-----------------------------------------------------------------------------
-- Handles click of config settings and sets appropriate CB variable.
-----------------------------------------------------------------------------
function FactionAddict_SetConfigVariables(self)
	
	local configName = self:GetName()
	
	PlaySound(SOUNDKIT.IG_INVENTORY_ROTATE_CHARACTER)

	if (configName == "CheckButton_CF") then
		faUpdateDisplayTable = true
		if (self:GetChecked() == true) then
			FactionAddictConfig.CB_CATEGORY_CF = true
		else
			FactionAddictConfig.CB_CATEGORY_CF = false
		end
	elseif (configName == "CheckButton_BC") then
		faUpdateDisplayTable = true
		if (self:GetChecked() == true) then
			FactionAddictConfig.CB_CATEGORY_BC = true
		else
			FactionAddictConfig.CB_CATEGORY_BC = false
		end
	elseif (configName == "CheckButton_WOTLK") then
		faUpdateDisplayTable = true
		if (self:GetChecked() == true) then
			FactionAddictConfig.CB_CATEGORY_WOTLK = true
		else
			FactionAddictConfig.CB_CATEGORY_WOTLK = false
		end
	elseif (configName == "CheckButton_CATA") then
		faUpdateDisplayTable = true
		if (self:GetChecked() == true) then
			FactionAddictConfig.CB_CATEGORY_CATA = true
		else
			FactionAddictConfig.CB_CATEGORY_CATA = false
		end
	elseif (configName == "CheckButton_MOP") then
		faUpdateDisplayTable = true
		if (self:GetChecked() == true) then
			FactionAddictConfig.CB_CATEGORY_MOP = true
		else
			FactionAddictConfig.CB_CATEGORY_MOP = false
		end
	elseif (configName == "CheckButton_WOD") then
		faUpdateDisplayTable = true
		if (self:GetChecked() == true) then
			FactionAddictConfig.CB_CATEGORY_WOD = true
		else
			FactionAddictConfig.CB_CATEGORY_WOD = false
		end
	elseif (configName == "CheckButton_LG") then
		faUpdateDisplayTable = true
		if (self:GetChecked() == true) then
			FactionAddictConfig.CB_CATEGORY_LG = true
		else
			FactionAddictConfig.CB_CATEGORY_LG = false
		end
	elseif (configName == "CheckButton_BFA") then
		faUpdateDisplayTable = true
		if (self:GetChecked() == true) then
			FactionAddictConfig.CB_CATEGORY_BFA = true
		else
			FactionAddictConfig.CB_CATEGORY_BFA = false
		end

	elseif (configName == "CheckButton_OrderPct") then
		self:SetChecked(true)
		CheckButton_OrderName:SetChecked(false)
		FactionAddictConfig.RB_ORDERBY = 1
	elseif (configName == "CheckButton_OrderName") then
		self:SetChecked(true)
		CheckButton_OrderPct:SetChecked(false)
		FactionAddictConfig.RB_ORDERBY = 2
	elseif (configName == "CheckButton_AO") then
		faUpdateDisplayTable = true
		if (self:GetChecked() == true) then
			FactionAddictConfig.CB_FILTER_SHOW_AO = true
		else
			FactionAddictConfig.CB_FILTER_SHOW_AO = false
		end
	elseif (configName == "CheckButton_HO") then
		faUpdateDisplayTable = true
		if (self:GetChecked() == true) then
			FactionAddictConfig.CB_FILTER_SHOW_HO = true
		else
			FactionAddictConfig.CB_FILTER_SHOW_HO = false
		end
	elseif (configName == "CheckButton_AUTOBAR") then
		if (self:GetChecked() == true) then
			FactionAddictConfig.CB_OPTION_AUTOBAR = true
		else
			FactionAddictConfig.CB_OPTION_AUTOBAR = false
		end
	elseif (configName == "CheckButton_HIDEINACTIVE") then
		faUpdateDisplayTable = true
		if (self:GetChecked() == true) then
			FactionAddictConfig.CB_OPTION_HIDEINACTIVE_V2 = true
		else
			FactionAddictConfig.CB_OPTION_HIDEINACTIVE_V2 = false
		end
	elseif (configName == "FactionInfo_CheckButton_MoveInactive") then
		-- update config setting -- update backdrop texture
		if (self:GetChecked() == true) then
			FactionAddictConfigIsInactive[tempAllFactionData[faClickedFactionName][1]] = true
			frameFactionAddictInfoFrame:SetBackdrop(InfoWindow_Backdrop_Inactive)
			frameFactionAddictInfoFrame:SetBackdropColor(InfoWindow_Inactive_RGBA[1], InfoWindow_Inactive_RGBA[2], InfoWindow_Inactive_RGBA[3], InfoWindow_Inactive_RGBA[4])
		else
			FactionAddictConfigIsInactive[tempAllFactionData[faClickedFactionName][1]] = false
			frameFactionAddictInfoFrame:SetBackdrop(InfoWindow_Backdrop_Default)
		end
		-- populate the display table - force repopulation since faction moved to inactive may be hidden
		faUpdateDisplayTable = true
		if (FactionAddictTab1:IsShown()) then
			fa_PopulateDisplayTable()
			fa_SortDisplayTable()
			FactionAddict_ScrollBar_Update()
		end
	end
end


-----------------------------------------------------------------------------
-- Handles OnClick event of a faction entry. Shows the InfoFrame for the faction.
-----------------------------------------------------------------------------
function FactionAddict_FactionEntrySB_OnClick(self)
	
	local clickedEntry = tonumber(strsub(self:GetParent():GetName(),-1))
	local faClickedRow
	
	fa_DebugOut ("FactionEntry - OnClick: " .. tostring(clickedEntry))
	
	faClickedRow = clickedEntry + FauxScrollFrame_GetOffset(FactionAddictScrollBar)
	
	faClickedFactionName =  tempDisplayData[faClickedRow][3]
	
	PlaySound(SOUNDKIT.IG_INVENTORY_ROTATE_CHARACTER)
	frameFactionAddictInfoFrame:Hide()
	frameFactionAddictInfoFrame:Show()

end
--*****************************************************************************
function FactionAddict_FactionEntry_OnClick(self)
	
	local clickedEntry = tonumber(strsub(self:GetName(),-1))
	local faClickedRow
	
	fa_DebugOut ("FactionEntry - OnClick: " .. tostring(clickedEntry))

	faClickedRow = clickedEntry + FauxScrollFrame_GetOffset(FactionAddictScrollBar)
	
	faClickedFactionName =  tempDisplayData[faClickedRow][3]
	
	PlaySound(SOUNDKIT.IG_INVENTORY_ROTATE_CHARACTER)
	frameFactionAddictInfoFrame:Hide()
	frameFactionAddictInfoFrame:Show()
	
end


-----------------------------------------------------------------------------
-- Handles OnClick event of the tabs along bottom of addon.
-----------------------------------------------------------------------------
function FactionAddict_Tab_OnClick(self)
	
	local tabNumber
	tabNumber = (self:GetID())
	
	PanelTemplates_SetTab(frameFactionAddict, tabNumber)
	
	-- DEBUG
	fa_DebugOut("FactionAddict_Tab_OnClick: " .. tostring(tabNumber))
	
	-- clear search
	if (faNameFilter ~= "") then
		faNameFilter = ""
		FactionAddictTab1.SearchBox:SetText("")
		faUpdateDisplayTable = true
	end
	-- set search widget back to default display
	FactionAddictTab1.SearchBox:Hide()
	FactionAddictTab1.SearchBox.clearButton:Hide()
	FactionAddictTab1.faDescText:Show()

	if ( tabNumber == 1 ) then
		-- Factions tab clicked
		FactionAddictTab1:Show()
		FactionAddictTab2:Hide()
		FactionAddictTab3:Hide()
		FactionAddictTab4:Hide()
		FactionAddictScrollBar:Show()
		FactionAddictLoggingScrollBar:Hide()
		fa_ShowFactions()
		fa_HideLogging()
		-- populate the display table
		fa_PopulateDisplayTable()
		-- order the display
		fa_SortDisplayTable()
		FactionAddict_ScrollBar_Update()
	elseif ( tabNumber == 2 ) then
		-- Log tab clicked
		FactionAddictTab1:Hide()
		FactionAddictTab2:Show()
		FactionAddictTab3:Hide()
		FactionAddictTab4:Hide()
		FactionAddictScrollBar:Hide()
		FactionAddictLoggingScrollBar:Show()
		fa_HideFactions()
		fa_ShowLogging()
	elseif ( tabNumber == 3 ) then
		-- Config tab clicked
		FactionAddictTab1:Hide()
		FactionAddictTab2:Hide()
		FactionAddictTab3:Show()
		FactionAddictTab4:Hide()
		FactionAddictScrollBar:Hide()
		FactionAddictLoggingScrollBar:Hide()
		fa_HideFactions()
		fa_HideLogging()
		-- set checkbox values
		CheckButton_CF:SetChecked(FactionAddictConfig.CB_CATEGORY_CF)
		CheckButton_BC:SetChecked(FactionAddictConfig.CB_CATEGORY_BC)
		CheckButton_WOTLK:SetChecked(FactionAddictConfig.CB_CATEGORY_WOTLK)
		CheckButton_CATA:SetChecked(FactionAddictConfig.CB_CATEGORY_CATA)
		CheckButton_MOP:SetChecked(FactionAddictConfig.CB_CATEGORY_MOP)
		CheckButton_WOD:SetChecked(FactionAddictConfig.CB_CATEGORY_WOD)
		CheckButton_LG:SetChecked(FactionAddictConfig.CB_CATEGORY_LG)
		CheckButton_BFA:SetChecked(FactionAddictConfig.CB_CATEGORY_BFA)
		CheckButton_AO:SetChecked(FactionAddictConfig.CB_FILTER_SHOW_AO)
		CheckButton_HO:SetChecked(FactionAddictConfig.CB_FILTER_SHOW_HO)
		CheckButton_AUTOBAR:SetChecked(FactionAddictConfig.CB_OPTION_AUTOBAR)
		CheckButton_HIDEINACTIVE:SetChecked(FactionAddictConfig.CB_OPTION_HIDEINACTIVE_V2)
		if (FactionAddictConfig.RB_ORDERBY == 1) then
			CheckButton_OrderPct:SetChecked(true)
			CheckButton_OrderName:SetChecked(false)
		else
			CheckButton_OrderPct:SetChecked(false)
			CheckButton_OrderName:SetChecked(true)
		end
	elseif ( tabNumber == 4 ) then
		-- About tab clicked
		FactionAddictTab1:Hide()
		FactionAddictTab2:Hide()
		FactionAddictTab3:Hide()
		FactionAddictTab4:Show()
		FactionAddictScrollBar:Hide()
		FactionAddictLoggingScrollBar:Hide()
		fa_HideFactions()
		fa_HideLogging()
	end
	PlaySound(SOUNDKIT.IG_CHARACTER_INFO_TAB)
end


-----------------------------------------------------------------------------
-- Handles OnEnter and OnLeave of the status bar element.
-----------------------------------------------------------------------------
function FactionAddict_StatusBar_OnEnter(self)
	--fa_DebugOut("StatusBar_OnEnter - ".. self:GetParent():GetName())
	self.text:Hide()
	self.text2:Show()
end
function FactionAddict_StatusBar_OnLeave(self)
	--fa_DebugOut("StatusBar_OnLeave - ".. self:GetParent():GetName())
	self.text:Show()
	self.text2:Hide()
end


-----------------------------------------------------------------------------
-- Handles OnClick event of the addon launcher button.
-----------------------------------------------------------------------------
function FactionAddictLauncher_OnClick(self)

	PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
	
	if frameFactionAddict:IsShown() then
		frameFactionAddict:Hide()
	else
		frameFactionAddict:Show()
	end
end


-----------------------------------------------------------------------------
-- Sets all the information to display in the Info window.
-----------------------------------------------------------------------------
local function fa_InfoWindow_LoadInfo(self)

	local color
	local totalHeight = 0
	-- tempAllFactionData has all data
	-- tempDisplayData has data shown in faction tabdisplay

	-- Set icon texture
	self.FactionIconInfoWin:SetTexture(tempAllFactionData[faClickedFactionName][2])
	totalHeight = totalHeight + self.FactionIconInfoWin:GetHeight()

	-- Set Faction Name
	self.FactionNameTxt:SetText(tempAllFactionData[faClickedFactionName][3])
	-- Set Status Bar values
	if (tempAllFactionData[faClickedFactionName][4] == 9) then
		color = FACTION_ADDICT_PARAGON_COLOR
	else
		color = FACTION_BAR_COLORS[tempAllFactionData[faClickedFactionName][4]]
	end
	self.StatusBar:SetStatusBarColor(color.r, color.g, color.b, 1)
	self.StatusBar:SetMinMaxValues(tempAllFactionData[faClickedFactionName][5], tempAllFactionData[faClickedFactionName][6])
	self.StatusBar:SetValue(tempAllFactionData[faClickedFactionName][7])
	-- Set Status Bar text
	self.StatusBar.text:SetText(fa_StandingText(tempAllFactionData[faClickedFactionName][1],tempAllFactionData[faClickedFactionName][4]))
	self.StatusBar.text:Show()
	self.StatusBar.text2:SetText(fa_SetStatusBarText_ByFactionName(faClickedFactionName))
	self.StatusBar.text2:Hide()
	-- Set EditBox text
	self.EditBox:SetText(L.FACTION_URL_TXT .. tostring(tempAllFactionData[faClickedFactionName][1]))
	totalHeight = totalHeight + self.EditBox:GetHeight()
	-- Set Percent text
	if (tempAllFactionData[faClickedFactionName][4] == 9) then
		self.PctTxt:SetText(LIGHTYELLOW_FONT_COLOR_CODE .. L.PCT_TO_REWARD_TXT .. FONT_COLOR_CODE_CLOSE .. tempAllFactionData[faClickedFactionName][8])
	else
		self.PctTxt:SetText(LIGHTYELLOW_FONT_COLOR_CODE .. L.PCT_TO_EXALTED_TXT .. FONT_COLOR_CODE_CLOSE .. tempAllFactionData[faClickedFactionName][8])
	end
	totalHeight = totalHeight + self.PctTxt:GetHeight()
	
	-- Set Category text
	self.CategoryTxt:SetText(LIGHTYELLOW_FONT_COLOR_CODE .. L.CATEGORY_TXT .. FONT_COLOR_CODE_CLOSE .. faFactionDataCategoryValues[tempAllFactionData[faClickedFactionName][12]])
	totalHeight = totalHeight + self.CategoryTxt:GetHeight()

	-- Set Move to Inactive text - 
	self.CBMoveInactive.fs:SetText(LIGHTYELLOW_FONT_COLOR_CODE .. MOVE_TO_INACTIVE .. FONT_COLOR_CODE_CLOSE)
	-- set the appropriate checkbox value
	self.CBMoveInactive:SetChecked( (FactionAddictConfigIsInactive[tempAllFactionData[faClickedFactionName][1]]) )
	totalHeight = totalHeight + self.CBMoveInactive:GetHeight()
	-- set the appropriate background
	if (FactionAddictConfigIsInactive[tempAllFactionData[faClickedFactionName][1]] == false) then
		self:SetBackdrop(InfoWindow_Backdrop_Default)
	else
		self:SetBackdrop(InfoWindow_Backdrop_Inactive)
		self:SetBackdropColor(InfoWindow_Inactive_RGBA[1], InfoWindow_Inactive_RGBA[2], InfoWindow_Inactive_RGBA[3], InfoWindow_Inactive_RGBA[4])
	end

	-- PARAGON REP - Display Reward Info
	if (tempAllFactionData[faClickedFactionName][4] == 9) then

		local itemName, itemTexture, quantity, quality, isUsable, itemID = GetQuestLogRewardInfo(1, tempAllParagonData[tempAllFactionData[faClickedFactionName][1]][3])
		-- show status bar bag
		self.StatusBar.FAParagonIcon:Show()
		self.StatusBar.FAParagonIcon.Glow:SetShown(tempAllParagonData[tempAllFactionData[faClickedFactionName][1]][4])
		self.StatusBar.FAParagonIcon.Check:SetShown(tempAllParagonData[tempAllFactionData[faClickedFactionName][1]][4])
		-- Reward Text
		self.RewardTxt:SetText(QUEST_REWARDS)
		self.RewardTxt:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b)
		totalHeight = totalHeight + self.RewardTxt:GetHeight()
		-- Reward Icon and Border
		self.RewardIcon:SetTexture(itemTexture)
		self.RewardIconBorder:SetVertexColor(BAG_ITEM_QUALITY_COLORS[quality].r, BAG_ITEM_QUALITY_COLORS[quality].g, BAG_ITEM_QUALITY_COLORS[quality].b)
		-- Reward Name
		self.RewardName:SetText(itemName)
		self.RewardName:SetTextColor(BAG_ITEM_QUALITY_COLORS[quality].r, BAG_ITEM_QUALITY_COLORS[quality].g, BAG_ITEM_QUALITY_COLORS[quality].b)
		-- Show Elements
		self.RewardTxt:Show()
		self.RewardIcon:Show()
		self.RewardIconBorder:Show()
		self.RewardName:Show()
		-- inc height
		totalHeight = totalHeight + self.RewardIcon:GetHeight()
	else
		-- Hide Elements
		self.StatusBar.FAParagonIcon:Hide()
		self.RewardTxt:Hide()
		self.RewardIcon:Hide()
		self.RewardIconBorder:Hide()
		self.RewardName:Hide()
	end
	-- END PARAGON REP

	-- Set Desc text 
	if (tempAllFactionData[faClickedFactionName][4] == 9) then
	   self.DescTxt:SetPoint("TOPLEFT",self.RewardIcon,"BOTTOMLEFT",0,-8)
	   totalHeight = totalHeight+10
	else
		self.DescTxt:SetPoint("TOPLEFT",self.CBMoveInactive,"BOTTOMLEFT",0,-2)
		totalHeight = totalHeight+0
	end
	self.DescTxt:SetText(tempAllFactionData[faClickedFactionName][9])
	totalHeight = totalHeight + self.DescTxt:GetHeight()

	-- set faction side icon
	if (tempAllFactionData[faClickedFactionName][11] == 2) then
		self.SideFactionIcon:SetTexture("Interface\\BattlefieldFrame\\Battleground-Horde.png")
		self.SideFactionIcon:Show()
		self.SideFactionIcon:SetDrawLayer("OVERLAY",7)
	elseif (tempAllFactionData[faClickedFactionName][11] == 1) then
		self.SideFactionIcon:SetTexture("Interface\\BattlefieldFrame\\Battleground-Alliance.png")
		self.SideFactionIcon:Show()
		self.SideFactionIcon:SetDrawLayer("OVERLAY",7)
	else
		self.SideFactionIcon:Hide()
	end
	-- set bonus icon
	if (tempAllFactionData[faClickedFactionName][13] == true) then
		self.StatusBar.FABonusIcon:Show()
	else
		self.StatusBar.FABonusIcon:Hide()
	end
	-- display/hide of LFG Bonus Star
	if (fa_IsFactionInReputationDisplay(tempAllFactionData[faClickedFactionName][1])) then 
		self.FALFGBonusRepButton.factionID = tempAllFactionData[faClickedFactionName][1]
		self.FALFGBonusRepButton:SetShown(tempAllFactionData[faClickedFactionName][14])
		self.FALFGBonusRepButton:SetChecked(lfgBonusFactionID == tempAllFactionData[faClickedFactionName][1])
		self.FALFGBonusRepButton:SetEnabled(lfgBonusFactionID ~= tempAllFactionData[faClickedFactionName][1])
		self.FALFGBonusRepButton.Glow:Show()
		self.FALFGBonusRepButton.Glow:SetAlpha(0.18)
		self.FALFGBonusRepButton.GlowAnim:Stop()
	else
		self.FALFGBonusRepButton:Disable()
		self.FALFGBonusRepButton:Hide()
	end

	-- Set size of frame based on contents
	self:SetSize(270, totalHeight+30)
	
end


-----------------------------------------------------------------------------
-- Updates displayed data on info window. Not used currently.
-----------------------------------------------------------------------------
local function fa_InfoWindow_Update()

	-- should only be called if window is visible -- after refreshing faction data
end


-----------------------------------------------------------------------------
-- Handles OnShow event of the Info Window.
-----------------------------------------------------------------------------
function FactionAddict_InfoWindow_OnShow(self)

	fa_DebugOut("FactionAddict_InfoWindow_OnShow: "..self:GetName())
	
	fa_InfoWindow_LoadInfo(self)
	FactionAddictLaunchWatchPanel:SetText(L.LAUNCH_WATCH_PANEL_TXT)
	
end


-----------------------------------------------------------------------------
-- Handles OnClick event that will show the Watch window.
-----------------------------------------------------------------------------
function FactionAddict_InfoWindow_Btn1_OnClick(self)
	PlaySound(SOUNDKIT.IG_MAINMENU_OPTION)
	frameFactionAddictWatchFrame:Show()
end


-----------------------------------------------------------------------------
-- Handles the main OnShow event for the addon.
-----------------------------------------------------------------------------
function FactionAddict_OnShow(self)

	PlaySound(SOUNDKIT.IG_CHARACTER_INFO_OPEN)
	fa_DebugOut("FactionAddict_OnShow: "..self:GetName())
	fa_DebugOut(faSessionDate)
	
	-- set search widget back to default display
	FactionAddictTab1.SearchBox:Hide()
	FactionAddictTab1.SearchBox.clearButton:Hide()
	FactionAddictTab1.faDescText:Show()

	-- populate the display table
	fa_PopulateDisplayTable()
	-- order the display
	fa_SortDisplayTable()
	-- display the data
	if (FactionAddictTab1:IsShown()) then
		FactionAddict_ScrollBar_Update()
	end
	-- update info window if displayed
	if (frameFactionAddictInfoFrame:IsVisible()) then
		fa_InfoWindow_LoadInfo(frameFactionAddictInfoFrame)
	end
end


-----------------------------------------------------------------------------
-- Handles the OnHide event for the addon. Clean up a few variables.
-----------------------------------------------------------------------------
function FactionAddict_OnHide(self)

	PlaySound(SOUNDKIT.IG_CHARACTER_INFO_CLOSE)
	fa_DebugOut("FactionAddict_OnHide: "..self:GetName())

	-- clear search params
	if (faNameFilter ~= "") then
		faNameFilter = ""
		FactionAddictTab1.SearchBox:SetText("")
		-- populate the display table - force repopulation
		faUpdateDisplayTable = true
	end
end


-----------------------------------------------------------------------------
-- The main event handler for the addon.
--
-- handled events:      ADDON_LOADED
--                      UPDATE_FACTION
--                      PLAYER_LOGIN
--                      LFG_BONUS_FACTION_ID_UPDATED
--                      CHAT_MSG_COMBAT_FACTION_CHANGE   
-----------------------------------------------------------------------------
function FactionAddict_OnEvent(self, event, ...)
	
	local arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11 = ...

	-- Things to do after addon is loaded
	if (event == "ADDON_LOADED") then
		if (arg1 == "FactionAddict") then
			fa_DebugOut("FactionAddict_OnEvent: ".. arg1 .. " " .. event)
			
			-- Check the version of stored logging info
			if (FactionAddictLogVersion == nil) then
				FactionAddictLogVersion = FACTION_ADDICT_LOGGING_VERSION
			end
			if (FactionAddictLogVersion < FACTION_ADDICT_LOGGING_VERSION) then
				-- update/clear logging info if necessary
				fa_UpdateLogVersion()
			end
			
			-- set defaults for show/hide configs
			fa_SetConfigShowHideDefaults()

			-- check for nil global config values - if not exist then default to on (1)
			if (FactionAddictConfig == nil) then
				FactionAddictConfig = FactionAddictConfigDefaults
			end
			-- check for nil on each config item - in case a new one is added
			if (FactionAddictConfig.CB_STANDING_EXALTED == nil) then
				FactionAddictConfig.CB_STANDING_EXALTED = FactionAddictConfigDefaults.CB_STANDING_EXALTED
			end
			if (FactionAddictConfig.CB_STANDING_PARAGON == nil) then
				FactionAddictConfig.CB_STANDING_PARAGON = FactionAddictConfigDefaults.CB_STANDING_PARAGON
			end
			if (FactionAddictConfig.CB_STANDING_REVERED == nil) then
				FactionAddictConfig.CB_STANDING_REVERED = FactionAddictConfigDefaults.CB_STANDING_REVERED
			end
			if (FactionAddictConfig.CB_STANDING_HONORED == nil) then
				FactionAddictConfig.CB_STANDING_HONORED = FactionAddictConfigDefaults.CB_STANDING_HONORED
			end
			if (FactionAddictConfig.CB_STANDING_FRIENDLY == nil) then
				FactionAddictConfig.CB_STANDING_FRIENDLY = FactionAddictConfigDefaults.CB_STANDING_FRIENDLY
			end
			if (FactionAddictConfig.CB_STANDING_NEUTRAL1 == nil) then
				FactionAddictConfig.CB_STANDING_NEUTRAL1 = FactionAddictConfigDefaults.CB_STANDING_NEUTRAL1
			end
			if (FactionAddictConfig.CB_STANDING_NEUTRAL0 == nil) then
				FactionAddictConfig.CB_STANDING_NEUTRAL0 = FactionAddictConfigDefaults.CB_STANDING_NEUTRAL0
			end
			if (FactionAddictConfig.CB_STANDING_UNFRIENDLY == nil) then
				FactionAddictConfig.CB_STANDING_UNFRIENDLY = FactionAddictConfigDefaults.CB_STANDING_UNFRIENDLY
			end
			if (FactionAddictConfig.CB_STANDING_HOSTILE == nil) then
				FactionAddictConfig.CB_STANDING_HOSTILE = FactionAddictConfigDefaults.CB_STANDING_HOSTILE
			end
			if (FactionAddictConfig.CB_STANDING_HATED == nil) then
				FactionAddictConfig.CB_STANDING_HATED = FactionAddictConfigDefaults.CB_STANDING_HATED
			end
			if (FactionAddictConfig.CB_CATEGORY_CF == nil) then
				FactionAddictConfig.CB_CATEGORY_CF = FactionAddictConfigDefaults.CB_CATEGORY_CF
			end
			if (FactionAddictConfig.CB_CATEGORY_BC == nil) then
				FactionAddictConfig.CB_CATEGORY_BC = FactionAddictConfigDefaults.CB_CATEGORY_BC
			end
			if (FactionAddictConfig.CB_CATEGORY_WOTLK == nil) then
				FactionAddictConfig.CB_CATEGORY_WOTLK = FactionAddictConfigDefaults.CB_CATEGORY_WOTLK
			end
			if (FactionAddictConfig.CB_CATEGORY_CATA == nil) then
				FactionAddictConfig.CB_CATEGORY_CATA = FactionAddictConfigDefaults.CB_CATEGORY_CATA
			end
			if (FactionAddictConfig.CB_CATEGORY_MOP == nil) then
				FactionAddictConfig.CB_CATEGORY_MOP = FactionAddictConfigDefaults.CB_CATEGORY_MOP
			end
			if (FactionAddictConfig.CB_CATEGORY_WOD == nil) then
				FactionAddictConfig.CB_CATEGORY_WOD = FactionAddictConfigDefaults.CB_CATEGORY_WOD
			end
			if (FactionAddictConfig.CB_CATEGORY_LG == nil) then
				FactionAddictConfig.CB_CATEGORY_LG = FactionAddictConfigDefaults.CB_CATEGORY_LG
			end
			if (FactionAddictConfig.CB_CATEGORY_BFA == nil) then
				FactionAddictConfig.CB_CATEGORY_BFA = FactionAddictConfigDefaults.CB_CATEGORY_BFA
			end
			if (FactionAddictConfig.RB_ORDERBY == nil) then
				FactionAddictConfig.RB_ORDERBY = FactionAddictConfigDefaults.RB_ORDERBY
			end
			if (FactionAddictConfig.CB_FILTER_SHOW_AO == nil) then
				FactionAddictConfig.CB_FILTER_SHOW_AO = FactionAddictConfigDefaults.CB_FILTER_SHOW_AO
			end
			if (FactionAddictConfig.CB_FILTER_SHOW_HO == nil) then
				FactionAddictConfig.CB_FILTER_SHOW_HO = FactionAddictConfigDefaults.CB_FILTER_SHOW_HO
			end
			if (FactionAddictConfig.CB_OPTION_AUTOBAR == nil) then
				FactionAddictConfig.CB_OPTION_AUTOBAR = FactionAddictConfigDefaults.CB_OPTION_AUTOBAR
			end
			if (FactionAddictConfig.CB_OPTION_HIDEINACTIVE_V2 == nil) then
				FactionAddictConfig.CB_OPTION_HIDEINACTIVE_V2 = FactionAddictConfigDefaults.CB_OPTION_HIDEINACTIVE_V2
			end

			-- cleanup old config vars
			fa_CleanConfigVars()
			
		end
	end
	
	if ( (event == "UPDATE_FACTION") ) then

		-- this is a bit of a workaround since value is not set when ADDON_LOADED is fired
		lfgBonusFactionID = GetLFGBonusFactionID()
		if (lfgBonusFactionID ~= nil) then
			fa_DebugOut("UPDATE_FACTION:lfgBonusFactionID: ".. lfgBonusFactionID)
		else
			fa_DebugOut("UPDATE_FACTION:lfgBonusFactionID: nil")
		end

		-- collapsing and expanding default UI also triggers this event
		fa_DebugOut("FactionAddict_OnEvent: " .. event)
		if (arg1 ~= nil) then fa_DebugOut("arg1: " .. arg1) end

		if (running) then 
			fa_DebugOut("IGNORE UPDATE_FACTION - Already Running!")
			return
		end

		-- check if main window is displayed
		if (frameFactionAddict:IsVisible()) then
			-- update data for factions
			doServerFactionQuery = 1
			fa_PopulateDisplayTable()
			-- order the display
			fa_SortDisplayTable()
			-- display the data
			if (FactionAddictTab1:IsShown()) then
				FactionAddict_ScrollBar_Update()
			end
			-- update info window if displayed
			if (frameFactionAddictInfoFrame:IsVisible()) then
				fa_InfoWindow_LoadInfo(frameFactionAddictInfoFrame)
			end
		else -- not visible - just update flag to reload data
			doServerFactionQuery = 1
		end

	end

	if (event == "PLAYER_LOGIN") then
		fa_DebugOut("FactionAddict_OnEvent: " .. event)
		-- update data for factions
		doServerFactionQuery = 1
		fa_PopulateDisplayTable()
		fa_DebugOut("Done with initial load.")

		-- Set inital base level for logging
		fa_UpdateParagonLogValue()

		-- check if main window is displayed
		if (frameFactionAddict:IsVisible()) then
			-- order the display
			fa_SortDisplayTable()
			-- display the data
			if (FactionAddictTab1:IsShown()) then
				FactionAddict_ScrollBar_Update()
			end
			-- update info window if displayed
			if (frameFactionAddictInfoFrame:IsVisible()) then
				fa_InfoWindow_LoadInfo(frameFactionAddictInfoFrame)
			end
		end
	end
	
	-- Handle Bonus Faction Update 
	if (event == "LFG_BONUS_FACTION_ID_UPDATED") then
		fa_DebugOut("FactionAddict_OnEvent: " .. event)
		lfgBonusFactionID = GetLFGBonusFactionID()
		-- display the data
		if (frameFactionAddict:IsVisible() and FactionAddictTab1:IsShown()) then
			FactionAddict_ScrollBar_Update()
		end
		-- update info window if displayed
		if (frameFactionAddictInfoFrame:IsVisible()) then
			fa_InfoWindow_LoadInfo(frameFactionAddictInfoFrame)
		end

	end

	if (event == "CHAT_MSG_COMBAT_FACTION_CHANGE") then
		fa_DebugOut("FactionAddict_OnEvent: " .. event)
		local factionDecrease = false
		
		-- Check standing message for faction increase or decrease
		local s1, e1, faction, amount = string.find(arg1, pattern_standing_inc)
		-- If increase not found check for decrease
		if (s1 == nil) then
			s1, e1, faction, amount = string.find(arg1, pattern_standing_dec)
			if (s1 ~= nil) then
				 factionDecrease = true
			end
		end
		-- check for generic gain
		if (s1 == nil) then
			s1, e1, faction = string.find(arg1, pattern_standing_inc_generic)
		end

		-- Seems to also be a case where this event will fire but not an UPDATE_FACTION
		-- which causes main tables to not get updated
		-- check if main window is displayed

		if (frameFactionAddict:IsVisible()) then
			-- update data for factions
			doServerFactionQuery = 1
			fa_PopulateDisplayTable()

			-- order the display
			fa_SortDisplayTable()
			-- display the data
			if (FactionAddictTab1:IsShown()) then
				FactionAddict_ScrollBar_Update()
			end
			-- update info window if displayed
			if (frameFactionAddictInfoFrame:IsVisible()) then
				fa_InfoWindow_LoadInfo(frameFactionAddictInfoFrame)
			end
		else -- not visible - just update flag to reload data
			doServerFactionQuery = 1
		end


		-- workaround to get the guildname updated in faction data
		if (faction == GUILD and (faPlayerGuildName == GUILD or faPlayerGuildName == '' or faPlayerGuildName == nil)) then
			fa_PopulateAllFactionDataTable()
		end
		
		-- Might be PARAGON if amount is nil
		if (amount == nil) then
			fa_DebugOut("parsed amount: nil !!! - Possibly Paragon ")
		end
		if (faction ~= nil) then
			fa_DebugOut("parsed name: " .. faction)
		else
			fa_DebugOut("parsed name: nil !!!")
		end
		
		if (s1 ~= nil and amount == nil) then
			-- see if there is a faction id
			if (tempFactionIDsByName[faction] ~= nil) then 
				fa_DebugOut("FactionIDByName: ".. tempFactionIDsByName[faction])
			   
				-- Check if faction is in Paragon Data Table 
				-- if not - then use api to check it - possibly became exalted after login
				if (tempAllParagonData[tempFactionIDsByName[faction]] == nil) then
					fa_DebugOut("FactionID not in ParagonData table for name: " .. faction)
					-- check factionid with api
					if (C_Reputation.IsFactionParagon(tempFactionIDsByName[faction])) then
						fa_DebugOut("IsFactionParagon - true - for: " .. faction)
						-- get paragon info
						local paraValue, paraThreshold, paraQuestId, paraRewardPending = C_Reputation.GetFactionParagonInfo(tempFactionIDsByName[faction])
						-- save paragon data
						tempAllParagonData[tempFactionIDsByName[faction]] = {}
						-- column 1 - current paragon value
						tempAllParagonData[ tempFactionIDsByName[faction] ][1] = paraValue
						-- column 2 - paragon threshold - max
						tempAllParagonData[ tempFactionIDsByName[faction] ][2] = paraThreshold
						-- column 3 - paragon quest id
						tempAllParagonData[ tempFactionIDsByName[faction] ][3] = paraQuestId
						-- column 4 - paragon reward pending flag
						tempAllParagonData[ tempFactionIDsByName[faction] ][4] = paraRewardPending
						-- column 5 - paragon logging value
						tempAllParagonData[ tempFactionIDsByName[faction] ][5] = paraValue
						-- set amount - assumes this is first gain since not in paragon table
						if (paraValue > 0) then
							amount = paraValue
							fa_DebugOut("Set amount: " .. amount)
						end
					else
						fa_DebugOut("IsFactionParagon - false - for: " .. faction)
					end
				-- faction exists in ParagonData
				else 
					-- check if logging value has been set
					if (tempAllParagonData[tempFactionIDsByName[faction]][5]  ~= nil) then
						local paraValue, _, _, _ = C_Reputation.GetFactionParagonInfo(tempFactionIDsByName[faction])
						fa_DebugOut("New paragon value: " .. paraValue)
						-- difference
						local diff = paraValue - tempAllParagonData[tempFactionIDsByName[faction]][5]
						fa_DebugOut("Diff paragon value: " .. diff)
						if (diff > 0) then
							amount = diff
							fa_DebugOut("Set calculated amount: " .. amount)
							tempAllParagonData[tempFactionIDsByName[faction]][5] = paraValue
						end
					else
						fa_DebugOut("Paragon logging value missing.")
					end
				end

			end -- end found factionid by name
		end

		-- Check that s1 is not nil before continuing
		if (s1 ~= nil and amount ~= nil) then
			local rep = tonumber(amount)
			if (factionDecrease) then
				rep = -rep
			end
			-- Override guild with actual guild name
			if (faction == GUILD) then
				faction = faPlayerGuildName
			end
			if (faction ~= nil) then
				fa_DebugOut ("Faction: " .. faction .. " Rep: " .. tostring(rep))
			end
			
			-- Truncate long faction names
			local tempTruncFactionName
			if (strlen(faction) > 25) then
				tempTruncFactionName = strsub(faction, 1, 23) .. "..."
			else
				tempTruncFactionName = faction
			end

			-- Check if factionID is nil - don't show as clickable text
			if (tempFactionIDsByName[faction] ~= nil) then 
				fa_DebugOut ("FactionID: " .. tostring(tempFactionIDsByName[faction]))
				if (rep > 0) then
					faLastRepGainStr = L.TAB2_LASTGAIN_TXT .. " - [" .. tempTruncFactionName .. "]: " .. GREEN_FONT_COLOR_CODE .. tostring(rep) .. FONT_COLOR_CODE_CLOSE
				else -- negative faction
					faLastRepGainStr = L.TAB2_LASTGAIN_TXT .. " - [" .. tempTruncFactionName .. "]: " .. RED_FONT_COLOR_CODE .. tostring(rep) .. FONT_COLOR_CODE_CLOSE
				end

				-- auto-change rep bar
				if (FactionAddictConfig.CB_OPTION_AUTOBAR == true
					and faction ~= faPlayerGuildName ) then
						fa_SetWatchedFactionByID(tempFactionIDsByName[faction])
				end
			else
				fa_DebugOut ("FactionID: faction not in table!")
				if (rep > 0) then
					faLastRepGainStr = L.TAB2_LASTGAIN_TXT .. " - " .. tempTruncFactionName .. ": " .. GREEN_FONT_COLOR_CODE .. tostring(rep) .. FONT_COLOR_CODE_CLOSE
				else -- negative faction
					faLastRepGainStr = L.TAB2_LASTGAIN_TXT .. " - " .. tempTruncFactionName .. ": " .. RED_FONT_COLOR_CODE .. tostring(rep) .. FONT_COLOR_CODE_CLOSE
				end
			end
			
			fa_AddToRepLog(faction, rep)
			-- add to session total
			faSessionRepGain = faSessionRepGain + rep
			FactionAddictTab2.faFactionsText2:SetText(L.TAB2_SESSIONTOTAL_TXT .. HIGHLIGHT_FONT_COLOR_CODE .. tostring(faSessionRepGain) .. FONT_COLOR_CODE_CLOSE)
		end
	end
	
end


-----------------------------------------------------------------------------
-- Handles OnClick event of dropdown menu.
-----------------------------------------------------------------------------
function FactionAddict_ConfigMenuButton_OnClick(self)
	PlaySound(SOUNDKIT.IG_INVENTORY_ROTATE_CHARACTER)
	ToggleDropDownMenu(1, nil, FactionAddict_ConfigMenu, self, 0, 0)
	fa_DebugOut("FactionAddict_ConfigMenuButton_OnClick")
end


-----------------------------------------------------------------------------
-- Handles OnClick of search toggle button. Shows or Hides search box.
-----------------------------------------------------------------------------
function FactionAddict_SearchToggle_OnClick(self)
	PlaySound(SOUNDKIT.IG_CHARACTER_INFO_TAB)

	-- show or hide - edit box / header text
	if FactionAddictTab1.SearchBox:IsShown() then
		-- clear search
		if (faNameFilter ~= "") then
			faNameFilter = ""
			FactionAddictTab1.SearchBox:SetText("")
			-- populate the display table - force repopulation
			faUpdateDisplayTable = true
			fa_PopulateDisplayTable()
			-- sort the display table
			fa_SortDisplayTable()
			-- initial display
			FactionAddict_ScrollBar_Update()
		end
		FactionAddictTab1.SearchBox:Hide()
		FactionAddictTab1.SearchBox.clearButton:Hide()
		FactionAddictTab1.faDescText:Show()
	else
		FactionAddictTab1.faDescText:Hide()
		FactionAddictTab1.SearchBox:Show()
		FactionAddictTab1.SearchBox:SetFocus()
	end

end


-----------------------------------------------------------------------------
-- Clears variables and resets elements related to search.
-----------------------------------------------------------------------------
function FactionAddict_SearchClear_OnClick(self) 

	-- clear search
	if (faNameFilter ~= "") then
		faNameFilter = ""
		FactionAddictTab1.SearchBox:SetText("")
		-- populate the display table - force repopulation
		faUpdateDisplayTable = true
		fa_PopulateDisplayTable()
		-- sort the display table
		fa_SortDisplayTable()
		-- initial display
		FactionAddict_ScrollBar_Update()
	end

	self:ClearFocus()
	self:SetFontObject("GameFontDisable")
	self.searchIcon:SetVertexColor(0.6, 0.6, 0.6)
	self.clearButton:Hide()
end


-----------------------------------------------------------------------------
-- Handles OnTextChanged event of search box.
--
-- @param userInput  	text in the search box.
-----------------------------------------------------------------------------
function FactionAddict_OnTextChanged(self, userInput)
	local text = self:GetText()


	fa_DebugOut("FactionAddict_OnTextChanged: " .. text .. ", userInput: " .. tostring(userInput))
	if (text ~= "") then
		self.label:Hide()
	else
		self.label:Show()
	end

	faNameFilter = text
	-- get rid of right and left brackets
	faNameFilter=string.gsub(faNameFilter, "%[", "")
	faNameFilter=string.gsub(faNameFilter, "%]", "")
	
	if (userInput == true) then
		-- force repopulation of display table
		faUpdateDisplayTable = true
		-- populate the display table
		fa_PopulateDisplayTable()
		-- sort the display table
		fa_SortDisplayTable()
		-- initial display
		FactionAddict_ScrollBar_Update()
	end
end


-----------------------------------------------------------------------------
-- Handles OnLoad event of the configmenu dropdown.
-----------------------------------------------------------------------------
function FactionAddict_ConfigMenu_OnLoad()
	local info =  {}
	local x
	info.isTitle = 1
	info.text = L.STANDING_FILTER_TITLE_TXT
	info.notCheckable = 1
	UIDropDownMenu_AddButton(info, 1)
	
	for x = 1,10 do
		info.text = ConfigMenuInfo[x].text
		info.disabled = nil
		info.isTitle = nil
		info.func = fa_SetDDConfigValue
		info.arg1 = ConfigMenuInfo[x].arg1
		info.notCheckable = nil
		info.checked = fa_GetDDConfigValue(ConfigMenuInfo[x].arg1)
		info.keepShownOnClick = 1
		info.isNotRadio = 1
		UIDropDownMenu_AddButton(info, 1)
	end
	
	-- Add the above information to the options menu as a button.
	fa_DebugOut("FactionAddict_ConfigMenu_OnLoad")
end


-----------------------------------------------------------------------------
-- Handles the main OnLoad event for the addon.
-----------------------------------------------------------------------------
function FactionAddict_OnLoad(self)

	fa_DebugOut("FactionAddict_OnLoad: "..self:GetName())

	-- Register the frame so it can be dragged
	self:RegisterForDrag("LeftButton")
	
	-- Register Events
	self:RegisterEvent("ADDON_LOADED")
	self:RegisterEvent("UPDATE_FACTION")
	self:RegisterEvent("LFG_BONUS_FACTION_ID_UPDATED")
	self:RegisterEvent("CHAT_MSG_COMBAT_FACTION_CHANGE")
	self:RegisterEvent("PLAYER_LOGIN")

	-- update portrait emblem
	SetPortraitToTexture(self.FactionAddictFramePortrait, "Interface\\ICONS\\achievement_reputation_01")
	
	-- Tab Handling code
	PanelTemplates_SetNumTabs(self, 4)
	PanelTemplates_SetTab(self, 1)

	-- show/hide panels
	FactionAddictTab1:Show()
	FactionAddictTab2:Hide()
	FactionAddictTab3:Hide()
	FactionAddictTab4:Hide()
	
	-- set addon text
	self.faTitleText:SetText(L.ADDON_TITLE)
	self.Tab1Label:SetText(L.TAB1_LABEL)
	self.Tab2Label:SetText(L.TAB2_LABEL)
	self.Tab3Label:SetText(L.TAB3_LABEL)
	self.Tab4Label:SetText(L.TAB4_LABEL)
	
	FactionAddictTab1.faDescText:SetText(L.TAB1_DESC_TXT)
	FactionAddictTab1.faErrorText1:Hide()
	FactionAddictTab2.faDescText:SetText(L.TAB2_DESC_TXT)
	FactionAddictTab2.hdr1:SetText(L.TAB2_LABEL)
	FactionAddictTab3.faDescText:SetText(L.TAB3_DESC_TXT)
	FactionAddictTab3.hdr1:SetText(L.TAB3_DISPLAY_CONFIG_TXT)
	FactionAddictTab3.hdr2:SetText(L.TAB3_DISPLAY_ORDER_TXT)
	FactionAddictTab3.hdr3:SetText(L.TAB3_DISPLAY_FILTER)
	FactionAddictTab3.hdr4:SetText(L.TAB3_DISPLAY_OPTIONS)
	CheckButton_CF.fs:SetText(L.TAB3_CONFIG_CF)
	CheckButton_BC.fs:SetText(L.TAB3_CONFIG_BC)
	CheckButton_WOTLK.fs:SetText(L.TAB3_CONFIG_WOTLK)
	CheckButton_CATA.fs:SetText(L.TAB3_CONFIG_CATA)
	CheckButton_MOP.fs:SetText(L.TAB3_CONFIG_MOP)
	CheckButton_WOD.fs:SetText(L.TAB3_CONFIG_WOD)
	CheckButton_LG.fs:SetText(L.TAB3_CONFIG_LG)
	CheckButton_BFA.fs:SetText(L.TAB3_CONFIG_BFA)
	CheckButton_OrderPct.fs:SetText(L.TAB3_CONFIG_ORDER_PCT)
	CheckButton_OrderName.fs:SetText(L.TAB3_CONFIG_ORDER_NAME)
	CheckButton_AO.fs:SetText(L.TAB3_CONFIG_ALLIANCE_ONLY)
	CheckButton_HO.fs:SetText(L.TAB3_CONFIG_HORDE_ONLY)
	CheckButton_AUTOBAR.fs:SetText(L.TAB3_CONFIG_AUTOBAR)
	CheckButton_HIDEINACTIVE.fs:SetText(L.TAB3_CONFIG_HIDEINACTIVE)
	FactionAddictTab4.faDescText:SetText(L.TAB4_DESC_TXT)
	FactionAddictTab4.faVersionText:SetText(L.VERSION_TXT..FACTION_ADDICT_VERSION)
	FactionAddictTab4.hdr1:SetText(L.TAB4_LABEL)
	FactionAddictAboutInfo:SetText(L.ABOUT_TXT)
	
	PanelTemplates_SetTab(frameFactionAddict, 1)
	
	-- init vars
	doServerFactionQuery = 1
	faUpdateDisplayTable = true

	faLastRepGainStr = L.TAB2_LASTGAIN_TXT .. " - " .. L.TAB2_NOGAIN_TXT
	faSessionRepGain = 0

	-- set date to use for this session
	local weekday = date("%A")
	local sessiondate = date("*t")
	-- (thanks MrUrkaz!) 
	-- 'D' weekday needs to be matched last since the matches with d/m/y may match a value in that day string. 
	-- for example Sunday has characters that also match 'd' and 'y' gsubs if done prior to them.
	faSessionDate = L.DATE_FORMAT:gsub("d", sessiondate["day"]):gsub("m", sessiondate["month"]):gsub("y", sessiondate["year"]):gsub("D", L[weekday])

	FactionAddictTab2.faFactionsText2:SetText(L.TAB2_SESSIONTOTAL_TXT .. HIGHLIGHT_FONT_COLOR_CODE .. tostring(faSessionRepGain) .. FONT_COLOR_CODE_CLOSE)

	-- make closable with escape
	tinsert(UISpecialFrames,self:GetName())

	faNameFilter = ""
	FactionAddictTab1.SearchBox.label:SetText(SEARCH)
end