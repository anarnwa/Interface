

-- UTF-8 encoding table and Unicode characters:
	-- � = \195\188
	-- � = \195\156
	-- � = \195\164
	-- � = \195\132
	-- � = \195\182
	-- � = \195\150
	-- � = \195\159


if GetLocale() == "deDE" then
	if not FactionAddictLocalization then
		FactionAddictLocalization = {}
	end

-- Titles
FactionAddictLocalization["ADDON_TITLE"] = "Faction Addict"

-- tab labels at bottom of addon
FactionAddictLocalization["TAB1_LABEL"] = "Fraktionen"
FactionAddictLocalization["TAB2_LABEL"] = "Log"
FactionAddictLocalization["TAB3_LABEL"] = "Config"
FactionAddictLocalization["TAB4_LABEL"] = "\195\156ber"

-- Error Messages
FactionAddictLocalization["ERROR1"] = "Keine anzuzeigende Fraktion!\n\n\195\156berpr\195\188fe deine Einstellungen."

-- Tooltips
FactionAddictLocalization["LAUNCHER_TT"] = "\195\150ffnen/Schliessen Faction Addict"
FactionAddictLocalization["CONFIG_TT_CF"] = "Zeige Classic WoW Fraktionen."
FactionAddictLocalization["CONFIG_TT_BC"] = "Zeige Burning Crusade Fraktionen."
FactionAddictLocalization["CONFIG_TT_WOTLK"] = "Zeige Wrath of the Lich King Fraktionen."
FactionAddictLocalization["CONFIG_TT_CATA"] = "Zeige Cataclysm Fraktionen."
FactionAddictLocalization["CONFIG_TT_MOP"] = "Zeige Mists of Pandaria Fraktionen."
FactionAddictLocalization["CONFIG_TT_WOD"] = "Zeige Warlords of Draenor Fraktionen."
FactionAddictLocalization["CONFIG_TT_LG"] = "Zeige Legion Fraktionen."
FactionAddictLocalization["CONFIG_TT_BFA"] = "Show Battle for Azeroth factions."
FactionAddictLocalization["CONFIG_TT_OrderPct"] = "Sortiere Fraktionen von Prozent nach Erf\195\188rchtig."
FactionAddictLocalization["CONFIG_TT_OrderName"] = "Sortiere Fraktionen nach Fraktions Name."
FactionAddictLocalization["CONFIG_TT_AO"] = "Zeige nur Allianz Fraktion."
FactionAddictLocalization["CONFIG_TT_HO"] = "Zeige nur Horde Fraktion."
FactionAddictLocalization["CONFIG_TT_AUTOBAR"] = "Erfahrungsleiste Automatisch auf die Fraktion \195\164ndern von der man zuletzt Ruf erhalten hat."
-- 2 lines below - NEED LOCALIZATION UPDATE
FactionAddictLocalization["CONFIG_TT_HIDEINACTIVE"] = "Hide factions you've set as Inactive in the addon. Otherwise Inactive factions are moved to the botton of the list with a red background."
FactionAddictLocalization["CHECKBUTTON_TT_SETINACTIVE"] = "Move this faction to the bottom of the Factions list. (Inactive factions have a red background and may also be hidden based on Config settings.)"
FactionAddictLocalization["TAB1_TT"] = FactionAddictLocalization["TAB1_LABEL"]
FactionAddictLocalization["TAB2_TT"] = FactionAddictLocalization["TAB2_LABEL"]
FactionAddictLocalization["TAB3_TT"] = FactionAddictLocalization["TAB3_LABEL"]
FactionAddictLocalization["TAB4_TT"] = FactionAddictLocalization["TAB4_LABEL"]
FactionAddictLocalization["CONFIG_MENU_TT"] = "Fraktion Filter"
FactionAddictLocalization["ACHIEVEMENT_TT_TITLE"] = "Ehrf\195\188rchtige Faktions Erfolge:"
FactionAddictLocalization["SEARCH_TOGGLE"] = "Toggle Search"

-- Tab1 - factions text
FactionAddictLocalization["TAB1_DESC_TXT"] = "Klicke eine Fraktion f\195\188r mehr Infos."
FactionAddictLocalization["KNOWN_TXT"] = "Bekannt: "
FactionAddictLocalization["SHOWN_TXT"] = "Zeigen: "
FactionAddictLocalization["EXALTED_TXT"] = "Ehrf\195\188rchtig: "
FactionAddictLocalization["NEXT_ACHIEV_TXT"] = "N\195\164chster Erfolg: "

-- Tab2 - log text
FactionAddictLocalization["TAB2_DESC_TXT"] = "Ruf Log"
FactionAddictLocalization["TAB2_LASTGAIN_TXT"] = "Zuletzt erhalten"
FactionAddictLocalization["TAB2_NOGAIN_TXT"] = "Keinen in dieser Sitzung"
FactionAddictLocalization["TAB2_SESSIONTOTAL_TXT"] = "Insgesamt in dieser Sitzung: "

