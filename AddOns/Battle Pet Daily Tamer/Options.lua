--[[
	Options.lua handles the tracking button on the world map and its attached menu.

	To avoid taint with default dropdowns and other addons messing with them, this
	addon adds its own tracking button that slides out from the world map's when the
	user mouseovers the world map tracking button.
]]

local tamer = BattlePetDailyTamer
local trackingButton = tamer.TrackingButton
local menuFrame = tamer.MenuFrame

local defaultTrackingButton -- this gets found after WorldMapFrame loads

-- call when WorldMapFrame is loaded, attach the slide-out tracking button to the world map
function tamer:SetupTrackingButton()
	-- default tracking button is anonymous, so we need to go through children of WorldFrame to find it
	for _,child in pairs({WorldMapFrame:GetChildren()}) do
		if child:GetObjectType()=="Button" and child.Icon and child.Icon:GetTexture()=="Interface\\Minimap\\Tracking\\None" then
			defaultTrackingButton = child
		end
	end
	-- if tracking button wasn't found, then leave without setting up our button
	if not defaultTrackingButton then
		return
	end
	-- parent tracking button to the map
	trackingButton:SetParent(WorldMapFrame)
	menuFrame:SetParent(WorldMapFrame)
	-- MEDIUM frameStrata is scarily busy; bumping tracking button up to HIGH frameStrata
	trackingButton:SetFrameStrata("HIGH") -- need to reassert after parent has changed
	menuFrame:SetFrameStrata("FULLSCREEN_DIALOG") -- same frameStrata as default dropdown
	-- initially position the button underneath the default's
	tamer:AnchorTrackingButton("TOP")

	-- when we mouseover the default tracking button slide our tracking button out
	defaultTrackingButton:HookScript("OnEnter",tamer.ShowTrackingButton)
	-- when the default tracking button hides, hide ours too
	defaultTrackingButton:HookScript("OnHide",function() trackingButton:Hide() end)
	-- when default tracking button clicked, hide menu if it's up
	defaultTrackingButton:HookScript("OnClick",function() menuFrame:Hide() end)

	-- and finally, add items to the menu
	tamer:SetupMenu()
end

function tamer:AnchorTrackingButton(relativePoint)
	trackingButton:SetPoint("TOP", defaultTrackingButton, relativePoint)
end

function tamer:ShowTrackingButton()
	if not trackingButton:IsVisible() then
		trackingButton:Show()
		trackingButton:SetFrameLevel(defaultTrackingButton:GetFrameLevel()-1)
		trackingButton.SlideOut:Play()
	end
end

-- call this to slide in/hide the tracking button unless it needs to be immediately hidden
function tamer:HideTrackingButton()
	menuFrame:Hide()
	if trackingButton.SlideOut:IsPlaying() or not defaultTrackingButton:IsVisible() then
		trackingButton:Hide() -- if button is still sliding out, hide it right away; don't need to animate
	else
		trackingButton.SlideIn:Play() -- an actual hide happens in the OnFinished of this animation
	end
end

function trackingButton:OnUpdate(elapsed)
	if not MouseIsOver(trackingButton) and not MouseIsOver(defaultTrackingButton) and not menuFrame:IsVisible() then
		tamer:HideTrackingButton()
	end
end

-- clicking the tracking button will toggle the menu
function trackingButton:OnClick()
	menuFrame.timer = nil -- see comments for menu's OnUpdate; this will keep menu up until mouseover
	menuFrame:SetShown(not menuFrame:IsVisible())
	tamer:UpdateMenu()
end

function trackingButton:OnHide()
	menuFrame:Hide()
end


--[[ menu ]]

-- menu has an OnKeyDown to hide the menu with ESC without messing with UISpecialFrames and stuff
function menuFrame:OnKeyDown(key)
	if key==GetBindingKey("TOGGLEGAMEMENU") then
		self:SetPropagateKeyboardInput(false)
		self:Hide()
	else -- if ESC not hit, pass key through
		self:SetPropagateKeyboardInput(true)
	end
end

