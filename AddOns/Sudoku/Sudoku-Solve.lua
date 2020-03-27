
local step = 0
local stepGroupSize = 40
local rtnFunc
local reducers = {}
local reducerDepth
function Sudoku:GetSolution(board, returnFunc, setReducers, maxReducerDepth)
	stepGroupSize= self:GetStepsPerFrame()
	rtnFunc = returnFunc
	self.solutionBoard = board
	self.solutionStack = {{}}
	reducers = setReducers
	reducerDepth = maxReducerDepth
	if self:IsValid() then
		if reducers and #reducers ~= 0 then
			self:StepCall(self,"NextSmartSolutionStep")
		else
			self:StepCall(self,"NextBruteSolutionStep")
		end
	else
		self.solutionBoard = nil
		self:StepCall(self,rtnFunc)
	end
end

function Sudoku:NextBruteSolutionStep()
	if #(self.solutionStack) == 0 then
		-- There is no solution
		self.solutionBoard = nil
		self:StepCall(self,rtnFunc)
		return
	end
	
	local stepStack = self.solutionStack[#(self.solutionStack)]
	if not stepStack["x"] then
		stepStack["x"], stepStack["y"], stepStack["valueSet"] = self:GetLeastSetCell()
	end
		
	if #(stepStack["valueSet"])  == 0 then
		-- This step was a failure, lets go back.
		self.solutionBoard[stepStack["x"]][stepStack["y"]] = 0
		tremove(self.solutionStack)
		self:StepCall(self,"NextBruteSolutionStep")
	elseif stepStack["x"] < 9 then
		-- Try the first value available
		self.solutionBoard[stepStack["x"]][stepStack["y"]] = stepStack["valueSet"][1]
		tremove(stepStack["valueSet"],1)
		
		if self:IsValid() then
			-- Yay its working, next cell.
			tinsert(self.solutionStack,{})
		else 
			-- That value failed, next up!
			self.solutionBoard[stepStack["x"]][stepStack["y"]] = 0
		end
		
		self:StepCall(self,"NextBruteSolutionStep")
	else
		self:StepCall(self,rtnFunc)
	end
end

function Sudoku:NextSmartSolutionStep()
	local progress = true
	local boardSets,_ = SimpleCellSetReducer(self.solutionBoard,BuildBoardSets())
	local localProgress
	local loopCount = 0
	local _,_, least = self:GetLeastSetCell()

	while not HasSolvableCells(self.solutionBoard,boardSets) do
		if not progress or loopCount == reducerDepth then
			self.solutionBoard = nil
			self:StepCall(self,rtnFunc)
			return
		end
		loopCount = loopCount +1
		progress = false
		for r = 1,#(reducers) do
			boardSets, localProgress = reducers[r](self.solutionBoard,boardSets)
			if boardSets == nil then
				--print(loopCount,"Invalid Board! Reducer",r)
				self.solutionBoard = nil
				self:StepCall(self,rtnFunc)
				return 
			elseif localProgress == true then
				progress = true
			end
		end	
		step = step + 1
	end
	
	local finished = true
	for x = 0,8 do
		for y = 0,8 do
			if self.solutionBoard[x][y] == 0 and GetSetSize(boardSets[x][y]) == 1 then
				for v = 1,9 do
					if boardSets[x][y][v] == true then
						self.solutionBoard[x][y] = v
					end
				end
			elseif self.solutionBoard[x][y] == 0 then
				finished = false
			end
		end
	end
	if finished == true then
		self:StepCall(self,rtnFunc)
	else
		self:StepCall(self,"NextSmartSolutionStep")
	end
end

function Sudoku:StepCall(handler, funcName)
	if step > stepGroupSize then
		step = 0
		handler:ScheduleTimer(funcName, self.stepDelay)
	else
		step = step + 1
		handler[funcName](handler)
	end
end

function Sudoku:IncrementStepCount()
	step = step + 1
end

function Sudoku:ResetStepCount()
	step = 0
end


function Sudoku:GetStepCount()
	return step
end






function Sudoku:GetLeastSetCell()
	local x,y = 0,0
	local tx,ty = 9,9
	local set = {1,1,1,1,1,1,1,1,1,1}
	while x < 9 do
		if self.solutionBoard[x][y] == 0 then
			tSet = self:CellCanBe(x,y)
			if #tSet < #set then
				tx,ty = x,y
				set = tSet
			end
		end
		y = y + 1
		if y>8 then
			y = y % 9
			x = x + 1
		end
	end
	set = self:Randomize(set)
	return tx, ty, set
end

function Sudoku:IsValid()
	local rSet, cSet, sSet, raSet, caSet, saSet
	local fail
	local sx,sy
	local size
	local canbeBoard = {}
	for x = 0,8 do
		canbeBoard[x] = {}
		rSet = {0,1,2,3,4,5,6,7,8,9}
		cSet = {0,1,2,3,4,5,6,7,8,9}
		sSet = {0,1,2,3,4,5,6,7,8,9}
		raSet = {1,2,3,4,5,6,7,8,9}
		caSet = {1,2,3,4,5,6,7,8,9}
		saSet = {1,2,3,4,5,6,7,8,9}
		for y = 0,8 do
			sx = floor(x/3)*3 +floor(y/3)
			sy = x%3*3 + y%3	
			if not canbeBoard[x] then
				canbeBoard[x] = {}
			end
			if not canbeBoard[x][y] then
				canbeBoard[x][y] = self:CellCanBe(x,y)
			end
			if not canbeBoard[y] then
				canbeBoard[y] = {}
			end
			if not canbeBoard[y][x] then
				canbeBoard[y][x] = self:CellCanBe(y,x)
			end
			if not canbeBoard[sx] then
				canbeBoard[sx] = {}
			end
			if not canbeBoard[sx][sy] then
				canbeBoard[sx][sy] = self:CellCanBe(sx,sy)
			end

			fail = 3
			for i,v in ipairs(rSet) do
				if v == self.solutionBoard[x][y] then
					rSet[i] = 0	
					fail = fail -1
					break
				end
			end
			for i,v in ipairs(cSet) do
				if v == self.solutionBoard[y][x] then
					cSet[i] = 0	
					fail = fail -1
					break
				end
			end
			for i,v in ipairs(sSet) do
				if v == self.solutionBoard[sx][sy] then
					sSet[i] = 0	
					fail = fail -1
					break
				end
			end

			if fail > 0 then
				return false
			end

			if self.solutionBoard[x][y] == 0 and #canbeBoard[x][y] == 0 then
				return false
			end
			raSet[self.solutionBoard[x][y]] = 0
			for _,v in ipairs(canbeBoard[x][y]) do
				raSet[v] = 0
			end
			caSet[self.solutionBoard[y][x]] = 0
			for _,v in ipairs(canbeBoard[y][x]) do
				caSet[v] = 0
			end
			saSet[self.solutionBoard[sx][sy]] = 0
			for _,v in ipairs(canbeBoard[sx][sy]) do
				saSet[v] = 0
			end
		end
		size = 0
		for _,v in ipairs(raSet) do
			if v ~= 0 then
				size = size + 1
			end
		end
		if size > 0 then
			return false
		end

		size = 0
		for _,v in ipairs(caSet) do
			if v ~= 0 then
				size = size + 1
			end
		end
		if size > 0 then
			return false
		end

		size = 0
		for _,v in ipairs(saSet) do
			if v ~= 0 then
				size = size + 1
			end
		end
		if size > 0 then
			return false
		end
	end

	return true
end

function Sudoku:Randomize(set)
	for i = 1,#set*4 do
		local a = math.random(1,#set)
		local b = math.random(1,#set)
		local temp = set[a]
		set[a] = set[b]
		set[b] = temp
	end
	return set
end

function Sudoku:CellCanBe(x,y)
	local aSet = {1,2,3,4,5,6,7,8,9}
	for z = 0,8 do
		aSet[self.solutionBoard[x][z]] = 0
		aSet[self.solutionBoard[z][y]] = 0
		local sI = floor(x/3)*3 + floor(y/3)
		aSet[self.solutionBoard[floor(sI/3)*3 +floor(z/3)][sI%3*3 + z%3]] = 0
	end
	local rtnSet = {}
	for i,v in pairs(aSet) do
		if v > 0 then
			table.insert(rtnSet,v)
		end
	end
	return rtnSet
end

function Sudoku:CountBlanks(board)
	local count = 0
	for x = 0,8 do
		for y = 0,8 do
			if board[x][y] == 0 then
				count = count +1
			end
		end
	end
	return count
end