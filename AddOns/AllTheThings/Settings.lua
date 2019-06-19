--------------------------------------------------------------------------------
--                        A L L   T H E   T H I N G S                         --
--------------------------------------------------------------------------------
--				Copyright 2017-2019 Dylan Fortune (Crieve-Sargeras)           --
--------------------------------------------------------------------------------
local app = AllTheThings;
local L = app.L;

-- Binding Localizations
BINDING_HEADER_ALLTHETHINGS = L["TITLE"];
BINDING_NAME_ALLTHETHINGS_TOGGLEACCOUNTMODE = L["TOGGLE_ACCOUNT_MODE"];
BINDING_NAME_ALLTHETHINGS_TOGGLECOMPLETIONISTMODE = L["TOGGLE_COMPLETIONIST_MODE"];
BINDING_NAME_ALLTHETHINGS_TOGGLEDEBUGMODE = L["TOGGLE_DEBUG_MODE"];

BINDING_HEADER_ALLTHETHINGS_PREFERENCES = L["PREFERENCES"];
BINDING_NAME_ALLTHETHINGS_TOGGLECOMPLETEDTHINGS = L["TOGGLE_COMPLETEDTHINGS"];
BINDING_NAME_ALLTHETHINGS_TOGGLECOMPLETEDGROUPS = L["TOGGLE_COMPLETEDGROUPS"];
BINDING_NAME_ALLTHETHINGS_TOGGLECOLLECTEDTHINGS = L["TOGGLE_COLLECTEDTHINGS"];
BINDING_NAME_ALLTHETHINGS_TOGGLEBOEITEMS = L["TOGGLE_BOEITEMS"];
BINDING_NAME_ALLTHETHINGS_TOGGLESOURCETEXT = L["TOGGLE_SOURCETEXT"];

BINDING_HEADER_ALLTHETHINGS_MODULES = L["MODULES"];
BINDING_NAME_ALLTHETHINGS_TOGGLEMAINLIST = L["TOGGLE_MAINLIST"];
BINDING_NAME_ALLTHETHINGS_TOGGLEMINILIST = L["TOGGLE_MINILIST"];
BINDING_NAME_ALLTHETHINGS_TOGGLE_PROFESSION_LIST = L["TOGGLE_PROFESSION_LIST"];
BINDING_NAME_ALLTHETHINGS_TOGGLE_RAID_ASSISTANT = L["TOGGLE_RAID_ASSISTANT"];
BINDING_NAME_ALLTHETHINGS_TOGGLE_WORLD_QUESTS_LIST = L["TOGGLE_WORLD_QUESTS_LIST"];
BINDING_NAME_ALLTHETHINGS_TOGGLERANDOM = L["TOGGLE_RANDOM"];
BINDING_NAME_ALLTHETHINGS_REROLL_RANDOM = L["REROLL_RANDOM"];

-- The Settings Frame
local settings = CreateFrame("FRAME", app:GetName() .. "-Settings", UIParent );
app.Settings = settings;
settings.name = app:GetName();
settings.MostRecentTab = nil;
settings.Tabs = {};
settings:SetBackdrop({
	bgFile = "Interface/RAIDFRAME/UI-RaidFrame-GroupBg", 
	edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
	tile = false, edgeSize = 16, 
	insets = { left = 4, right = 4, top = 4, bottom = 4 }
});
settings:SetBackdropColor(0, 0, 0, 1);
InterfaceOptions_AddCategory(settings);

-- Music / Sound Management (You can add your own sounds for this if you want.)
settings.AUDIO_COMPLETE_TABLE = {
	"Interface\\AddOns\\AllTheThings\\assets\\complete1.ogg",
};
settings.AUDIO_FANFARE_TABLE = {
	"Interface\\AddOns\\AllTheThings\\assets\\fanfare1.ogg",
	"Interface\\AddOns\\AllTheThings\\assets\\fanfare2.ogg",
	"Interface\\AddOns\\AllTheThings\\assets\\fanfare3.ogg",
	"Interface\\AddOns\\AllTheThings\\assets\\fanfare4.ogg",
	"Interface\\AddOns\\AllTheThings\\assets\\fanfare5.ogg",
	"Interface\\AddOns\\AllTheThings\\assets\\fanfare6.ogg",
};
settings.AUDIO_RAREFIND_TABLE = {
	"Interface\\AddOns\\AllTheThings\\assets\\rarefind1.ogg",
};
settings.AUDIO_REMOVE_TABLE = {
	"Interface\\AddOns\\AllTheThings\\assets\\remove1.ogg",
};

-- Settings Class
local GeneralSettingsBase = {
	__index = {
		["AccountMode"] = false,
		["Completionist"] = true,
		["MainOnly"] = false,
		["DebugMode"] = false,
		["AccountWide:Achievements"] = true,
		-- ["AccountWide:BattlePets"] = true,
		["AccountWide:FlightPaths"] = true,
		["AccountWide:Followers"] = true,
		-- ["AccountWide:Heirlooms"] = true,
		["AccountWide:Illusions"] = true,
		-- ["AccountWide:Mounts"] = true,
		["AccountWide:MusicRolls"] = true,
		-- ["AccountWide:Quests"] = false,
		["AccountWide:Recipes"] = true,
		["AccountWide:Reputations"] = true,
		["AccountWide:SelfieFilters"] = true,
		["AccountWide:Titles"] = true,
		-- ["AccountWide:Toys"] = true,
		-- ["AccountWide:Transmog"] = true,
		["Thing:Achievements"] = true,
		["Thing:BattlePets"] = true,
		["Thing:FlightPaths"] = true,
		["Thing:Followers"] = true,
		["Thing:Heirlooms"] = true,
		["Thing:Illusions"] = true,
		["Thing:Mounts"] = true,
		["Thing:MusicRolls"] = true,
		["Thing:Quests"] = false,
		["Thing:Recipes"] = true,
		["Thing:Reputations"] = true,
		["Thing:SelfieFilters"] = true,
		["Thing:Titles"] = true,
		["Thing:Toys"] = true,
		["Thing:Transmog"] = true,
		["Show:CompletedGroups"] = false,
		["Show:CollectedThings"] = false,
	},
};
local FilterSettingsBase = {
	__index = {
		
	},
};
local TooltipSettingsBase = {
	__index = {
		["Auto:MiniList"] = true,
		["Auto:ProfessionList"] = true,
		["Celebrate"] = true,
		["ClassRequirements"] = true,
		["Descriptions"] = true,
		["DisplayInCombat"] = true,
		["Enabled"] = true,
		["Expand:Difficulty"] = true,
		["IncludeOriginalSource"] = true,
		["LootSpecializations"] = true,
		["MinimapButton"] = true,
		["MinimapSize"] = 36,
		["MinimapStyle"] = true,
		["Models"] = true,
		["LiveScan"] = false,
		["Locations"] = 5,
		["Precision"] = 2,
		["Progress"] = true,
		["QuestGivers"] = true,
		["RaceRequirements"] = true,
		["Report:Collected"] = true,
		["ShowIconOnly"] = false,
		["SharedAppearances"] = true,
		["SourceLocations"] = true,
		["SourceLocations:Completed"] = true,
		["SourceLocations:Creatures"] = true,
		["SourceLocations:Things"] = true,
		["SpecializationRequirements"] = true,
		["SummarizeThings"] = true,
		["Warn:Difficulty"] = false,
		["Warn:Removed"] = true,
	},
};
local OnClickForTab = function(self)
	local id = self:GetID();
	local parent = self:GetParent();
	PanelTemplates_SetTab(parent, id);
	-- print("CLICKED TAB", id, self:GetText());
	for i,tab in ipairs(parent.Tabs) do
		if i == id then
			for j,o in ipairs(tab.objects) do
				o:Show();
			end
		else
			for j,o in ipairs(tab.objects) do
				o:Hide();
			end
		end
	end
