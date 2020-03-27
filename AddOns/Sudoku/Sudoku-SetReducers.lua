function SimpleCellSetReducer(boardValues, boardSets)
	local c,r,s,sx,sy
	local progress = false
	for i = 0,8 do
		for j = 0,8 do
			sx = floor(i/3)*3 +floor(j/3)
			sy = i%3*3 + j%3
			c = boardValues[i][j]
			r = boardValues[j][i]
			s = boardValues[sx][sy]
			for z = 0,8 do
				if c ~= 0 and boardValues[i][z] == 0 and boardSets[i][z][c] == true then
					progress = true
					boardSets[i][z][c] = false
					if GetSetSize(boardSets[i][z]) == 1 then
						return boardSets, true
					end
					--print("Cell ".. i.. ",".. z .. " cannot be ".. c )
				end
				if r ~= 0 and boardValues[z][i] == 0 and boardSets[z][i][r] == true then
					progress = true
					boardSets[z][i][r] = false
					if GetSetSize(boardSets[z][i]) == 1 then
						return boardSets, true
					end
					--print("Cell ".. z.. ",".. i .. " cannot be ".. r )
				end
				sx = floor(i/3)*3 +floor(z/3)
				sy = i%3*3 + z%3
				if s ~= 0 and boardValues[sx][sy] == 0 and boardSets[sx][sy][s] == true then
					progress = true
					boardSets[sx][sy][s] = false
					if GetSetSize(boardSets[sx][sy]) == 1 then
						return boardSets, true
					end
					--print("Cell ".. (sx).. ",".. (sy) .. " cannot be ".. s )
				end
			end
		end
	end
	return boardSets, progress
end

function SimpleValueSetReducer(boardValues,boardSets)
	local rSet,cSet,sSet,rC,cC,sC
	for i = 0,8 do
		rSet = {true,true,true,true,true,true,true,true,true}
		cSet = {true,true,true,true,true,true,true,true,true}
		sSet = {true,true,true,true,true,true,true,true,true}
		for j = 0,8 do
			sx = floor(i/3)*3 +floor(j/3)
			sy = i%3*3 + j%3
			r = boardValues[i][j]
			c = boardValues[j][i]
			s = boardValues[sx][sy]
			rSet[r] = false
			cSet[c] = false
			sSet[s] = false
		end
		for v = 1,9 do
			rC = 0
			cC = 0
			sC = 0
			for j = 0,8 do
				if rSet[v] == true and boardValues[i][j] == 0 and boardSets[i][j][v] == true then
					rC = rC + 1
				end
				
				if cSet[v] == true and boardValues[j][i] == 0 and boardSets[j][i][v] == true then
					cC = cC + 1
				end
				
				sx = floor(i/3)*3 +floor(j/3)
				sy = i%3*3 + j%3
				if sSet[v] == true and boardValues[sx][sy] == 0 and boardSets[sx][sy][v] == true then
					sC = sC + 1
				end
			end
			
			if rC == 1 then
				for j = 0,8 do
					if boardValues[i][j] == 0 and boardSets[i][j][v] == true and GetSetSize(boardSets[i][j]) > 1 then
						boardSets[i][j] = {false,false,false,false,false,false,false,false,false}
						boardSets[i][j][v] = true
						return boardSets, true
						--print("Cell", (i).. ",".. (j), "can only be",v, "Row")
					end
				end
			elseif rC == 0 and rSet[v] == true then
				--print("Invalid Board","Row",i,"Value",v)
				return nil
			end
			
			if cC == 1 then
				for j = 0,8 do
					if boardValues[j][i] == 0 and boardSets[j][i][v] == true and GetSetSize(boardSets[j][i]) > 1 then
						boardSets[j][i] = {false,false,false,false,false,false,false,false,false}
						boardSets[j][i][v] = true
						return boardSets, true
						--print("Cell", (j).. ",".. (i), "can only be",v,"Column")
					end
				end
			elseif cC == 0 and cSet[v] == true then
				--print("Invalid Board","Column",i,"Value",v)
				return nil
			end
			
			if sC == 1 then
				for j = 0,8 do
					sx = floor(i/3)*3 +floor(j/3)
					sy = i%3*3 + j%3
					if boardValues[sx][sy] == 0 and boardSets[sx][sy][v] == true and GetSetSize(boardSets[sx][sy]) > 1 then
						boardSets[sx][sy] = {false,false,false,false,false,false,false,false,false}
						boardSets[sx][sy][v] = true
						return boardSets, true
						--print("Cell", (sx).. ",".. (sy), "can only be",v,"Set")
					end
				end
			elseif sC == 0 and sSet[v] == true then
				--print("Invalid Board","Set",i,"Value",v)
				return nil
			end
			
		end
	end
	return boardSets, false
