		-------------------------------------------------
		-- Paragon Reputation 1.26 by Fail US-Ragnaros --
		-------------------------------------------------

		  --[[	  Special thanks to Ammako for
				  helping me with the vars and
				  the options.						]]--

local ADDON_NAME,ParagonReputation = ...
local PR = ParagonReputation

local ACTIVE_TOAST = false
local WAITING_TOAST = {}

local PARAGON_QUEST_ID = { --[questID] = {factionID,rewardID}
	--Legion
		[48976] = {2170,152922}, -- Argussian Reach
		[46777] = {2045,152108}, -- Armies of Legionfall
		[48977] = {2165,152923}, -- Army of the Light
		[46745] = {1900,152102}, -- Court of Farondis
		[46747] = {1883,152103}, -- Dreamweavers
		[46743] = {1828,152104}, -- Highmountain Tribes
		[46748] = {1859,152105}, -- The Nightfallen
		[46749] = {1894,152107}, -- The Wardens
		[46746] = {1948,152106}, -- Valarjar
	
	--Battle for Azeroth
		--Neutral
		[54453] = {2164,166298}, --Champions of Azeroth
		[55348] = {2391,170061}, --Rustbolt Resistance
		[54451] = {2163,166245}, --Tortollan Seekers
		
		--Horde
		[54460] = {2156,166282}, --Talanji's Expedition
		[54455] = {2157,166299}, --The Honorbound
		[53982] = {2373,169940}, --The Unshackled
		[54461] = {2158,166290}, --Voldunai
		[54462] = {2103,166292}, --Zandalari Empire
		
		--Alliance
		[54456] = {2161,166297}, --Order of Embers
		[54458] = {2160,166295}, --Proudmoore Admiralty
		[54457] = {2162,166294}, --Storm's Wake
		[54454] = {2159,166300}, --The 7th Legion
		[55976] = {2400,169939}, --Waveblade Ankoan
}

-- [Reputation Watchbar] Color the Reputation Watchbar by the settings. (Thanks Hoalz)
hooksecurefunc(ReputationBarMixin,"Update",function(self)
	local _,_,_,_,_,factionID = GetWatchedFactionInfo()
	if factionID and C_Reputation.IsFactionParagon(factionID) then
		self:SetBarColor(unpack(PR.DB.value))
	end
end)

-- [ParagonTooltip] Setup the Paragon Tooltip accordingly.
hooksecurefunc("ReputationParagonFrame_SetupParagonTooltip",function(self)
	local _,_,rewardQuestID,hasRewardPending = C_Reputation.GetFactionParagonInfo(self.factionID)
	if hasRewardPending then
		local factionName = GetFactionInfoByID(self.factionID)
		local questIndex = GetQuestLogIndexByID(rewardQuestID)
		local description = GetQuestLogCompletionText(questIndex) or ""
		EmbeddedItemTooltip:SetText(PR.L["PARAGON"])
		EmbeddedItemTooltip:AddLine(description,HIGHLIGHT_FONT_COLOR.r,HIGHLIGHT_FONT_COLOR.g,HIGHLIGHT_FONT_COLOR.b,1)
		GameTooltip_AddQuestRewardsToTooltip(EmbeddedItemTooltip,rewardQuestID)
		EmbeddedItemTooltip:Show()
	else
		EmbeddedItemTooltip:Hide()
	end
end)

-- [GameTooltip] Show the GameTooltip with the Item Reward Hyperlink on mouseover. (Thanks Brudarek)
function ParagonReputation:Tooltip(self,event)
	if not self.questID then return end
	if event == "OnEnter" then
		local _,link = GetItemInfo(PARAGON_QUEST_ID[self.questID][2])
		if link ~= nil then
			GameTooltip:SetOwner(self,"ANCHOR_NONE")
			GameTooltip:SetPoint("TOPLEFT",self,"BOTTOMRIGHT")
			GameTooltip:SetHyperlink(link)
			GameTooltip:Show()
		end
	elseif event == "OnLeave" then
		GameTooltip_SetDefaultAnchor(GameTooltip,UIParent)
		GameTooltip:Hide()
	end
end