end;
settings.Initialize = function(self)
	PanelTemplates_SetNumTabs(self, #self.Tabs);
	
	-- Assign the default settings
	if not AllTheThingsSettings then AllTheThingsSettings = {}; end
	if not AllTheThingsSettings.General then AllTheThingsSettings.General = {}; end
	if not AllTheThingsSettings.Tooltips then AllTheThingsSettings.Tooltips = {}; end
	setmetatable(AllTheThingsSettings.General, GeneralSettingsBase);
	setmetatable(AllTheThingsSettings.Tooltips, TooltipSettingsBase);
	
	-- Assign the preset filters for your character class as the default states
	if not AllTheThingsSettingsPerCharacter then AllTheThingsSettingsPerCharacter = {}; end
	if not AllTheThingsSettingsPerCharacter.Filters then AllTheThingsSettingsPerCharacter.Filters = {}; end
	setmetatable(AllTheThingsSettingsPerCharacter.Filters, FilterSettingsBase);
	FilterSettingsBase.__index = app.Presets[app.Class];
	
	self.LocationsSlider:SetValue(self:GetTooltipSetting("Locations"));
	self.PrecisionSlider:SetValue(self:GetTooltipSetting("Precision"));
	self.MinimapButtonSizeSlider:SetValue(self:GetTooltipSetting("MinimapSize"));
	if self:GetTooltipSetting("MinimapButton") then
		if not app.Minimap then app.Minimap = app.CreateMinimapButton(); end
		app.Minimap:Show();
	elseif app.Minimap then
		app.Minimap:Hide();
	end
	OnClickForTab(self.Tabs[1]);
	self:Refresh();
	self:UpdateMode();
	
	if self:GetTooltipSetting("Auto:MainList") then
		app:OpenMainList();
	end
	if self:GetTooltipSetting("Auto:RaidAssistant") then
		app:GetWindow("RaidAssistant"):Show();
	end
	if self:GetTooltipSetting("Auto:WorldQuestsList") then
		app:GetWindow("WorldQuests"):Show();
	end
end
settings.Get = function(self, setting)
	return AllTheThingsSettings.General[setting];
end
settings.GetFilter = function(self, filterID)
	return AllTheThingsSettingsPerCharacter.Filters[filterID];
end
settings.GetModeString = function(self)
	local mode = "Mode";
	if settings:Get("Thing:Transmog") or settings:Get("DebugMode") then
		if self:Get("Completionist") then
			mode = "Completionist " .. mode;
		else
			mode = "Unique Appearance " .. mode;
		end
	end
	if self:Get("DebugMode") then
		mode = "Debug " .. mode;
	else
		if self:Get("AccountMode") then
			mode = "Account " .. mode;
		elseif self:Get("MainOnly") and not self:Get("Completionist") then
			mode = mode .. " (Main Only)";
		end
		
		local things = {};
		local thingCount = 0;
		local totalThingCount = 0;
		for key,_ in pairs(GeneralSettingsBase.__index) do
			if string.sub(key, 1, 6) == "Thing:" then
				totalThingCount = totalThingCount + 1;
				if settings:Get(key) then
					thingCount = thingCount + 1;
					table.insert(things, string.sub(key, 7));
				end
			end
		end
		if thingCount == 0 then
			mode = "None of the Things " .. mode;
		elseif thingCount == 1 then
			mode = things[1] .. " Only " .. mode;
		elseif thingCount == 2 then
			mode = things[1] .. " + " .. things[2] .. " Only " .. mode;
		elseif thingCount == totalThingCount then
			mode = "Insane " .. mode;
		elseif not settings:Get("Thing:Transmog") then
			mode = "Some of the Things " .. mode;
		end
	end
	if self:Get("Filter:ByLevel") then
		mode = "Level " .. app.Level .. " " .. mode;
	end
	return mode;
end
settings.GetPersonal = function(self, setting)
	return AllTheThingsSettingsPerCharacter[setting];
end
settings.GetTooltipSetting = function(self, setting)
	return AllTheThingsSettings.Tooltips[setting];
end
settings.Set = function(self, setting, value)
	AllTheThingsSettings.General[setting] = value;
	self:Refresh();
end
settings.SetFilter = function(self, filterID, value)
	AllTheThingsSettingsPerCharacter.Filters[filterID] = value;
	self:Refresh();
	app:RefreshData();
end
settings.SetTooltipSetting = function(self, setting, value)
	AllTheThingsSettings.Tooltips[setting] = value;
	wipe(app.searchCache);
	self:Refresh();
end
settings.SetPersonal = function(self, setting, value)
	AllTheThingsSettingsPerCharacter[setting] = value;
	self:Refresh();
end
settings.Refresh = function(self)
	for i,tab in ipairs(self.Tabs) do
		if tab.OnRefresh then tab:OnRefresh(); end
		for j,o in ipairs(tab.objects) do
			if o.OnRefresh then o:OnRefresh(); end
		end
	end
end
settings.CreateCheckBox = function(self, text, OnRefresh, OnClick)
	local cb = CreateFrame("CheckButton", self:GetName() .. "-" .. text, self, "InterfaceOptionsCheckButtonTemplate");
	table.insert(self.MostRecentTab.objects, cb);
	cb:SetScript("OnClick", OnClick);
	cb.OnRefresh = OnRefresh;
	cb.Text:SetText(text);
	return cb;
end
settings.CreateTab = function(self, text)
	local id = #self.Tabs + 1;
	local tab = CreateFrame('Button', self:GetName() .. '-Tab' .. id, self, 'OptionsFrameTabButtonTemplate');
	if id > 1 then tab:SetPoint("TOPLEFT", self.Tabs[id - 1], "TOPRIGHT", 0, 0); end
	table.insert(self.Tabs, tab);
	self.MostRecentTab = tab;
	tab.objects = {};
	tab:SetID(id);
	tab:SetText(text);
	PanelTemplates_TabResize(tab, 0);
	tab:SetScript('OnClick', OnClickForTab);
	return tab;
end
settings.ShowCopyPasteDialog = function(self)
	app:ShowPopupDialogWithEditBox(nil, self:GetText());
end

settings.SetAccountMode = function(self, accountMode)
	self:Set("AccountMode", accountMode);
	self:UpdateMode();
	app:RefreshData();
end
settings.ToggleAccountMode = function(self)
	self:SetAccountMode(not self:Get("AccountMode"));
end
settings.SetCompletionistMode = function(self, completionistMode)
	self:Set("Completionist", completionistMode);
	self:UpdateMode();
	wipe(app.GetDataMember("CollectedSources"));
	app.RefreshCollections();
end
settings.ToggleCompletionistMode = function(self)
	self:SetCompletionistMode(not self:Get("Completionist"));
end
settings.SetDebugMode = function(self, debugMode)
	self:Set("DebugMode", debugMode);
	self:UpdateMode();
	if debugMode and not self:Get("Thing:Transmog") then
		wipe(app.GetDataMember("CollectedSources"));
		app.RefreshCollections();
	end
	app:RefreshData();
end
settings.ToggleDebugMode = function(self)
	self:SetDebugMode(not self:Get("DebugMode"));
end
settings.SetMainOnlyMode = function(self, mainOnly)
	self:Set("MainOnly", mainOnly);
	self:SetCompletionistMode(self:Get("Completionist"));
end
settings.ToggleMainOnlyMode = function(self)
	self:SetMainOnlyMode(not self:Get("MainOnly"));
end
settings.SetCompletedThings = function(self, checked)
	self:Set("Show:CompletedGroups", checked);
	self:Set("Show:CollectedThings", checked);
	self:UpdateMode();
	app:RefreshData();
end
settings.ToggleCompletedThings = function(self)
	self:SetCompletedThings(not self:Get("Show:CompletedGroups"));
end
settings.SetCompletedGroups = function(self, checked)
	self:Set("Show:CompletedGroups", checked);
	self:UpdateMode();
	app:RefreshData();
end
settings.ToggleCompletedGroups = function(self)
	self:SetCompletedGroups(not self:Get("Show:CompletedGroups"));
end
settings.SetCollectedThings = function(self, checked)
	self:Set("Show:CollectedThings", checked);
	self:UpdateMode();
	app:RefreshData();
end
settings.ToggleCollectedThings = function(self)
	settings:SetCollectedThings(not self:Get("Show:CollectedThings", checked));
end
settings.SetHideBOEItems = function(self, checked)
	self:Set("Hide:BoEs", checked);
	if checked then
		app.RequireBindingFilter = app.FilterItemClass_RequireBinding;
	else
		app.RequireBindingFilter = app.NoFilter;
	end
	app:RefreshData();
end
settings.ToggleBOEItems = function(self)
	self:SetHideBOEItems(not self:Get("Hide:BoEs"));
end
settings.UpdateMode = function(self)
	if self:Get("Completionist") then
		app.ItemSourceFilter = app.FilterItemSource;
		app.ActiveItemCollectionHelper = app.CompletionistItemCollectionHelper;
		app.ActiveItemRemovalHelper = app.CompletionistItemRemovalHelper;
	else
		if self:Get("MainOnly") and not self:Get("AccountMode") and not self:Get("DebugMode") then
			app.ItemSourceFilter = app.FilterItemSourceUniqueOnlyMain;
			app.ActiveItemCollectionHelper = app.UniqueModeItemCollectionHelperOnlyMain;
			app.ActiveItemRemovalHelper = app.UniqueModeItemRemovalHelperOnlyMain;
		else
			app.ItemSourceFilter = app.FilterItemSourceUnique;
			app.ActiveItemCollectionHelper = app.UniqueModeItemCollectionHelper;
			app.ActiveItemRemovalHelper = app.UniqueModeItemRemovalHelper;
		end
	end
	if self:Get("DebugMode") then
		app.GroupFilter = app.NoFilter;
		app.SeasonalItemFilter = app.NoFilter;
		app.UnobtainableItemFilter = app.NoFilter;
		app.VisibilityFilter = app.NoFilter;
		
		app.AccountWideAchievements = true;
		app.AccountWideBattlePets = true;
		app.AccountWideFlightPaths = true;
		app.AccountWideFollowers = true;
		app.AccountWideIllusions = true;
		app.AccountWideMounts = true;
		app.AccountWideMusicRolls = true;
		app.AccountWideQuests = true;
		app.AccountWideRecipes = true;
		app.AccountWideReputations = true;
		app.AccountWideSelfieFilters = true;
		app.AccountWideTitles = true;
		app.AccountWideToys = true;
		app.AccountWideTransmog = true;
		
		app.CollectibleAchievements = true;
		app.CollectibleBattlePets = true;
		app.CollectibleFlightPaths = true;
		app.CollectibleFollowers = true;
		app.CollectibleHeirlooms = true;
		app.CollectibleIllusions = true;
		app.CollectibleMounts = true;
		app.CollectibleMusicRolls = true;
		app.CollectibleQuests = true;
		app.CollectibleRecipes = true;
		app.CollectibleReputations = true;
		app.CollectibleSelfieFilters = true;
		app.CollectibleTitles = true;
		app.CollectibleToys = true;
		app.CollectibleTransmog = true;
	else
		app.VisibilityFilter = app.ObjectVisibilityFilter;
		app.GroupFilter = app.FilterItemClass;
		if app.GetDataMember("FilterSeasonal") then
			app.SeasonalItemFilter = app.FilterItemClass_SeasonalItem;
		else
			app.SeasonalItemFilter = app.NoFilter;
		end
		if app.GetDataMember("FilterUnobtainableItems") then
			app.UnobtainableItemFilter = app.FilterItemClass_UnobtainableItem;
		else
			app.UnobtainableItemFilter = app.NoFilter;
		end
		
		app.AccountWideAchievements = self:Get("AccountWide:Achievements");
		app.AccountWideBattlePets = self:Get("AccountWide:BattlePets");
		app.AccountWideFlightPaths = self:Get("AccountWide:FlightPaths");
		app.AccountWideFollowers = self:Get("AccountWide:Followers");
		app.AccountWideIllusions = self:Get("AccountWide:Illusions");
		app.AccountWideMounts = self:Get("AccountWide:Mounts");
		app.AccountWideMusicRolls = self:Get("AccountWide:MusicRolls");
		app.AccountWideQuests = self:Get("AccountWide:Quests");
		app.AccountWideRecipes = self:Get("AccountWide:Recipes");
		app.AccountWideReputations = self:Get("AccountWide:Reputations");
		app.AccountWideSelfieFilters = self:Get("AccountWide:SelfieFilters");
		app.AccountWideTitles = self:Get("AccountWide:Titles");
		app.AccountWideToys = self:Get("AccountWide:Toys");
		app.AccountWideTransmog = self:Get("AccountWide:Transmog");
		
		app.CollectibleAchievements = self:Get("Thing:Achievements");
		app.CollectibleBattlePets = self:Get("Thing:BattlePets");
		app.CollectibleFlightPaths = self:Get("Thing:FlightPaths");
		app.CollectibleFollowers = self:Get("Thing:Followers");
		app.CollectibleHeirlooms = self:Get("Thing:Heirlooms");
		app.CollectibleIllusions = self:Get("Thing:Illusions");
		app.CollectibleMounts = self:Get("Thing:Mounts");
		app.CollectibleMusicRolls = self:Get("Thing:MusicRolls");
		app.CollectibleQuests = self:Get("Thing:Quests");
		app.CollectibleRecipes = self:Get("Thing:Recipes");
		app.CollectibleReputations = self:Get("Thing:Reputations");
		app.CollectibleSelfieFilters = self:Get("Thing:SelfieFilters");
		app.CollectibleTitles = self:Get("Thing:Titles");
		app.CollectibleToys = self:Get("Thing:Toys");
		app.CollectibleTransmog = self:Get("Thing:Transmog");
	end
	if self:Get("AccountMode") then
		app.ItemTypeFilter = app.NoFilter;
		app.ClassRequirementFilter = app.NoFilter;
		app.RaceRequirementFilter = app.NoFilter;
		app.RequiredSkillFilter = app.NoFilter;
	else
		app.ItemTypeFilter = app.FilterItemClass_RequireItemFilter;
		app.ClassRequirementFilter = app.FilterItemClass_RequireClasses;
		app.RaceRequirementFilter = app.FilterItemClass_RequireRaces;
		app.RequiredSkillFilter = app.FilterItemClass_RequiredSkill;
	end
	if self:Get("Show:CompletedGroups") or self:Get("DebugMode") then
		app.GroupVisibilityFilter = app.NoFilter;
	else
		app.GroupVisibilityFilter = app.FilterGroupsByCompletion;
	end
	if self:Get("Show:CollectedThings") or self:Get("DebugMode") then
		app.CollectedItemVisibilityFilter = app.NoFilter;
	else
		app.CollectedItemVisibilityFilter = app.Filter;
	end
	if self:Get("Show:IncompleteThings") then
		app.ShowIncompleteThings = app.FilterItemTrackable;
	else
		app.ShowIncompleteThings = app.Filter;
	end
	if self:Get("AccountWide:Achievements") then
		app.AchievementFilter = 4;
	else
		app.AchievementFilter = 13;
	end
	if self:Get("AccountWide:Recipes") then
		app.RecipeChecker = app.GetDataSubMember;
	else
		app.RecipeChecker = app.GetTempDataSubMember;
	end
	
	if self:Get("Filter:BoEs") then
		app.ItemBindFilter = app.FilterItemBind;
	else
		app.ItemBindFilter = app.Filter;
	end
	if self:Get("Hide:BoEs") then
		app.RequireBindingFilter = app.FilterItemClass_RequireBinding;
	else
		app.RequireBindingFilter = app.NoFilter;
	end
	app:UnregisterEvent("PLAYER_LEVEL_UP");
	if self:Get("Filter:ByLevel") then
		app:RegisterEvent("PLAYER_LEVEL_UP");
		app.GroupRequirementsFilter = app.FilterGroupsByLevel;
	else
		app.GroupRequirementsFilter = app.NoFilter;
	end
	app:UnregisterEvent("TAXIMAP_OPENED");
	if self:Get("Thing:FlightPaths") or self:Get("DebugMode") then
		app:RegisterEvent("TAXIMAP_OPENED");
	end
end

-- The ALL THE THINGS Epic Logo!
local f = settings:CreateTexture(nil, "ARTWORK");
f:SetATTSprite("base_36x36", 429, 141, 36, 36, 512, 256);
f:SetPoint("TOPLEFT", settings, "TOPLEFT", 8, -8);
f:SetSize(36, 36);
f:Show();
settings.logo = f;

f = settings:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
f:SetPoint("TOPLEFT", settings.logo, "TOPRIGHT", 4, -4);
f:SetJustifyH("LEFT");
f:SetText(L["TITLE"]);
f:SetScale(1.5);
f:Show();
settings.title = f;

f = settings:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
f:SetPoint("TOPRIGHT", settings, "TOPRIGHT", -8, -8);
f:SetJustifyH("RIGHT");
f:SetText("v" .. GetAddOnMetadata("AllTheThings", "Version"));
f:Show();
settings.version = f;

f = CreateFrame("Button", nil, settings, "OptionsButtonTemplate");
f:SetPoint("TOPLEFT", settings, "BOTTOMLEFT", 0, -6);
f:SetText("https://www.twitch.tv/dfortun81");
f:SetWidth(230);
f:SetHeight(30);
f:RegisterForClicks("AnyUp");
f:SetScript("OnClick", settings.ShowCopyPasteDialog);
f:SetATTTooltip("单击按钮复制url到我的Twitch Channel.\n\n可以在我直播的时候问问题，我会尽力回答!");
settings.twitch = f;

f = CreateFrame("Button", nil, settings, "OptionsButtonTemplate");
f:SetPoint("TOPLEFT", settings.twitch, "TOPRIGHT", 4, 0);
f:SetText("https://discord.gg/9GFDsgy");
f:SetWidth(200);
f:SetHeight(30);
f:RegisterForClicks("AnyUp");
f:SetScript("OnClick", settings.ShowCopyPasteDialog);
f:SetATTTooltip("单击按钮复制url到ALL THE THINGS Discord.\n\n可以与其他收藏家分享进步/挫折!");
settings.community = f;

------------------------------------------
-- The "General" Tab.					--
------------------------------------------
local line;
(function()
local tab = settings:CreateTab("常规");
tab:SetPoint("TOPLEFT", settings.logo, "BOTTOMRIGHT", 16, 0);
line = settings:CreateTexture(nil, "ARTWORK");
line:SetPoint("LEFT", settings, "LEFT", 4, 0);
line:SetPoint("RIGHT", settings, "RIGHT", -4, 0);
line:SetPoint("TOP", settings.Tabs[1], "BOTTOM", 0, 0);
line:SetColorTexture(1, 1, 1, 0.4);
line:SetHeight(2);

local ModeLabel = settings:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
ModeLabel:SetPoint("TOPLEFT", line, "BOTTOMLEFT", 8, -8);
ModeLabel:SetJustifyH("LEFT");
ModeLabel:Show();
table.insert(settings.MostRecentTab.objects, ModeLabel);
ModeLabel.OnRefresh = function(self)
	self:SetText(settings:GetModeString());
end;

local DebugModeCheckBox = settings:CreateCheckBox("|Cff15abff调试模式|r (展示所有事)",
function(self)
	self:SetChecked(settings:Get("DebugMode"));
end,
function(self)
	settings:SetDebugMode(self:GetChecked());
end);
DebugModeCheckBox:SetATTTooltip("字面意思是…游戏中的所有事情. PERIOD. DOT. 是的, 所有的一切. 即使是不可回收的物品，如袋子、消耗品、试剂等也会出现在清单中. (甚至你自己! 不, 真的. 看.)\n\n这仅用于调试目的. 不用于完成跟踪.\n\n此模式绕过所有过滤器, 包括不可获得的.");
DebugModeCheckBox:SetPoint("TOPLEFT", ModeLabel, "BOTTOMLEFT", 0, -8);

local CompletionistModeCheckBox = settings:CreateCheckBox("|CFFADD8E6完美主义模式|r (All Sources)",
function(self)
	self:SetChecked(settings:Get("Completionist"));
	if not settings:Get("Thing:Transmog") and not settings:Get("DebugMode") and not settings:Get("AccountMode") then
		self:Disable();
		self:SetAlpha(0.2);
	else
		self:Enable();
		self:SetAlpha(1);
	end
end,
function(self)
	settings:SetCompletionistMode(self:GetChecked());
end);
CompletionistModeCheckBox:SetATTTooltip("如果您希望ATT标记符合“已收集”相同解锁要求的共享外观，请关闭此设置.\n\n通过此模式“收集”的项目将用星号标记(*). 这意味着还没有收集到外观的特定来源.");
CompletionistModeCheckBox:SetPoint("TOPLEFT", DebugModeCheckBox, "BOTTOMLEFT", 0, 4);

local MainOnlyModeCheckBox = settings:CreateCheckBox(L["I_ONLY_CARE_ABOUT_MY_MAIN"],
function(self)
	self:SetChecked(settings:Get("MainOnly"));
	if settings:Get("Completionist") or settings:Get("AccountMode") or settings:Get("DebugMode") then
		self:Disable();
		self:SetAlpha(0.2);
	else
		self:Enable();
		self:SetAlpha(1);
	end
end,
function(self)
	settings:SetMainOnlyMode(self:GetChecked());
end);
MainOnlyModeCheckBox:SetATTTooltip("如果您还想让att*假装*您赢得了所有未被其他种族或职业锁定的共享外观，请启用此设置.\n\n例如，如果您从ICC收集了一个仅限猎人使用的等级，并且在没有等级/种族限制的情况下，有一个来自突袭的共享外观，那么ATT将*假装*您也获得了该外观的来源.\n\n注意: 以这种方式解锁时，切换到其他种族/职业将错误地报告您已经获得了尚未为新角色收集的外观源.");
MainOnlyModeCheckBox:SetPoint("TOPLEFT", CompletionistModeCheckBox, "BOTTOMLEFT", 4, 4);

local AccountModeCheckBox = settings:CreateCheckBox("|Cff00ab00战网模式|r (All Characters)",
function(self)
	self:SetChecked(settings:Get("AccountMode"));
	if settings:Get("DebugMode") then
		self:Disable();
		self:SetAlpha(0.2);
	else
		self:Enable();
		self:SetAlpha(1);
	end
end,
function(self)
	settings:SetAccountMode(self:GetChecked());
end);
AccountModeCheckBox:SetATTTooltip("如果要跟踪所有角色的所有内容，而不考虑职业和种族筛选器，请启用此设置.\n\n不可获得的过滤器仍然适用.");
AccountModeCheckBox:SetPoint("TOPLEFT", MainOnlyModeCheckBox, "BOTTOMLEFT", -5, 4);



-- This creates the "Precision" slider.
local PrecisionSlider = CreateFrame("Slider", "ATTPrecisionSlider", settings, "OptionsSliderTemplate");
PrecisionSlider:SetPoint("RIGHT", settings, "RIGHT", -20, 0);
PrecisionSlider:SetPoint("TOP", ModeLabel, "BOTTOM", 0, -12);
table.insert(settings.MostRecentTab.objects, PrecisionSlider);
settings.PrecisionSlider = PrecisionSlider;
PrecisionSlider.tooltipText = '使用此选项可自定义百分比计算中所需的精度级别.\n\n默认: 2';
PrecisionSlider:SetOrientation('HORIZONTAL');
PrecisionSlider:SetWidth(260);
PrecisionSlider:SetHeight(20);
PrecisionSlider:SetValueStep(1);
PrecisionSlider:SetMinMaxValues(0, 8);
PrecisionSlider:SetObeyStepOnDrag(true);
_G[PrecisionSlider:GetName() .. 'Low']:SetText('0')
_G[PrecisionSlider:GetName() .. 'High']:SetText('8')
_G[PrecisionSlider:GetName() .. 'Text']:SetText("百分比的精确度")
PrecisionSlider.Label = PrecisionSlider:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall");
PrecisionSlider.Label:SetPoint("TOP", PrecisionSlider, "BOTTOM", 0, 0);
PrecisionSlider.Label:SetText(PrecisionSlider:GetValue());
PrecisionSlider:SetScript("OnValueChanged", function(self, newValue)
	self.Label:SetText(newValue);
	if newValue == settings:GetTooltipSetting("Precision") then
		return 1;
	end
	settings:SetTooltipSetting("Precision", newValue)
	app:UpdateWindows();
end);

-- This creates the "Minimap Button Size" slider.
local MinimapButtonSizeSlider = CreateFrame("Slider", "ATTMinimapButtonSizeSlider", settings, "OptionsSliderTemplate");
MinimapButtonSizeSlider:SetPoint("RIGHT", settings, "RIGHT", -20, 0);
MinimapButtonSizeSlider:SetPoint("TOP", PrecisionSlider, "BOTTOM", 0, -28);
table.insert(settings.MostRecentTab.objects, MinimapButtonSizeSlider);
settings.MinimapButtonSizeSlider = MinimapButtonSizeSlider;
MinimapButtonSizeSlider.tooltipText = '使用此选项可自定义迷你地图按钮的大小.\n\n默认: 36';
MinimapButtonSizeSlider:SetOrientation('HORIZONTAL');
MinimapButtonSizeSlider:SetWidth(260);
MinimapButtonSizeSlider:SetHeight(20);
MinimapButtonSizeSlider:SetValueStep(1);
MinimapButtonSizeSlider:SetMinMaxValues(18, 48);
MinimapButtonSizeSlider:SetObeyStepOnDrag(true);
_G[MinimapButtonSizeSlider:GetName() .. 'Low']:SetText('18')
_G[MinimapButtonSizeSlider:GetName() .. 'High']:SetText('48')
_G[MinimapButtonSizeSlider:GetName() .. 'Text']:SetText("迷你地图按钮的大小")
MinimapButtonSizeSlider.Label = MinimapButtonSizeSlider:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall");
MinimapButtonSizeSlider.Label:SetPoint("TOP", MinimapButtonSizeSlider, "BOTTOM", 0, 0);
MinimapButtonSizeSlider.Label:SetText(MinimapButtonSizeSlider:GetValue());
MinimapButtonSizeSlider:SetScript("OnValueChanged", function(self, newValue)
	self.Label:SetText(newValue);
	if newValue == settings:GetTooltipSetting("MinimapSize") then
		return 1;
	end
	settings:SetTooltipSetting("MinimapSize", newValue)
	if app.Minimap then app.Minimap:SetSize(newValue, newValue); end
end);

local ShowMinimapButtonCheckBox = settings:CreateCheckBox("显示尼米地图按钮",
function(self)
	self:SetChecked(settings:GetTooltipSetting("MinimapButton"));
end,
function(self)
	settings:SetTooltipSetting("MinimapButton", self:GetChecked());
	if self:GetChecked() then
		if not app.Minimap then app.Minimap = app.CreateMinimapButton(); end
		app.Minimap:Show();
	elseif app.Minimap then
		app.Minimap:Hide();
	end
end);
ShowMinimapButtonCheckBox:SetATTTooltip("如果要查看小地图按钮，请启用此选项. 使用此按钮可以快速访问主列表，显示总体收集进度，并通过右键单击访问“设置菜单”.\n\n有些人不喜欢混乱. 或者，您可以通过在聊天框中键入“/ att”来访问主列表. 从那里，您可以右键单击标题以进入“设置”菜单.");
ShowMinimapButtonCheckBox:SetPoint("TOP", MinimapButtonSizeSlider, "BOTTOM", 0, -12);
ShowMinimapButtonCheckBox:SetPoint("RIGHT", settings, "RIGHT", -228, 0);

local MinimapButtonStyleCheckBox = settings:CreateCheckBox("使用旧的迷你地图样式",
function(self)
	self:SetChecked(settings:GetTooltipSetting("MinimapStyle"));
end,
function(self)
	settings:SetTooltipSetting("MinimapStyle", self:GetChecked());
	if app.Minimap then app.Minimap:UpdateStyle(); end
end);
MinimapButtonStyleCheckBox:SetATTTooltip("有些人不喜欢新的小地图按钮...\n\n那些人错了!\n\n如果你不喜欢它，这里可以选择回到旧式.");
MinimapButtonStyleCheckBox:SetPoint("TOP", ShowMinimapButtonCheckBox, "BOTTOM", 0, 4);
MinimapButtonStyleCheckBox:SetPoint("RIGHT", settings, "RIGHT", -228, 0);



local ThingsLabel = settings:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
ThingsLabel:SetPoint("TOPLEFT", AccountModeCheckBox, "BOTTOMLEFT", 0, -8);
ThingsLabel:SetJustifyH("LEFT");
ThingsLabel:SetText("您要跟踪哪些“事物”?");
ThingsLabel:Show();
table.insert(settings.MostRecentTab.objects, ThingsLabel);
ThingsLabel.OnRefresh = function(self)
	if settings:Get("DebugMode") then
		self:SetAlpha(0.2);
	else
		self:SetAlpha(1);
	end
end;

local AchievementsCheckBox = settings:CreateCheckBox("成就",
function(self)
	self:SetChecked(settings:Get("Thing:Achievements"));
	if settings:Get("DebugMode") then
		self:Disable();
		self:SetAlpha(0.2);
	else
		self:Enable();
		self:SetAlpha(1);
	end
end,
function(self)
	settings:Set("Thing:Achievements", self:GetChecked());
	settings:UpdateMode();
	app:RefreshData();
end);
AchievementsCheckBox:SetATTTooltip("启用此选项可跟踪成就.");
AchievementsCheckBox:SetPoint("TOPLEFT", ThingsLabel, "BOTTOMLEFT", 0, -8);

local AchievementsAccountWideCheckBox = settings:CreateCheckBox("战网范围",
function(self)
	self:SetChecked(settings:Get("AccountWide:Achievements"));
	if settings:Get("DebugMode") or not settings:Get("Thing:Achievements") then
		self:Disable();
		self:SetAlpha(0.2);
	else
		self:Enable();
		self:SetAlpha(1);
	end
end,
function(self)
	settings:Set("AccountWide:Achievements", self:GetChecked());
	settings:UpdateMode();
	app:RefreshData();
end);
AchievementsAccountWideCheckBox:SetATTTooltip("成就跟踪通常是广泛的，但有一些专属于特定职业和种族的成就，你无法在你的主要成就.");
AchievementsAccountWideCheckBox:SetPoint("TOPLEFT", AchievementsCheckBox, "TOPLEFT", 220, 0);

local TransmogCheckBox = settings:CreateCheckBox("外形 / 幻化",
function(self)
	self:SetChecked(settings:Get("Thing:Transmog"));
	if settings:Get("DebugMode") then
		self:Disable();
		self:SetAlpha(0.2);
	else
		self:Enable();
		self:SetAlpha(1);
	end
end,
function(self)
	settings:Set("Thing:Transmog", self:GetChecked());
	settings:UpdateMode();
	if self:GetChecked() then
		wipe(app.GetDataMember("CollectedSources"));
		app.RefreshCollections();
	end
	app:RefreshData();
end);
TransmogCheckBox:SetATTTooltip("启用此选项可跟踪外观获取.\n\n注意: 禁用此选项也会禁用所有采集逻辑，您可以使用此切换来防止在执行重要组内容时出现延迟，请牢记，重新启用后将需要进行计算.\n\n默认情况下跟踪战网范围.");
TransmogCheckBox:SetPoint("TOPLEFT", AchievementsCheckBox, "BOTTOMLEFT", 0, 4);

local TransmogAccountWideCheckBox = settings:CreateCheckBox("战网范围",
function(self)
	self:SetChecked(true);
	self:Disable();
	self:SetAlpha(0.2);
end,
function(self)
	print("幻象外观仅在战网范围内进行跟踪，无法禁用.");
end);
TransmogAccountWideCheckBox:SetPoint("TOPLEFT", TransmogCheckBox, "TOPLEFT", 220, 0);

local BattlePetsCheckBox = settings:CreateCheckBox("战斗宠物 / 同伴",
function(self)
	self:SetChecked(settings:Get("Thing:BattlePets"));
	if settings:Get("DebugMode") then
		self:Disable();
		self:SetAlpha(0.2);
	else
		self:Enable();
		self:SetAlpha(1);
	end
end,
function(self)
	settings:Set("Thing:BattlePets", self:GetChecked());
	settings:UpdateMode();
	app:RefreshData();
end);
BattlePetsCheckBox:SetATTTooltip("启用此选项可跟踪战斗宠物和同伴. 这些可以在开放的世界中找到，也可以通过各种地下城和团本中的boss掉落，以及从供应商和声望获取.\n\n默认情况下跟踪战网范围.");
BattlePetsCheckBox:SetPoint("TOPLEFT", TransmogCheckBox, "BOTTOMLEFT", 0, 4);

local BattlePetsAccountWideCheckBox = settings:CreateCheckBox("战网范围",
function(self)
	self:SetChecked(true);
	self:Disable();
	self:SetAlpha(0.2);
end,
function(self)
	print("战斗宠物只在战网范围内被跟踪.");
end);
BattlePetsAccountWideCheckBox:SetPoint("TOPLEFT", BattlePetsCheckBox, "TOPLEFT", 220, 0);

local FlightPathsCheckBox = settings:CreateCheckBox("飞行路径 / 飞艇",
function(self)
	self:SetChecked(settings:Get("Thing:FlightPaths"));
	if settings:Get("DebugMode") then
		self:Disable();
		self:SetAlpha(0.2);
	else
		self:Enable();
		self:SetAlpha(1);
	end
end,
function(self)
	settings:Set("Thing:FlightPaths", self:GetChecked());
	settings:UpdateMode();
	app:RefreshData();
end);
FlightPathsCheckBox:SetATTTooltip("启用此选项以跟踪飞行路径和飞艇.\n\n要收集这些信息，请与每个大陆的飞行点/飞艇船长打开对话.\n\注意: 由于分阶段技术，您可能必须分阶段到区域的其他敌方，以获得这些兴趣点的开启.");
FlightPathsCheckBox:SetPoint("TOPLEFT", BattlePetsCheckBox, "BOTTOMLEFT", 0, 4);

local FlightPathsAccountWideCheckBox = settings:CreateCheckBox("战网范围",
function(self)
	self:SetChecked(settings:Get("AccountWide:FlightPaths"));
	if settings:Get("DebugMode") or not settings:Get("Thing:FlightPaths") then
		self:Disable();
		self:SetAlpha(0.2);
	else
		self:Enable();
		self:SetAlpha(1);
	end
end,
function(self)
	settings:Set("AccountWide:FlightPaths", self:GetChecked());
	settings:UpdateMode();
	app:RefreshData();
end);
FlightPathsAccountWideCheckBox:SetATTTooltip("飞行路径跟踪仅对每个角色非常有用，但是你真的想要在所有50个角色上收集它们吗?");
FlightPathsAccountWideCheckBox:SetPoint("TOPLEFT", FlightPathsCheckBox, "TOPLEFT", 220, 0);

local FollowersCheckBox = settings:CreateCheckBox("随从",
function(self)
	self:SetChecked(settings:Get("Thing:Followers"));
	if settings:Get("DebugMode") then
		self:Disable();
		self:SetAlpha(0.2);
	else
		self:Enable();
		self:SetAlpha(1);
	end
end,
function(self)
	settings:Set("Thing:Followers", self:GetChecked());
	settings:UpdateMode();
	app:RefreshData();
end);
FollowersCheckBox:SetATTTooltip("启用此选项可跟踪随从.\n\n即: 要塞随从, 德拉诺随从, BFA随从.");
FollowersCheckBox:SetPoint("TOPLEFT", FlightPathsCheckBox, "BOTTOMLEFT", 0, 4);

local FollowersAccountWideCheckBox = settings:CreateCheckBox("战网范围",
function(self)
	self:SetChecked(settings:Get("AccountWide:Followers"));
	if settings:Get("DebugMode") or not settings:Get("Thing:Followers") then
		self:Disable();
		self:SetAlpha(0.2);
	else
		self:Enable();
		self:SetAlpha(1);
	end
end,
function(self)
	settings:Set("AccountWide:Followers", self:GetChecked());
	settings:UpdateMode();
	app:RefreshData();
end);
FollowersAccountWideCheckBox:SetATTTooltip("随从通常是每个角色，但是你真的想以每周1个的速度在一个角色上收集243个随从吗?\n\n我想不行，好的先生.");
FollowersAccountWideCheckBox:SetPoint("TOPLEFT", FollowersCheckBox, "TOPLEFT", 220, 0);


local HeirloomsCheckBox = settings:CreateCheckBox("传家宝",
function(self)
	self:SetChecked(settings:Get("Thing:Heirlooms"));
	if settings:Get("DebugMode") then
		self:Disable();
		self:SetAlpha(0.2);
	else
		self:Enable();
		self:SetAlpha(1);
	end
end,
function(self)
	settings:Set("Thing:Heirlooms", self:GetChecked());
	settings:UpdateMode();
	app:RefreshData();
end);
HeirloomsCheckBox:SetATTTooltip("启用此选项可跟踪您是否已解锁传家宝及其各自的升级级别.\n\n具有相关外观的传家宝将通过外观过滤器进行过滤. (关闭外观仍将显示传家宝本身)");
HeirloomsCheckBox:SetPoint("TOPLEFT", FollowersCheckBox, "BOTTOMLEFT", 0, 4);

local HeirloomsAccountWideCheckBox = settings:CreateCheckBox("Account Wide",
function(self)
	self:SetChecked(true);
	self:Disable();
	self:SetAlpha(0.2);
end,
nil);
HeirloomsAccountWideCheckBox:SetATTTooltip("战网范围追踪传家宝.");
HeirloomsAccountWideCheckBox:SetPoint("TOPLEFT", HeirloomsCheckBox, "TOPLEFT", 220, 0);

local IllusionsCheckBox = settings:CreateCheckBox("幻象",
function(self)
	self:SetChecked(settings:Get("Thing:Illusions"));
	if settings:Get("DebugMode") then
		self:Disable();
		self:SetAlpha(0.2);
	else
		self:Enable();
		self:SetAlpha(1);
	end
end,
function(self)
	settings:Set("Thing:Illusions", self:GetChecked());
	settings:UpdateMode();
	app:RefreshData();
end);
IllusionsCheckBox:SetATTTooltip("启用此选项以跟踪幻象.\n\n这些看起来很酷的变形效果，你可以应用到你的武器上!\n\n注意: 你不是一个幻象，尽管你是一个彻夜不眠的人.\n\n默认情况下的跟踪战网范围.");
IllusionsCheckBox:SetPoint("TOPLEFT", HeirloomsCheckBox, "BOTTOMLEFT", 0, 4);

local IllusionsAccountWideCheckBox = settings:CreateCheckBox("战网范围",
function(self)
	self:SetChecked(settings:Get("AccountWide:Illusions"));
	self:Disable();
	self:SetAlpha(0.2);
end,
function(self)
	settings:Set("AccountWide:Illusions", self:GetChecked());
	settings:UpdateMode();
	app:RefreshData();
end);
IllusionsAccountWideCheckBox:SetPoint("TOPLEFT", IllusionsCheckBox, "TOPLEFT", 220, 0);

local MountsCheckBox = settings:CreateCheckBox("坐骑",
function(self)
	self:SetChecked(settings:Get("Thing:Mounts"));
	if settings:Get("DebugMode") then
		self:Disable();
		self:SetAlpha(0.2);
	else
		self:Enable();
		self:SetAlpha(1);
	end
end,
function(self)
	settings:Set("Thing:Mounts", self:GetChecked());
	settings:UpdateMode();
	app:RefreshData();
end);
MountsCheckBox:SetATTTooltip("启用此选项以跟踪坐骑.\n\n你可以骑着它们去比跑步更快的地方. 谁知道!\n\n默认情况下的跟踪战网范围.");
MountsCheckBox:SetPoint("TOPLEFT", IllusionsCheckBox, "BOTTOMLEFT", 0, 4);

local MountsAccountWideCheckBox = settings:CreateCheckBox("战网范围",
function(self)
	self:SetChecked(true);
	self:Disable();
	self:SetAlpha(0.2);
end);
MountsAccountWideCheckBox:SetPoint("TOPLEFT", MountsCheckBox, "TOPLEFT", 220, 0);

local MusicRollsCheckBox = settings:CreateCheckBox("乐谱",
function(self)
	self:SetChecked(settings:Get("Thing:MusicRolls"));
	if settings:Get("DebugMode") then
		self:Disable();
		self:SetAlpha(0.2);
	else
		self:Enable();
		self:SetAlpha(1);
	end
end,
function(self)
	settings:Set("Thing:MusicRolls", self:GetChecked());
	settings:UpdateMode();
	app:RefreshData();
end);
MusicRollsCheckBox:SetATTTooltip("启用此选项以跟踪乐谱.\n\n你可以用你的点唱机播放游戏中的音乐!");
MusicRollsCheckBox:SetPoint("TOPLEFT", MountsCheckBox, "BOTTOMLEFT", 0, 4);

local MusicRollsAccountWideCheckBox = settings:CreateCheckBox("战网范围",
function(self)
	self:SetChecked(settings:Get("AccountWide:MusicRolls"));
	if settings:Get("DebugMode") or not settings:Get("Thing:MusicRolls") then
		self:Disable();
		self:SetAlpha(0.2);
	else
		self:Enable();
		self:SetAlpha(1);
	end
end,
function(self)
	settings:Set("AccountWide:MusicRolls", self:GetChecked());
	settings:UpdateMode();
	app:RefreshData();
end);
MusicRollsAccountWideCheckBox:SetATTTooltip("在暴雪的数据库中，乐谱通常不会被广泛跟踪，但我们可以这样做.\n\n注意: 您只能使用您在当前角色上收集的点唱机玩具播放音乐.");
MusicRollsAccountWideCheckBox:SetPoint("TOPLEFT", MusicRollsCheckBox, "TOPLEFT", 220, 0);

local QuestsCheckBox = settings:CreateCheckBox("任务",
function(self)
	self:SetChecked(settings:Get("Thing:Quests"));
	if settings:Get("DebugMode") then
		self:Disable();
		self:SetAlpha(0.2);
	else
		self:Enable();
		self:SetAlpha(1);
	end
end,
function(self)
	settings:Set("Thing:Quests", self:GetChecked());
	settings:UpdateMode();
	app:RefreshData();
end);
QuestsCheckBox:SetATTTooltip("启用此选项以跟踪任务.\n\n您可以右键单击列表中的任何任务，弹出它们的完整任务链，以显示您的进度和任何先决条件或后续任务.\n\n注意: 由于暴雪数据库中每日、每周、每年和世界任务的跟踪方式的性质，任务不会被永久跟踪.");
QuestsCheckBox:SetPoint("TOPLEFT", MusicRollsCheckBox, "BOTTOMLEFT", 0, 4);

local QuestsAccountWideCheckBox = settings:CreateCheckBox("战网范围",
function(self)
	self:SetChecked(false);
	self:Disable();
	self:SetAlpha(0.2);
end);
QuestsAccountWideCheckBox:SetPoint("TOPLEFT", QuestsCheckBox, "TOPLEFT", 220, 0);

local RecipesCheckBox = settings:CreateCheckBox("图纸",
function(self)
	self:SetChecked(settings:Get("Thing:Recipes"));
	if settings:Get("DebugMode") then
		self:Disable();
		self:SetAlpha(0.2);
	else
		self:Enable();
		self:SetAlpha(1);
	end
end,
function(self)
	settings:Set("Thing:Recipes", self:GetChecked());
	settings:UpdateMode();
	app:RefreshData();
end);
RecipesCheckBox:SetATTTooltip("启用此选项可跟踪您的专业图纸.\n\n注意: 您必须打开专业列表才能缓存这些.");
RecipesCheckBox:SetPoint("TOPLEFT", QuestsCheckBox, "BOTTOMLEFT", 0, 4);

local RecipesAccountWideCheckBox = settings:CreateCheckBox("战网范围",
function(self)
	self:SetChecked(settings:Get("AccountWide:Recipes"));
	if settings:Get("DebugMode") or not settings:Get("Thing:Recipes") then
		self:Disable();
		self:SetAlpha(0.2);
	else
		self:Enable();
		self:SetAlpha(1);
	end
end,
function(self)
	settings:Set("AccountWide:Recipes", self:GetChecked());
	settings:UpdateMode();
	app:RefreshData();
end);
RecipesAccountWideCheckBox:SetATTTooltip("在暴雪的数据库中，图纸通常不会在整个战网范围内被跟踪，但我们可以做到这一点.\n\n在一个角色上收集它们是不可能的，所以有了这个，你可以追踪所有角色.");
RecipesAccountWideCheckBox:SetPoint("TOPLEFT", RecipesCheckBox, "TOPLEFT", 220, 0);

local ReputationsCheckBox = settings:CreateCheckBox("声望",
function(self)
	self:SetChecked(settings:Get("Thing:Reputations"));
	if settings:Get("DebugMode") then
		self:Disable();
		self:SetAlpha(0.2);
	else
		self:Enable();
		self:SetAlpha(1);
	end
end,
function(self)
	settings:Set("Thing:Reputations", self:GetChecked());
	settings:UpdateMode();
	app:RefreshData();
end);
ReputationsCheckBox:SetATTTooltip("启用此选项可跟踪声望.\n\n一旦你达到了有声望的尊敬或最好的朋友，它将被标记为收藏.\n\n您可能需要手动刷新才能正确更新.");
ReputationsCheckBox:SetPoint("TOPLEFT", RecipesCheckBox, "BOTTOMLEFT", 0, 4);

local ReputationsAccountWideCheckBox = settings:CreateCheckBox("战网范围",
function(self)
	self:SetChecked(settings:Get("AccountWide:Reputations"));
	if settings:Get("DebugMode") or not settings:Get("Thing:Reputations") then
		self:Disable();
		self:SetAlpha(0.2);
	else
		self:Enable();
		self:SetAlpha(1);
	end
end,
function(self)
	settings:Set("AccountWide:Reputations", self:GetChecked());
	settings:UpdateMode();
	app:RefreshData();
end);
ReputationsAccountWideCheckBox:SetATTTooltip("在暴雪的数据库中，声望现在被广泛地追踪到，所以打开它可能是个好主意.");
ReputationsAccountWideCheckBox:SetPoint("TOPLEFT", ReputationsCheckBox, "TOPLEFT", 220, 0);

local SelfieFiltersCheckBox = settings:CreateCheckBox("自拍滤镜",
function(self)
	self:SetChecked(settings:Get("Thing:SelfieFilters"));
	if settings:Get("DebugMode") then
		self:Disable();
		self:SetAlpha(0.2);
	else
		self:Enable();
		self:SetAlpha(1);
	end
end,
function(self)
	settings:Set("Thing:SelfieFilters", self:GetChecked());
	settings:UpdateMode();
	app:RefreshData();
end);
SelfieFiltersCheckBox:SetATTTooltip("启用此选项可跟踪S.E.L.F.I.E相机玩具的自拍过滤器.\n\n哦, 开心! 自拍照! 好的伙~~~计.");
SelfieFiltersCheckBox:SetPoint("TOPLEFT", ReputationsCheckBox, "BOTTOMLEFT", 0, 4);

local SelfieFiltersAccountWideCheckBox = settings:CreateCheckBox("战网范围",
function(self)
	self:SetChecked(settings:Get("AccountWide:SelfieFilters"));
	if settings:Get("DebugMode") or not settings:Get("Thing:SelfieFilters") then
		self:Disable();
		self:SetAlpha(0.2);
	else
		self:Enable();
		self:SetAlpha(1);
	end
end,
function(self)
	settings:Set("AccountWide:SelfieFilters", self:GetChecked());
	settings:UpdateMode();
	app:RefreshData();
end);
SelfieFiltersAccountWideCheckBox:SetATTTooltip("在暴雪的数据库中，自拍过滤器通常不会在战网范围内进行跟踪，但我们可以做到这一点.\n\n注意: 您必须使用S.E.L.F.I.E相机玩具拍摄自拍照!");
SelfieFiltersAccountWideCheckBox:SetPoint("TOPLEFT", SelfieFiltersCheckBox, "TOPLEFT", 220, 0);

local TitlesCheckBox = settings:CreateCheckBox("头衔",
function(self)
	self:SetChecked(settings:Get("Thing:Titles"));
	if settings:Get("DebugMode") then
		self:Disable();
		self:SetAlpha(0.2);
	else
		self:Enable();
		self:SetAlpha(1);
	end
end,
function(self)
	settings:Set("Thing:Titles", self:GetChecked());
	settings:UpdateMode();
	app:RefreshData();
end);
TitlesCheckBox:SetATTTooltip("启用此选项可跟踪头衔.\n\n这些可以让你的角色脱颖而出，看起来你已经玩了一段时间. 通常只有新玩家没有称号.");
TitlesCheckBox:SetPoint("TOPLEFT", SelfieFiltersCheckBox, "BOTTOMLEFT", 0, 4);

local TitlesAccountWideCheckBox = settings:CreateCheckBox("战网范围",
function(self)
	self:SetChecked(settings:Get("AccountWide:Titles"));
	if settings:Get("DebugMode") or not settings:Get("Thing:Titles") then
		self:Disable();
		self:SetAlpha(0.2);
	else
		self:Enable();
		self:SetAlpha(1);
	end
end,
function(self)
	settings:Set("AccountWide:Titles", self:GetChecked());
	settings:UpdateMode();
	app:RefreshData();
end);
TitlesAccountWideCheckBox:SetATTTooltip("大多数头衔都是在战网范围内进行跟踪，但是魔兽世界中一些着名的头衔被锁定在赢得他们的角色上.\n\n如果你不关心这个并且想要看到那些标记为你收集的标题，请切换它.");
TitlesAccountWideCheckBox:SetPoint("TOPLEFT", TitlesCheckBox, "TOPLEFT", 220, 0);

local ToysCheckBox = settings:CreateCheckBox("玩具",
function(self)
	self:SetChecked(settings:Get("Thing:Toys"));
	if settings:Get("DebugMode") then
		self:Disable();
		self:SetAlpha(0.2);
	else
		self:Enable();
		self:SetAlpha(1);
	end
end,
function(self)
	settings:Set("Thing:Toys", self:GetChecked());
	settings:UpdateMode();
	app:RefreshData();
end);
ToysCheckBox:SetATTTooltip("启用此选项可跟踪玩具.\n\n这些玩具中的大多数玩具都有趣. 其他的，如炉石玩具，可以用来代替你的实际炉石，并可以为你节省一个袋子! 他们也有有趣的效果......很好!\n\n默认情况下跟踪战网范围.");
ToysCheckBox:SetPoint("TOPLEFT", TitlesCheckBox, "BOTTOMLEFT", 0, 4);

local ToysAccountWideCheckBox = settings:CreateCheckBox("战网范围",
function(self)
	self:SetChecked(true);
	self:Disable();
	self:SetAlpha(0.2);
end);
ToysAccountWideCheckBox:SetPoint("TOPLEFT", ToysCheckBox, "TOPLEFT", 220, 0);



local ShowCompletedGroupsCheckBox = settings:CreateCheckBox("显示已完成的组",
function(self)
	self:SetChecked(settings:Get("Show:CompletedGroups"));
	if settings:Get("DebugMode") then
		self:Disable();
		self:SetAlpha(0.2);
	else
		self:Enable();
		self:SetAlpha(1);
	end
end,
function(self)
	settings:SetCompletedGroups(self:GetChecked());
	settings:UpdateMode();
	app:RefreshData();
end);
ShowCompletedGroupsCheckBox:SetATTTooltip("如果要将已完成的组视为具有完成百分比的标题，请启用此选项. 如果某个群组与您的职业没有任何关联，则此设置也会使这些群组显示在列表中.\n\n我们建议您关闭此设置，因为它将节省迷你列表中的空间，并允许您快速查看区域中缺少的内容.");
ShowCompletedGroupsCheckBox:SetPoint("TOPLEFT", AchievementsAccountWideCheckBox, "TOPLEFT", 160, 0);

local ShowCollectedThingsCheckBox = settings:CreateCheckBox("显示已收集的东西",
function(self)
	self:SetChecked(settings:Get("Show:CollectedThings"));
	if settings:Get("DebugMode") then
		self:Disable();
		self:SetAlpha(0.2);
	else
		self:Enable();
		self:SetAlpha(1);
	end
end,
function(self)
	settings:SetCollectedThings(self:GetChecked());
	settings:UpdateMode();
	app:RefreshData();
end);
ShowCollectedThingsCheckBox:SetATTTooltip("如果要将已完成的组视为具有完成百分比的标题，请启用此选项. 如果某个群组与您的职业没有任何关联，则此设置也会使这些群组显示在列表中.\n\n我们建议您关闭此设置，因为它将节省迷你列表中的空间，并允许您快速查看区域中缺少的内容.");
ShowCollectedThingsCheckBox:SetPoint("TOPLEFT", ShowCompletedGroupsCheckBox, "BOTTOMLEFT", 0, 4);

local ShowIncompleteThingsCheckBox = settings:CreateCheckBox("显示未完成的任务",
function(self)
	self:SetChecked(settings:Get("Show:IncompleteThings"));
	if settings:Get("DebugMode") then
		self:Disable();
		self:SetAlpha(0.2);
	else
		self:Enable();
		self:SetAlpha(1);
	end
end,
function(self)
	settings:Set("Show:IncompleteThings", self:GetChecked());
	settings:UpdateMode();
	app:RefreshData();
end);
ShowIncompleteThingsCheckBox:SetATTTooltip("如果要查看与未完成任务相关联的物品，装备，NPC和称号，则启用此选项，这些任务不一定具有您可以通过完成任务而收集的任何内容.\n\n你可以用这个来帮助你获得博学者的成就，如果你还没有.\n\n注意: 在启用此设置的情况下，列表中也会出现稀有任务.");
ShowIncompleteThingsCheckBox:SetPoint("TOPLEFT", ShowCollectedThingsCheckBox, "BOTTOMLEFT", 0, 4);

local FilterThingsByLevelCheckBox = settings:CreateCheckBox("按等级筛选内容",
function(self)
	self:SetChecked(settings:Get("Filter:ByLevel"));
	if settings:Get("DebugMode") then
		self:Disable();
		self:SetAlpha(0.2);
	else
		self:Enable();
		self:SetAlpha(1);
	end
end,
function(self)
	settings:Set("Filter:ByLevel", self:GetChecked());
	settings:UpdateMode();
	app:RefreshData();
end);
FilterThingsByLevelCheckBox:SetATTTooltip("如果只想查看当前级别角色可用的内容，请启用此设置.\n\n注意: 这对新手战网特别有用.");
FilterThingsByLevelCheckBox:SetPoint("TOPLEFT", ShowIncompleteThingsCheckBox, "BOTTOMLEFT", 0, 4);

local HideBoEItemsCheckBox = settings:CreateCheckBox("隐藏BoE物品",
function(self)
	self:SetChecked(settings:Get("Hide:BoEs"));
	if settings:Get("DebugMode") or settings:Get("Filter:BoEs") then
		self:Disable();
		self:SetAlpha(0.2);
	else
		self:Enable();
		self:SetAlpha(1);
	end
end,
function(self)
	settings:SetHideBOEItems(self:GetChecked());
end);
HideBoEItemsCheckBox:SetATTTooltip("如果要隐藏BoE物品，请启用此设置.\n\n当您尝试为角色完成经典旧世并且不想专门用于可以在alts或拍卖行上放置的物品时，此设置非常有用.\n\n即: 不要因为毁灭之锤而扰乱你的思绪.");
HideBoEItemsCheckBox:SetPoint("TOPLEFT", FilterThingsByLevelCheckBox, "BOTTOMLEFT", 0, 4);

local IgnoreFiltersForBoEsCheckBox = settings:CreateCheckBox("忽略BOE的筛选器",
function(self)
	self:SetChecked(settings:Get("Filter:BoEs"));
	if settings:Get("DebugMode") then
		self:Disable();
		self:SetAlpha(0.2);
	else
		self:Enable();
		self:SetAlpha(1);
	end
end,
function(self)
	settings:Set("Filter:BoEs", self:GetChecked());
	settings:UpdateMode();
	app:RefreshData();
end);
IgnoreFiltersForBoEsCheckBox:SetATTTooltip("如果要忽略BOE项目的装备、武器、种族、等级或职业要求，请启用此设置.\n\n如果您正试图通过拍卖行扫描收集您的物品，此模式可能对您有用.");
IgnoreFiltersForBoEsCheckBox:SetPoint("TOPLEFT", HideBoEItemsCheckBox, "BOTTOMLEFT", 0, 4);

local ExpandDifficultyCheckBox = settings:CreateCheckBox("展开当前难度",
function(self)
	self:SetChecked(settings:GetTooltipSetting("Expand:Difficulty"));
end,
function(self)
	settings:SetTooltipSetting("Expand:Difficulty", self:GetChecked());
end);
ExpandDifficultyCheckBox:SetATTTooltip("如果要在进入地下城或团队时自动最小化迷你列表中未激活的难度标题，请启用此选项.\n\n比如: 在普通难度地下城中最小化英雄条目");
ExpandDifficultyCheckBox:SetPoint("TOPLEFT", IgnoreFiltersForBoEsCheckBox, "BOTTOMLEFT", 0, 0);

local WarnDifficultyCheckBox = settings:CreateCheckBox("警告已完成难度",
function(self)
	self:SetChecked(settings:GetTooltipSetting("Warn:Difficulty"));
end,
function(self)
	settings:SetTooltipSetting("Warn:Difficulty", self:GetChecked());
end);
WarnDifficultyCheckBox:SetATTTooltip("如果您希望在进入具有难度设置的副本时收到警告，当您有其他未保存的难度时，您将无法获得新的收藏品.");
WarnDifficultyCheckBox:SetPoint("TOPLEFT", ExpandDifficultyCheckBox, "BOTTOMLEFT", 0, 4);

local CelebrateCollectedThingsCheckBox = settings:CreateCheckBox("庆祝已收集的东西",
function(self)
	self:SetChecked(settings:GetTooltipSetting("Celebrate"));
end,
function(self)
	settings:SetTooltipSetting("Celebrate", self:GetChecked());
end);
CelebrateCollectedThingsCheckBox:SetATTTooltip("如果您希望在获得新物品时听到庆祝的声音效果，请启用此选项.\n\n此功能可以极大地帮助您保持动力.");
CelebrateCollectedThingsCheckBox:SetPoint("TOPLEFT", WarnDifficultyCheckBox, "BOTTOMLEFT", 0, 4);

local WarnRemovedThingsCheckBox = settings:CreateCheckBox("删除内容时发出警告",
function(self)
	self:SetChecked(settings:GetTooltipSetting("Warn:Removed"));
end,
function(self)
	settings:SetTooltipSetting("Warn:Removed", self:GetChecked());
end);
WarnRemovedThingsCheckBox:SetATTTooltip("如果您想在不小心售出或交易某个物品时听到警告音效，而该物品的外观会导致您在收藏中丢失该外观，请启用此选项.\n\n如果您提供带有购买计时器的商品，这将非常有用. 插件会告诉你，你犯了一个错误.");
WarnRemovedThingsCheckBox:SetPoint("TOPLEFT", CelebrateCollectedThingsCheckBox, "BOTTOMLEFT", 0, 4);

local ReportCollectedThingsCheckBox = settings:CreateCheckBox("报告已收集的东西",
function(self)
	self:SetChecked(settings:GetTooltipSetting("Report:Collected"));
end,
function(self)
	settings:SetTooltipSetting("Report:Collected", self:GetChecked());
end);
ReportCollectedThingsCheckBox:SetATTTooltip("如果您希望在聊天中看到一条消息，详细说明您从收藏中收集或删除了哪些物品，请启用此选项.\n\n注意: 这是因为暴雪默默地添加了外观和其他收藏品并且忽略了通知您可用的其他物品.\n\n我们建议您保持此设置. 如果你打开了这个选项，你仍然会听到警告声.");
ReportCollectedThingsCheckBox:SetPoint("TOPLEFT", WarnRemovedThingsCheckBox, "BOTTOMLEFT", 0, 4);

local ReportCompletedQuestsCheckBox = settings:CreateCheckBox("报告已完成的任务",
function(self)
	self:SetChecked(settings:GetTooltipSetting("Report:CompletedQuests"));
end,
function(self)
	settings:SetTooltipSetting("Report:CompletedQuests", self:GetChecked());
end);
ReportCompletedQuestsCheckBox:SetATTTooltip("如果您希望在任务发生后立即看到您完成的任何任务的任务ID，请启用此选项. (用于报告错误、跟踪等)");
ReportCompletedQuestsCheckBox:SetPoint("TOPLEFT", ReportCollectedThingsCheckBox, "BOTTOMLEFT", 0, 4);

local ReportUnsortedCompletedQuestsCheckBox = settings:CreateCheckBox("仅限未分类的任务",
function(self)
	self:SetChecked(settings:GetTooltipSetting("Report:UnsortedQuests"));
end,
function(self)
	settings:SetTooltipSetting("Report:UnsortedQuests", self:GetChecked());
end);
ReportUnsortedCompletedQuestsCheckBox:SetATTTooltip("如果您只想查看您完成的任何任务的任务ID，而该任务ID尚未在加载项中列出，请启用此选项.");
ReportUnsortedCompletedQuestsCheckBox:SetPoint("TOPLEFT", ReportCompletedQuestsCheckBox, "BOTTOMLEFT", 4, 4);
end)();

------------------------------------------
-- The "Filters" Tab.					--
------------------------------------------
(function()
local tab = settings:CreateTab("筛选");
tab.OnRefresh = function(self) 
	if settings:Get("DebugMode") then
		PanelTemplates_DisableTab(settings, self:GetID());
	else
		PanelTemplates_EnableTab(settings, self:GetID());
	end
end;

local ItemFiltersLabel = settings:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
ItemFiltersLabel:SetPoint("TOPLEFT", line, "BOTTOMLEFT", 8, -8);
ItemFiltersLabel:SetJustifyH("LEFT");
ItemFiltersLabel:SetText("装备 / 武器 筛选");
ItemFiltersLabel:Show();
table.insert(settings.MostRecentTab.objects, ItemFiltersLabel);

-- Armor
local last, xoffset, yoffset = ItemFiltersLabel, 0, -4;
local itemFilterNames = L["FILTER_ID_TYPES"];

-- Primary Armor Class
local ItemFilterOnClick = function(self)
	settings:SetFilter(self.filterID, self:GetChecked());
end;
local ItemFilterOnRefresh = function(self)
	if settings:Get("AccountMode") or settings:Get("DebugMode") then
		self:Disable();
		self:SetAlpha(0.2);
	elseif FilterSettingsBase.__index[self.filterID] then
		self:SetChecked(settings:GetFilter(self.filterID));
		self:Enable();
		self:SetAlpha(1);
	else
		self:SetChecked(false);
		self:Disable();
		self:SetAlpha(0.2);
	end
end;
for i,filterID in ipairs({ 4, 5, 6, 7 }) do
	local filter = settings:CreateCheckBox(itemFilterNames[filterID], ItemFilterOnRefresh, ItemFilterOnClick);
	filter:SetPoint("TOPLEFT", last, "BOTTOMLEFT", 0, yoffset);
	filter.filterID = filterID;
	last = filter;
	yoffset = 6;
end

-- Weapons
yoffset = -4;
for i,filterID in ipairs({ 20, 29, 28  }) do
	local filter = settings:CreateCheckBox(itemFilterNames[filterID], ItemFilterOnRefresh, ItemFilterOnClick);
	filter:SetPoint("TOPLEFT", last, "BOTTOMLEFT", 0, yoffset);
	filter.filterID = filterID;
	last = filter;
	yoffset = 6;
end

-- Big Ole Boys
yoffset = -4;
for i,filterID in ipairs({ 21, 22, 23, 24, 25, 26, 1, 8 }) do
	local filter = settings:CreateCheckBox(itemFilterNames[filterID], ItemFilterOnRefresh, ItemFilterOnClick);
	filter:SetPoint("TOPLEFT", last, "BOTTOMLEFT", 0, yoffset);
	filter.filterID = filterID;
	last = filter;
	yoffset = 6;
end

-- Weird Boys
yoffset = -4;
for i,filterID in ipairs({ 50, 57, 34, 35, 27 }) do
	local filter = settings:CreateCheckBox(itemFilterNames[filterID], ItemFilterOnRefresh, ItemFilterOnClick);
	filter:SetPoint("TOPLEFT", last, "BOTTOMLEFT", 0, yoffset);
	filter.filterID = filterID;
	last = filter;
	yoffset = 6;
end

-- Secondary Armor Classes
last, xoffset, yoffset = ItemFiltersLabel, 120, -4;
for i,filterID in ipairs({ 11, 2, 3, 10, 9, 33, 32, 31 }) do
	local filter = settings:CreateCheckBox(itemFilterNames[filterID], ItemFilterOnRefresh, ItemFilterOnClick);
	filter:SetPoint("TOPLEFT", last, "BOTTOMLEFT", xoffset, yoffset);
	filter.filterID = filterID;
	last = filter;
	xoffset = 0;
	yoffset = 6;
end

f = CreateFrame("Button", nil, settings, "OptionsButtonTemplate");
f:SetPoint("BOTTOMLEFT", settings, "BOTTOMLEFT", 8, 8);
f:SetText("默认职业");
f:SetWidth(120);
f:SetHeight(24);
f:RegisterForClicks("AnyUp");
f:SetScript("OnClick", function(self)
	for key,value in pairs(AllTheThingsSettingsPerCharacter.Filters) do
		AllTheThingsSettingsPerCharacter.Filters[key] = nil;
	end
	settings:Refresh();
	app:RefreshData();
end);
f:SetATTTooltip("单击此按钮可将所有筛选器重置为职业默认值.\n\n注意: 只能打开可为职业收集的筛选器.");
f.OnRefresh = function(self) 
	if settings:Get("AccountMode") or settings:Get("DebugMode") then
		self:Disable();
	else
		self:Enable();
	end
end;
table.insert(settings.MostRecentTab.objects, f);
settings.classdefaults = f;

f = CreateFrame("Button", nil, settings, "OptionsButtonTemplate");
f:SetPoint("TOPLEFT", settings.classdefaults, "TOPRIGHT", 3, 0);
f:SetText("所有");
f:SetWidth(80);
f:SetHeight(24);
f:RegisterForClicks("AnyUp");
f:SetScript("OnClick", function(self)
	local active, count = 0, 0;
	for key,value in pairs(FilterSettingsBase.__index) do
		if value then
			count = count + 1;
			if AllTheThingsSettingsPerCharacter.Filters[key] then
				active = active + 1;
			end
		end
	end
	if count > 0 then
		if (active / count) > 0.5 then
			for key,value in pairs(FilterSettingsBase.__index) do
				if value then AllTheThingsSettingsPerCharacter.Filters[key] = false; end
			end
		else
			for key,value in pairs(FilterSettingsBase.__index) do
				if value then AllTheThingsSettingsPerCharacter.Filters[key] = true; end
			end
		end
		settings:Refresh();
		app:RefreshData();
	end
end);
f:SetATTTooltip("单击此按钮可一次切换所有筛选器.");
f.OnRefresh = function(self) 
	if settings:Get("AccountMode") or settings:Get("DebugMode") then
		self:Disable();
	else
		self:Enable();
	end
end;
table.insert(settings.MostRecentTab.objects, f);

local LegacyFiltersLabel = settings:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
LegacyFiltersLabel:SetPoint("TOPRIGHT", line, "BOTTOMRIGHT", -88, -8);
LegacyFiltersLabel:SetJustifyH("LEFT");
LegacyFiltersLabel:SetText("遗留 / 不可获得 筛选");
LegacyFiltersLabel:Show();
table.insert(settings.MostRecentTab.objects, LegacyFiltersLabel);

local LegacyFiltersTempLabel = settings:CreateFontString(nil, "ARTWORK", "GameFontNormal");
LegacyFiltersTempLabel:SetPoint("TOPLEFT", LegacyFiltersLabel, "BOTTOMLEFT", 0, -8);
LegacyFiltersTempLabel:SetPoint("TOPRIGHT", LegacyFiltersLabel, "BOTTOMRIGHT", 0, -8);
LegacyFiltersTempLabel:SetJustifyH("LEFT");
LegacyFiltersTempLabel:SetText("|CFFFFFFFF我将彻底修改我们的遗留、不可获得和节日性过滤器的工作方式.\n\n即将到来™.|r");
LegacyFiltersTempLabel:Show();
table.insert(settings.MostRecentTab.objects, LegacyFiltersTempLabel);
end)();

------------------------------------------
-- The "Social" Tab.					--
------------------------------------------
--[[
(function()
local tab = settings:CreateTab("社交");
tab.OnRefresh = function(self) 
	-- We aren't ready yet. :(
	PanelTemplates_DisableTab(settings, self:GetID());
end;
end)();
--]]

------------------------------------------
-- The temporary "Unobtainables" Tab.	--
------------------------------------------
(function()
local tab = settings:CreateTab("不可获得");
tab.OnRefresh = function(self) 
	if settings:Get("DebugMode") then
		PanelTemplates_DisableTab(settings, self:GetID());
	else
		PanelTemplates_EnableTab(settings, self:GetID());
	end
end;
local function OnScrollBarMouseWheel(self, delta)
	self.ScrollBar:SetValue(self.ScrollBar.CurrentValue - (delta * 5));
end
local function OnScrollBarValueChanged(self, value)
	local un = math.floor(value);
	local up = un + 1;
	self.CurrentValue = (up - value) > (-(un - value)) and un or up;
	self.child:SetPoint("TOP", 0, (self.CurrentValue / 100) * 360);
end
local scrollbar = CreateFrame("Slider", nil, settings, "UIPanelScrollBarTemplate");
scrollbar:SetPoint("TOP", line, "BOTTOM", -3, -16);
scrollbar:SetPoint("BOTTOMRIGHT", settings, "BOTTOMRIGHT", -3, 20);
scrollbar:SetScript("OnValueChanged", OnScrollBarValueChanged);
scrollbar.back = scrollbar:CreateTexture(nil, "BACKGROUND");
scrollbar.back:SetColorTexture(0,0,0,0.4)
scrollbar.back:SetAllPoints(scrollbar);
scrollbar:SetMinMaxValues(0, 100);
scrollbar:SetValueStep(1);
scrollbar.CurrentValue = 0;
scrollbar:SetWidth(16);
table.insert(settings.MostRecentTab.objects, scrollbar);

local scrollFrame = CreateFrame("Frame", nil, settings);
scrollFrame:SetPoint("TOP", line, "BOTTOM", 0, -1);
scrollFrame:SetPoint("LEFT", settings, "LEFT", 0, 0);
scrollFrame:SetPoint("BOTTOMRIGHT", settings, "BOTTOMRIGHT", -20, 4);
scrollFrame:SetClipsChildren(true);
scrollFrame:EnableMouseWheel(true);
scrollFrame.ScrollBar = scrollbar;
scrollFrame:SetScript("OnMouseWheel", OnScrollBarMouseWheel);
table.insert(settings.MostRecentTab.objects, scrollFrame);

local child = CreateFrame("Frame", nil, scrollFrame);
child:SetPoint("TOP", 0, 0);
child:SetSize(600, 2500);
scrollbar.child = child;
table.insert(settings.MostRecentTab.objects, child);
child.CreateCheckBox = function(self, label, onRefresh, onClick)
	local checkBox = settings:CreateCheckBox(label, onRefresh, onClick);
	checkBox:SetParent(child);
	return checkBox;
end

-- seasonal
local seasonal = child:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
seasonal:SetPoint("TOPLEFT", child, 4, -8)
seasonal:SetText("节日 (选择隐藏)");

local seasonalFrame = CreateFrame("Frame", nil, child, "ThinBorderTemplate");
seasonalFrame:SetPoint("TOP", seasonal, "BOTTOM", 0, -4);
seasonalFrame:SetPoint("LEFT", child, 4, 0);
seasonalFrame:SetPoint("RIGHT", child, -4, 0);
seasonalFrame:SetHeight(250);

-- seasonal enable
local seasonalEnable = child:CreateCheckBox("筛选节日物品", 
function(self) 
	self:SetChecked(app.GetDataMember("FilterSeasonal"));
end,
function(self)
	app.SetDataMember("FilterSeasonal", self:GetChecked());
	if self:GetChecked() then
		app.SeasonalItemFilter = app.FilterItemClass_SeasonalItem;
	else
		app.SeasonalItemFilter = app.NoFilter;
	end
	settings:Refresh();
	app:RefreshData();
end);
seasonalEnable:SetPoint("TOPLEFT", seasonalFrame, "TOPLEFT", 4, -4);

-- seasonal Everything
local seasonalAll = child:CreateCheckBox("启用所有节日",
function(self)
	local isTrue = true
	local val = app.GetDataMember("SeasonalFilters")
	for k,v in ipairs(L["UNOBTAINABLE_ITEM_REASONS"]) do
		if v[1] > 4 then
			isTrue = isTrue and not val[k]
		end
	end
	self:SetChecked(isTrue);
	if not app.GetDataMember("FilterSeasonal") then
		self:Disable();
		self:SetAlpha(0.2);
	else
		self:Enable();
		self:SetAlpha(1);
	end
end,
function(self)
	local val = app.GetDataMember("SeasonalFilters")
	for k,v in ipairs(L["UNOBTAINABLE_ITEM_REASONS"]) do
		if v[1] > 4 then
			val[k] = not self:GetChecked()
		end
	end
	app.SetDataMember("SeasonalFilters", val);
	settings:Refresh();
	app:RefreshData();
end);
seasonalAll:SetPoint("TOP", seasonalFrame, "TOP", 0, -4);
seasonalAll:SetPoint("LEFT", seasonalFrame, "CENTER", 0, 0);

local seasonalSubFrame = CreateFrame("Frame", nil, child, "ThinBorderTemplate");
seasonalSubFrame:SetPoint("TOPLEFT",seasonalFrame,5,-30);
seasonalSubFrame:SetPoint("BOTTOMRIGHT", seasonalFrame, -15, 20);

local last = seasonalSubFrame;
local x = 5;
local y = 5;
local count = 0;
for k,v in ipairs(L["UNOBTAINABLE_ITEM_REASONS"]) do
	if v[1] > 4 then
		local seasonalFilter = child:CreateCheckBox(v[3], 
		function(self) 
			self:SetChecked(not app.GetDataMember("SeasonalFilters")[k]);
			if not app.GetDataMember("FilterSeasonal") then
				self:Disable();
				self:SetAlpha(0.2);
			else
				self:Enable();
				self:SetAlpha(1);
			end
		end,
		function(self)
			local val = app.GetDataMember("SeasonalFilters")
			val[k]= not self:GetChecked()
			app.SetDataMember("SeasonalFilters", val);
			settings:Refresh();
			app:RefreshData();
		end);
		seasonalFilter:SetATTTooltip(v[2]);
		seasonalFilter:SetPoint("TOPLEFT",last,x,-y)
		last = seasonalFilter
		x = 0;
		y = 20;
		count = count + 1;
		if count == 9 then
			x = 300
			y = 5
			last = seasonalSubFrame
		end
	end
end

-- Unobtainable
local unobtainable = child:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
unobtainable:SetPoint("TOPLEFT", seasonalFrame, 0, -(seasonalFrame:GetHeight() + 20))
unobtainable:SetText("无法获得 (选择隐藏)");

local unobtainableFrame = CreateFrame("Frame", nil, child, "ThinBorderTemplate");
unobtainableFrame:SetPoint("TOP",unobtainable,0,-20);
unobtainableFrame:SetPoint("LEFT", child, 4, 0);
unobtainableFrame:SetPoint("RIGHT", child, -4, 0);
unobtainableFrame:SetHeight(535);

-- unobtainable enable
local unobtainableEnable = child:CreateCheckBox("筛选不可获得的物品",
function(self) 
	self:SetChecked(app.GetDataMember("FilterUnobtainableItems"));
end,
function(self)
	app.SetDataMember("FilterUnobtainableItems", self:GetChecked());
	if self:GetChecked() then
		app.UnobtainableItemFilter = app.FilterItemClass_UnobtainableItem;
	else
		app.UnobtainableItemFilter = app.NoFilter;
	end
	settings:Refresh();
	app:RefreshData();
end);
unobtainableEnable:SetPoint("TOPLEFT",unobtainable,5,-20)

-- unobtainable Everything
local unobtainableAll = child:CreateCheckBox("启用所有不可获得",
function(self)
	local isTrue = true
	local val = app.GetDataMember("UnobtainableItemFilters")
	for k,v in ipairs(L["UNOBTAINABLE_ITEM_REASONS"]) do
		if v[1] < 5 then
			isTrue = isTrue and not val[k]
		end
	end
	self:SetChecked(isTrue);
	if not app.GetDataMember("FilterUnobtainableItems") then
		self:Disable();
		self:SetAlpha(0.2);
	else
		self:Enable();
		self:SetAlpha(1);
	end
end,
function(self)
	local val = app.GetDataMember("UnobtainableItemFilters")
	for k,v in ipairs(L["UNOBTAINABLE_ITEM_REASONS"]) do
		if v[1] < 5 then
			val[k] = not self:GetChecked()
		end
	end
	app.SetDataMember("UnobtainableItemFilters", val);
	settings:Refresh();
	app:RefreshData();
end);
unobtainableAll:SetPoint("TOPLEFT",unobtainable, 300, -20)

-- no chance
local noChance = child:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
noChance:SetPoint("TOPLEFT", unobtainable, 10, -50)
noChance:SetText("没有机会");

local noChanceFrame = CreateFrame("Frame", nil, child, "ThinBorderTemplate");
noChanceFrame:SetPoint("TOP",noChance,0,-20);
noChanceFrame:SetPoint("LEFT", child, 4, 0);
noChanceFrame:SetPoint("RIGHT", child, -4, 0);
noChanceFrame:SetHeight(120);

-- no chance Everything
local noChanceAll = child:CreateCheckBox("启用所有 \"没有机会\"",
function(self)
	local isTrue = true
	local val = app.GetDataMember("UnobtainableItemFilters")
	for k,v in ipairs(L["UNOBTAINABLE_ITEM_REASONS"]) do
		if v[1] == 1 then
			isTrue = isTrue and not val[k]
		end
	end
	self:SetChecked(isTrue);
	if not app.GetDataMember("FilterUnobtainableItems") then
		self:Disable();
		self:SetAlpha(0.2);
	else
		self:Enable();
		self:SetAlpha(1);
	end
end,
function(self)
	local val = app.GetDataMember("UnobtainableItemFilters")
	for k,v in ipairs(L["UNOBTAINABLE_ITEM_REASONS"]) do
		if v[1] == 1 then
			val[k] = not self:GetChecked()
		end
	end
	app.SetDataMember("UnobtainableItemFilters", val);
	settings:Refresh();
	app:RefreshData();
end);
noChanceAll:SetPoint("TOPLEFT",noChance, 300, 7)

local last = noChanceFrame;
local x = 5;
local y = 5;
local count = 0;
for k,v in ipairs(L["UNOBTAINABLE_ITEM_REASONS"]) do
	if v[1]  == 1 then
		local filter = child:CreateCheckBox(v[3],
		function(self) 
			self:SetChecked(not app.GetDataMember("UnobtainableItemFilters")[k]);
			if not app.GetDataMember("FilterUnobtainableItems") then
				self:Disable();
				self:SetAlpha(0.2);
			else
				self:Enable();
				self:SetAlpha(1);
			end
		end,
		function(self)
			local val = app.GetDataMember("UnobtainableItemFilters")
			val[k]= not self:GetChecked()
			app.SetDataMember("UnobtainableItemFilters", val);
			settings:Refresh();
			app:RefreshData();
		end);
		filter:SetATTTooltip(v[2]);
		filter:SetPoint("TOPLEFT",last,x,-y)
		last = filter
		x = 0;
		y = 20;
		count = count + 1;
		if count == 5 then
			x = 300
			y = 5
			last = noChanceFrame
		end
	end
end

-- possible
local possChance = child:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
possChance:SetPoint("TOPLEFT", noChance, 0, -(noChanceFrame:GetHeight() + (2*20)))
possChance:SetText("有机会");

local possChanceFrame = CreateFrame("Frame", nil, child, "ThinBorderTemplate");
possChanceFrame:SetPoint("TOP",possChance,0,-20);
possChanceFrame:SetPoint("LEFT", child, 4, 0);
possChanceFrame:SetPoint("RIGHT", child, -4, 0);
possChanceFrame:SetHeight(75);

-- possible Everything
local possChanceAll = child:CreateCheckBox("启用所有 \"有机会\"",
function(self)
	local isTrue = true
	local val = app.GetDataMember("UnobtainableItemFilters")
	for k,v in ipairs(L["UNOBTAINABLE_ITEM_REASONS"]) do
		if v[1] == 2 then
			isTrue = isTrue and not val[k]
		end
	end
	self:SetChecked(isTrue);
	if not app.GetDataMember("FilterUnobtainableItems") then
		self:Disable();
		self:SetAlpha(0.2);
	else
		self:Enable();
		self:SetAlpha(1);
	end
end,
function(self)
	local val = app.GetDataMember("UnobtainableItemFilters")
	for k,v in ipairs(L["UNOBTAINABLE_ITEM_REASONS"]) do
		if v[1] == 2 then
			val[k] = not self:GetChecked()
		end
	end
	app.SetDataMember("UnobtainableItemFilters", val);
	settings:Refresh();
	app:RefreshData();
end);
possChanceAll:SetPoint("TOPLEFT",possChance, 300, 7)

local last = possChanceFrame;
local x = 5;
local y = 5;
local count = 0;
for k,v in ipairs(L["UNOBTAINABLE_ITEM_REASONS"]) do
	if v[1]  == 2 then
		local filter = child:CreateCheckBox(v[3],
		function(self) 
			self:SetChecked(not app.GetDataMember("UnobtainableItemFilters")[k]);
			if not app.GetDataMember("FilterUnobtainableItems") then
				self:Disable();
				self:SetAlpha(0.2);
			else
				self:Enable();
				self:SetAlpha(1);
			end
		end,
		function(self)
			local val = app.GetDataMember("UnobtainableItemFilters")
			val[k]= not self:GetChecked()
			app.SetDataMember("UnobtainableItemFilters", val);
			settings:Refresh();
			app:RefreshData();
		end);
		filter:SetATTTooltip(v[2]);
		filter:SetPoint("TOPLEFT",last,x,-y)
		last = filter
		x = 0;
		y = 20;
		count = count + 1;
		if count == 3 then
			x = 300
			y = 5
			last = possChanceFrame
		end
	end
end

-- high
local highChance = child:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
highChance:SetPoint("TOPLEFT", possChance, 0, -(possChanceFrame:GetHeight() + (2*20)))
highChance:SetText("很大机会");

local highChanceFrame = CreateFrame("Frame", nil, child, "ThinBorderTemplate");
highChanceFrame:SetPoint("TOP",highChance,0,-20);
highChanceFrame:SetPoint("LEFT", child, 4, 0);
highChanceFrame:SetPoint("RIGHT", child, -4, 0);
highChanceFrame:SetHeight(90);

-- high Everything
local highChanceAll = child:CreateCheckBox("启用所有 \"很大机会\"",
function(self)
	local isTrue = true
	local val = app.GetDataMember("UnobtainableItemFilters")
	for k,v in ipairs(L["UNOBTAINABLE_ITEM_REASONS"]) do
		if v[1] == 3 then
			isTrue = isTrue and not val[k]
		end
	end
	self:SetChecked(isTrue);
	if not app.GetDataMember("FilterUnobtainableItems") then
		self:Disable();
		self:SetAlpha(0.2);
	else
		self:Enable();
		self:SetAlpha(1);
	end
end,
function(self)
	local val = app.GetDataMember("UnobtainableItemFilters")
	for k,v in ipairs(L["UNOBTAINABLE_ITEM_REASONS"]) do
		if v[1] == 3 then
			val[k] = not self:GetChecked()
		end
	end
	app.SetDataMember("UnobtainableItemFilters", val);
	settings:Refresh();
	app:RefreshData();
end);
highChanceAll:SetPoint("TOPLEFT",highChance, 300, 7)

local last = highChanceFrame;
local x = 5;
local y = 5;
local count = 0;
for k,v in ipairs(L["UNOBTAINABLE_ITEM_REASONS"]) do
	if v[1] == 3 then
		local filter = child:CreateCheckBox(v[3],
		function(self) 
			self:SetChecked(not app.GetDataMember("UnobtainableItemFilters")[k]);
			if not app.GetDataMember("FilterUnobtainableItems") then
				self:Disable();
				self:SetAlpha(0.2);
			else
				self:Enable();
				self:SetAlpha(1);
			end
		end,
		function(self)
			local val = app.GetDataMember("UnobtainableItemFilters")
			val[k]= not self:GetChecked()
			app.SetDataMember("UnobtainableItemFilters", val);
			settings:Refresh();
			app:RefreshData();
		end);
		filter:SetATTTooltip(v[2]);
		filter:SetPoint("TOPLEFT",last,x,-y)
		last = filter
		x = 0;
		y = 20;
		count = count + 1;
		if count == 4 then
			x = 300
			y = 5
			last = highChanceFrame
		end
	end
end

-- Legacy
local legacy = child:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
legacy:SetPoint("TOPLEFT", highChance, 0, -(highChanceFrame:GetHeight() + (2*15)))
legacy:SetText("遗留");

local legacyFrame = CreateFrame("Frame", nil, child, "ThinBorderTemplate");
legacyFrame:SetPoint("TOP",legacy,0,-20);
legacyFrame:SetPoint("LEFT", child, 4, 0);
legacyFrame:SetPoint("RIGHT", child, -4, 0);
legacyFrame:SetHeight(150);

-- Legacy Everything
local legacyAll = child:CreateCheckBox("启用所有 \"遗留\"",
function(self)
	local isTrue = true
	local val = app.GetDataMember("UnobtainableItemFilters")
	for k,v in ipairs(L["UNOBTAINABLE_ITEM_REASONS"]) do
		if v[1] == 4 then
			isTrue = isTrue and not val[k]
		end
	end
	self:SetChecked(isTrue);
	if not app.GetDataMember("FilterUnobtainableItems") then
		self:Disable();
		self:SetAlpha(0.2);
	else
		self:Enable();
		self:SetAlpha(1);
	end
end,
function(self)
	local val = app.GetDataMember("UnobtainableItemFilters")
	for k,v in ipairs(L["UNOBTAINABLE_ITEM_REASONS"]) do
		if v[1] == 4 then
			val[k] = not self:GetChecked()
		end
	end
	app.SetDataMember("UnobtainableItemFilters", val);
	settings:Refresh();
	app:RefreshData();
end);
legacyAll:SetPoint("TOPLEFT",legacy, 300, 7)

local x = 5;
local y = 5;
local legacyWidth = 600;
for k,v in ipairs(L["UNOBTAINABLE_ITEM_REASONS"]) do
	if v[1]  == 4 then
		local filter = child:CreateCheckBox(v[3],
		function(self) 
			self:SetChecked(not app.GetDataMember("UnobtainableItemFilters")[k]);
			if not app.GetDataMember("FilterUnobtainableItems") then
				self:Disable();
				self:SetAlpha(0.2);
			else
				self:Enable();
				self:SetAlpha(1);
			end
		end,
		function(self)
			local val = app.GetDataMember("UnobtainableItemFilters")
			val[k]= not self:GetChecked()
			app.SetDataMember("UnobtainableItemFilters", val);
			settings:Refresh();
			app:RefreshData();
		end);
		filter:SetATTTooltip(v[2]);
		filter:SetPoint("TOPLEFT",legacyFrame,x,-y)
		
		x = x + (legacyWidth / 2);
		if x > legacyWidth then
			y = y + 20;
			x = 5;
		end
	end
end
end)();

------------------------------------------
-- The "Features" Tab.					--
------------------------------------------
(function()
local tab = settings:CreateTab("特征");
local TooltipLabel = settings:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
TooltipLabel:SetPoint("TOPLEFT", line, "BOTTOMLEFT", 8, -8);
TooltipLabel:SetJustifyH("LEFT");
TooltipLabel:SetText("鼠标提示");
TooltipLabel:Show();
table.insert(settings.MostRecentTab.objects, TooltipLabel);

local EnableTooltipInformationCheckBox = settings:CreateCheckBox("|CFFADD8E6启用鼠标提示|r",
function(self)
	self:SetChecked(settings:GetTooltipSetting("Enabled"));
end,
function(self)
	settings:SetTooltipSetting("Enabled", self:GetChecked());
end);
EnableTooltipInformationCheckBox:SetATTTooltip("如果希望在鼠标提示中查看att提供的信息，请启用此选项. 这包括其他玩家发送的物品链接，在拍卖行，在地下城助手，在你的包里，在世界上，在NPC上，等等.\n\n如果关闭此功能，则会严重降低快速确定是否需要杀BOSS徒或学习外观的能力.\n\n我们建议您保持此设置.");
EnableTooltipInformationCheckBox:SetPoint("TOPLEFT", TooltipLabel, "BOTTOMLEFT", 4, 0);

local DisplayInCombatCheckBox = settings:CreateCheckBox("在战斗中展示",
function(self)
	self:SetChecked(settings:GetTooltipSetting("DisplayInCombat"));
	if not settings:GetTooltipSetting("Enabled") then
		self:Disable();
		self:SetAlpha(0.2);
	else
		self:Enable();
		self:SetAlpha(1);
	end
end,
function(self)
	settings:SetTooltipSetting("DisplayInCombat", self:GetChecked());
end);
DisplayInCombatCheckBox:SetATTTooltip("如果要在战斗中呈现鼠标提示信息，请启用此选项.\n\n如果你正在使用你的史诗/史诗+公会进行攻击，你可能应该关闭这个设置以尽可能节省性能.\n\n当你正在查找旧的内容时，立即从BOSS那里知道你需要什么是很有用的.");
DisplayInCombatCheckBox:SetPoint("TOPLEFT", EnableTooltipInformationCheckBox, "BOTTOMLEFT", 8, 4);


local ShowCollectionProgressCheckBox = settings:CreateCheckBox("显示收集进度",
function(self)
	self:SetChecked(settings:GetTooltipSetting("Progress"));
	if not settings:GetTooltipSetting("Enabled") then
		self:Disable();
		self:SetAlpha(0.2);
	else
		self:Enable();
		self:SetAlpha(1);
	end
end,
function(self)
	settings:SetTooltipSetting("Progress", self:GetChecked());
end);
ShowCollectionProgressCheckBox:SetATTTooltip("如果希望在鼠标提示的右上角看到收集某个对象或完成某组对象的进度，请启用此选项.\n\n我们建议您保持此设置处于打开状态.");
ShowCollectionProgressCheckBox:SetPoint("TOPLEFT", DisplayInCombatCheckBox, "BOTTOMLEFT", 0, 4);

local ShortenProgressCheckBox = settings:CreateCheckBox("只显示图标",
function(self)
	self:SetChecked(settings:GetTooltipSetting("ShowIconOnly"));
	if not settings:GetTooltipSetting("Enabled") or not settings:GetTooltipSetting("Progress") then
		self:Disable();
		self:SetAlpha(0.2);
	else
		self:Enable();
		self:SetAlpha(1);
	end
end,
function(self)
	settings:SetTooltipSetting("ShowIconOnly", self:GetChecked());
end);
ShortenProgressCheckBox:SetATTTooltip("如果只想在右上角看到图标而不是图标和已收集/未收集的文本，请启用此选项.\n\n有些人喜欢更小的鼠标提示...");
ShortenProgressCheckBox:SetPoint("TOPLEFT", ShowCollectionProgressCheckBox, "BOTTOMLEFT", 8, 4);


local SummarizeThingsCheckBox = settings:CreateCheckBox("汇总",
function(self)
	self:SetChecked(settings:GetTooltipSetting("SummarizeThings"));
	if not settings:GetTooltipSetting("Enabled") then
		self:Disable();
		self:SetAlpha(0.2);
	else
		self:Enable();
		self:SetAlpha(1);
	end
end,
function(self)
	settings:SetTooltipSetting("SummarizeThings", self:GetChecked());
end);
SummarizeThingsCheckBox:SetATTTooltip("启用此选项可在鼠标提示中汇总. ");
SummarizeThingsCheckBox:SetPoint("TOPLEFT", ShortenProgressCheckBox, "BOTTOMLEFT", -8, 4);


local ShowCoordinatesCheckBox = settings:CreateCheckBox("显示坐标",
function(self)
	self:SetChecked(settings:GetTooltipSetting("Coordinates"));
	if not settings:GetTooltipSetting("Enabled") then
		self:Disable();
		self:SetAlpha(0.2);
	else
		self:Enable();
		self:SetAlpha(1);
	end
end,
function(self)
	settings:SetTooltipSetting("Coordinates", self:GetChecked());
end);
ShowCoordinatesCheckBox:SetATTTooltip("如果要将鼠标悬停在迷你列表中的条目上时查看鼠标提示中的坐标，请启用此选项.");
ShowCoordinatesCheckBox:SetPoint("TOPLEFT", SummarizeThingsCheckBox, "BOTTOMLEFT", 0, 4);

local ShowDescriptionsCheckBox = settings:CreateCheckBox("显示说明",
function(self)
	self:SetChecked(settings:GetTooltipSetting("Descriptions"));
	if not settings:GetTooltipSetting("Enabled") then
		self:Disable();
		self:SetAlpha(0.2);
	else
		self:Enable();
		self:SetAlpha(1);
	end
end,
function(self)
	settings:SetTooltipSetting("Descriptions", self:GetChecked());
end);
ShowDescriptionsCheckBox:SetATTTooltip("启用此选项可在工具提示中显示说明. 这可能包括地下城说明提供的描述性文字，或由认为有必要提供其他信息的投稿人添加的自定义描述.\n\n你可能想把这个打开.");
ShowDescriptionsCheckBox:SetPoint("TOPLEFT", ShowCoordinatesCheckBox, "BOTTOMLEFT", 0, 4);

local ShowKnownByCheckBox = settings:CreateCheckBox("显示已知",
function(self)
	self:SetChecked(settings:GetTooltipSetting("KnownBy"));
	if not settings:GetTooltipSetting("Enabled") then
		self:Disable();
		self:SetAlpha(0.2);
	else
		self:Enable();
		self:SetAlpha(1);
	end
end,
function(self)
	settings:SetTooltipSetting("KnownBy", self:GetChecked());
end);
ShowKnownByCheckBox:SetATTTooltip("如果要在鼠标提示中查看知道此配方的所有服务器上的完整角色列表，请启用此选项.");
ShowKnownByCheckBox:SetPoint("TOPLEFT", ShowDescriptionsCheckBox, "BOTTOMLEFT", 0, 4);

local ShowModelsCheckBox = settings:CreateCheckBox("显示模型预览",
function(self)
	self:SetChecked(settings:GetTooltipSetting("Models"));
	if not settings:GetTooltipSetting("Enabled") then
		self:Disable();
		self:SetAlpha(0.2);
	else
		self:Enable();
		self:SetAlpha(1);
	end
end,
function(self)
	settings:SetTooltipSetting("Models", self:GetChecked());
end);
ShowModelsCheckBox:SetATTTooltip("启用此选项可在预览中显示模型，而不是鼠标提示上的图标.\n\n此选项可以帮助您识别稀有怪或供应商的样子. 出于这个原因保持开启可能是一个好主意.");
ShowModelsCheckBox:SetPoint("TOPLEFT", ShowKnownByCheckBox, "BOTTOMLEFT", 0, 4);


local ShowSharedAppearancesCheckBox = settings:CreateCheckBox("显示共享外观",
function(self)
	self:SetChecked(settings:GetTooltipSetting("SharedAppearances"));
	if not settings:GetTooltipSetting("Enabled") then
		self:Disable();
		self:SetAlpha(0.2);
	else
		self:Enable();
		self:SetAlpha(1);
	end
end,
function(self)
	settings:SetTooltipSetting("SharedAppearances", self:GetChecked());
end);
ShowSharedAppearancesCheckBox:SetATTTooltip("启用此选项可在鼠标提示中查看共享相似外观的项目.\n\n注意: 列表中显示与装备类型不匹配的物品. 这是为了帮助您诊断收集进度.\n\n如果您对此感到困惑，从ATT v1.5.0开始，您可以右键单击该项目以将项目及其共享外观打开到他们自己的独立迷你列表中.");
ShowSharedAppearancesCheckBox:SetPoint("TOPLEFT", ShowModelsCheckBox, "BOTTOMLEFT", 0, 4);

local IncludeOriginalSourceCheckBox = settings:CreateCheckBox("包括原始来源",
function(self)
	self:SetChecked(settings:GetTooltipSetting("IncludeOriginalSource"));
	if not settings:GetTooltipSetting("Enabled") then
		self:Disable();
		self:SetAlpha(0.2);
	else
		self:Enable();
		self:SetAlpha(1);
	end
end,
function(self)
	settings:SetTooltipSetting("IncludeOriginalSource", self:GetChecked());
end);
IncludeOriginalSourceCheckBox:SetATTTooltip("如果您确实喜欢在鼠标提示的“共享外观”列表中查看原始源信息，请启用此选项.");
IncludeOriginalSourceCheckBox:SetPoint("TOPLEFT", ShowSharedAppearancesCheckBox, "BOTTOMLEFT", 8, 4);

local OnlyShowRelevantSharedAppearancesCheckBox = settings:CreateCheckBox("只有相关",
function(self)
	self:SetChecked(settings:GetTooltipSetting("OnlyShowRelevantSharedAppearances"));
	if not settings:GetTooltipSetting("Enabled") then
		self:Disable();
		self:SetAlpha(0.2);
	else
		self:Enable();
		self:SetAlpha(1);
	end
end,
function(self)
	settings:SetTooltipSetting("OnlyShowRelevantSharedAppearances", self:GetChecked());
end);
OnlyShowRelevantSharedAppearancesCheckBox:SetATTTooltip("如果您只想查看角色可以解锁的共享外观，请启用此选项.\n\n注意: 我们建议您将其关闭，因为知道项目的解锁要求有助于确定物品未收集的原因.");
OnlyShowRelevantSharedAppearancesCheckBox:SetPoint("TOPLEFT", IncludeOriginalSourceCheckBox, "BOTTOMLEFT", 0, 4);


local ShowClassRequirementsCheckBox = settings:CreateCheckBox("显示职业要求",
function(self)
	self:SetChecked(settings:GetTooltipSetting("ClassRequirements"));
	if not settings:GetTooltipSetting("Enabled") then
		self:Disable();
		self:SetAlpha(0.2);
	else
		self:Enable();
		self:SetAlpha(1);
	end
end,
function(self)
	settings:SetTooltipSetting("ClassRequirements", self:GetChecked());
end);
ShowClassRequirementsCheckBox:SetATTTooltip("如果要在工具提示中查看职业需求的完整列表，请启用此选项.");
ShowClassRequirementsCheckBox:SetPoint("TOPLEFT", OnlyShowRelevantSharedAppearancesCheckBox, "BOTTOMLEFT", -8, 4);

local ShowRaceRequirementsCheckBox = settings:CreateCheckBox("显示种族要求",
function(self)
	self:SetChecked(settings:GetTooltipSetting("RaceRequirements"));
	if not settings:GetTooltipSetting("Enabled") then
		self:Disable();
		self:SetAlpha(0.2);
	else
		self:Enable();
		self:SetAlpha(1);
	end
end,
function(self)
	settings:SetTooltipSetting("RaceRequirements", self:GetChecked());
end);
ShowRaceRequirementsCheckBox:SetATTTooltip("如果要在工具提示中查看完整的种族要求列表，请启用此选项.");
ShowRaceRequirementsCheckBox:SetPoint("TOPLEFT", ShowClassRequirementsCheckBox, "BOTTOMLEFT", 0, 4);

local ShowSpecializationRequirementsCheckBox = settings:CreateCheckBox("显示专业要求",
function(self)
	self:SetChecked(settings:GetTooltipSetting("SpecializationRequirements"));
	if not settings:GetTooltipSetting("Enabled") then
		self:Disable();
		self:SetAlpha(0.2);
	else
		self:Enable();
		self:SetAlpha(1);
	end
end,
function(self)
	settings:SetTooltipSetting("SpecializationRequirements", self:GetChecked());
end);
ShowSpecializationRequirementsCheckBox:SetATTTooltip("启用此选项可显示项目工具提示中物品的战利品专业要求.\n\n注意: 无论此设置如何，这些图标仍将显示在ATT迷你列表中.");
ShowSpecializationRequirementsCheckBox:SetPoint("TOPLEFT", ShowRaceRequirementsCheckBox, "BOTTOMLEFT", 0, 4);

local ShowSourceLocationsCheckBox = settings:CreateCheckBox("显示源位置",
function(self)
	self:SetChecked(settings:GetTooltipSetting("SourceLocations"));
	if not settings:GetTooltipSetting("Enabled") then
		self:Disable();
		self:SetAlpha(0.2);
	else
		self:Enable();
		self:SetAlpha(1);
	end
end,
function(self)
	settings:SetTooltipSetting("SourceLocations", self:GetChecked());
end);
ShowSourceLocationsCheckBox:SetATTTooltip("如果要在工具提示中查看ATT数据库中对象的完整源位置路径，请启用此选项.");
ShowSourceLocationsCheckBox:SetPoint("TOPLEFT", ShowSpecializationRequirementsCheckBox, "BOTTOMLEFT", 0, 4);

local ShowCompletedSourceLocationsForCheckBox = settings:CreateCheckBox("已完成的源",
function(self)
	self:SetChecked(settings:GetTooltipSetting("SourceLocations:Completed"));
	if not settings:GetTooltipSetting("Enabled") or not settings:GetTooltipSetting("SourceLocations") then
		self:Disable();
		self:SetAlpha(0.2);
	else
		self:Enable();
		self:SetAlpha(1);
	end
end,
function(self)
	settings:SetTooltipSetting("SourceLocations:Completed", self:GetChecked());
end);
ShowCompletedSourceLocationsForCheckBox:SetATTTooltip("如果要在工具提示中查看已完成的源位置，请启用此选项.\n\n.");
ShowCompletedSourceLocationsForCheckBox:SetPoint("TOPLEFT", ShowSourceLocationsCheckBox, "BOTTOMLEFT", 8, 4);

local ShowSourceLocationsForCreaturesCheckBox = settings:CreateCheckBox("人物",
function(self)
	self:SetChecked(settings:GetTooltipSetting("SourceLocations:Creatures"));
	if not settings:GetTooltipSetting("Enabled") or not settings:GetTooltipSetting("SourceLocations") then
		self:Disable();
		self:SetAlpha(0.2);
	else
		self:Enable();
		self:SetAlpha(1);
	end
end,
function(self)
	settings:SetTooltipSetting("SourceLocations:Creatures", self:GetChecked());
end);
ShowSourceLocationsForCreaturesCheckBox:SetATTTooltip("如果要查看人物的源位置，请启用此选项.");
ShowSourceLocationsForCreaturesCheckBox:SetPoint("TOPLEFT", ShowCompletedSourceLocationsForCheckBox, "BOTTOMLEFT", 0, 4);

local ShowSourceLocationsForThingsCheckBox = settings:CreateCheckBox("事物",
function(self)
	self:SetChecked(settings:GetTooltipSetting("SourceLocations:Things"));
	if not settings:GetTooltipSetting("Enabled") or not settings:GetTooltipSetting("SourceLocations") then
		self:Disable();
		self:SetAlpha(0.2);
	else
		self:Enable();
		self:SetAlpha(1);
	end
end,
function(self)
	settings:SetTooltipSetting("SourceLocations:Things", self:GetChecked());
end);
ShowSourceLocationsForThingsCheckBox:SetATTTooltip("如果要查看事物的源位置，请启用此选项.");
ShowSourceLocationsForThingsCheckBox:SetPoint("TOPLEFT", ShowSourceLocationsForCreaturesCheckBox, "BOTTOMLEFT", 0, 4);

-- This creates the "Locations" slider.
local LocationsSlider = CreateFrame("Slider", "ATTLocationsSlider", settings, "OptionsSliderTemplate");
LocationsSlider:SetPoint("LEFT", ShowSourceLocationsCheckBox, "LEFT", 0, 0);
LocationsSlider:SetPoint("TOP", ShowSourceLocationsForThingsCheckBox, "BOTTOM", 0, -16);
table.insert(settings.MostRecentTab.objects, LocationsSlider);
settings.LocationsSlider = LocationsSlider;
LocationsSlider.tooltipText = '使用此选项可自定义要在鼠标提示中显示的源位置数.\n\n注意: 这也将根据显示元素的总数等于显示元素的总数来显示其他来源的“X”个数，然后只显示最后一个来源.\n\n默认: 5';
LocationsSlider:SetOrientation('HORIZONTAL');
LocationsSlider:SetWidth(180);
LocationsSlider:SetHeight(20);
LocationsSlider:SetValueStep(1);
LocationsSlider:SetMinMaxValues(1, 40);
LocationsSlider:SetObeyStepOnDrag(true);
_G[LocationsSlider:GetName() .. 'Low']:SetText('1')
_G[LocationsSlider:GetName() .. 'High']:SetText('40')
_G[LocationsSlider:GetName() .. 'Text']:SetText("显示的源位置")
LocationsSlider.Label = LocationsSlider:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall");
LocationsSlider.Label:SetPoint("TOP", LocationsSlider, "BOTTOM", 0, 0);
LocationsSlider.Label:SetText(LocationsSlider:GetValue());
LocationsSlider:SetScript("OnValueChanged", function(self, newValue)
	self.Label:SetText(newValue);
	if newValue == settings:GetTooltipSetting("Locations") then
		return 1;
	end
	settings:SetTooltipSetting("Locations", newValue)
	app:UpdateWindows();
end);
LocationsSlider.OnRefresh = function(self)
	if not settings:GetTooltipSetting("Enabled") or not settings:GetTooltipSetting("SourceLocations") then
		self:Disable();
		self:SetAlpha(0.2);
	else
		self:Enable();
		self:SetAlpha(1);
	end
end;


local ModulesLabel = settings:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
ModulesLabel:SetPoint("TOPRIGHT", line, "BOTTOMRIGHT", -138, -8);
ModulesLabel:SetJustifyH("LEFT");
ModulesLabel:SetText("模块 & 迷你列表");
ModulesLabel:Show();
table.insert(settings.MostRecentTab.objects, ModulesLabel);

local OpenMainListAutomatically = settings:CreateCheckBox("自动打开主列表",
function(self)
	self:SetChecked(settings:GetTooltipSetting("Auto:MainList"));
end,
function(self)
	settings:SetTooltipSetting("Auto:MainList", self:GetChecked());
end);
OpenMainListAutomatically:SetATTTooltip("如果要在登录时自动打开主列表，请启用此选项.\n\n快捷命令: /att");
OpenMainListAutomatically:SetPoint("TOPLEFT", ModulesLabel, "BOTTOMLEFT", 4, 0);

local OpenMiniListAutomatically = settings:CreateCheckBox("自动打开迷你列表",
function(self)
	self:SetChecked(settings:GetTooltipSetting("Auto:MiniList"));
end,
function(self)
	settings:SetTooltipSetting("Auto:MiniList", self:GetChecked());
end);
OpenMiniListAutomatically:SetATTTooltip("如果要查看当前区域中可以收集的所有内容，请启用此选项. 更改区域时，列表将自动切换. 有些人不喜欢这个功能，但是当你进行solo时，这个功能非常有用.快捷命令: /att mini");
OpenMiniListAutomatically:SetPoint("TOPLEFT", OpenMainListAutomatically, "BOTTOMLEFT", 0, 4);

local OpenProfessionListAutomatically = settings:CreateCheckBox("自动打开专业列表",
function(self)
	self:SetChecked(settings:GetTooltipSetting("Auto:ProfessionList"));
end,
function(self)
	settings:SetTooltipSetting("Auto:ProfessionList", self:GetChecked());
end);
OpenProfessionListAutomatically:SetATTTooltip("如果您希望在打开专业时打开并刷新职业列表，请启用此选项. 由于暴雪强加的API限制，插件可以与您的专业数据进行交互的时间是打开时. 当您更改为其他专业时，列表将自动切换.\n\n我们不建议禁用此选项，因为它可能会阻止配方正确跟踪.\n\n快捷命令: /att prof");
OpenProfessionListAutomatically:SetPoint("TOPLEFT", OpenMiniListAutomatically, "BOTTOMLEFT", 0, 4);

local OpenRaidAssistantAutomatically = settings:CreateCheckBox("自动打开Raid助手",
function(self)
	self:SetChecked(settings:GetTooltipSetting("Auto:RaidAssistant"));
end,
function(self)
	settings:SetTooltipSetting("Auto:RaidAssistant", self:GetChecked());
end);
OpenRaidAssistantAutomatically:SetATTTooltip("如果要查看名为“RAID助手”的备用组/队伍/RAID设置管理器，请启用此选项. 当组设置更改时，列表将自动更新.\n\n快捷命令: /attra");
OpenRaidAssistantAutomatically:SetPoint("TOPLEFT", OpenProfessionListAutomatically, "BOTTOMLEFT", 0, 4);

local OpenWorldQuestsListAutomatically = settings:CreateCheckBox("自动打开世界任务列表",
function(self)
	self:SetChecked(settings:GetTooltipSetting("Auto:WorldQuestsList"));
end,
function(self)
	settings:SetTooltipSetting("Auto:WorldQuestsList", self:GetChecked());
end);
OpenWorldQuestsListAutomatically:SetATTTooltip("如果希望“世界任务”列表自动显示，请启用此选项. 当您切换区域时，列表将自动更新.\n\nn快捷命令: /attwq");
OpenWorldQuestsListAutomatically:SetPoint("TOPLEFT", OpenRaidAssistantAutomatically, "BOTTOMLEFT", 0, 4);

local ShowCurrenciesInWorldQuestsList = settings:CreateCheckBox("将货币视为容器",
function(self)
	self:SetChecked(settings:GetTooltipSetting("WorldQuestsList:Currencies"));
end,
function(self)
	settings:SetTooltipSetting("WorldQuestsList:Currencies", self:GetChecked());
end);
ShowCurrenciesInWorldQuestsList:SetATTTooltip("如果您希望将世界任务授予的货币视为列表中用于获取的所有内容都计为+1，则启用此选项.");
ShowCurrenciesInWorldQuestsList:SetPoint("TOPLEFT", OpenWorldQuestsListAutomatically, "BOTTOMLEFT", 4, 4);

local DebuggingLabel = settings:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
DebuggingLabel:SetPoint("TOPLEFT", ShowCurrenciesInWorldQuestsList, "BOTTOMLEFT", -8, -8);
DebuggingLabel:SetJustifyH("LEFT");
DebuggingLabel:SetText("调试");
DebuggingLabel:Show();
table.insert(settings.MostRecentTab.objects, DebuggingLabel);
local ids = {["achievementID"] = "Achievement ID",
	["artifactID"] = "Artifact ID",
	["bonusID"] = "Bonus ID",
	["creatureID"] = "Creature ID",
	["creatures"] = "Creatures List",
	["currencyID"] = "Currency ID",
	["difficultyID"] = "Difficulty ID",
	["displayID"] = "Display ID",
	["encounterID"] = "Encounter ID",
	["factionID"] = "Faction ID",
	["filterID"] = "Filter ID",
	["fileID"] = "File ID",
	["illusionID"] = "Illusion ID",
	["instanceID"] = "Instance ID",
	["itemID"] = "Item ID",
	["itemString"] = "Item String",
	["mapID"] = "Map ID",
	["modID"] = "Mod ID",
	["objectID"] = "Object ID",
	["questID"] = "Quest ID",
	["QuestGivers"] = "Quest Givers",
	["sourceID"] = "Source ID",
	["speciesID"] = "Species ID",
	["spellID"] = "Spell ID",
	["tierID"] = "Tier ID",
	["titleID"] = "Title ID",
	["visualID"] = "Visual ID",
};
local last = nil;
for _,id in pairs({"achievementID","artifactID","bonusID","creatureID","creatures","currencyID","difficultyID","displayID","encounterID","factionID","fileID","filterID","illusionID","instanceID"}) do
	local filter = settings:CreateCheckBox(ids[id],
	function(self) 
		self:SetChecked(settings:GetTooltipSetting(id));
	end,
	function(self)
		settings:SetTooltipSetting(id, self:GetChecked());
		settings:Refresh();
	end);
	if not last then
		filter:SetPoint("TOPLEFT", DebuggingLabel, "BOTTOMLEFT", 4, 0);
	else
		filter:SetPoint("TOPLEFT", last, "BOTTOMLEFT", 0, 4);
	end
	last = filter;
end
last = nil;
for _,id in pairs({"itemID","itemString", "mapID","modID","objectID","questID","QuestGivers","sourceID","speciesID","spellID","tierID","titleID","visualID"}) do
	local filter = settings:CreateCheckBox(ids[id],
	function(self) 
		self:SetChecked(settings:GetTooltipSetting(id));
	end,
	function(self)
		settings:SetTooltipSetting(id, self:GetChecked());
		settings:Refresh();
	end);
	if not last then
		filter:SetPoint("TOPLEFT", DebuggingLabel, "BOTTOMLEFT", 164, 0);
	else
		filter:SetPoint("TOPLEFT", last, "BOTTOMLEFT", 0, 4);
	end
	last = filter;
end
end)();

------------------------------------------
-- The "About/Help" Tab.				--
------------------------------------------
(function()
local tab = settings:CreateTab("关于/帮助");
local AboutText = settings:CreateFontString(nil, "ARTWORK", "GameFontNormal");
AboutText:SetPoint("TOPLEFT", line, "BOTTOMLEFT", 8, -8);
AboutText:SetPoint("TOPRIGHT", line, "BOTTOMRIGHT", -8, -8);
AboutText:SetJustifyH("LEFT");
AboutText:SetText(L["TITLE"] .. " |CFFFFFFFFis a collection tracking addon that shows you where and how to get everything in the game! We have a large community of users on our Discord (link at the bottom) where you can ask questions, submit suggestions as well as Report Bugs / Missing Items. If you find something collectible or a quest that isn't documented, you can tell us on the Discord, or for the more technical savy, we have a Git that you may contribute directly to.\n\nWhile we do strive for completion, there's a lot of stuff getting added into the game each patch, so if we're missing something, please understand that we're a small team trying to keep up with changes as well as collect things ourselves. :D\n\nFeel free to ask me questions when I'm streaming and I'll try my best to answer it, even if it's not directly related to ATT. (general WoW Addon Programming as well)\n\n- |r|Cffff8000Crieve (DFortun81)|CFFFFFFFF\n\nPS: As a community, we're currently focusing on Legion Raid Transmog, so if you're interested in this, we form groups on Fridays and Saturdays at 3 PM Arizona Time. Search Premade Group finder for \"CRIEVE\" around this time and you'll likely find our group!\n\n\n\nI keep getting this question:\nYes, there will be a version of ATT for Classic WoW. It will simply be a loot and quest tracker as obviously there will be no transmog collecting in Classic. (nor should there be)\n\nYes, I intend to play Classic WoW, but between working full time and developing the two versions of the addon, there won't be a lot of time for raiding.\n\nNo, ATT is not the addon that places icons on your bag icons. That's CanIMogIt and Caerdon Wardrobe!\n\nWebsite for comparing Collections coming Soon™.|r");
AboutText:Show();
table.insert(settings.MostRecentTab.objects, AboutText);

local ShoutoutText = settings:CreateFontString(nil, "ARTWORK", "GameFontNormal");
ShoutoutText:SetPoint("LEFT", AboutText, "LEFT", 0, 0);
ShoutoutText:SetPoint("RIGHT", AboutText, "RIGHT", 0, 0);
ShoutoutText:SetPoint("BOTTOM", settings, "BOTTOM", 0, 8);
ShoutoutText:SetJustifyH("LEFT");
ShoutoutText:SetText("Additional Contributors: |CFFFFFFFF(in order of joining the team)\nDaktar, Lucetia, Slumber, Gold, Avella, Aiue, Dead Serious, Oiche, Oxlotus, Eiltherune, Blueyleader, Iyanden, Pr3vention, BigBlaris, Talonzor, Heallie, Eckhardt, Boohyaka, Sadidorf, Sanctuari and the rest of the ALL THE THINGS Discord!\n\nSpecial Shoutout to AmiYuy (CanIMogIt) and Caerdon (Caerdon Wardrobe).|r  " .. L["COLLECTED_ICON"] .. " " .. L["COLLECTED_APPEARANCE_ICON"] .. " " ..L["NOT_COLLECTED_ICON"] .. "\n|CFFFFFFFFYou should absolutely download their addons to get the collection icons on items in your bags!|r");
ShoutoutText:Show();
table.insert(settings.MostRecentTab.objects, ShoutoutText);
end)();