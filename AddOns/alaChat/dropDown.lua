--[[--
	alex@0
--]]--
----------------------------------------------------------------------------------------------------
local ADDON,NS=...;
NS.FUNC=NS.FUNC or {ON={},OFF={},INIT={},TOOLTIPS={},SETVALUE={},};
local FUNC=NS.FUNC;
local L=NS.L;
if not L then return;end
----------------------------------------------------------------------------------------------------
local math,table,string,pairs,type,select,tonumber,unpack=math,table,string,pairs,type,select,tonumber,unpack;
local _G=_G;
local GameTooltip=GameTooltip;
----------------------------------------------------------------------------------------------------
local LCONFIG=L.CONFIG;
if not LCONFIG then
	return;
end
----------------------------------------------------------------------------------------------------main
local dropMenuBackdrop = {
	bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
	tile = true,
	tileSize = 2,
	edgeSize = 2,
	insets = { left = 2, right = 2, top = 2, bottom = 2 }
};
local dropMenuBackdropColor = { 0.25, 0.25, 0.25, 0.9 };

local COUNTING_DOWN_TIMER_PERIOD = 1.5;
local dropMenuButtonHeight = 20;
local dropMenuButtonInterval = 0;
local dropMenuButtonTopBottomInterval = 2;

local dropMenuButtonOnClick;
local dropMenuButtonOnEnter;
local dropMenuButtonOnLeave;
local showMenu;

dropMenuButtonOnClick = function(self, button)
	local level = self.level;
	local packIndex = self.packIndex;
	local action = self.action;
	local data = self.parent.frame.data;
	if level == 1 then
		local action1 = action[1];
		if action1 == 5 then
			self.parent:Hide();
			return;
		end

		if data[action1].items then
			control_cur_L = 1;
			control_cur_L1 = action1;
			control_cur_L2 = 0;
			control_cur_L3 = 0;
			control_cur_I = 1;
			
			--PRINT(action1);

			apply(self.parent.frame);
			self.parent:Hide();
		end
	elseif level == 2 then
		local action1 = action[1];
		local action2 = action[2];

		if data[action1][action2].items then
			control_cur_L = 2;
			control_cur_L1 = action1;
			control_cur_L2 = action2;
			control_cur_L3 = 0;
			control_cur_I = 1;

			--PRINT(action1, action2);

			apply(self.parent.frame);
			self.parent.parent:Hide();
		end
	elseif level == 3 then
		local action1 = action[1];
		local action2 = action[2];
		local action3 = action[3];

		if data[action1][action2][action3].items then
			control_cur_L = 3;
			control_cur_L1 = action1;
			control_cur_L2 = action2;
			control_cur_L3 = action3;
			control_cur_I = 1;

			--PRINT(action1, action2, action3);
			
			apply(self.parent.frame);
			self.parent.parent.parent:Hide();
		end
	end
end
dropMenuButtonOnEnter = function(self)
	local frame = self.parent.frame;
	local data = frame.data;
	local level = self.level;
	local action = self.action;
	if level == 1 then
		self.parent.isCountingDown = false;
		local action1 = action[1]
		local data1 = data[action1];
		if data1.L then
			local menu2 = frame.dropMenu2;
			showMenu(menu2, data1, action, level + 1);
			menu2:ClearAllPoints();
			menu2:SetPoint("TOPLEFT", self, "TOPRIGHT", 2, 0);
		else
			frame.dropMenu2:Hide();
		end
		frame.dropMenu3:Hide();
	elseif level == 2 then
		self.parent.parent.isCountingDown = false;
		local action1 = action[1];
		local action2 = action[2];
		local data2 = data[action1][action2];
		if data2.L then
			local menu3 = frame.dropMenu3;
			showMenu(menu3, data2, action, level + 1);
			menu3:ClearAllPoints();
			menu3:SetPoint("TOPLEFT", self, "TOPRIGHT", 2, 0);
		else
			frame.dropMenu3:Hide();
		end
	elseif level == 3 then
		self.parent.parent.parent.isCountingDown = false;
	else
		PRINT("ERROR dropMenuButtonOnEnter");
	end
