
DBM_Raidlead_Translation = {}

local L = DBM_Raidlead_Translation

if GetLocale() == "zhCN" then
	L.Area_Raidleadtool				= "额外团长工具"
	L.ShowWarningForLootMaster		= "非队长分配时提示警告"

	L.Warning_NoLootMaster			= "拾取方式不是队长分配! 请切换到队长分配"

	L.StickyIcons					= "总是将团队标记设置回战斗之前的情况"

	L['Raidlead Tools'] = '团长工具箱'
elseif GetLocale() == "zhTW" then
	L.Area_Raidleadtool				= "額外團長工具"
	L.ShowWarningForLootMaster		= "非隊長分配時顯示警告"

	L.Warning_NoLootMaster			= "拾取方式不是隊長分配! 請切換到隊長分配!"

	L.StickyIcons					= "總是將團隊目標設置回戰鬥開始之前的樣子"

	L['Raidlead Tools'] = '團隊隊長工具'
else
	L.Area_Raidleadtool				= "Additional Raidlead options"
	L.ShowWarningForLootMaster		= "Show a warning on combatstart if Masterloot is not enabled"

	L.Warning_NoLootMaster			= "Lootmaster is currently disabled! - Please enable Lootmaster now!"

	L.StickyIcons					= "Always set Raidicons back to as they where on Combatstart"

	L['Raidlead Tools'] = 'Raidlead Tools'
end
