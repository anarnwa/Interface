if GetLocale() == "zhCN" then
	if not FactionAddictLocalization then
		FactionAddictLocalization = {}
	end

-- Titles
FactionAddictLocalization["ADDON_TITLE"] = "Faction Addict"

-- tab labels at bottom of addon
FactionAddictLocalization["TAB1_LABEL"] = "声望"
FactionAddictLocalization["TAB2_LABEL"] = "声望记录"
FactionAddictLocalization["TAB3_LABEL"] = "设定"
FactionAddictLocalization["TAB4_LABEL"] = "关于"

-- Error Messages
FactionAddictLocalization["ERROR1"] = "没有可显示的声望!\n\n请检查设定及筛选。"

-- Tooltips
FactionAddictLocalization["LAUNCHER_TT"] = "开启/关闭 Faction Addict"
FactionAddictLocalization["CONFIG_TT_CF"] = "显示 经典艾泽拉斯 声望"
FactionAddictLocalization["CONFIG_TT_BC"] = "显示 燃烧的远征 声望"
FactionAddictLocalization["CONFIG_TT_WOTLK"] = "显示 巫妖王之怒 声望"
FactionAddictLocalization["CONFIG_TT_CATA"] = "显示 大地的裂变 声望"
FactionAddictLocalization["CONFIG_TT_MOP"] = "显示 熊猫人之谜 声望"
FactionAddictLocalization["CONFIG_TT_WOD"] = "显示 德拉诺之王 声望"
FactionAddictLocalization["CONFIG_TT_LG"] = "显示 军团再临 声望"
FactionAddictLocalization["CONFIG_TT_BFA"] = "Show Battle for Azeroth factions."
FactionAddictLocalization["CONFIG_TT_OrderPct"] = "以崇拜百分比排序"
FactionAddictLocalization["CONFIG_TT_OrderName"] = "以阵营名称排序"
FactionAddictLocalization["CONFIG_TT_AO"] = "只显示联盟阵营"
FactionAddictLocalization["CONFIG_TT_HO"] = "只显示部落阵营"
FactionAddictLocalization["CONFIG_TT_AUTOBAR"] = "自动更改声望条为最近获得声望之阵营"
FactionAddictLocalization["CONFIG_TT_HIDEINACTIVE"] = "隐藏您于此插件中设为闲置的声望，否则闲置声望会移至清单底部，背景为红色。"
FactionAddictLocalization["CHECKBUTTON_TT_SETINACTIVE"] = "将此声望移至清单底部。(闲置声望背景为红色，亦可设置为隐藏。)"
FactionAddictLocalization["TAB1_TT"] = FactionAddictLocalization["TAB1_LABEL"]
FactionAddictLocalization["TAB2_TT"] = FactionAddictLocalization["TAB2_LABEL"]
FactionAddictLocalization["TAB3_TT"] = FactionAddictLocalization["TAB3_LABEL"]
FactionAddictLocalization["TAB4_TT"] = FactionAddictLocalization["TAB4_LABEL"]
FactionAddictLocalization["CONFIG_MENU_TT"] = "声望筛选"
FactionAddictLocalization["ACHIEVEMENT_TT_TITLE"] = "声望崇拜成就:"
FactionAddictLocalization["SEARCH_TOGGLE"] = "开启搜寻"

-- Tab1 - factions text
FactionAddictLocalization["TAB1_DESC_TXT"] = "点击声望以显示更多资讯"
FactionAddictLocalization["KNOWN_TXT"] = "已知: "
FactionAddictLocalization["SHOWN_TXT"] = "显示: "
FactionAddictLocalization["EXALTED_TXT"] = "崇拜: "
FactionAddictLocalization["NEXT_ACHIEV_TXT"] = "下一个成就: "

-- Tab2 - log text
FactionAddictLocalization["TAB2_DESC_TXT"] = "声望记录"
FactionAddictLocalization["TAB2_LASTGAIN_TXT"] = "最后获得"
FactionAddictLocalization["TAB2_NOGAIN_TXT"] = "此阶段并无获得声望。"
FactionAddictLocalization["TAB2_SESSIONTOTAL_TXT"] = "阶段总计: "

-- Tab3 - config text
FactionAddictLocalization["TAB3_DESC_TXT"] = "设定"
FactionAddictLocalization["TAB3_DISPLAY_CONFIG_TXT"] = "要显示哪一个声望?"
FactionAddictLocalization["TAB3_DISPLAY_ORDER_TXT"] = "声望排序条件"
FactionAddictLocalization["TAB3_DISPLAY_FILTER"] = "声望筛选"
FactionAddictLocalization["TAB3_DISPLAY_OPTIONS"] = "选项"
FactionAddictLocalization["TAB3_CONFIG_CF"] = "经典艾泽拉斯"
FactionAddictLocalization["TAB3_CONFIG_BC"] = "燃烧的远征"
FactionAddictLocalization["TAB3_CONFIG_WOTLK"] = "巫妖王之怒"
FactionAddictLocalization["TAB3_CONFIG_CATA"] = "大地的裂变"
FactionAddictLocalization["TAB3_CONFIG_MOP"] = "熊猫人之谜"
FactionAddictLocalization["TAB3_CONFIG_WOD"] = "德拉诺之王"
FactionAddictLocalization["TAB3_CONFIG_LG"] = "军团再临"
FactionAddictLocalization["TAB3_CONFIG_BFA"] = "Battle for Azeroth Factions"
FactionAddictLocalization["TAB3_CONFIG_ORDER_PCT"] = "崇拜百分比"
FactionAddictLocalization["TAB3_CONFIG_ORDER_NAME"] = "阵型名称"
FactionAddictLocalization["TAB3_CONFIG_ALLIANCE_ONLY"] = "只显示联盟阵营"
FactionAddictLocalization["TAB3_CONFIG_HORDE_ONLY"] = "只显示部落阵营"
FactionAddictLocalization["TAB3_CONFIG_AUTOBAR"] = "自动更改声望条"
FactionAddictLocalization["TAB3_CONFIG_HIDEINACTIVE"] = "隐藏闲置声望"

-- Tab4 - about text
FactionAddictLocalization["TAB4_DESC_TXT"] = "关于 Faction Addict"
FactionAddictLocalization["VERSION_TXT"] = "版本: "
FactionAddictLocalization["ABOUT_TXT"] = "Faction Addict 是一个方便玩家查看及追踪各声望的插件，非常适合正努力追寻崇拜之路的玩家。 |n|n输入 |cFFFF0000/fa|r 或 |cFFFF0000/factionaddict|r 开启/关闭插件视窗。插件视窗按钮在游戏预设的声望页右上角。|n|n下载更新及提供意见: |cFFFFFF00wowinterface.com|r 及 |cFFFFFF00wow.curse.com|r|n|n作者: |cFFFFFF00gmz323 (Greg)|r"

-- Info Window
FactionAddictLocalization["LAUNCH_WATCH_PANEL_TXT"] = "打开检视面板"
FactionAddictLocalization["FACTION_URL_TXT"] = "https://www.wowhead.com/faction="
FactionAddictLocalization["PCT_TO_EXALTED_TXT"] = "崇拜百分比: "
FactionAddictLocalization["PCT_TO_REWARD_TXT"] = "Pct to Next Reward: "
FactionAddictLocalization["CATEGORY_TXT"] = "类别: "

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