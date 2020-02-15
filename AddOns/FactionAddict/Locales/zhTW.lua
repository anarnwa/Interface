if GetLocale() == "zhTW" then
	if not FactionAddictLocalization then
		FactionAddictLocalization = {}
	end

-- Titles
FactionAddictLocalization["ADDON_TITLE"] = "Faction Addict"

-- tab labels at bottom of addon
FactionAddictLocalization["TAB1_LABEL"] = "聲望"
FactionAddictLocalization["TAB2_LABEL"] = "聲望記錄"
FactionAddictLocalization["TAB3_LABEL"] = "設定"
FactionAddictLocalization["TAB4_LABEL"] = "關於"

-- Error Messages
FactionAddictLocalization["ERROR1"] = "沒有可顯示的聲望!\n\n請檢查設定及篩選。"

-- Tooltips
FactionAddictLocalization["LAUNCHER_TT"] = "開啟/關閉 Faction Addict"
FactionAddictLocalization["CONFIG_TT_CF"] = "顯示 經典艾澤拉斯 聲望"
FactionAddictLocalization["CONFIG_TT_BC"] = "顯示 燃燒的遠征 聲望"
FactionAddictLocalization["CONFIG_TT_WOTLK"] = "顯示 巫妖王之怒 聲望"
FactionAddictLocalization["CONFIG_TT_CATA"] = "顯示 浩劫與重生 聲望"
FactionAddictLocalization["CONFIG_TT_MOP"] = "顯示 潘達利亞之謎 聲望"
FactionAddictLocalization["CONFIG_TT_WOD"] = "顯示 德拉諾之霸 聲望"
FactionAddictLocalization["CONFIG_TT_LG"] = "顯示 軍臨天下 聲望"
FactionAddictLocalization["CONFIG_TT_BFA"] = "Show Battle for Azeroth factions."
FactionAddictLocalization["CONFIG_TT_OrderPct"] = "以崇拜百分比排序"
FactionAddictLocalization["CONFIG_TT_OrderName"] = "以陣營名稱排序"
FactionAddictLocalization["CONFIG_TT_AO"] = "只顯示聯盟陣營"
FactionAddictLocalization["CONFIG_TT_HO"] = "只顯示部落陣營"
FactionAddictLocalization["CONFIG_TT_AUTOBAR"] = "自動更改聲望條為最近獲得聲望之陣營"
FactionAddictLocalization["CONFIG_TT_HIDEINACTIVE"] = "隱藏您於此插件中設為閒置的聲望，否則閒置聲望會移至清單底部，背景為紅色。"
FactionAddictLocalization["CHECKBUTTON_TT_SETINACTIVE"] = "將此聲望移至清單底部。(閒置聲望背景為紅色，亦可設置為隱藏。)"
FactionAddictLocalization["TAB1_TT"] = FactionAddictLocalization["TAB1_LABEL"]
FactionAddictLocalization["TAB2_TT"] = FactionAddictLocalization["TAB2_LABEL"]
FactionAddictLocalization["TAB3_TT"] = FactionAddictLocalization["TAB3_LABEL"]
FactionAddictLocalization["TAB4_TT"] = FactionAddictLocalization["TAB4_LABEL"]
FactionAddictLocalization["CONFIG_MENU_TT"] = "聲望篩選"
FactionAddictLocalization["ACHIEVEMENT_TT_TITLE"] = "聲望崇拜成就:"
FactionAddictLocalization["SEARCH_TOGGLE"] = "開啟搜尋"

-- Tab1 - factions text
FactionAddictLocalization["TAB1_DESC_TXT"] = "點擊聲望以顯示更多資訊"
FactionAddictLocalization["KNOWN_TXT"] = "已知: "
FactionAddictLocalization["SHOWN_TXT"] = "顯示: "
FactionAddictLocalization["EXALTED_TXT"] = "崇拜: "
FactionAddictLocalization["NEXT_ACHIEV_TXT"] = "下一個成就: "

-- Tab2 - log text
FactionAddictLocalization["TAB2_DESC_TXT"] = "聲望記錄"
FactionAddictLocalization["TAB2_LASTGAIN_TXT"] = "最後獲得"
FactionAddictLocalization["TAB2_NOGAIN_TXT"] = "此階段並無獲得聲望。"
FactionAddictLocalization["TAB2_SESSIONTOTAL_TXT"] = "階段總計: "