-- [GameTooltip] Hook the Reputation Bars Scripts to show the Tooltip.
function ParagonReputation:HookScript()
	for n=1,NUM_FACTIONS_DISPLAYED do
		if _G["ReputationBar"..n] then
			_G["ReputationBar"..n]:HookScript("OnEnter",function(self)
				PR:Tooltip(self,"OnEnter")
			end)
			_G["ReputationBar"..n]:HookScript("OnLeave",function(self)
				PR:Tooltip(self,"OnLeave")
			end)
		end
	end
end

-- [Paragon Toast] Show the Paragon Toast if a Paragon Reward Quest is accepted.
function ParagonReputation:ShowToast(name,text)
	ACTIVE_TOAST = true
	if PR.DB.sound then PlaySound(44295,"master",true) end
	PR.toast:EnableMouse(false)
	PR.toast.title:SetText(name)
	PR.toast.title:SetAlpha(0)
	PR.toast.description:SetText(text)
	PR.toast.description:SetAlpha(0)
	PR.toast.reset:Hide()
	PR.toast.lock:Hide()
	UIFrameFadeIn(PR.toast,.5,0,1)
	C_Timer.After(.5,function()
		UIFrameFadeIn(PR.toast.title,.5,0,1)
	end)
	C_Timer.After(.75,function()
		UIFrameFadeIn(PR.toast.description,.5,0,1)
	end)
	C_Timer.After(PR.DB.fade,function()
		UIFrameFadeOut(PR.toast,1,1,0)
	end)
	C_Timer.After(PR.DB.fade+1.25,function()
		PR.toast:Hide()
		ACTIVE_TOAST = false
		if #WAITING_TOAST > 0 then
			PR:WaitToast()
		end
	end)
end

-- [Paragon Toast] Get next Paragon Reward Quest if more than two are accepted at the same time.
function ParagonReputation:WaitToast()
	local name,text = unpack(WAITING_TOAST[1])
	table.remove(WAITING_TOAST,1)
	PR:ShowToast(name,text)
end