end
dropMenuButtonOnLeave = function(self)
	local level = self.level;
	if level == 1 then
		local P = self.parent;
		P.isCountingDown = true;
		P.countingDownTimer = COUNTING_DOWN_TIMER_PERIOD;
	elseif level == 2 then
		local P = self.parent.parent;
		P.isCountingDown = true;
		P.countingDownTimer = COUNTING_DOWN_TIMER_PERIOD;
	elseif level == 3 then
		local P = self.parent.parent.parent;
		P.isCountingDown = true;
		P.countingDownTimer = COUNTING_DOWN_TIMER_PERIOD;
	else
		PRINT("ERROR dropMenuButtonOnEnter");
	end
end

local function createDropMenu(frame)
	local dropMenu = CreateFrame("Button", nil, frame);
	dropMenu:SetClampedToScreen(true);
	dropMenu:Hide();
	dropMenu:SetPoint("TOPLEFT", frame, "BOTTOMLEFT", 0, -6);
	dropMenu:SetBackdrop(dropMenuBackdrop);
	dropMenu:SetBackdropColor(dropMenuBackdropColor[1], dropMenuBackdropColor[2], dropMenuBackdropColor[3], dropMenuBackdropColor[4]);
	dropMenu:SetScript("OnClick", function(self, button)
			self:Hide();
		end
	);
	dropMenu:SetScript("OnEnter", function(self)
			for i = 1, self.level do
				self.counting[i] = nil;
			end
		end
	);
	dropMenu:SetScript("OnLeave", function(self)
			for i = 1, self.level do
				self.counting[i] = COUNTING_DOWN_TIMER_PERIOD;
			end
		end
	);
	dropMenu:SetScript("OnUpdate", function(self, elasped)
			if self:IsShown() and self.counting[self.level] then
				self.counting[self.level] = self.counting[self.level] - elasped;
				if self.counting[self.level] <= 0 then
					self.counting[self.level] = nil;
					self:Hide();
				end
			end
		end
	);
	dropMenu:SetScript("OnHide", function(self)
			self.counting[self.level] = nil;
		end
	);
	dropMenu.buttons = {};
	dropMenu.counting = frame.counting;
	dropMenu.frame = frame;
end

