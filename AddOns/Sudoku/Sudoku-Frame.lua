
local buildingFrame 
local puzzleFrame 
local valueFrame 
local menuFrame 
local activeCellX = 0
local activeCellY = 0
local hideTimer
local startTime
local isLegit
local inCombat
local gameHidden = false

local _, L = ...;



local cellMouseDown = function (self)
	if self.locked then
		return
	end
	
	if hideTimer then
		Sudoku:CancelTimer(hideTimer,true)
	end
	if Sudoku:GetValueFrame():IsShown() and activeCellX == self.x and activeCellY == self.y then
		Sudoku:GetValueFrame():Hide()
		return 
	end
	Sudoku:GetValueFrame():Show()
	activeCellX = self.x
	activeCellY = self.y
	Sudoku:GetValueFrame():ClearAllPoints()
	Sudoku:GetValueFrame():SetPoint("TOP",self,"BOTTOM")
	Sudoku:GetValueFrame():Show()
	
	hideTimer = Sudoku:ScheduleTimer("HideValueFrame", 3)
end


local titleDragDown = function(self)
	self:GetParent():StartMoving();
end
function Sudoku:ShowPuzzleFrame()
	self:GetPuzzleFrame():Show()
end


function Sudoku:GetBuildingFrame()
	if not buildingFrame then
		buildingFrame = CreateFrame('Frame', nil, UIParent, 'Sudoku-ProgressFrame')
		self:SetFrameLocation("buildingFrame",buildingFrame)
		
		local titleDragFrame = CreateFrame('Frame', nil, buildingFrame)
		titleDragFrame:SetSize(160,32)
		titleDragFrame:SetPoint("TOP",buildingFrame,"TOP",0,20)
		titleDragFrame:SetScript("OnMouseDown",titleDragDown)
		titleDragFrame:SetScript("OnMouseUp",function(self)
			self:GetParent():StopMovingOrSizing();
			Sudoku:SaveFrameLocation("buildingFrame",self:GetParent())
		end)
		buildingFrame:Hide()
	end
	return buildingFrame
end


function Sudoku:GetMenuFrame()
	if not menuFrame then
		menuFrame = CreateFrame('Frame', nil, UIParent, 'Sudoku-MenuFrame')
		self:SetFrameLocation("menuFrame",menuFrame)

		local kids = { menuFrame:GetRegions() };

		for _, child in ipairs(kids) do
			if child:GetName()=="UIParentMenuMessage" then
				menuFrame.message = child
			end
		end
		local titleDragFrame = CreateFrame('Frame', nil, menuFrame)
		titleDragFrame:SetSize(160,32)
		titleDragFrame:SetPoint("TOP",menuFrame,"TOP",0,20)
		titleDragFrame:SetScript("OnMouseDown",titleDragDown)
		titleDragFrame:SetScript("OnMouseUp",function(self)
			self:GetParent():StopMovingOrSizing();
			Sudoku:SaveFrameLocation("menuFrame",self:GetParent())
		end)
		menuFrame:Hide()
	end
	return menuFrame
end


function Sudoku:GetPuzzleFrame()
	if not puzzleFrame then
		puzzleFrame = CreateFrame('Frame', nil, UIParent, 'Sudoku-PuzzleFrame')
		self:SetFrameLocation("puzzleFrame",puzzleFrame)
		puzzleFrame.cells = {}
		for i = 0, 8 do
			puzzleFrame.cells[i] = {}
		end
		local kids = {self:GetPuzzleFrame():GetChildren()};
		for _, child in ipairs(kids) do
			local cName = child:GetName()
			if cName and strsub(cName,-4,-4) == "x" and strsub(cName,-2,-2) == "y" then
				child.x = tonumber(strsub(cName,-3,-3))
				child.y = tonumber(strsub(cName,-1,-1))
				child:SetText("1")
				puzzleFrame.cells[child.x][child.y] = child
				child:SetScript("OnMouseDown",cellMouseDown)
			end
		end
		local titleDragFrame = CreateFrame('Frame', nil, puzzleFrame)
		titleDragFrame:SetSize(160,32)
		titleDragFrame:SetPoint("TOP",puzzleFrame,"TOP",0,20)
		titleDragFrame:SetScript("OnMouseDown",titleDragDown)
		titleDragFrame:SetScript("OnMouseUp",function(self)
			self:GetParent():StopMovingOrSizing();
			Sudoku:SaveFrameLocation("puzzleFrame",self:GetParent())
		end)
		puzzleFrame:Hide()
	end
	return puzzleFrame
end

function Sudoku:GetValueFrame()
	if not valueFrame then
		valueFrame = CreateFrame('Frame', nil, self:GetPuzzleFrame(),'Sudoku-ValueFrame')
		valueFrame:Hide()
	end
	return valueFrame
end

function Sudoku:SetActiveLeft()
	local tX = activeCellX
	local tY = activeCellY
	tY = tY - 1
	if tY <0 then
		tY = 8
		tX = tX - 1
		if tX <0 then
			tX = 8
		end
	end
	self:GetPuzzleFrame().cells[tX][tY]:Click()
end