-- Tab3 - config text
FactionAddictLocalization["TAB3_DESC_TXT"] = "Konfiguration"
FactionAddictLocalization["TAB3_DISPLAY_CONFIG_TXT"] = "Welche Fraktionen angezeigen?"
FactionAddictLocalization["TAB3_DISPLAY_ORDER_TXT"] = "Sortiere Fraktionen nach"
FactionAddictLocalization["TAB3_DISPLAY_FILTER"] = "Fraktionen Filter"
FactionAddictLocalization["TAB3_DISPLAY_OPTIONS"] = "Optionen"
FactionAddictLocalization["TAB3_CONFIG_CF"] = "Classic Fraktionen"
FactionAddictLocalization["TAB3_CONFIG_BC"] = "Burning Crusade Fraktionen"
FactionAddictLocalization["TAB3_CONFIG_WOTLK"] = "Wrath of the Lich King Fraktionen"
FactionAddictLocalization["TAB3_CONFIG_CATA"] = "Cataclysm Fraktionen"
FactionAddictLocalization["TAB3_CONFIG_MOP"] = "Mists of Pandaria Fraktionen"
FactionAddictLocalization["TAB3_CONFIG_WOD"] = "Warlords of Draenor Fraktionen"
FactionAddictLocalization["TAB3_CONFIG_LG"] = "Legion Fraktionen"
FactionAddictLocalization["TAB3_CONFIG_BFA"] = "Battle for Azeroth Factions"
FactionAddictLocalization["TAB3_CONFIG_ORDER_PCT"] = "% bis Erf\195\188rchtig"
FactionAddictLocalization["TAB3_CONFIG_ORDER_NAME"] = "Fraktion Name"
FactionAddictLocalization["TAB3_CONFIG_ALLIANCE_ONLY"] = "Zeige nur Allianz Fraktionen"
FactionAddictLocalization["TAB3_CONFIG_HORDE_ONLY"] = "Zeige nur Horde Fraktionen"
FactionAddictLocalization["TAB3_CONFIG_AUTOBAR"] = "Erfahrungsleiste automatisch wechseln"
FactionAddictLocalization["TAB3_CONFIG_HIDEINACTIVE"] = "Verstecke inaktive Fraktionen"

-- Tab4 - about text
FactionAddictLocalization["TAB4_DESC_TXT"] = "\195\156ber Faction Addict"
FactionAddictLocalization["VERSION_TXT"] = "version: "
FactionAddictLocalization["ABOUT_TXT"] = "Faction Addict ist ein Addon, das dem Spieler dabei hilft, Informationen im Zusammenhang mit den verschiedenen Fraktionen im Spiel leicht und einfach zu verfolgen. Hervorragend f\195\188r diejenigen auf dem weg zu einem Erf\195\188rchtigen Ruf bei den verschiedenen Fraktionen. |n|nBenutze slash command |cFFFF0000/fa|r oder |cFFFF0000/factionaddict|r zum \195\150ffnen und/oder schliessen des Fensters. Das Standard Ruf Fenster besitzt ebenfalls einen \195\150ffnen Button in der oberen-rechten Ecke.|n|nDownloade Updates oder hinterlasse einen Kommentar auf: |cFFFFFF00wowinterface.com|r und |cFFFFFF00wow.curse.com|r|n|nAuthored by: |cFFFFFF00gmz323 (Greg)|r"

-- Info Window
FactionAddictLocalization["LAUNCH_WATCH_PANEL_TXT"] = "\195\150ffne Informations Panel"
FactionAddictLocalization["FACTION_URL_TXT"] = "https://de.wowhead.com/faction="
FactionAddictLocalization["PCT_TO_EXALTED_TXT"] = "Proz. bis Erf\195\188rchtig: "
FactionAddictLocalization["PCT_TO_REWARD_TXT"] = "Pct to Next Reward: "
FactionAddictLocalization["CATEGORY_TXT"] = "Kategorie: "

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
FactionAddictLocalization["Monday"] = "Montag"
FactionAddictLocalization["Tuesday"] = "Dienstag"
FactionAddictLocalization["Wednesday"] = "Mittwoch"
FactionAddictLocalization["Thursday"] = "Donnerstag"
FactionAddictLocalization["Friday"] = "Freitag"
FactionAddictLocalization["Saturday"] = "Samstag"
FactionAddictLocalization["Sunday"] = "Sonntag"
FactionAddictLocalization["DATE_FORMAT"] = "D m/d"

-- Misc Strings
FactionAddictLocalization["MISC_PARAGON_TXT"] = "Paragon"

end;