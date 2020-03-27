
local TimerFrame = CreateFrame('Frame')
local NextTime = 0

local function CleanTrash()
	local time = GetTime()
	
	if NextTime < time then
		if MainMenuBarBackpackButton.freeSlots == 0 then
			local bestValue, bestBag, bestSlot
		
			for bag, slot, id in Scrap:IterateJunk() do
				local bagType = select(2, GetContainerNumFreeSlots(bag))
				if not bagType then
					return
				end
				
				if bagType == 0 then
					local maxStack = select(8, GetItemInfo(id))
					local stack = select(2, GetContainerItemInfo(bag, slot))
					if not stack or not maxStack then
						return
					end
					
					local value = select(11, GetItemInfo(id)) * (stack + maxStack) * .5 -- Lets bet 50% on not full stacks
					if not bestValue or value < bestValue then
						bestBag, bestSlot = bag, slot
						bestValue = value
					end
				end
			end
			
			if bestBag and bestSlot then
				PickupContainerItem(bestBag, bestSlot)
				DeleteCursorItem()
				
				NextTime = time + 1
				TimerFrame:SetScript('OnUpdate', nil)
			end
		end
	else
		TimerFrame:SetScript('OnUpdate', CleanTrash)
	end
end

hooksecurefunc('MainMenuBarBackpackButton_UpdateFreeSlots', CleanTrash)