showMenu = function(frame, data, action, level)
	local menus = frame.menus;
	local menu = menus[level];
	if not menu then
		menu=createDropMenu(frame);
		menus[level] = menu;
	end
	menu.level = level;

	local buttons = menu.buttons;
	if #buttons < #data then
		for i = #buttons + 1, #data do
			local button = CreateFrame("Button", nil, menu);
			button:SetHeight(dropMenuButtonHeight);
			--button:SetNormalTexture("Interface\\Buttons\\UI-StopButton");
			--button:SetPushedTexture("Interface\\Buttons\\UI-StopButton");
			button:SetHighlightTexture("Interface\TargetingFrame\UI-StatusBar");
			button:GetHighlightTexture():SetVertexColor(0.5, 0.5, 0.0, 0.75);
			button:SetPoint("TOP", menu, 0, -((i - 1) * (dropMenuButtonHeight + dropMenuButtonInterval) + dropMenuButtonTopBottomInterval));

			local text = button:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
			text:SetPoint("LEFT", 2, 0)
			text:SetTextColor(0.9, 0.9, 0.9, 0.9)
			text.parent = button;
			button.text = text;

			local texture = button:CreateTexture(nil, "ARTWORK");
			texture:SetSize(dropMenuButtonHeight / 2, dropMenuButtonHeight);
			texture:SetPoint("RIGHT", -2, 0)
			texture:SetTexture("interface\\buttons\\ui-colorpicker-buttons");
			texture:SetTexCoord(0.25, 0.375, 0.0, 1.0);
			texture:SetVertexColor(1.0, 1.0, 0.25, 1.0);
			texture.parent = button;
			button.texture = texture;
			
			button:SetScript("OnClick", dropMenuButtonOnClick);
			button:SetScript("OnEnter", dropMenuButtonOnEnter);
			button:SetScript("OnLeave", dropMenuButtonOnLeave);
	
			button.parent = menu;
			button.level = level;
			
			buttons[i] = button;
		end
	elseif #buttons > #data then
		for i = #data + 1, #buttons do
			buttons[i]:Hide();
		end
	end

	local width = -1;
	for i = 1, #data do
		local button = buttons[i];

		button.level = level;
		button.action = {};
		for k, v in pairs(action) do
			button.action[k] = v;
		end
		button.action[level] = i;
	
		button:Show();

		button.text:SetText(data[i].title);
		local w = button.text:GetWidth();
		if w > width then
			width = w;
		end

		if data[i].L then
			button.texture:Show();
		else
			button.texture:Hide();
		end
	end
	width = width + dropMenuButtonHeight;
	for i = 1, #data do
		buttons[i]:SetWidth(width);
	end
	menu:SetWidth(width);
	menu:SetHeight(dropMenuButtonHeight * #data + dropMenuButtonInterval * (#data - 1) + dropMenuButtonTopBottomInterval * 2);

	menu:Show();
end

local function buttonOnClick(self, button)
	local menu1 = self.dropMenu;
	if menu1:IsShown() then
		menu1:Hide();
		return;
	end
	self.dropMenu2:Hide();
	self.dropMenu3:Hide();
	showMenu(menu1, self.frame.data, {}, 1);
end

function CreateDropDown(frame)
	local frame = CreateFrame("frame");
	frame:SetSize(48, 20);
	frame:ClearAllPoints();
	frame:SetBackdrop({
		bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		tile = true,
		tileSize = 2,
		edgeSize = 2,
		insets = { left = 2, right = 2, top = 2, bottom = 2 }
	});
	frame:SetBackdropColor(0.25, 0.25, 0.25, 0.5);
	frame.counting = {};

	local button = CreateFrame("Button", nil, frame);
	button:SetSize(18, 18);
	button:SetNormalTexture("interface\\mainmenubar\\ui-mainmenu-scrolldownbutton-up");
	button:SetPushedTexture("interface\\mainmenubar\\ui-mainmenu-scrolldownbutton-down");
	button:SetHighlightTexture("interface\\mainmenubar\\ui-mainmenu-scrolldownbutton-highlight");
	button:SetPoint("RIGHT", 0, 0);
	button:SetScript("OnClick", buttonOnClick);
	button:SetScript("OnEnter", function(self)
			if self.frame:IsShown() then
				self.frame.isCountingDown = false;
			end
		end
	);
	button:SetScript("OnLeave", function(self)
			if self.dropMenu:IsShown() then
				self.dropMenu.isCountingDown = true;
				self.dropMenu.countingDownTimer = COUNTING_DOWN_TIMER_PERIOD;
			end
		end
	);
	button.frame = frame;
	frame.button = button;

	local dropMenu = CreateFrame("Button", nil, frame);
	dropMenu:SetClampedToScreen(true);
	dropMenu:Hide();
	dropMenu:SetPoint("TOPLEFT", button, "BOTTOMLEFT", 0, -6);
	dropMenu:SetBackdrop(dropMenuBackdrop);
	dropMenu:SetBackdropColor(dropMenuBackdropColor[1], dropMenuBackdropColor[2], dropMenuBackdropColor[3], dropMenuBackdropColor[4]);
	dropMenu:SetScript("OnClick", function(self, button)
			self:Hide();
		end
	);
	dropMenu:SetScript("OnEnter", function(self)
			self.isCountingDown = false;
		end
	);
	dropMenu:SetScript("OnLeave", function(self)
			self.isCountingDown = true;
			self.countingDownTimer = COUNTING_DOWN_TIMER_PERIOD;
		end
	);
	dropMenu:SetScript("OnUpdate", function(self, elasped)
			if self:IsShown() and self.isCountingDown then
				self.countingDownTimer = self.countingDownTimer - elasped;
				if self.countingDownTimer <= 0 then
					self.isCountingDown = false;
					self:Hide();
				end
			end
		end
	);
	dropMenu:SetScript("OnHide", function(self)
			self.isCountingDown = false;
		end
	);
	dropMenu.frame = frame;
	dropMenu.button = button;
	button.dropMenu = dropMenu;
	frame.dropMenu = dropMenu;
	dropMenu.buttons = {};

	local dropMenu2 = CreateFrame("Button", nil, dropMenu);
	dropMenu2:SetClampedToScreen(true);
	dropMenu2:Hide();
	dropMenu2:SetPoint("TOPLEFT", button, "BOTTOMLEFT", 0, -6);
	dropMenu2:SetPoint("TOPRIGHT", -6, -4);
	dropMenu2:SetBackdrop(dropMenuBackdrop);
	dropMenu2:SetBackdropColor(dropMenuBackdropColor[1], dropMenuBackdropColor[2], dropMenuBackdropColor[3], dropMenuBackdropColor[4]);
	dropMenu2:SetScript("OnClick", function(self, button)
			self:Hide();
		end
	);
	dropMenu2:SetScript("OnEnter", function(self)
			self.isCountingDown = false;
			self.parent.isCountingDown = false;
		end
	);
	dropMenu2:SetScript("OnLeave", function(self)
			self.isCountingDown = true;
			self.countingDownTimer = COUNTING_DOWN_TIMER_PERIOD;
			self.parent.isCountingDown = true;
			self.parent.countingDownTimer = COUNTING_DOWN_TIMER_PERIOD;
		end
	);
	dropMenu2:SetScript("OnUpdate", function(self, elasped)
			if self:IsShown() and self.isCountingDown then
				self.countingDownTimer = self.countingDownTimer - elasped;
				if self.countingDownTimer <= 0 then
					self.isCountingDown = false;
					self:Hide();
				end
			end
		end
	);
	dropMenu2:SetScript("OnHide", function(self)
			self.isCountingDown = false;
		end
	);
	dropMenu2.frame = frame;
	dropMenu2.parent = dropMenu
	button.dropMenu2 = dropMenu2;
	frame.dropMenu2 = dropMenu2;
	dropMenu.child = dropMenu2;
	dropMenu2.buttons = {};

	local dropMenu3 = CreateFrame("Button", nil, dropMenu2);
	dropMenu3:SetClampedToScreen(true);
	dropMenu3:Hide();
	dropMenu3:SetPoint("TOPLEFT", button, "BOTTOMLEFT", 0, -6);
	dropMenu3:SetPoint("TOPRIGHT", -6, -4);
	dropMenu3:SetBackdrop(dropMenuBackdrop);
	dropMenu3:SetBackdropColor(dropMenuBackdropColor[1], dropMenuBackdropColor[2], dropMenuBackdropColor[3], dropMenuBackdropColor[4]);
	dropMenu3:SetScript("OnClick", function(self, button)
			self:Hide();
		end
	);
	dropMenu3:SetScript("OnEnter", function(self)
			self.isCountingDown = false;
			self.parent.isCountingDown = false;
			self.parent.parent.isCountingDown = false;
		end
	);
	dropMenu3:SetScript("OnLeave", function(self)
			self.isCountingDown = true;
			self.countingDownTimer = COUNTING_DOWN_TIMER_PERIOD;
			self.parent.isCountingDown = true;
			self.parent.countingDownTimer = COUNTING_DOWN_TIMER_PERIOD;
			self.parent.parent.isCountingDown = true;
			self.parent.parent.countingDownTimer = COUNTING_DOWN_TIMER_PERIOD;
		end
	);
	dropMenu3:SetScript("OnUpdate", function(self, elasped)
			if self:IsShown() and self.isCountingDown then
				self.countingDownTimer = self.countingDownTimer - elasped;
				if self.countingDownTimer <= 0 then
					self.isCountingDown = false;
					self:Hide();
				end
			end
		end
	);
	dropMenu3:SetScript("OnHide", function(self)
			self.isCountingDown = false;
		end
	);
	dropMenu3.frame = frame;
	dropMenu3.parent = dropMenu2;
	button.dropMenu3 = dropMenu3;
	frame.dropMenu3 = dropMenu3;
	dropMenu2.child = dropMenu3;
	dropMenu3.buttons = {};
end