-- when the menu is first shown its timer is nil; only when the mouse moves over the menu does
-- it set a timer of 0; 2 seconds after leaving the menu the menu will hide.
-- note this will make menu stay up indefinitely if mouse never enters menu (just like default)
function menuFrame:OnUpdate(elapsed)
	if MouseIsOver(self) then
		self.timer = 0
	elseif self.timer then
		self.timer = self.timer + elapsed
		if self.timer > 2 then
			self:Hide()
		end
	end
end

-- this builds the menu
function tamer:SetupMenu()
	menuFrame.Buttons = {}
	local maxWidth = 0
	for i=0,#tamer.pawInfo do
		menuFrame.Buttons[i] = CreateFrame("Button", nil, menuFrame, "BattlePetDailyTamerMenuItemTemplate")
		local button = menuFrame.Buttons[i]
		button:SetID(i)
		if i==0 then
			button:SetText("Battle Pet Daily Tamer")
			button:SetNormalFontObject("GameFontNormalSmallLeft")
			button.Icon:Hide()
		else
			button:SetText(tamer.pawInfo[i][1])
			button.Icon:SetTexture(tamer.pawInfo[i][4])
			button.Icon:SetVertexColor(tamer.pawInfo[i][5], tamer.pawInfo[i][6], tamer.pawInfo[i][7])
		end
		button:SetPoint("TOPLEFT",10,-15-i*16)
		maxWidth = max(maxWidth, button.Text:GetStringWidth())
	end
	-- make all buttons the same width
	for i=0,#menuFrame.Buttons do
		menuFrame.Buttons[i]:SetWidth(maxWidth + 46)
	end
	-- and size menu for its contents
	menuFrame:SetSize(maxWidth+46+24, (#menuFrame.Buttons+1)*16+30)
	-- color to match regular tracking menu
	menuFrame:SetBackdropBorderColor(TOOLTIP_DEFAULT_COLOR.r, TOOLTIP_DEFAULT_COLOR.g, TOOLTIP_DEFAULT_COLOR.b)
	menuFrame:SetBackdropColor(TOOLTIP_DEFAULT_BACKGROUND_COLOR.r, TOOLTIP_DEFAULT_BACKGROUND_COLOR.g, TOOLTIP_DEFAULT_BACKGROUND_COLOR.b)
end

-- this updates the check/unchecked/enabled status of each item on the menu
function tamer:UpdateMenu()
	local settings = BattlePetDailyTamerSettings
	local enabled -- true if main cvar is enabled
	for i=0,#menuFrame.Buttons do
		local button = menuFrame.Buttons[i]
		local checked -- whether individual option is enabled
		if i==0 then
			checked = GetCVarBool("showTamers") and true -- for "Battle Pet Daily Tamer" option, it's the showTamers cvar
			enabled = checked and true -- if false all the rest will be disabled/greyed out
		else -- this is a pawInfo setting, which can be disabled if enabled is false
			checked = settings[tamer.pawInfo[i][2]]
			button:SetEnabled(enabled)
			button.Check:SetDesaturated(not enabled)
			button.Icon:SetDesaturated(not enabled)
			if not enabled then
				button.Icon:SetVertexColor(0.75,0.75,0.75)
			else
				button.Icon:SetVertexColor(tamer.pawInfo[i][5],tamer.pawInfo[i][6],tamer.pawInfo[i][7])
			end
		end
		if checked then
			button.Check:SetTexCoord(0,0.5,0,0.5)
		else
			button.Check:SetTexCoord(0.5,1,0,0.5)
		end
	end
end

-- click of menu button will toggle its setting and refresh the map
function tamer:MenuButtonOnClick()
	local id = self:GetID()
	if id==0 then
		SetCVar("showTamers",1-GetCVar("showTamers"))
	else
		local settings = BattlePetDailyTamerSettings
		settings[tamer.pawInfo[id][2]] = not settings[tamer.pawInfo[id][2]]
	end
	tamer:UpdateMenu()
	tamer.dataProvider:RefreshAllData()
end