end

function SubSetReducer(boardValues, boardSets)
	local c,r,s,fc,fr,fs,sx,sy,temp
	local rSet,cSet,sSet
	local progress = false
	for i = 0,8 do
		for j = 0,8 do
			rSet = boardSets[i][j]
			--print(i,j, rSet[1], rSet[2], rSet[3], rSet[4], rSet[5], rSet[6], rSet[7], rSet[8], rSet[9])

			r = 0
			fr = 0
			if boardValues[i][j] == 0 then
				for z = 0,8 do
					if boardValues[i][z] == 0 then
						fr = fr + 1
						if IsSubSet(rSet, boardSets[i][z]) then
							r = r + 1
						end	
					end
				end
				
				temp = GetSetSize(rSet) 
				if temp < fr and r == temp then
					for z = 0,8 do
						if boardValues[i][z] == 0 then
							for v = 1,9 do
								if rSet[v] and not IsSubSet(rSet, boardSets[i][z]) and boardSets[i][z][v] == true then
									boardSets[i][z][v] = false
									progress = true
									if GetSetSize(boardSets[i][z]) == 1 then
										return boardSets, progress
									end
									--print("Row","Cell ".. (i).. ",".. (z) .. " cannot be ".. v, "("..i..","..j..")"  )
								end
							end
						end
					end
				elseif r > temp then
					--print("Invalid Row Subset, ", i,j, rSet[1], rSet[2], rSet[3], rSet[4], rSet[5], rSet[6], rSet[7], rSet[8], rSet[9])
					--print(r,temp,fr)
					return nil
				end
			end
			

			cSet = boardSets[j][i]
			--print(j,i, cSet[1], cSet[2], cSet[3], cSet[4], cSet[5], cSet[6], cSet[7], cSet[8], cSet[9])

			c = 0
			fc = 0
			if boardValues[j][i] == 0 then
				for z = 0,8 do
					if boardValues[z][i] == 0 then
						fc = fc + 1
						if IsSubSet(cSet, boardSets[z][i]) then
							c = c + 1
						end	
					end
				end
				
				temp = GetSetSize(cSet) 
				if temp < fc and c == temp then
					for z = 0,8 do
						if boardValues[z][i] == 0 then
							for v = 1,9 do
								if not cSet[v] and IsSubSet(cSet, boardSets[z][i]) and boardSets[z][i][v] == true then
									boardSets[z][i][v] = false
									progress = true
									if GetSetSize(boardSets[z][i]) == 1 then
										return boardSets, progress
									end
									--print("Column","Cell ".. (z).. ",".. (i) .. " cannot be ".. v , "("..j..","..i..")" )
								end
							end
						end
					end
				elseif c > temp then
					--print("Invalid Column Subset, ", j,i, cSet[1], cSet[2], cSet[3], cSet[4], cSet[5], cSet[6], cSet[7], cSet[8], cSet[9])
					--print(c,temp,fc)
					return nil
				end
			end
			
			
			sx = floor(i/3)*3 +floor(j/3)
			sy = i%3*3 + j%3
			sSet = boardSets[sx][sy]
			--print(sx,sy, sSet[1], sSet[2], sSet[3], sSet[4], sSet[5], sSet[6], sSet[7], sSet[8], sSet[9])
			s = 0
			fs = 0
			if boardValues[sx][sy] == 0 then
				for z = 0,8 do
					sx = floor(i/3)*3 +floor(z/3)
					sy = i%3*3 + z%3
					if boardValues[sx][sy] == 0 then
						fs = fs + 1
						if IsSubSet(sSet, boardSets[sx][sy]) then
							s = s + 1
						end	
					end
				end
				
				temp = GetSetSize(sSet) 
				if temp < fs and s == temp then
					for z = 0,8 do
						sx = floor(i/3)*3 +floor(z/3)
						sy = i%3*3 + z%3
						if boardValues[sx][sy] == 0 then
							for v = 1,9 do
								if not sSet[v] and IsSubSet(sSet, boardSets[sx][sy]) and boardSets[sx][sy][v] == true then
									boardSets[sx][sy][v] = false
									progress = true
									if GetSetSize(boardSets[sx][sy]) == 1 then
										return boardSets, progress
									end
									--sx = floor(i/3)*3 +floor(j/3)
									--sy = i%3*3 + j%3
									--print("Set","Cell ".. (sx).. ",".. (sy) .. " cannot be ".. v, "("..sx..","..sy..")" )
								end
							end
						end
					end
				elseif s > temp then
					sx = floor(i/3)*3 +floor(j/3)
					sy = i%3*3 + j%3
					--print("Invalid Set Subset, ", sx,sy, sSet[1], sSet[2], sSet[3], sSet[4], sSet[5], sSet[6], sSet[7], sSet[8], sSet[9])
					--print(s,temp,fs)
					return nil
				end
			end
			
			
		end
	end
	return boardSets, progress
