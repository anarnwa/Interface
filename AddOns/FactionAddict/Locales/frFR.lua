if GetLocale() == "frFR" then
	if not FactionAddictLocalization then
		FactionAddictLocalization = {}
	end

-- Titles
FactionAddictLocalization["ADDON_TITLE"] = "Faction Addict"

-- tab labels at bottom of addon
FactionAddictLocalization["TAB1_LABEL"] = "Factions"
FactionAddictLocalization["TAB2_LABEL"] = "Log"
FactionAddictLocalization["TAB3_LABEL"] = "Config"
FactionAddictLocalization["TAB4_LABEL"] = "About"

-- Error Messages
FactionAddictLocalization["ERROR1"] = "No factions to show!\n\nCheck config and standing filter."

-- Tooltips
FactionAddictLocalization["LAUNCHER_TT"] = "Open/Close Faction Addict"
FactionAddictLocalization["CONFIG_TT_CF"] = "Show Classic WoW factions."
FactionAddictLocalization["CONFIG_TT_BC"] = "Show Burning Crusade factions."
FactionAddictLocalization["CONFIG_TT_WOTLK"] = "Show Wrath of the Lich King factions."
FactionAddictLocalization["CONFIG_TT_CATA"] = "Show Cataclysm factions."
FactionAddictLocalization["CONFIG_TT_MOP"] = "Show Mists of Pandaria factions."
FactionAddictLocalization["CONFIG_TT_WOD"] = "Show Warlords of Draenor factions."
FactionAddictLocalization["CONFIG_TT_LG"] = "Show Legion factions."
FactionAddictLocalization["CONFIG_TT_BFA"] = "Show Battle for Azeroth factions."
FactionAddictLocalization["CONFIG_TT_OrderPct"] = "Order factions by percent to exalted."
FactionAddictLocalization["CONFIG_TT_OrderName"] = "Order factions by faction name."
FactionAddictLocalization["CONFIG_TT_AO"] = "Show Alliance only factions."
FactionAddictLocalization["CONFIG_TT_HO"] = "Show Horde only factions."
FactionAddictLocalization["CONFIG_TT_AUTOBAR"] = "Automatically change the reputation bar to faction with last reputation gain."
FactionAddictLocalization["CONFIG_TT_HIDEINACTIVE"] = "Hide factions you've set as Inactive in the addon. Otherwise Inactive factions are moved to the botton of the list with a red background."
FactionAddictLocalization["CHECKBUTTON_TT_SETINACTIVE"] = "Move this faction to the bottom of the Factions list. (Inactive factions have a red background and may also be hidden based on Config settings.)"
FactionAddictLocalization["TAB1_TT"] = FactionAddictLocalization["TAB1_LABEL"]
FactionAddictLocalization["TAB2_TT"] = FactionAddictLocalization["TAB2_LABEL"]
FactionAddictLocalization["TAB3_TT"] = FactionAddictLocalization["TAB3_LABEL"]
FactionAddictLocalization["TAB4_TT"] = FactionAddictLocalization["TAB4_LABEL"]
FactionAddictLocalization["CONFIG_MENU_TT"] = "Faction Standing Filter"
FactionAddictLocalization["ACHIEVEMENT_TT_TITLE"] = "Exalted Achievements:"
FactionAddictLocalization["SEARCH_TOGGLE"] = "Toggle Search"

-- Tab1 - factions text
FactionAddictLocalization["TAB1_DESC_TXT"] = "Click a faction for more info."
FactionAddictLocalization["KNOWN_TXT"] = "Known: "
FactionAddictLocalization["SHOWN_TXT"] = "Shown: "
FactionAddictLocalization["EXALTED_TXT"] = "Exalted: "
FactionAddictLocalization["NEXT_ACHIEV_TXT"] = "Next Achievement: "

-- Tab2 - log text
FactionAddictLocalization["TAB2_DESC_TXT"] = "Reputation Log"
FactionAddictLocalization["TAB2_LASTGAIN_TXT"] = "Last Gain"
FactionAddictLocalization["TAB2_NOGAIN_TXT"] = "None This Session"
FactionAddictLocalization["TAB2_SESSIONTOTAL_TXT"] = "Session Total: "

-- Tab3 - config text
FactionAddictLocalization["TAB3_DESC_TXT"] = "Configuration"
FactionAddictLocalization["TAB3_DISPLAY_CONFIG_TXT"] = "Which factions to display?"
FactionAddictLocalization["TAB3_DISPLAY_ORDER_TXT"] = "Order factions by"
FactionAddictLocalization["TAB3_DISPLAY_FILTER"] = "Faction Filter"
FactionAddictLocalization["TAB3_DISPLAY_OPTIONS"] = "Options"
FactionAddictLocalization["TAB3_CONFIG_CF"] = "Classic Factions"
FactionAddictLocalization["TAB3_CONFIG_BC"] = "Burning Crusade Factions"
FactionAddictLocalization["TAB3_CONFIG_WOTLK"] = "Wrath of the Lich King Factions"
FactionAddictLocalization["TAB3_CONFIG_CATA"] = "Cataclysm Factions"
FactionAddictLocalization["TAB3_CONFIG_MOP"] = "Mists of Pandaria Factions"
FactionAddictLocalization["TAB3_CONFIG_WOD"] = "Warlords of Draenor Factions"
FactionAddictLocalization["TAB3_CONFIG_LG"] = "Legion Factions"
FactionAddictLocalization["TAB3_CONFIG_BFA"] = "Battle for Azeroth Factions"
FactionAddictLocalization["TAB3_CONFIG_ORDER_PCT"] = "% to Exalted"
FactionAddictLocalization["TAB3_CONFIG_ORDER_NAME"] = "Faction Name"
FactionAddictLocalization["TAB3_CONFIG_ALLIANCE_ONLY"] = "Show Alliance Only Factions"
FactionAddictLocalization["TAB3_CONFIG_HORDE_ONLY"] = "Show Horde Only Factions"
FactionAddictLocalization["TAB3_CONFIG_AUTOBAR"] = "Auto-Change Reputation Bar"
FactionAddictLocalization["TAB3_CONFIG_HIDEINACTIVE"] = "Hide Inactive Factions"

