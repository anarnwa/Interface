if(GetLocale() ~= 'zhCN') then return end

local _, core = ...
local baseLocale = {
	["- Announce to chat players who are missing achievements for certain bosses"] = "通报某些BOSS还没有成就的玩家",
	["- Announce to chat tactics for a certain boss"] = "通报某些BOSS成就攻略",
	["- Keeps track of achievements which require you to kill so many mobs within a certain time period. It will announce to chat when enough mobs have spawned and whether they were killed in the time period."] = "持续追踪需要在一定时间内杀指定数量怪物成就，当有聚集足够的怪的时候他会在聊天框报告这些怪物是否在指定时间被击杀",
	["- Scans all players in the group to see which achievements each player is missing for the current instance"] = "扫描队中的所有玩家，追踪没有当前BOSS成就的玩家",
	["- Tracks when the criteria of instance achievements has been failed and outputs this to chat"] = "追踪当前BOSS成就失败并输出到聊天框",
	["- Tracks when the criteria of instance achievements have been met and output this to chat"] = "追踪当前BOSS成就并输出到聊天框",
	["(Enter instance to start scanning)"] = "进入副本开始扫描",
	["Core_AchievementScanFinished"] = "成就扫描完毕",
	["Core_AchievementTrackingEnabledFor"] = "成就追踪已启用",
	["Core_CommandEnableTracking"] = "开启/关闭IAT成就追踪",
	["Core_Commands"] = "命令列表",
	["Core_Counter"] = "计数",
	["Core_CriteriaMet"] = "成就已经达成. BOSS可以被击杀!",
	["Core_Enable"] = "开启",
	["Core_EnableAchievementTracking"] = "是否启用成就追踪",
	["Core_Failed"] = "失败!",
	["Core_GameFreezeWarning"] = "这可能会造成几秒的卡顿",
	["Core_help"] = "帮助",
	["Core_ListCommands"] = "显示命令列表",
	["Core_No"] = "否",
	["Core_NoTrackingForInstance"] = "IAT 无法追踪这场战役的任何成就.",
	["Core_PersonalAchievement"] = "个人成就",
	["Core_Reason"] = "原因",
	["Core_StartingAchievementScan"] = "开始扫描",
	["Core_TrackAchievements"] = "追踪成就",
	["Core_Yes"] = "是",
	["Features"] = "功能",
	["GUI_Achievement"] = "成就",
	["GUI_Achievements"] = "成就",
	["GUI_AchievementsCompletedForInstance"] = "所有成就均已完成",
	["GUI_AchievementsDiscordDescription"] = "战术是由 Achievements Discord 提供，在这个社区中可以遇到相同的成就控，相约一起组队解决各式各样的成就。",
	["GUI_AnnounceMessagesToRaidWarning"] = "在团队警告中显示信息",
	["GUI_AnnounceTracking"] = "在团队中显示成就追踪",
	["GUI_Author"] = "作者",
	["GUI_BattleForAzeroth"] = "争霸艾泽拉斯",
	["GUI_Cataclysm"] = "大地的裂变",
	["GUI_Disabled"] = "取消",
	["GUI_DisplayInfoFrame"] = "启用资讯框",
	["GUI_EnableAddon"] = "启用插件",
	["GUI_EnableAutomaticCombatLogging"] = "启用自动战斗记录",
	["GUI_Enabled"] = "开始",
	["GUI_EnterInstanceToStartScanning"] = "进入副本开始扫描",
	["GUI_GreyOutCompletedAchievements"] = "淡出已完成的成就",
	["GUI_HideCompletedAchievements"] = "隐藏已完成成就",
	["GUI_Legion"] = "军团再临",
	["GUI_MinimapDisabled"] = "关闭迷你小地图图标",
	["GUI_MinimapEnabled"] = "开启迷你小地图图标",
	["GUI_MistsOfPandaria"] = "潘达利亚之谜",
	["GUI_NoPlayersNeedAchievement"] = "队伍中没有玩家需要做这个成就",
	["GUI_OnlyDisplayMissingAchievements"] = "只显示未完成成就",
	["GUI_OnlyTrackMissingAchievements"] = "只追踪未完成成就",
	["GUI_Options"] = "选项",
	["GUI_OutputPlayers"] = "输出玩家",
	["GUI_OutputTactics"] = "输出战术",
	["GUI_Players"] = "玩家",
	["GUI_PlayersWhoNeedAchievement"] = "需要做成就的玩家",
	["GUI_PlaySoundOnFailed"] = "当成就失败时播放音效",
	["GUI_PlaySoundOnSuccess"] = "当成就完成时播放音效",
	["GUI_ScanInProgress"] = "扫描仍在进行中",
	["GUI_SelectSound"] = "选择音效",
	["GUI_Tactic"] = "战术",
	["GUI_Tactics"] = "战术",
	["GUI_ToggleMinimap"] = "在小地图显示按钮",
	["GUI_Track"] = "追踪",
	["GUI_Tracking"] = "追踪",
	["GUI_TrackingDisabled"] = "成就追踪已停用",
	["GUI_TrackingNumber"] = "当前追踪",
	["Gui_TranslatorNames"] = "萌丶汉丶纸",
	["GUI_Translators"] = "翻译",
	["GUI_WarlordsOfDraenor"] = "德拉诺之王",
	["GUI_WrathOfTheLichKing"] = "巫妖王之怒",
	["Instance Achievement Tracker"] = "Instance Achievement Tracker(成就追踪)",
	["Instances_Other"] = "其他",
	["Instances_TrashAfterThirdBoss"] = "第三个BOSS后的集市",
	["Main"] = "主界面",
	["Shared_AddKillCounter"] = "%s 击杀次数",
	["Shared_CompletedBossKill"] = "将完成(当BOSS被击杀)",
	["Shared_DamageFromAbility"] = "%s 伤害",
	["Shared_DirectHitFromAbility"] = "%s 直接命中",
	["Shared_DoesNotMeetCritera"] = "不满足",
	["Shared_Eight"] = "8",
	["Shared_Eighteen"] = "18",
	["Shared_Eleven"] = "11",
	["Shared_FailedPersonalAchievement"] = "%s 已经失败 %s (原因: %s)(个人成就)",
	["Shared_Fifteen"] = "15",
	["Shared_Five"] = "5",
	["Shared_Found"] = "发现",
	["Shared_Four"] = "4",
	["Shared_Fourteen"] = "14",
	["Shared_GotHit"] = "被击中",
	["Shared_HasBeenHitWith"] = "已经被击中",
	["Shared_HasBeenInfectedWith"] = "被感染",
	["Shared_HasCompleted"] = "已成功",
	["Shared_HasFailed"] = "已失败",
	["Shared_HasGained"] = "已获得",
	["Shared_HasLost"] = "已失去",
	["Shared_HeCanNowBeKileld"] = "他现在可以被击杀",
	["Shared_JustKillBoss"] = "满级时，只需要直接击杀BOSS即可得到这个成就。",
	["Shared_JustKillBossesTogether"] = "满级时，只要同时击杀BOSS就可获得这个成就。",
	["Shared_JustKillBossSingleTarget"] = "满级时，只需要直接使用单体技能击杀BOSS即可得到这个成就。",
	["Shared_KillTheAddNow"] = "现在击杀 %s ",
	["Shared_MeetsCritera"] = "满足",
	["Shared_Nine"] = "9",
	["Shared_Nineteen"] = "19",
	["Shared_NotHit"] = "没有被击中",
	["Shared_One"] = "1",
	["Shared_PlayersHit"] = "击中玩家",
	["Shared_PlayersWhoNeedAchievement"] = "需要成就的玩家",
	["Shared_PlayersWhoStillNeedToGetHit"] = "仍然需要被击中的玩家:",
	["Shared_PlayersWhoStillNeedToGetResurrected"] = "以下玩家需要复活才能获得成就:",
	["Shared_ReportString"] = "请将下列的文字讯息回报给IAT作者",
	["Shared_Seven"] = "7",
	["Shared_Seventeen"] = "17",
	["Shared_SheCanNowBeKilled"] = "她现在可以被击杀",
	["Shared_Six"] = "6",
	["Shared_Sixteen"] = "16",
	["Shared_Ten"] = "10",
	["Shared_Thirteen"] = "13",
	["Shared_Three"] = "3",
	["Shared_Twelve"] = "12",
	["Shared_Twenty"] = "20",
	["Shared_Two"] = "2",
	["Shared_WasKilled"] = "已击杀"
}

core:RegisterLocale('zhCN', baseLocale)

-- core:RegisterLocale('enUS', baseLocale)
