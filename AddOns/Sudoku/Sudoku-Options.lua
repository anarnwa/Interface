
local icon


local options = {
	name = GetL()["SudokubyStrucker"],
	type = 'group',
	desc = GetL()["Description"],
	set = function(info,arg) Sudoku:SetOptionValue(info,arg) end,
	get = function(info) return Sudoku:GetOptionValue(info) end,
	handler = Sudoku,
	args = {
		["SHOW_MINIMAP_BUTTON"] = {
			name = GetL()["ShowMiniMapButton"],
			type = 'toggle',
			order = 50,
			set = function(info,val) 
				Sudoku:GetMiniMapSettings().hide = not val 
				if val then
					icon:Show(GetL()["Sudoku"])
				else
					icon:Hide(GetL()["Sudoku"])
				end
			
			end,
			get = function(info) return not Sudoku:GetMiniMapSettings().hide end,
			arg = "",
		},
	
	
	
	
	
	
		["PUZZLE_FRAME"] = {
			name = GetL()["PuzzleScreenSettings"],
			type = 'group',
			order = 100,
			guiInline = true,
			args = {
				
				["HIDE_IN_COMBAT"] = {
					name = GetL()["HideinCombat"],
					type = 'toggle',
					order = 100,
					arg = "hideInCombat",
					disabled = false,
				},
				["ANNOUNCE_NEW_RECORDS"] = {
					name = GetL()["ShoutNewRecords"],
					type = 'toggle',
					order = 150,
					arg = "announceNewRecords",
					disabled = false,
				},
				["PUZZLE_FRAME_SCALE"] = {
					name = GetL()["PuzzleFrameScale"],
					type = 'range',
					min = .5, max = 3, step = .1,
					order = 200,
					arg = "puzzleFrameScale"
				},
			}
		},
		
		["CREATE_FRAME"] = {
			name = GetL()["PuzzleCreationSettings"],
			type = 'group',
			order = 200,
			guiInline = true,
			args = {
				["DIFFICULTY"] = {
					name = GetL()["DifficultyMode"],
					type = 'select',
					values = {[1]=GetL()["Easy"], [2]=GetL()["Normal"], [3]=GetL()["Hard"], [4]=GetL()["MakeMeCry"]},
					order = 50,
					arg = "mode",
					disabled = false,
				},
				["STEPS_PER_FRAME"] = {
					name = GetL()["CalcStepsPerFrame"],
					type = 'range',
					min = 5, max = 2000, step = 1,
					order = 100,
					arg = "stepsPerFrame"
				},
			}
		}
	}
}

local main

function Sudoku:RegisterOptions()
	local registry = LibStub('AceConfigRegistry-3.0')
	local dialog = LibStub('AceConfigDialog-3.0')
	LibStub('AceConfig-3.0'):RegisterOptionsTable(GetL()["Sudoku"], options, {GetL()["Sudoku"],GetL()["Sudoku"]})
	
	registry:RegisterOptionsTable(GetL()["SudokuOptions"], options)
	main = dialog:AddToBlizOptions(GetL()["SudokuOptions"], GetL()["Sudoku"])
	
	local dataobj = LibStub:GetLibrary('LibDataBroker-1.1'):NewDataObject(GetL()["Sudoku"], {
		type = 'launcher',
		text = GetL()["Sudoku"],
		label = GetL()["Sudoku"],
		icon = 'Interface\\Icons\\Spell_Fire_Rune',
	})
	
	if dataobj then
		dataobj.OnClick = function(self,button,down) 
			if button == "RightButton" then
				Sudoku:ShowOptions()
			else
				if Sudoku:GetMenuFrame():IsVisible() then
					Sudoku:GetMenuFrame():Hide()
				else
					Sudoku:SlashCommand("")
				end
			end
		end
		dataobj.OnTooltipShow = function(tooltip)
			tooltip:AddLine(GetL()["SudokubyStrucker"])
			tooltip:AddLine(GetL()["Description"])
			tooltip:AddLine(GetL()["MiniMapLeftClick"])
			tooltip:AddLine(GetL()["MiniMapRightClick"])
		end
		icon = LibStub("LibDBIcon-1.0", true)
		icon:Register(GetL()["Sudoku"], dataobj,self:GetMiniMapSettings())
	end
end

function Sudoku:ShowOptions()
	if InterfaceOptionsFrame:IsVisible() then
		InterfaceOptionsFrame:Hide()
	else
		InterfaceOptionsFrame_OpenToCategory(main) 
	end
end