-- Tab3 - config text
FactionAddictLocalization["TAB3_DESC_TXT"] = "設定"
FactionAddictLocalization["TAB3_DISPLAY_CONFIG_TXT"] = "要顯示哪一個聲望?"
FactionAddictLocalization["TAB3_DISPLAY_ORDER_TXT"] = "聲望排序條件"
FactionAddictLocalization["TAB3_DISPLAY_FILTER"] = "聲望篩選"
FactionAddictLocalization["TAB3_DISPLAY_OPTIONS"] = "選項"
FactionAddictLocalization["TAB3_CONFIG_CF"] = "經典艾澤拉斯"
FactionAddictLocalization["TAB3_CONFIG_BC"] = "燃燒的遠征"
FactionAddictLocalization["TAB3_CONFIG_WOTLK"] = "巫妖王之怒"
FactionAddictLocalization["TAB3_CONFIG_CATA"] = "浩劫與重生"
FactionAddictLocalization["TAB3_CONFIG_MOP"] = "潘達利亞之謎"
FactionAddictLocalization["TAB3_CONFIG_WOD"] = "德拉諾之霸"
FactionAddictLocalization["TAB3_CONFIG_LG"] = "軍臨天下"
FactionAddictLocalization["TAB3_CONFIG_BFA"] = "Battle for Azeroth Factions"
FactionAddictLocalization["TAB3_CONFIG_ORDER_PCT"] = "崇拜百分比"
FactionAddictLocalization["TAB3_CONFIG_ORDER_NAME"] = "陣型名稱"
FactionAddictLocalization["TAB3_CONFIG_ALLIANCE_ONLY"] = "只顯示聯盟陣營"
FactionAddictLocalization["TAB3_CONFIG_HORDE_ONLY"] = "只顯示部落陣營"
FactionAddictLocalization["TAB3_CONFIG_AUTOBAR"] = "自動更改聲望條"
FactionAddictLocalization["TAB3_CONFIG_HIDEINACTIVE"] = "隱藏閒置聲望"

-- Tab4 - about text
FactionAddictLocalization["TAB4_DESC_TXT"] = "關於 Faction Addict"
FactionAddictLocalization["VERSION_TXT"] = "版本: "
FactionAddictLocalization["ABOUT_TXT"] = "Faction Addict 是一個方便玩家查看及追蹤各聲望的插件，非常適合正努力追尋崇拜之路的玩家。 |n|n輸入 |cFFFF0000/fa|r 或 |cFFFF0000/factionaddict|r 開啟/關閉插件視窗。插件視窗按鈕在遊戲預設的聲望頁右上角。|n|n下載更新及提供意見: |cFFFFFF00wowinterface.com|r 及 |cFFFFFF00wow.curse.com|r|n|n作者: |cFFFFFF00gmz323 (Greg)|r"

-- Info Window
FactionAddictLocalization["LAUNCH_WATCH_PANEL_TXT"] = "打開檢視面板"
FactionAddictLocalization["FACTION_URL_TXT"] = "https://www.wowhead.com/faction="
FactionAddictLocalization["PCT_TO_EXALTED_TXT"] = "崇拜百分比: "
FactionAddictLocalization["PCT_TO_REWARD_TXT"] = "Pct to Next Reward: "
FactionAddictLocalization["CATEGORY_TXT"] = "類別: "

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
FactionAddictLocalization["Monday"] = "Monday"
FactionAddictLocalization["Tuesday"] = "Tuesday"
FactionAddictLocalization["Wednesday"] = "Wednesday"
FactionAddictLocalization["Thursday"] = "Thursday"
FactionAddictLocalization["Friday"] = "Friday"
FactionAddictLocalization["Saturday"] = "Saturday"
FactionAddictLocalization["Sunday"] = "Sunday"
FactionAddictLocalization["DATE_FORMAT"] = "D m/d"

-- Misc Strings
FactionAddictLocalization["MISC_PARAGON_TXT"] = "Paragon"
end;