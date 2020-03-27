

function Sudoku:OnInitialize()
	self.stepDelay = .0001
	self:RegisterOptions()
	self:RegisterChatCommand("Sudoku", "SlashCommand")
end

function GetRandomOrder(low,high)
	local list = {}
	for i = low,high do
		list[i] = i
	end
	for i = 1,(high-low)*4 do
		local a = math.random(low,high)
		local b = math.random(low,high)
		local temp = list[a]
		list[a] = list[b]
		list[b] = temp
	end
	return list
end

function PrintBoard(board)
	print("   1,2,3,4,5,6,7,8,9")
	for i = 0,8 do
		local line = "" .. (i+1) .. ":"
		for j = 0,8 do
			if board[i][j] == 0 then
				line = line .. "  "
			else
				line = line .. " " .. board[i][j]
			end
		end
		print(line)
	end
end

function Sudoku:SlashCommand(info)
	
	
	if (not self:GetBuildingFrame():IsVisible()) and (not self:GetPuzzleFrame():IsVisible()) and (not self:GetMenuFrame():IsVisible()) then
		if self:HasSavedGame() then
			local savedTime
			self.puzzleBoard, self.completeBoard, savedTime = self:GetSavedGame()
			self:SetStartTime(time()-savedTime)
			self:SetSavedGame(nil,nil,0)
			
			self:GetPuzzleFrame():Show()
		else
			self:GetMenuFrame():Show()
		end
	end
end