end

function ValueSubSetReducer(boardValues,boardSets)
	--print("ValueSubSetReducer")
	local sx,sy
	local rowSets = {}
	local colSets = {}
	local setSets = {}
	for i = 0,8 do
		rowSets[i] = {}
		colSets[i] = {}
		setSets[i] = {}
		for v = 1,9 do
			rowSets[i][v] = {}
			colSets[i][v] = {}
			setSets[i][v] = {}
			for j = 0,8 do
				if boardValues[i][j] == 0 and rowSets[i][v] ~= nil then
					rowSets[i][v][j] =  boardSets[i][j][v]
				elseif boardValues[i][j] == v then
					rowSets[i][v] = nil
				end
				
				if boardValues[j][i] == 0 and colSets[i][v] ~= nil then
					colSets[i][v][j] =  boardSets[j][i][v]
				elseif boardValues[j][i] == v then
					colSets[i][v] = nil
				end
				
				sx = floor(i/3)*3 +floor(j/3)
				sy = i%3*3 + j%3
				if boardValues[sx][sy] == 0 and setSets[i][v] ~= nil then
					setSets[i][v][j] =  boardSets[sx][sy][v]
				elseif boardValues[sx][sy] == v then
					setSets[i][v] = nil
				end
			end
		end
	end
	
	local setSize, subSetCount, setCount, set
	for s = 0,8 do
		for v = 1,9 do
			set = rowSets[s][v]
			subSetCount = 0
			setCount = 0
		
			if set ~= nil then
				setSize = GetValueSetSize(set) 
				
				for z = 1,9 do
					if rowSets[s][z] ~= nil then
						setCount = setCount + 1
						if IsValueSubSet(set, rowSets[s][z]) then
							subSetCount = subSetCount + 1
						end	
					end
				end
				
				
				if setSize < setCount and subSetCount == setSize then
					for z = 1,9 do
						if rowSets[s][z] ~= nil then
							for j = 0,8 do
								if set[j] and not IsValueSubSet(set, rowSets[s][z]) and rowSets[s][z][j] == true then
									rowSets[s][z][j] = false
									boardSets[s][j][z] = false
									--print("Row","Cell ".. (s).. ",".. (j) .. " cannot be ".. z, "("..v..")" )
									progress = true
									if GetSetSize(boardSets[s][j]) == 1 then
										return boardSets, progress
									end
								end
							end
						end
					end
				elseif subSetCount > setSize then
					return nil
				end
			end
			
		
			set = colSets[s][v]
			subSetCount = 0
			setCount = 0
		
			if set ~= nil then
				setSize = GetValueSetSize(set) 
				
				for z = 1,9 do
					if colSets[s][z] ~= nil then
						setCount = setCount + 1
						if IsValueSubSet(set, colSets[s][z]) then
							subSetCount = subSetCount + 1
						end	
					end
				end
				
				
				if setSize < setCount and subSetCount == setSize then
					for z = 1,9 do
						if colSets[s][z] ~= nil then
							for j = 0,8 do
								if set[j] and not IsValueSubSet(set, colSets[s][z]) and colSets[s][z][j] == true then
									colSets[s][z][j] = false
									boardSets[j][s][z] = false
									--print("Column","Cell ".. (j).. ",".. (s) .. " cannot be ".. z, "("..v..")" )
									progress = true
									if GetSetSize(boardSets[j][s]) == 1 then
										return boardSets, progress
									end
								end
							end
						end
					end
				elseif subSetCount > setSize then
					return nil
				end
			end
			
			
			set = setSets[s][v]
			subSetCount = 0
			setCount = 0
		
			if set ~= nil then
				setSize = GetValueSetSize(set) 
				
				for z = 1,9 do
					if setSets[s][z] ~= nil then
						setCount = setCount + 1
						if IsValueSubSet(set, setSets[s][z]) then
							subSetCount = subSetCount + 1
						end	
					end
				end
				
				
				if setSize < setCount and subSetCount == setSize then
					for z = 1,9 do
						if setSets[s][z] ~= nil then
							for j = 0,8 do
								if set[j] and not IsValueSubSet(set, setSets[s][z]) and setSets[s][z][j] == true then
									sx = floor(s/3)*3 +floor(j/3)
									sy = s%3*3 + j%3
									setSets[s][z][j] = false
									boardSets[sx][sy][v] = false
									--print("Set","Cell ".. (sx).. ",".. (sy) .. " cannot be ".. z, "("..v..")" )
									progress = true
									if GetSetSize(boardSets[sx][sy]) == 1 then
										return boardSets, progress
									end
								end
							end
						end
					end
				elseif subSetCount > setSize then
					return nil
				end
			end
		
		
		
		end	
	end
	return boardSets, progress
end


function HasSolvableCells(boardValues,boardSets)
	for x = 0,8 do
		for y = 0,8 do
			if boardValues[x][y] == 0 and GetSetSize(boardSets[x][y]) == 1 then
				return true
			end
		end
	end
	return false
end

function IsSubSet(set1,set2)
	for v = 1,9 do
		if not set1[v] and set2[v] then
			return false
		end
	end
	return true
end


function IsValueSubSet(set1,set2)
	for v = 1,9 do
		if not set1[v] and set2[v] then
			return false
		end
	end
	return true
end

function GetSetSize(set)
	local size = 0
	for v = 1,9 do
		if set[v] == true then
			size = size + 1
		end
	end
	return size
end

function GetValueSetSize(set)
	local size = 0
	for v = 0,8 do
		if set[v] == true then
			size = size + 1
		end
	end
	return size
end

function BuildBoardSets()
	local boardSets = {}
	for i = 0,8 do
		boardSets[i] = {}
		for j = 0,8 do
			boardSets[i][j] = {}
			for z = 1,9 do
				boardSets[i][j][z] = true
			end
		end
	end
	return boardSets
end