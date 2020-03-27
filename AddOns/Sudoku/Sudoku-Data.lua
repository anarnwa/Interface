
local Sudoku = LibStub('AceAddon-3.0'):NewAddon('Sudoku', 'AceTimer-3.0', 'AceEvent-3.0', 'AceConsole-3.0')
_G.Sudoku = Sudoku

local defaults = {
	global = {
		gameLog = {},
		stepsPerFrame = 150,
		hideInCombat = true,
		announceNewRecords = true,
		puzzleBoard = nil,
		completeBoard = nil,
		savedTime = 0,
		mode = 2,
		puzzleFrameScale = 1.5,
		minimap = {hide = false},
	}
}
local db

local function GetDB()
	if not db then
		db = LibStub('AceDB-3.0'):New('SudokuDB', defaults, 'Default')
	end
	return db["global"]
end

function Sudoku:GetMiniMapSettings()
	return GetDB()["minimap"]
end

function Sudoku:SaveFrameLocation(frameName,frame)
	local p1, _, p2, x, y = frame:GetPoint()
	GetDB()[frameName] = {}
	GetDB()[frameName]["p1"] = p1
	GetDB()[frameName]["p2"] = p2
	GetDB()[frameName]["x"] = x
	GetDB()[frameName]["y"] = y
end

function Sudoku:SetFrameLocation(frameName,frame)
	local p1, p2, x, y = "Center", "Center",0,0
	if GetDB()[frameName] then
		p1 = GetDB()[frameName]["p1"]
		p2 = GetDB()[frameName]["p2"]
		x = GetDB()[frameName]["x"]
		y = GetDB()[frameName]["y"]
	end
	frame:SetPoint(p1,frame:GetParent(),p2,x,y)
end

function Sudoku:GetTimeString(duration)
	local timeString = ""
	if duration < 60 then
		return format(GetL()["TimeSeconds"],duration)
	elseif duration < 3600 then
		return format(GetL()["TimeMinutesSeconds"],1/60 * duration, duration % 60)
	elseif duration < 86400 then
		return format(GetL()["TimeHoursMinutes"], 1/3600 * duration, 1/60 * (duration % 3600))
	else
		return format(GetL()["TimeDaysHours"],1/86400 * duration, 1/3600 * (duration % 86400))
	end
end

function Sudoku:GetShortTimeString(duration)
	local timeString = ""
	if duration < 60 then
		return format(GetL()["ShortTimeSeconds"],duration)
	elseif duration < 3600 then
		return format(GetL()["ShortTimeMinutesSeconds"],1/60 * duration, duration % 60)
	elseif duration < 86400 then
		return format(GetL()["ShortTimeHoursMinutes"], 1/3600 * duration, 1/60 * (duration % 3600))
	else
		return format(GetL()["ShortTimeDaysHours"],1/86400 * duration, 1/3600 * (duration % 86400))
	end
end

function Sudoku:LogGame(isWin, duration, isLegit)
	tinsert(GetDB()["gameLog"], {isWin,duration,isLegit,0,self:GetDifficultyMode()})
	if isWin == true and isLegit == true and self:GetAnnounceNewRecords() == true then
		local best = self:GetBestGame(self:GetDifficultyMode())
		if best[2] == duration then
			local timeString = format(GetL()["WinShoutMessage"],UnitName("player"),self:ModeString(self:GetDifficultyMode()),self:GetTimeString(duration))
			if UnitName("player") == "Strucker" then
				SendChatMessage(timeString, "WHISPER", nil, UnitName("player"))
			else
				SendChatMessage(timeString, "GUILD", nil, nil)
			end
		end
	end
end

function Sudoku:GetGameLog()
	return GetDB()["gameLog"]
end

function Sudoku:ClearGameLog()
	GetDB()["gameLog"] = {}
	print(GetL()["HistoryCleared"])
end

function Sudoku:GetBestGame(mode)
	if #(GetDB()["gameLog"]) == 0 then
		return nil
	end
	local best = {true,9999999,true,46,mode}
	for i,game in ipairs(GetDB()["gameLog"]) do
		if game[5] == mode and game[1] == true and game[3] == true and game[2] < best[2] then
			best = game
		end
	end
	return best
end

function Sudoku:PrintGameLog()
	local text = ""
	if #(GetDB()["gameLog"]) == 0 then
		print(GetL()["EmptyHistory"])
	end
	for i,game in ipairs(GetDB()["gameLog"]) do 
		print(self:GameLogEntryToString(i,game))
	end
end

function Sudoku:ModeString(mode)
	if mode==1 then
		return GetL()["Easy"]
	elseif mode==2 then
		return GetL()["Normal"]
	elseif mode==3 then
		return GetL()["Hard"]
	else
		return GetL()["MakeMeCry"]
	end
end

function Sudoku:GameLogEntryToString(index,game)

	if game[1] == false then
		text = self:ModeString(game[5]) .. " - " .. GetL()["Loss"]
	else
		text = self:ModeString(game[5]) .. " - " .. GetL()["Win"] .. " " .. self:GetTimeString(game[2])
	end
	
	if game[3] ~= true then
		text = text .. " *" .. GetL()["Cheated"] .. "*"
	end
	
	if index ~= nil then
		text = index .. ": " .. text
	end
	return text
end

function Sudoku:GetOptionValue(info)
	return GetDB()[info.arg]
end

function Sudoku:SetOptionValue(info, value)
	GetDB()[info.arg] = value
end

function Sudoku:GetStepsPerFrame()
	return GetDB()["stepsPerFrame"]
end

function Sudoku:GetDifficultyMode()
	return GetDB()["mode"]
end

function Sudoku:GetHideInCombat()
	return GetDB()["hideInCombat"]
end

function Sudoku:GetAnnounceNewRecords()
	return GetDB()["announceNewRecords"]
end

function Sudoku:GetPuzzleFrameScale()
	return GetDB()["puzzleFrameScale"]
end

function Sudoku:HasSavedGame()
	return (GetDB()["puzzleBoard"] ~= nil and GetDB()["completeBoard"] ~= nil)
end

function Sudoku:SetSavedGame(puzzleBoard,completeBoard,time)
	GetDB()["puzzleBoard"] = puzzleBoard
	GetDB()["completeBoard"] = completeBoard
	GetDB()["savedTime"] = time
end

function Sudoku:GetSavedGame()
	return GetDB()["puzzleBoard"],GetDB()["completeBoard"],GetDB()["savedTime"]
end

