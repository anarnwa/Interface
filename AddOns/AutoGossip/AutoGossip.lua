GossipFrame:HookScript("OnShow",function()
local targetid = tonumber(string.match(tostring(UnitGUID("target")), "-([^-]+)-[^-]+$"))

-- Stop if modifier key is held down
	if
	(
		IsModifierKeyDown()
	)
	then 
		return
	end 

-- Stop if NPC has quests or quest turn-ins
	if
	(
		GetNumGossipActiveQuests() > 0						
		or GetNumGossipAvailableQuests() > 0						
	)
	then 
		return
	end 

-- Auto select option if only 1 is available	
	local ticker = C_Timer.NewTicker(0.1,function(ticker)
        if(GetNumGossipOptions() == 1)
        then SelectGossipOption(1)
	    else ticker:Cancel()
	    end
    end)

-- Auto select option 1 if more than one option is available for the listed NPCs	
	if
	(
		GetNumGossipOptions() > 1							
	)
	then
		if
		(
			targetid == 39188		-- Mongar (Legion Dalaran)
			or targetid == 96782		-- Lucian Trias (Legion Dalaran)
			or targetid == 97004		-- "Red" Jack Findle (Legion Dalaran)
			or targetid == 138708		-- Garona Halforcen (BFA)
			or targetid == 135614		-- Master Mathias Shaw (BFA)
			or targetid == 131287		-- Natal'hakata (Horde Zandalari Emissary)
			or targetid == 138097		-- Muka Stormbreaker (Stormsong Valley Horde flight master)
			or targetid == 35642		-- Jeeves
		)
		then
			SelectGossipOption(1)
			print("|cFF00ff99AutoGossip:|r option chosen. Hold a modifier key to override.")
		end
	end
end
)
