
local blankCells = 54
local randOrder 
local iVals, ix, iy
local reducers
local reducerDepth

function Sudoku:GetMakeProgress()
	if randOrder then
		return format('%d%%', self:CountBlanks(self.puzzleBoard) * 100 / (blankCells+1))
	end
	return "0%"
end

function Sudoku:NextBruteCell()
	self:IncrementStepCount()
	if #(randOrder) == 0 then
		randOrder, ix, iy, iVals = nil
		Sudoku[self.makeFinishCall](Sudoku)
		return
	elseif not ix then
		ix = floor(randOrder[1] / 9)
		iy = randOrder[1] % 9
		iVals =  {1,2,3,4,5,6,7,8,9}
		tremove(iVals,self.puzzleBoard[ix][iy])
	end
	
	if self:CountBlanks(self.puzzleBoard) >= blankCells then
		randOrder, ix, iy, iVals = nil
		Sudoku[self.makeFinishCall](Sudoku)
	else
		local tempBoard = {}
		for l=0,8 do
			tempBoard[l] = {}
			for j=0,8 do
				tempBoard[l][j] = self.puzzleBoard[l][j]
			end
		end
		self.puzzleBoard[ix][iy] = 0
		tempBoard[ix][iy] = iVals[1]
		tremove(iVals,1)
		self:GetSolution(tempBoard,"NextBruteCellEnd")
	end
	
end

function Sudoku:NextBruteCellEnd()
	if self.solutionBoard then
		self.puzzleBoard[ix][iy] = self.completeBoard[ix][iy]
		tremove(randOrder,1)
		ix, iy, iVals = nil
	elseif #(iVals) == 0 then
		tremove(randOrder,1)
		ix, iy, iVals = nil
	end
	self:StepCall(self,"NextBruteCell")
end


function Sudoku:NextSmartCell()
	self:IncrementStepCount()
	if #(randOrder) == 0 or self:CountBlanks(self.puzzleBoard) >= blankCells then
		randOrder, ix, iy, iVals = nil
		Sudoku[self.makeFinishCall](Sudoku)
		return
	end
	
	ix = floor(randOrder[1] / 9)
	iy = randOrder[1] % 9
	
	self.puzzleBoard[ix][iy] = 0
	local tempBoard = {}
	for l = 0, 8 do
		tempBoard[l] = {}
		for j=0,8 do
			tempBoard[l][j] = self.puzzleBoard[l][j]
		end
	end
	self:GetSolution(tempBoard,"NextSmartCellEnd",reducers,reducerDepth)
end

function Sudoku:NextSmartCellEnd()
	tremove(randOrder,1)
	if self.solutionBoard == nil then
		self.puzzleBoard[ix][iy] = self.completeBoard[ix][iy]
	end
	self:StepCall(self,"NextSmartCell")
end

function Sudoku:Make(returnCall)
	randOrder = nil
	if returnCall then
		self.makeFinishCall = returnCall
	else
		self.makeFinishCall = "MakeFinished"
	end
	
	local mode = self:GetDifficultyMode()

	if mode == 1 then
		reducers = {SimpleValueSetReducer}
		reducerDepth = 0
		blankCells = 47
	elseif mode == 2 then
		reducers = {SimpleValueSetReducer,SubSetReducer}
		reducerDepth = 1
		blankCells = 52
	elseif mode == 3 then
		reducers = {SubSetReducer,ValueSubSetReducer}
		reducerDepth = 100
		blankCells = 55
	else
		reducers = nil
		blankCells = 66
	end
	
	self.puzzleBoard = {}
	self.completeBoard = {}

	for i=0,8 do
		self.puzzleBoard[i] = {}
		for j=0,8 do
			self.puzzleBoard[i][j] = 0
		end
	end
	self:GetSolution(self.puzzleBoard, "MakeEnd")
end

function Sudoku:MakeEnd()
	if self.solutionBoard then
		-- We have a solution to build our puzzle from.
		self.puzzleBoard = {}
		self.completeBoard = {}
		for i=0,8 do
			self.completeBoard[i] = {}
			self.puzzleBoard[i] = {}
			for j=0,8 do
				self.completeBoard[i][j] = self.solutionBoard[i][j]
				self.puzzleBoard[i][j] = self.solutionBoard[i][j]
			end
		end
		randOrder = GetRandomOrder(0,80)
		ix, iy, iVals = nil
		if self:GetDifficultyMode() == 4 then
			self:ScheduleTimer("NextBruteCell", self.stepDelay)
		else
			self:ScheduleTimer("NextSmartCell", self.stepDelay)
		end
	else
		-- wtf? we couldn't solve a blank board?
		print("Error creating sudoku board.")
	end
end

function Sudoku:MakeFinished()
	PrintBoard(self.completeBoard)
	PrintBoard(self.puzzleBoard)
end