function Sudoku:SetActiveRight()
	local tX = activeCellX
	local tY = activeCellY
	tY = tY + 1
	if tY >8 then
		tY = 0
		tX = tX + 1
		if tX >8 then
			tX = 0
		end
	end
	self:GetPuzzleFrame().cells[tX][tY]:Click()
end

function Sudoku:SetActiveUp()
	local tX = activeCellX
	local tY = activeCellY
	tX = tX - 1
	if tX <0 then
		tX = 8
		tY = tY - 1
		if tY <0 then
			tY = 8
		end
	end
	self:GetPuzzleFrame().cells[tX][tY]:Click()
end

function Sudoku:SetActiveDown()
	local tX = activeCellX
	local tY = activeCellY
	tX = tX + 1
	if tX >8 then
		tX = 0
		tY = tY + 1
		if tY >8 then
			tY = 0
		end
	end
	self:GetPuzzleFrame().cells[tX][tY]:Click()
end

function Sudoku:CreatePuzzle()
	self:GetPuzzleFrame():Hide()
	self:GetBuildingFrame():Show()
	self:Make("CreatePuzzleEnd")
end

function Sudoku:CreatePuzzleEnd()
	self:GetBuildingFrame():Hide()
	self:GetPuzzleFrame():Show()
	isLegit = true
	startTime = time()
	for x = 0, 8 do
		for y = 0, 8 do
			if self.puzzleBoard[x][y] > 0 then
				self:GetPuzzleFrame().cells[x][y].locked = true
			else
				self:GetPuzzleFrame().cells[x][y].locked = false
			end
		end
	end
end

function Sudoku:Cheat()
	isLegit = false
	local done = false
	local x,y
	repeat
		x = math.random(0,8)
		y = math.random(0,8)
		if self.puzzleBoard[x][y] == 0 then
			done = true
			self.puzzleBoard[x][y] = self.completeBoard[x][y]
		end
	until done or self:CountBlanks(self.puzzleBoard) == 0
end

function Sudoku:Save()
	self:SetSavedGame(self.puzzleBoard,self.completeBoard,time()-startTime)
	self:GetPuzzleFrame():Hide()
end

function Sudoku:Reset()
	for x = 0, 8 do
		for y = 0, 8 do
			if self:GetPuzzleFrame().cells[x][y].locked then
				self.puzzleBoard[x][y] = self.completeBoard[x][y]
			else
				self.puzzleBoard[x][y] = 0
			end
		end
	end
end

function Sudoku:UpdateCells()
	if self:GetPuzzleFrame() and self.puzzleBoard then
		local duration = time()-startTime
		if self:IsFinished() then
			self:GetPuzzleFrame():Hide()
			self:LogGame(true,duration,isLegit)
			self:GetMenuFrame().message:SetText(GetL()["WinMenuMessage"] .. " " .. self:GetShortTimeString(duration))
			self:GetMenuFrame():Show()
		else
			self:GetPuzzleFrame().clock:SetText(self:GetShortTimeString(duration))
			for x = 0, 8 do
				for y = 0, 8 do
					local val = self.puzzleBoard[x][y]
					if val == 0 then
						self:GetPuzzleFrame().cells[x][y]:SetText("")
					else
						self:GetPuzzleFrame().cells[x][y]:SetText(val)
					end
				end
			end
			self:GetPuzzleFrame():SetScale(self:GetPuzzleFrameScale())
		end
	end
end

function Sudoku:IsFinished()
	for x = 0, 8 do
		for y = 0, 8 do
			if self.puzzleBoard[x][y] ~= self.completeBoard[x][y] then
				return false
			end
		end
	end
	return true
end

function Sudoku:IsCorrect()
	for x = 0, 8 do
		for y = 0, 8 do
			local pVal = self.puzzleBoard[x][y]
			local cVal = self.completeBoard[x][y]
			if pVal ~= cVal and pVal ~= 0 then
				return false
			end
		end
	end
	return true
end

function Sudoku:DoQuitPuzzle()
	self:GetPuzzleFrame():Hide()
	self:GetMenuFrame().message:SetText(GetL()["LossMenuMessage"])
	self:LogGame(false,time()-startTime,isLegit)
	self:GetMenuFrame():Show()
end


function Sudoku:SetActiveCellValue(val)
	if self.puzzleBoard and activeCellX and activeCellY then
		self.puzzleBoard[activeCellX][activeCellY] = val
	end
end

function Sudoku:HideValueFrame()
	valueFrame:Hide()
end

function Sudoku:SetStartTime(time)
	startTime = time
end

local events = {}
function events:PLAYER_REGEN_ENABLED() 
	if gameHidden == true then
		gameHidden = false
		Sudoku:SlashCommand("")
	end
end

function events:PLAYER_REGEN_DISABLED() 
	if Sudoku:GetPuzzleFrame():IsVisible() and Sudoku:GetHideInCombat() == true then
		gameHidden = true
		Sudoku:Save()
	end
end

local function EventFunc(self, event, ...)
	events[event](event, ...)
end
local eventHandler = CreateFrame("Frame", nil, WorldFrame)
eventHandler:SetScript("OnEvent", EventFunc)
for eventname in pairs(events) do eventHandler:RegisterEvent(eventname) end	