-- [Paragon Toast] Handle the QUEST_ACCEPTED event.
local reward = CreateFrame("FRAME")
reward:RegisterEvent("QUEST_ACCEPTED")
reward:SetScript("OnEvent",function(self,event,...)
	local questIndex,questID = ...
	if PR.DB.toast and PARAGON_QUEST_ID[questID] then
		local name = GetFactionInfoByID(PARAGON_QUEST_ID[questID][1])
		local text = GetQuestLogCompletionText(questIndex)
		if ACTIVE_TOAST then
			WAITING_TOAST[#WAITING_TOAST+1] = {name,text} --Toast is already active, put this info on the line.
		else
			PR:ShowToast(name,text)
		end
	end
end)

-- [Paragon Overlay] Create the Overlay for the Reputation Bar.
function ParagonReputation:CreateBarOverlay(factionBar)
	local overlay = CreateFrame("FRAME",nil,factionBar)
	overlay:SetAllPoints(factionBar)
	overlay:SetFrameLevel(3)
	overlay.bar = overlay:CreateTexture("ARTWORK",nil,nil,-1)
	overlay.bar:SetTexture((ElvUI and ElvUI[1].private and ElvUI[1].private.skins and ElvUI[1].private.skins.blizzard and ElvUI[1].private.skins.blizzard.enable and ElvUI[1].private.skins.blizzard.character and ElvUI[1].media and ElvUI[1].media.normTex) or "Interface\\TARGETINGFRAME\\UI-StatusBar") -- Checks for ElvUI and it's values in case they are skinning the Character Frame.
	overlay.bar:SetPoint("TOP",overlay)
	overlay.bar:SetPoint("BOTTOM",overlay)
	overlay.bar:SetPoint("LEFT",overlay)
	overlay.edge = overlay:CreateTexture("ARTWORK",nil,nil,-1)
	overlay.edge:SetTexture("Interface\\CastingBar\\UI-CastingBar-Spark")
	overlay.edge:SetPoint("CENTER",overlay.bar,"RIGHT")
	overlay.edge:SetBlendMode("ADD")
	overlay.edge:SetSize(38,38) --Arbitrary value, I hope there isn't an AddOn that skins the bar and the glow doesnt look right with this size.
	factionBar.ParagonOverlay = overlay
end

-- [Reputation Frame] Change the Reputation Bars accordingly.
hooksecurefunc("ReputationFrame_Update",function()
	ReputationFrame.paragonFramesPool:ReleaseAll()
	local factionOffset = FauxScrollFrame_GetOffset(ReputationListScrollFrame)
	for n=1,NUM_FACTIONS_DISPLAYED,1 do
		local factionIndex = factionOffset+n
		local factionRow = _G["ReputationBar"..n]
		local factionBar = _G["ReputationBar"..n.."ReputationBar"]
		local factionStanding = _G["ReputationBar"..n.."ReputationBarFactionStanding"]
		if factionIndex <= GetNumFactions() then
			local name,_,_,_,_,_,_,_,_,_,_,_,_,factionID = GetFactionInfo(factionIndex)
			if factionID and C_Reputation.IsFactionParagon(factionID) then
				local r,g,b = unpack(PR.DB.value)
				local currentValue,threshold,rewardQuestID,hasRewardPending = C_Reputation.GetFactionParagonInfo(factionID)
				factionRow.questID = rewardQuestID
				if currentValue then
					local value = mod(currentValue,threshold)
					if hasRewardPending then
						local paragonFrame = ReputationFrame.paragonFramesPool:Acquire()
						paragonFrame.factionID = factionID
						paragonFrame:SetPoint("RIGHT",factionRow,11,0)
						paragonFrame.Glow:SetShown(true)
						paragonFrame.Check:SetShown(true)
						paragonFrame:Show()
						-- If value is 0 we force it to 1 so we don't get 0 as result, math...
						local over = ((value <= 0 and 1) or value)/threshold
						if not factionBar.ParagonOverlay then PR:CreateBarOverlay(factionBar) end
						factionBar.ParagonOverlay:Show()
						factionBar.ParagonOverlay.bar:SetWidth(factionBar.ParagonOverlay:GetWidth()*over)
						factionBar.ParagonOverlay.bar:SetVertexColor(r+.15,g+.15,b+.15)
						factionBar.ParagonOverlay.edge:SetVertexColor(r+.2,g+.2,b+.2,(over > .05 and .75) or 0)
						value = value+threshold
					else
						if factionBar.ParagonOverlay then factionBar.ParagonOverlay:Hide() end
					end
					factionBar:SetMinMaxValues(0,threshold)
					factionBar:SetValue(value)
					factionBar:SetStatusBarColor(r,g,b)
					factionRow.rolloverText = HIGHLIGHT_FONT_COLOR_CODE.." "..format(REPUTATION_PROGRESS_FORMAT,BreakUpLargeNumbers(value),BreakUpLargeNumbers(threshold))..FONT_COLOR_CODE_CLOSE
					if PR.DB.text == "PARAGON" then
						factionStanding:SetText(PR.L["PARAGON"])
						factionRow.standingText = PR.L["PARAGON"]
					elseif PR.DB.text == "CURRENT"  then
						factionStanding:SetText(BreakUpLargeNumbers(value))
						factionRow.standingText = BreakUpLargeNumbers(value)
					elseif PR.DB.text == "VALUE" then
						factionStanding:SetText(" "..BreakUpLargeNumbers(value).." / "..BreakUpLargeNumbers(threshold))
						factionRow.standingText = (" "..BreakUpLargeNumbers(value).." / "..BreakUpLargeNumbers(threshold))
						factionRow.rolloverText = nil					
					elseif PR.DB.text == "DEFICIT" then
						if hasRewardPending then
							value = value-threshold
							factionStanding:SetText("+"..BreakUpLargeNumbers(value))
							factionRow.standingText = "+"..BreakUpLargeNumbers(value)
						else
							value = threshold-value
							factionStanding:SetText(BreakUpLargeNumbers(value))
							factionRow.standingText = BreakUpLargeNumbers(value)
						end
						factionRow.rolloverText = nil
					end
					if factionIndex == GetSelectedFaction() and ReputationDetailFrame:IsShown() then
						local count = floor(currentValue/threshold)
						if hasRewardPending then count = count-1 end
						if count > 0 then
							ReputationDetailFactionName:SetText(name.." |cffffffffx"..count.."|r")
						end
					end
				end
			else
				factionRow.questID = nil
				if factionBar.ParagonOverlay then factionBar.ParagonOverlay:Hide() end
			end
		else
			factionRow:Hide()
		end
	end
end)