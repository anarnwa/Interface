
DBM_AutoInvite_Translations = {}

local L = DBM_AutoInvite_Translations

if GetLocale() == "zhCN" then
	L.TabCategory_AutoInvite 	= "邀请助手"
	L.AreaGeneral 			= "常规设置"
	L.AllowGuildMates 		= "允许公会成员进组"
	L.AllowFriends 			= "允许好友进组"
	L.AllowOthers 			= "允许任何人进组"
	L.Activate 			= "启用关键字"
	L.KeyWord 			= "密语关键字"
	L.InviteFailed 			= "无法邀请玩家 %s"
	L.ConvertRaid 			= "转换为团队"
	L.WhisperMsg_RaidIsFull 	= "对不起, 团队已满, 我无法邀请你."
	L.WhisperMsg_NotLeader 		= "对不起, 我没有权限组你."
	L.WarnMsg_NoRaid		= "请在使用集体邀请前创建团队"
	L.WarnMsg_NotLead		= "对不起, 只有团长和助理才能使用这个命令"
	L.WarnMsg_InviteIncoming	= "<DBM> 收到集体邀请! 请离开你当前队伍."
	L.Button_AOE_Invite		= "开始集体邀请"
	L.AOEbyGuildRank		= "邀请所有在此公会等级以上的会员"

	-- RaidInvite Options
	L.AreaRaidOptions		= "团队设置"
	L.PromoteEveryone		= "提升所有玩家为助理 (不推荐)"
	L.PromoteGuildRank		= "按公会等级提升"
	L.PromoteByNameList		= "自动提升以下玩家为助理 (以空格隔开)"

	L.DontPromoteAnyRank		= "不自动提升所有公会等级"

	L.Button_ResetSettings		= "重置设置"
elseif GetLocale() == "zhTW" then
	L.TabCategory_AutoInvite 	= "邀請助手"
	L.AreaGeneral 			= "一般設定"
	L.AllowGuildMates 		= "允許來自公會成員的自動邀請"
	L.AllowFriends 			= "允許來自好友的自動邀請"
	L.AllowOthers 			= "允許來自任何人的自動邀請"
	L.Activate 			= "開啟關鍵字自動邀請"
	L.KeyWord 			= "用於密語邀請的關鍵字"
	L.InviteFailed 			= "不能邀請玩家 %s"
	L.ConvertRaid 			= "轉換隊伍為團隊"
	L.WhisperMsg_RaidIsFull 	= "對不起，我不能邀請你。團隊已滿了。"
	L.WhisperMsg_NotLeader 		= "對不起，我不能邀請你。我不是組長。"
	L.WarnMsg_NoRaid		= "使用集體邀請前請先建立一個團隊"
	L.WarnMsg_NotLead		= "對不起，你必須為團長或助理才能使用此命令"
	L.WarnMsg_InviteIncoming	= "<DBM> 收到集體邀請! 請現在離開你的隊伍."
	L.Button_AOE_Invite		= "集體邀請公會成員"
	L.AOEbyGuildRank		= "邀請所有等於或大於所選階級的玩家"

	-- RaidInvite Options
	L.AreaRaidOptions		= "團隊選項"
	L.PromoteEveryone		= "提升所有新進來的玩家 (不建議)"
	L.PromoteGuildRank		= "根據公會階級提升"
	L.PromoteByNameList		= "自動提升以下玩家 (用空格分開)"

	L.DontPromoteAnyRank		= "不根據公會階級提升"

	L.Button_ResetSettings		= "重置設置"
else
	L.TabCategory_AutoInvite 	= "Auto-Invite Tool"
	L.AreaGeneral 			= "General Invite Options"
	L.AllowGuildMates 		= "Allow auto-invite from guild mates"
	L.AllowFriends 			= "Allow auto-invite from friends"
	L.AllowOthers 			= "Allow auto-invite from everyone"
	L.Activate 			= "Enable auto invite by keyword"
	L.KeyWord 			= "Keyword to whisper for invite"
	L.InviteFailed 			= "Can't invite player %s"
	L.ConvertRaid 			= "Converting group to raid"
	L.WhisperMsg_RaidIsFull 	= "Sorry, I can't invite you. The raid is full."
	L.WhisperMsg_NotLeader 		= "Sorry, I can't invite you. I'm not the group leader."
	L.WarnMsg_NoRaid		= "Please create a raid group before using AoE-invite"
	L.WarnMsg_NotLead		= "Sorry, you have to be leader or promoted to use this command"
	L.WarnMsg_InviteIncoming	= "<DBM> AoE-invite incoming! Please leave your groups now."
	L.Button_AOE_Invite		= "AoE guild invite"
	L.AOEbyGuildRank		= "Invite all players at or above this rank"

	-- RaidInvite Options
	L.AreaRaidOptions		= "Raid Options"
	L.PromoteEveryone		= "Promote all new player (not recommended)"
	L.PromoteGuildRank		= "Promote by guild rank"
	L.PromoteByNameList		= "Auto-promote the following players (separate by space)"

	L.DontPromoteAnyRank		= "No auto-promote by guild rank"

	L.Button_ResetSettings		= "reset settings"
end
