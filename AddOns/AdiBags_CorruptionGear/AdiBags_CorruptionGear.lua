local AdiBags = LibStub("AceAddon-3.0"):GetAddon("AdiBags")
local corruptionGearFilter = AdiBags:RegisterFilter("Corruption", 94)
corruptionGearFilter.uiName = "|cffb685ffCorruption Gear";
corruptionGearFilter.uiDesc = "Put Corruption Gear in their own section."

function corruptionGearFilter:Filter(slotData)
	local itemLink = GetContainerItemLink(slotData.bag, slotData.slot)
	if (itemLink) then
		local isCorruptedItem = IsCorruptedItem(itemLink)
		if (isCorruptedItem) then
			return "|cffb685ffCorruption Gear";
		end
	end
end