-- Tab4 - about text
FactionAddictLocalization["TAB4_DESC_TXT"] = "About Faction Addict"
FactionAddictLocalization["VERSION_TXT"] = "version: "
FactionAddictLocalization["ABOUT_TXT"] = "Faction Addict is an addon that helps the player easily view and track information related to the various factions in the game. Great for those working towards exalted reputations with different factions. |n|nUse slash commands |cFFFF0000/fa|r or |cFFFF0000/factionaddict|r to open and/or close the window. The default ui reputation panel also has a launch button in the upper-right corner.|n|nDownload updates and leave comments at: |cFFFFFF00wowinterface.com|r and |cFFFFFF00wow.curse.com|r|n|nAuthored by: |cFFFFFF00gmz323 (Greg)|r"

-- Info Window
FactionAddictLocalization["LAUNCH_WATCH_PANEL_TXT"] = "Launch Watch Panel"
FactionAddictLocalization["FACTION_URL_TXT"] = "https://www.wowhead.com/faction="
FactionAddictLocalization["PCT_TO_EXALTED_TXT"] = "Pct to Exalted: "
FactionAddictLocalization["PCT_TO_REWARD_TXT"] = "Pct to Next Reward: "
FactionAddictLocalization["CATEGORY_TXT"] = "Category: "

-- Info Window - Categories
FactionAddictLocalization["CATEGORY_ALLIANCE_TXT"] = "Alliance"
FactionAddictLocalization["CATEGORY_ALLIANCEFORCES_TXT"] = "Alliance Forces"
FactionAddictLocalization["CATEGORY_ALLIANCEVANGUARD_TXT"] = "Alliance Vanguard"
FactionAddictLocalization["CATEGORY_CATACLYSM_TXT"] = "Cataclysm"
FactionAddictLocalization["CATEGORY_CLASSIC_TXT"] = "Classic"
FactionAddictLocalization["CATEGORY_GUILD_TXT"] = "Guild"
FactionAddictLocalization["CATEGORY_HORDE_TXT"] = "Horde"
FactionAddictLocalization["CATEGORY_HORDEEXP_TXT"] = "Horde Expedition"
FactionAddictLocalization["CATEGORY_OTHER_TXT"] = "Other"
FactionAddictLocalization["CATEGORY_SHATTRATH_TXT"] = "Shattrath City"
FactionAddictLocalization["CATEGORY_SHOLAZAR_TXT"] = "Sholazar Basin"
FactionAddictLocalization["CATEGORY_STEAMWHEEDLE_TXT"] = "Steamwheedle Cartel"
FactionAddictLocalization["CATEGORY_TBC_TXT"] = "The Burning Crusade"
FactionAddictLocalization["CATEGORY_WOTLK_TXT"] = "Wrath of the Lich King"
FactionAddictLocalization["CATEGORY_HORDEFORCES_TXT"] = "Horde Forces"
FactionAddictLocalization["CATEGORY_MOP_TXT"] = "Mists of Pandaria"
FactionAddictLocalization["CATEGORY_WOD_TXT"] = "Warlords of Draenor"
FactionAddictLocalization["CATEGORY_BARRACKSBODYGUARDS_TXT"] = "Barracks Bodyguards"
FactionAddictLocalization["CATEGORY_LEGION_TXT"] = "Legion"
FactionAddictLocalization["CATEGORY_BFA_TXT"] = "Battle for Azeroth"

-- Standing Filter (Tab1 - dropdown)
FactionAddictLocalization["STANDING_FILTER_TITLE_TXT"] =    "Standing Filter"
FactionAddictLocalization["STANDING_FILTER_LABEL_8_TXT"] =  "(42,000+)"
FactionAddictLocalization["STANDING_FILTER_LABEL_7_TXT"] =  "(21,000 to 42,000)"
FactionAddictLocalization["STANDING_FILTER_LABEL_6_TXT"] =  "(9,000 to 21,000)"
FactionAddictLocalization["STANDING_FILTER_LABEL_5_TXT"] =  "(3,000 to 9,000)"
FactionAddictLocalization["STANDING_FILTER_LABEL_4B_TXT"] = "(1 to 3,000)"
FactionAddictLocalization["STANDING_FILTER_LABEL_4A_TXT"] = "(=0)"
FactionAddictLocalization["STANDING_FILTER_LABEL_3_TXT"] =  "(-3,000 to 0)"
FactionAddictLocalization["STANDING_FILTER_LABEL_2_TXT"] =  "(-6,000 to -3,000)"
FactionAddictLocalization["STANDING_FILTER_LABEL_1_TXT"] =  "(-42,000 to -6,000)"

-- Log date (Format: D = weekday, d = day, m = month, y = year)
FactionAddictLocalization["Monday"] = "Lundi"
FactionAddictLocalization["Tuesday"] = "Mardi"
FactionAddictLocalization["Wednesday"] = "Mercredi"
FactionAddictLocalization["Thursday"] = "Jeudi"
FactionAddictLocalization["Friday"] = "Vendredi"
FactionAddictLocalization["Saturday"] = "Samedi"
FactionAddictLocalization["Sunday"] = "Dimanche"
FactionAddictLocalization["DATE_FORMAT"] = "D m/d"

-- Misc Strings
FactionAddictLocalization["MISC_PARAGON_TXT"] = "Paragon"
end;