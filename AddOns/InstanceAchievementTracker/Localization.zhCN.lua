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
	["AssaultOnVioletHold_Festerface"] = "为了使%s产生，%s需要达到100能量。当他靠近地板上的胆汁时能量会减少，因此BOSS需要拉开胆汁。一旦%s生成了击杀掉，然后击杀BOSS即可",
	["AssaultOnVioletHold_MillificentManastorm"] = "为了完成这个成就你需要使用%s 玩具当对战%s的时候",
	["Atal_Dazar_Yazma"] = "为了点燃暗影烈焰烛台，当BOSS释放%s时除了坦克的其他四个人必须分散开靠近其中一个烛台。烛台点燃后会持续25秒，你应该在BOSS血量剩5%%到10%%的时候做这件事。",
	["AtalDazar_Other"] = "整个地下城中的IAT_122969会释放%s给一名随即玩家使他变形5秒，当变形时间结束后会继续变形他身边的另一位玩家。\n\n在你拉IAT_122969之前需要先清干净副本中的其他小怪。你将带着他参与每一个BOSS的战斗，如果你队伍中有长控制技能的职业(比如武僧的%s，猎人的%s，法师的%s)则需要控制小怪直到战斗快要结束。如果你队伍中没有控制职业，你需要在正常战斗中关注%s的打断。",
	["AtalDazar_Priestess_AlunZa"] = "BOSS会通过释放%s来召唤一个小怪。他将移动到任何%s去吸水，当没有水的时候他会攻击玩家。此时你需要控制小怪防止他被打死。当他吸收8个%s后会变成IAT_131140",
	["AzsharasEternalPalace_AbyssalCommanderSivara"] = "在%s之前的小怪堆中找到完成此成就所需的三个副官。你只需要清除房间中间和右侧的小怪。\n\n你可以使用4个坦克，当然如果你第三个坦克足够强力也可以不需要第四个坦克。\n\n%s释放%s。解除此效果影响的方式可以是将所有副官拉开旗帜或者让DPS转掉。\n\n%s释放%s。只需要已开朝向就可以规避伤害。她还会释放%s和%s只会造成轻微伤害。\n\n%s还会时不时释放%s来治疗一个盟友35%%血量。没有必要打断她，只需要确保副官远离%s。\n\n%s释放%s会恐惧他身边人。第三个或第四个坦克必须打断此技能。",
	["AzsharasEternalPalace_Applause"] = "出列",
	["AzsharasEternalPalace_BlackwaterBehemoth"] = "为了取得这一成就，你将不得不指派几个人在整个区域内游泳并收集海洋生物样本：\n -%s\n -%s\n -%s\n -%s\n\n一但收集了50个样本就可以击杀BOSS获得成就。\n\n请确保指定的玩家切到了坦克专精这样他就不会被%s击中。如果你的团队中有德鲁伊，则应指派他们收集海洋生物，因为他们会因%s而快速游泳。\n\n请注意，指派的玩家应该碰一下boss，否则他们可能不会获得成就。",
	["AzsharasEternalPalace_Curtsey"] = "重复行动",
	["AzsharasEternalPalace_Grovel"] = "缓刑",
	["AzsharasEternalPalace_Kneel"] = "服从或受苦",
	["AzsharasEternalPalace_LadyAshvane"] = "为了取得这一成就，你必须确保%s的每一条射线都经过艾什凡女勋爵。如果可能的话，还可以尝试将其放置在%s的后面以将其销毁。\n\n在通常的难度下，此成就非常容易实现，并且具有足够的dps，你可以跳过第二阶段2中的%s释放（第二次甲壳 破碎）。",
	["AzsharasEternalPalace_QueenAzshara"] = "要获得此成就，你必须在只有一个活着的玩家的情况下击败%s，并且该玩家必须承受%s的增益。\n\n战斗结束的场景应如下所示：\n-将BOSS打倒 500k生命值。\n -让2个坦克和1个治疗师除外的所有人都留在上古结界中，以获得10层%s并死亡。\n -现在，剩下的3名玩家必须使boss降低到200k生命值并停止 所有dps。\n -使用%s直到其中一个坦克（坦克1）获得%s buff。\n -坦克2和治疗者现在必须留在上古结界中才能死亡。\n -一旦坦克1成为唯一活着的玩家然后击杀BOSS可获得成就",
	["AzsharasEternalPalace_RadianceOfAzshara"] = "为了取得这一成就，你将必须连续转6圈而不掉入水中。\n\n跑了三圈之后，你将获得减益%s'你已经到一半了...'，再跑了三圈之后，你将获得另一个减益%s'已完成全距离趣味跑步。'。\n\n此成就是个人成就。\n\nDPS请务必保存所有大招的CD留给%s，如果你杀死它的速度足够快，则不必处理%s。\n\n不惜一切代价避免被%s击中 ，因为向后移动可能会删除你当前的%s减益效果。 坦克还必须警惕%s以及它们的位置，以免它们掉入水中。",
	["AzsharasEternalPalace_Salute"] = "列阵",
	["AzsharasEternalPalace_SamplesCollected"] = "样本采集",
	["AzsharasEternalPalace_TargetAndPerformEmote"] = "现在目标为%s和/%s！",
	["AzsharasEternalPalace_TheQueensCourt"] = "要获得%s，你必须在某项法令生效时的战斗中执行正确的仪式（表情）：\n\n -%s - /salute\n -%s - /curtsey\n -%s - /applause\n -%s - /grovel\n -%s - /kneel\n\n此成就是个人成就",
	["AzsharasEternalPalace_ZaquiHarbingerOfNyalotha"] = "要打开通往神秘奶牛关的门，你必须打开地面上的6个“符文”。 为此，玩家必须在第4阶段站在他们的上面，被%s点名，然后被驱散。 地面上的%s将为符文充能。\n\n所有6个符文充能后，会在房间中间打开一个门。 按下额外的动作按钮，你将被传送到神秘奶牛关！从那里，你有有限的时间击败10个%s。",
	["BastionOfTwilight_HalfusWyrmbreaker"] = "要完成此成就，你必须首先拉BOSS，然后释放房间周围的两条龙。这是通过单击没有%s debuff的龙来完成的。然后，你需要在杀死BOSS之前的10秒内将两个龙击杀。",
	["BastionOfTwilight_ValionaAndTheralion"] = "要完成此成就，请拉%s开始战斗，然后等待%s释放%s。 一旦站在由%s创建的池中，你将被传送到虚空领域，这时你将需要杀死以随机产生的6个%s。当你杀死6个%s后，你可以杀死BOSS。",
	["BattleOfDazaralor_ChampionOfTheLight"] = "为了实现这一目标，你将需要从战斗的每个敌人中窃取3颗亮闪闪，然后将它们带入加尼的垃圾堆。你必须总共窃取9颗亮闪闪：3个在%s，3个在%s，3个在%s\n\n此外，此成就要求团队中的每个人都与“加尼的垃圾堆”互动获取%s debuff。在boss战斗中，玩家将转化为%s ，并获得一个额外的操作按钮，可用于在敌人身上窃取一颗亮闪闪。\n\n一旦你的团队交出了9颗亮闪闪（每种NPC类型3个），你可以杀死BOSS并获得成就。",
	["BattleOfDazaralor_ConclaveOfTheChosen"] = "为了获得这一成就，您将需要保持三个迅猛龙中的一个迅猛龙的生命，直到战斗结束。 你可以杀死其余的迅猛龙，但由于无法控制，所以你需要在整个战斗过程中放风筝。\n\n %s将锁定另一个玩家每20秒（%s），因此你需要确保玩家放风筝使其远离团队，以免造成AoE伤害。\n\n在这场战斗中，一到两个死亡骑士可能会有用，因为他们可以使迅猛龙远离团队。",
	["BattleOfDazaralor_Grong"] = "为了实现这一目标，你需要在与%s战斗之前将6个桶放到BOSS场地。你可以在通往BOSS楼梯的右侧找到%s。\n\n将%s放在BOSS场地，与BOSS接触，并确保桶被%s（部落版本）或%s（联盟版本）击中。\n\n一旦%s被摧毁，则每击毁一桶（%s），boss将获得20 %%的伤害增加增益，持续30秒。一旦所有桶都被摧毁，将他杀死，你将获得成就。",
	["BattleOfDazaralor_Grong_Alliance"] = "为了实现这一目标，你需要在与%s战斗之前将6个桶放到BOSS场地。你可以在通往BOSS楼梯的右侧找到%s。\n\n将%s放在BOSS场地，与BOSS接触，并确保桶被%s击中。\n\n一旦%s被摧毁，则每击毁一桶（%s），boss将获得20 %%的伤害增加增益，持续30秒。一旦所有桶都被摧毁，将他杀死，你将获得成就。",
	["BattleOfDazaralor_Grong_Horde"] = "为了实现这一目标，你需要在与%s战斗之前将6个桶放到BOSS场地。你可以在通往BOSS楼梯的右侧找到%s。\n\n将%s放在BOSS场地，与BOSS接触，并确保桶被%s击中。\n\n一旦%s被摧毁，则每击毁一桶（%s），boss将获得20 %%的伤害增加增益，持续30秒。一旦所有桶都被摧毁，将他杀死，你将获得成就。",
	["BattleOfDazaralor_HighTinkerMekkatorque"] = "要完成此成就，你需要有%s和%s。\n\n在战斗前召唤两个布林顿，他们将开始对决。开BOSS后不久%s将产生。 很容易杀死，所以击败它，然后完成BOSS战斗，你就应该获得成就。\n\n%s有两个技能：\n %s -在NPC8码AOE近战注意躲开。\n %s - 连环闪电，保持传播或中断施法。",
	["BattleOfDazaralor_JadefireMasters"] = "为了获得这一成就，你将必须在BOSS场地中拾取隐藏的%s，使其免受火焰的伤害，并让武僧在其上施放%s。\n\n你应该在第一组%s之后拾取龙蛋 ，这样您就不会因受到%s失去龙蛋。确保在P2开始之前将其拾取，因为%s会破坏它。\n\n和尚100能量后转化为%s。%s击中拿着龙蛋的玩家后，你可以杀死BOSS以获得成就。\n\n部落和联盟%s的位置不同。",
	["BattleOfDazaralor_JainaProudmoore"] = "要完成此成就，你首先需要3个玩家在与%s的战斗中收集雪堆。\n\n仅在P1.5期间才能找到雪堆。 雪堆将均匀分布在圆形区域周围，因此在阶段开始时，你至少需要3名有加速技能的职业。\n\n穿过雪堆，你的角色旁边会出现一个小雪花 。 一旦找到所有3个，打断BOSS进入下一个阶段。 拥有雪花的玩家应重合在一个炸药桶附近以创建%s。\n\n使用%s移除炸药桶的%s，此时%s在炸药桶旁边，然后攻击该炸药桶。 爆炸将导致%s融化，从而完成了实现此目标的条件。",
	["BattleOfDazaralor_KingRastakhan"] = "要实现这一成就，你需要保持幻影存活，直到战斗结束。 只需将它们从大团中拉开以避免不必要的伤害。\n\n第三个坦克是实现这一目标的理想选择。",
	["BattleOfDazaralor_Opulence"] = "要获得此成就，你首先必须确保至少有一个玩家拥有%s宠物。\n\n此成就是个人的，需要玩家对%s宠物使用/ praise命令，前提是在%s的效果下。 宠物不必是你自己的。\n\n要进入%s，一个或多个玩家应该捡起%s。该宝石将在玩家单独存在时为他们叠加%s。达到100叠加后，他们将获得%s的光环20秒，使该玩家和附近的所有玩家获得%s的暴击几率提高100 %%。叠满会花费大约100秒的时间，一旦激活，就赞美%s来获得成就。",
	["BattleOfDazaralor_StormwallBlockade"] = "要完成此成就，你需要在BOSS战斗中召唤%s 。你无需打败%s 。\n\n要召唤%s，你需要开BOSS后单击码头左侧的鱼池。理想情况下，你只希望一个留在码头上的玩家来召唤它。该玩家将不得不处理2分钟的风骚操作。\n\n -单击鱼池后，玩家将开始从水中拉出一根绳子，并且他们将开始慢慢拉向水面。向相反的方向走以停留在码头上，但不要走得太远，否则绳索会断裂。\n -不久之后，%s将开始掉落在玩家身上，玩家必须躲避它们保持生命。\n -之后，海浪将撞击到船坞上，并且拉绳的玩家必须躲避它们。\n\n这将持续到2分钟的拉绳动作完成为止。其余的玩家需要照常进行boss战斗。\n\n %s产生后，召唤玩家和其他成员将不得不处理其两个技能以及正常的boss技能：\n %s - 正面圆锥体会将任何人推开，将他们射入水中\n %s -将所有玩家拉向%s，立即杀死距离太近的人。\n\n要对付%s，你需要一个盗贼在每次施放%s时都只专注于晕它。如果你没有盗贼，则必须进行控制轮换。其余的玩家需要在激怒之前杀死BOSS，同时还要与%s交战。",
	["BattleOfDazzarlor_BarrelsDestroyed"] = "桶被摧毁",
	["BattleOfDazzarlor_OpulenceRangeWarning"] = "警告：为了让IAT正确跟踪此成就，%s必须在称赞%s的玩家的25码范围内。 拥有%s的玩家应该站在一起，以简化这项工作",
	["BlackrockCaverns_KarshSteelbender"] = "将BOSS拉到房间中间的火中，直到他到达15层%s。 一旦他拥有15层%s，你就可以杀死BOSS。",
	["BlackrockFoundry_BeastlordDarmac"] = "此成就将需要3次击杀才能完成。 每次尝试时，拉BOSS到一个之前没有击杀过的野兽旁边。 BOSS在拉来之后要花几秒钟的时间来骑野兽。 一旦他骑了其中一只野兽，就可以杀死BOSS。",
	["BlackrockFoundry_Blackhand"] = "要完成此成就，DPS将BOSS血量打到30%% 进入P3。接下来，玩家需要分散在BOSS场地周围，并在他们从天花板跌落时站在他们的下方来收集%s。小组收集完20个%s后，你就可以杀死BOSS。\n\n注意：在小组中更容易完成此成就。",
	["BlackrockFoundry_Kromog"] = "此成就需要至少10位玩家来完成，尽管更多的玩家可以使成就变得更容易。\n\n开BOSS后大家分散到房间各处并等待%s生成。 %s生成后，每个玩家将需要站立在自己的符文上并等待被手抓住。接下来等待BOSS施放%s，然后在5秒内所有玩家AOE掉所有手。\n\n 注意：如果你在施放%s之前杀死了手，则可能导致一些玩家被击飞上天并且没有摸到BOSS，这可能会阻止一些玩家获得成就。",
	["BlackrockFoundry_OperatorThogar"] = "开怪倒计时5的时候开始放玩具火车,放在第一条铁轨上 进入战斗之后在边上放下火车破坏者,这时候破坏者会变成\"狂喜的发条式火车破坏者\"。",
	["BlackRookHold_AmalgamOfSouls"] = "将%s降低至50%%HP。 当%s生成时，你将需要控制一个来阻止它到达BOSS。 1分钟后，%s将转换为%s。 然后你可以杀死%s，然后杀死BOSS以获得此成就",
	["BloodmaulSlagMines_Magmolatus"] = "在最大级别下，你需要缓慢击杀BOSS，以便在杀死BOSS之前生成%s和%s。",
	["CathedralOfEternalNight_Agronox"] = "为了获得此成就，你需要站在BOSS场地周围的4个萌芽种子那里，然后等狂暴的鞭笞者将%s放到每个萌芽种子上。 一旦完成这4个种子中的每个种子，你就可以杀死BOSS。",
	["CathedralOfEternalNight_Mephistroth"] = "战斗开始时拿起%s。 然后，你需要等待boss达到100的能量进入P2。在P2，用战斗开始时拾取的盾牌面对%s。 盾牌抵挡20个%s后，你可以杀死Boss。",
	["CathedralOfEternalNight_ThrashbiteTheScornful"] = "房间周围有4个书架。 要完成此成就，你需要站在每个书架后面，等待BOSS释放%s才能打破书架。 一旦书架被打破，可点击的书就会出现在地板上。 小组中的每个成员都需要单击此书。 在BOSS房间中的其他3个书柜重复此操作，确保你顺时针旋转。 完成此操作后，组中的每个人都应该拥有%s 增益，并且可以杀死BOSS。\n\n注意：你必须有一个完整的5人小组才能完成此成就。",
	["Core_AchievementScanFinished"] = "成就扫描完毕",
	["Core_AchievementTrackingEnabledFor"] = "成就追踪已启用",
	["Core_CommandEnableTracking"] = "开启/关闭IAT成就追踪",
	["Core_Commands"] = "命令列表",
	["Core_CompletedAllAchievements"] = "您已完成此副本的所有成就",
	["Core_Counter"] = "计数",
	["Core_CriteriaMet"] = "成就已经达成. BOSS可以被击杀!",
	["Core_Enable"] = "开启",
	["Core_EnableAchievementTracking"] = "是否启用成就追踪",
	["Core_Failed"] = "失败!",
	["Core_GameFreezeWarning"] = "这可能会造成几秒的卡顿",
	["Core_help"] = "帮助",
	["Core_IncompletedAchievements"] = "此副本的成就不完整",
	["Core_ListCommands"] = "显示命令列表",
	["Core_No"] = "否",
	["Core_NoTrackingForInstance"] = "IAT 无法追踪这场战役的任何成就.",
	["Core_PersonalAchievement"] = "个人成就",
	["Core_Reason"] = "原因",
	["Core_StartingAchievementScan"] = "开始扫描",
	["Core_TrackAchievements"] = "追踪成就",
	["Core_Yes"] = "是",
	["CourtOfStars_Other"] = "完成成就的要求如下：\n\n -不要让%s释放%s\n -在与第一个BOSS交战之前关闭5个信标\n -确保在开%s前分别杀死所有3个恶魔\n -一次尝试便猜到间谍",
	["CourtOfStars_PatrolCaptainGerdo"] = "要完成此成就，你必须首先清除BOSS场地中的所有小怪。 杀死小怪时，请确保小怪或玩家都不会激活信标，因为这将使成就失败。\n\n一旦所有小怪都死了，拉BOSS后等待他施放%s。 BOSS施放此技能后，你将需要点场地周围的所有5个信标。 一旦所有5个信标都被关闭，你就可以杀死BOSS。",
	["CrucibleOfStorms_StartMoving"] = "你现在可以移动！",
	["CrucibleOfStorms_StopMoving"] = "停止移动！",
	["CrucibleOfStorms_TheRestlessCabal"] = "在战斗中%s将施放%s。 这会生成虚空能量，这些虚空能量会在场地周围反弹，直到击中玩家为止。 每次反弹时，冲击半径和伤害都会减少（最多两次）。 只需避免所有%s，直到有10个，然后杀死BOSS即可。\n\n你只需要在战斗中的某个时刻激活10个%s。 建议在战斗开始时进行此操作。",
	["CrucibleOfStorms_UunatHarbingerOfTheVoid"] = "为了取得这一成就，你不能在%s睁开眼睛时移动。 这个成就是个人的，死了就无法获得。\n\n％s的眼睛睁开前提是当乌纳特释放%s，%s或%s时，因此当BOSS接近100的能量时，完全不要移动。 在%s闭上眼睛之前，你都不要移动，这会消耗大约40的能量。 在大约70 %%和45 %%血量时眼睛也会睁开。",
	["DarkheartThicket_Dresaron"] = "拉BOSS后，穿过%s后面的大蛋使其孵化。 接下来杀死生成的%s，然后杀死BOSS。",
	["DarkheartThicket_ShadeOfXavius"] = "BOSS打到15 %%-20 %%的生命值。 将BOSS拖过地面上的漩涡状水坑，直到BOSS有10层%s，然后杀死BOSS。",
	["EndTime_EchoOfSylvanas"] = "要完成此成就，拉着BOSS然后等待%s 产生。 一旦%s 产生，杀死至少两个，然后杀死BOSS。",
	["EndTime_EchoOfTyrande"] = "完成此成就的最简单方法是没有治疗。",
	["EyeOfAzshara_LadyHatecoil"] = "当%s debuff失效或被驱散时，你将朝着你当前面对的方向吐息，以杀死其路径中的任何%s。 为了获得成就，你需要对11个或更多%s进行1次吐息。 随着时间的流逝，%s会生成，因此请你远离小怪，直到生成11个或更多。",
	["Features"] = "功能",
	["Freehold_HarlanSweete"] = "%s将随机点名一位玩家%s，该玩家必须站在其中一个箱子附近，以便最终被摧毁。",
	["Freehold_RingOfBooty"] = "为了这个成就，你必须在整个副本中找到3个物品。击败第一个BOSS后，鸟巢旁会出現%s，在朗姆酒区的平台上找到%s，第三个BOSS后方，靠近岸边的角落找到%s。",
	["Freehold_SkycapNKragg"] = "要召唤IAT_138314，你必须在拉BOSS之前放置一个%s。",
	["GrimrailDepot_RocketsparkAndBorka"] = "在BOSS场地周围有4个箱子（%s），需要打碎才能完成此成就。 首先拉BOSS，然后在每个箱子中等待%s释放%s以击碎箱子。 一旦所有4个箱子都打碎了，就可以杀死BOSS。",
	["GUI_Achievement"] = "成就",
	["GUI_Achievements"] = "成就",
	["GUI_AchievementsCompletedForInstance"] = "所有成就均已完成",
	["GUI_AchievementsDiscordDescription"] = "战术是由 Achievements Discord 提供，在这个社区中可以遇到相同的成就控，相约一起组队解决各式各样的成就。",
	["GUI_AchievementsDiscordTitle"] = "成就Discord",
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
	["GUI_TrackAchievementsInBlizzardUI"] = "在成就界面中跟踪成就",
	["GUI_Tracking"] = "追踪",
	["GUI_TrackingDisabled"] = "成就追踪已停用",
	["GUI_TrackingNumber"] = "当前追踪",
	["Gui_TranslatorNames"] = "萌丶汉丶纸",
	["GUI_Translators"] = "翻译",
	["GUI_WarlordsOfDraenor"] = "德拉诺之王",
	["GUI_WrathOfTheLichKing"] = "巫妖王之怒",
	["HallsOfValor_Other1"] = "前往%s区域。清除整个区域，除了你在传送时看到的%s和任何%s。完成后，攻击%s并将其拖到该区域的10个%s处。一旦%s有10层%s，你可以杀死它来获得成就。",
	["HallsOfValor_Other2"] = "注意：此成就至少需要4名玩家才能完成。\n\n在你击败了%s和%s之后，通往第四王的道路将打开。在你走这条路之前，回到餐厅，让每个玩家点击桌上的一个%s获得%s buff。\n\n一旦你拿起buff，玩家将有20秒的时间上楼，并将他们的%s扔给四个国王之一（%s、%s、%s和%s）。注意：每个玩家需要选择不同的BOSS。",
	["HellfireCitadel_Archimonde"] = "若要完成此成就，请拉住BOSS，然后等待%s生成。一旦生成了%s，就可以杀死boss。\n\n注意：只要在120秒内杀死BOSS，就不需要让%s活着。",
	["Highmaul_Brackenspore"] = "在开BOSS之前，让一个玩家拿起%s（%s）。然后拉住BOSS并将其打到大约40-50%%的生命值，以便%s开始从房间边缘生长。一旦房间里充满了%s，让%s的玩家在重复按下“额外动作”按钮的同时，在%s上移动。一旦玩家达到15层%s，你就可以杀死BOSS。",
	["Highmaul_ImperatorMargok"] = "为了完成这一成就，DPS将BOSS的生命值降低到55%% 。此时，boss将转换，并生成2个%s。让他们中的一个活下来，杀死另一个。\n\n为了获得%s buff，需要将%s移动到BOSS宝座左边的云中。最简单的方法是让DK多次使用他的%s技能移动小怪。\n\n一旦转换完成，让DK将小怪移动到BOSS宝座右侧，然后将BOSS的生命值降低到25%%，开始第二次转换。\n\n一旦小怪进入BOSS宝座右侧的第二个云，它将获得%s buff，此时，你可以杀死小怪然后杀死BOSS来完成此成就。\n\n注意：也可以在没有DK的情况下单独完成此成就。这是通过单击%s 完成的，它将在他下面显示一个红色圆圈。你需要站在这个圆圈的边缘或附近，然后观察他的施法条。一旦%s完成了一次转换，就开始向云端跑去，小怪应该会跟着你。重复此操作，直到添加到每个云。",
	["Highmaul_Tectus"] = "对于此成就，只需杀死%s。这将导致BOSS重生为2个%s。再次杀死2个%s，BOSS将重生为8个%s。接下来等待所有8个%s在一起，然后在10秒内将其AOE以完成此成就。",
	["Highmaul_TheButcher"] = "在整个战斗中%s将在场地周围生成。若要完成此成就，请将BOSS移到每个%s前面，并等待BOSS将其杀死。一旦6个%s被杀死，你可以杀死BOSS。\n\n注意：由于叠加了%s debuff，这个成就需要至少2个玩家或1个带宠物的玩家。",
	["Instance Achievement Tracker"] = "Instance Achievement Tracker(成就追踪)",
	["Instances_Other"] = "其他",
	["Instances_TrashAfterThirdBoss"] = "第三个BOSS后的集市",
	["IronDocks_FleshrenderNokgar"] = "若要完成此成就，只需攻击%s、%s和%s，然后杀死%s，同时保持三个小怪存活。这些小怪可以在%s之前的怪堆中找到。",
	["KingsRest_DazarTheFirstKing"] = "此成就是在%s获得的，该副本中的最后一个BOSS。让两个玩家各自站在石棺前的石头上，石棺周围的灯光就会开始充能。一旦他们都点燃，正确的石棺将开始摇晃，这意味着你可以杀死BOSS。",
	["KingsRest_MchimbaTheEmbalmer"] = "要获得此成就，你必须在%s没有多次使用%s的情况下释放目标玩家，并且在BOSS施放%s之前释放目标玩家。\n\n注意：玩家报告此成就有一个小错误，建议被埋葬的玩家不要使用%s直到BOSS施放%s",
	["KingsRest_Other"] = "第一个小饰物在副本的第一个房间里，在石棺后面，在篮子下面。\n第二个小饰物在第一个BOSS走廊里，在平台的尽头，在最后一组楼梯后面。\n第三个小饰物（查看沃顿英雄成就指南的荣耀，了解沃瓦德的详细信息）第四个小饰物位于在最后的BOSS场地前面，在楼梯的底部，在右柱子的顶部。",
	["LostCityOfTheTolVir_Lockmaw"] = "拉着BOSS然后等待20个%s生成。当20个%s的怪物生成后，把他们杀死，然后杀死BOSS。",
	["Main"] = "主界面",
	["MawOfSouls_Other"] = "要完成这一成就，你必须在第一个BOSS刚上船后3分30秒内杀死第二个BOSS。",
	["NeltharionsLair_Naraxas"] = "若要完成此成就，您需要等待BOSS获得6层%s。可以通过以下方式完成此任务：\n\n -坦克被BOSS吃掉\\\n -让小怪活着使其被BOSS吃掉。\n\n一旦达到6层%s，你可以杀死BOSS以获得此成就。",
	["NeltharionsLair_Other"] = "你首先需要从%s购买一个%s，这是在进入副本后沿着向右的狭窄路径找到的。然后，你将需要使用%s在整个副本中攻击蜗牛。请确保在使用%s攻击蜗牛之前不要杀死它们。\n\n打完1号BOSS进鱼桶往下漂流时在蘑菇上可以找到%s。你得朝他扔条鱼才能让他动起来。一旦你用鱼打了他，他就会在瀑布的底部等你了。\n\n%s在瀑布后面的洞穴里找到，你刚刚在那里找到了%s。你需要有人嘲讽%s，这样在用%s打他之前就会离开电场。\n\n%s在2号boss前清小怪路上，左边沿着长长的通道，会有一个洞穴，进去后，会发现什么也没有，不要急，这只蜗牛是个变色龙，靠在墙边根本看不到。\n\n%s、%s和%s是在2号BOSS后可以直接找到，他们在那里绕圈圈。\n\n%s在前三个蜗牛之后。你需要到右边的水里去，然后游到洞里。%s挂在洞的天花板上，所以你需要打他一次，让他掉下来。然后你就可以用%s打他了。",
	["Ny’alotha_CarapaceOfNZoth"] = "为了完成成就，你的队伍必须分成两组，将所有的%s血量打到10%%-15%%，然后在10秒内杀死它们。\n\n请注意，此阶段并不需要%s，你可以将其保留到P3。只要玩家使用爆发和精华来打增生，你在10秒内击败他们应该没有问题。",
	["Ny’alotha_DarkInquisitorXanesh"] = "要达成此成就，你必须消除%s三次，每次在%s debuff上剩余的时间少于3秒。\n\n要获得%s debuff，玩家必须站到%s区域。 之后%s将在两个玩家之间反弹，使其靠近传送门并在%s debuff将在3秒内到期时将其消除。\n\n注意：请确保考虑球的移动时间，即使你离球门很近，也需要1到2秒的时间才能消除球体。\n\n重要：如果%s debuff超时，然后%s进入，则这将不计算在内，你必须再次执行此操作。",
	["Ny’alotha_Drestagath"] = "为完成成就，你必须在60秒内触发%s两次。\n\n策略：杀死触须直到%s达到80能量，然后等待触须重生。一旦4+个触手被举起，杀死一个，这样%s获得100能量并释放%s。\n\n从那时起，使用%s并杀死所有剩余的触手和在1分钟内产生的新触手。",
	["Ny’alotha_IlgynothCorruptionReborn"] = "为了这个成就，你必须在3秒内击败10个%s。完成这一成就的最佳时机是在第一次转阶段后不久，或者是在战斗快结束时%s不断产生。\n\n一旦10个或更多的%s被激活，使用%s，开团队减伤（如%s和%s），并对其进行击杀。",
	["Ny’alotha_Maut"] = "对于这个成就，你必须让它从第2阶段吸收一个法力球以此来给%s供电，然后打败它，然后打败%s。\n\n为了使这个成就更容易，让第三个坦克从BOSS那里拉开%s，并在%s中坦克它，直到P2开始。\n\n一旦小怪转换为%s，使用%s并在完成他的%s施法之前击杀他。",
	["Ny’alotha_NZothTheCorruptor"] = "对于这个成就，组中的每个人都必须达到0%s才能获得%s，然后击败%s。这个成就在战斗快结束时的P3（普通或英雄）完成。\n\n一旦每个玩家低于50%s，并且BOSS的生命值在15%%-20%%左右，让%s在没有任何人踩圈的情况下完成他的%s施法。然后每个人都将达到0%s，收到%s，你可以使用%s对恩佐斯进行击杀。\n\n提示：在P3，高%s的玩家应始终踩到%s，低%s的玩家应使用%s，以避免提前获得%s。\n\n提示：如果某些玩家具有高%s，他们可以留在%s中以快速失去它。",
	["Ny’alotha_RadenTheDespoiled"] = "为完成此成就，玩家必须使用%s（从%s获得）摧毁2个方尖碑。若要触发%s，玩家必须杀死%s。\n\n注意：你需要5个玩家将%s定向到方尖碑，使其面向玩家的方向。",
	["Ny’alotha_ShadharTheInsatiable"] = "为获得此成就，团队中的每个人都必须/pet%s并获得%s debuff。\n\n注意：每次有人/pets%s时，他将获得一个加速效果，并且在5秒内不咬其他任何人。玩家在战斗中必须/pet，直到每个人都得到了debuff。",
	["Ny’alotha_TheHivemind"] = "为完成此成就，你必须找到并拿起3个%s 并将它们带到%s 战斗中。\n\n你将在Maw of Gor'ma入口附近找到一个样本，一个在仪式室（在%s之前），最后一个在%s之前。\n\n开始战斗，这三个样本将很快进化。使用%s，击杀%s，然后你可以击杀BOSS并获得成就。\n\n注意：捡到样本的玩家将获得一个buff：%s。如果buff由于任何原因消失，样本将在其原始位置刷新。",
	["Ny’alotha_TheProphetSkitra"] = "为完成此成就，你必须打败%s和他的两个克隆体（在与%s交战后）。\n\n在左边走廊的尽头找到%s（在到达%s之前）。在拉%s之前，请确保清除那边和BOSS场地的所有小怪。\n\n在开始战斗后，将产生两个%s克隆体。使用%s，击杀使徒然后你就可以击杀BOSS并获得成就。",
	["Ny’alotha_Vexiona"] = "为完成此成就，团队中的每个玩家必须至少被%s击中30次（在击败%s之前）。\n\n让坦克面向团队拉%s，团队使用减伤技能使用，如%s、%s和%s当小怪施放%s。\n\n由于一次施法无法达到30层堆叠，因此必须多次执行此操作。确保团减和个减合理分配。",
	["Ny’alotha_WrathionTheBlackEmperor"] = "要取得这个成就，你必须在3秒内击败10个%s。你可以通过让三个人在P2获得%s，然后让他们同时在碎片上行走来轻松做到这一点。\n\n恶魔猎手的%s和武僧的%s对于这场战斗来说是极好的法术，因为他们可以立即通过多个碎片。",
	["ObsidianSanctum_SartharionTheOnyxGuardian"] = "对于满级玩家，你可以杀死%s而忽略所有其他BOSS来获得这个成就。",
	["OperationMechagon_Gunker"] = "在开BOSS后，5个看起来像鹤的生物将在BOSS周围的水中刷新。只需把它们捡起来，带到%s处清洗即可。清洗5只动物后，你可以杀死BOSS。",
	["OperationMechagon_HertzLocker"] = "若要完成此成就，你必须在困难模式下杀死副本中的所有BOSS，而队伍中的任何玩家都不能死亡。\n\n前三个BOSS击杀顺序必须是当%s悬停在哪个BOSS上方时击杀哪个。%s使%s在整个战斗中刷新。他们免疫伤害，并且会跟随玩家直到他们达到100能量并自毁。\n\n对于%s战斗，%s被替换为%s。这会增加一个额外的机械，叫做%s，玩家必须集合在一起才能吸收。还有%s有射束能力，需要规避。\n\n要进行%s战斗，你必须先点击地上的%s，然后才开怪。这将为战斗添加一个名为%s的附加机械师，这将向队伍中添加一个减速叠加debuff。\n\n对于%s战斗，必须在开始战斗前单击红色小按钮。%s将加入战斗，能量为0时爆炸并消灭团队。为了防止这种情况发生，房间周围有4个面板，当%s达到35能量时激活。面板以随机顺序显示4种颜色的序列。序列完成后，组中的4名玩家必须按相同顺序单击每个面板来重复序列。如果操作正确%s将补充能量到100。",
	["OperationMechagon_KeepDpsingAndNobodyExplodes"] = "若要完成此成就，你必须在困难模式下杀死副本中的所有BOSS，而队伍中的任何玩家都不能死亡。\n\n前三个BOSS击杀顺序必须是当%s悬停在哪个BOSS上方时击杀哪个。%s使%s在整个战斗中刷新。他们免疫伤害，并且会跟随玩家直到他们达到100能量并自毁。\n\n对于%s战斗，%s被替换为%s。这会增加一个额外的机械，叫做%s，玩家必须集合在一起才能吸收。还有%s有射束能力，需要规避。\n\n要进行%s战斗，你必须先点击地上的%s，然后才开怪。这将为战斗添加一个名为%s的附加机械师，这将向队伍中添加一个减速叠加debuff。\n\n对于%s战斗，必须在开始战斗前单击红色小按钮。%s将加入战斗，能量为0时爆炸并消灭团队。为了防止这种情况发生，房间周围有4个面板，当%s达到35能量时激活。面板以随机顺序显示4种颜色的序列。序列完成后，组中的4名玩家必须按相同顺序单击每个面板来重复序列。如果操作正确%s将补充能量到100。",
	["OperationMechagon_KingGobbamak"] = "为了完成这个成就，你必须在战斗中始终保持%s在%s后面。要给%s充电，只要让一个玩家在有%s（你从%s得到）的时候跑上装备。最简单的方法是让两个玩家每隔15秒轮流为%s充电。\n\n注意：确保保存%s debuff以充电%s的玩家不会靠近%s或%s。",
	["OperationMechagon_MachinistsGarden"] = "此成就是个人成就，需要你躲开下列战斗的伤害机制：\n\n %s、%s、%s、%s",
	["OperationMechagon_TussleTonks"] = "若要完成此项成就，开怪后将%s拉到%s，该位置位于BOSS左侧的竞技场壁架上。\n\n下一步等待%s击中%s（用%s），这将导致%s从壁架上被击落到地上。一旦%s在地上，把他拉到其中一个%s，等待他被击中，然后杀了BOSS以获得这个成就。",
	["ReturnToKarazhan_OperaHall"] = "这一成就将需要3周的时间来完成，因为有三种不同的戏剧。",
	["ReturnToKarazhan_ShadeOfMedivh"] = "此成就需要5名玩家完成。小组中的所有玩家进入BOSS场地后，都需要点击左侧地板上的一本书。这将使组中的每个人都有%s debuff。一旦每个人都得到了%s debuff，你就可以杀了BOSS。",
	["SeatOfTheTriumvirate_Lura"] = "在你从2号BOSS到3号BOSS的路上，你会发现大量的空虚池把你拉向他们的中心，在那里你每秒会得到一层%s。一旦你得到10层，debuff将被一个新的被称为%s debuff替换。杀死%s而受%s影响将获得该成就。",
	["SeatOfTheTriumvirate_Saprish"] = "为了取得这个成就，你需要站在场地四周4个%s的上方，这样当他跳到其中一个玩家身上时%s就会打破。一旦所有的%s都被破坏，你可以杀死%s并获得成就。",
	["SeatOfTheTriumvirate_ZuraalTheAscended"] = "战斗开始大约40秒后，BOSS会瞄准一个随机玩家并施放%s，这会将该玩家向后击入虚空领域。\n\n现在该玩家想要填满他们的能量栏，攻击%s，然后在他附近使用额外的操作按钮%s，这样他们两个都将被送回正常的领域。\n\n从那里你只需杀死%s，然后%s，这就是你的成就。",
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
	["Shared_Killed"] = "击杀",
	["Shared_KillTheAddNow"] = "现在击杀 %s ",
	["Shared_MeetsCritera"] = "满足",
	["Shared_Nine"] = "9",
	["Shared_Nineteen"] = "19",
	["Shared_Notes"] = "注意",
	["Shared_NotHit"] = "没有被击中",
	["Shared_One"] = "1",
	["Shared_PlayersHit"] = "击中玩家",
	["Shared_PlayersRunningAddon2"] = "为了使IAT准确跟踪此成就，收集物品的玩家需要运行此组件",
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
	["Shared_TrackingStatus"] = "有插件的玩家",
	["Shared_Twelve"] = "12",
	["Shared_Twenty"] = "20",
	["Shared_Two"] = "2",
	["Shared_WasKilled"] = "已击杀",
	["ShrineOfTheStorm_LordStormsong"] = "在战斗过程中，%s将周期性地开始到%s，召唤%s追逐玩家并试图在撞击时爆炸。为了获得这个成就，你不能接触任何虚空加成，所以你会在整个战斗中需要不断地放风筝。",
	["ShrineOfTheStorm_Other"] = "%s在地下城开始时在第一个房间被拾取。如果你受到任何霜冻伤害，那么精灵火焰将被熄灭，因此建议你首先将3号BOSS前所有小怪清掉，然后再拾取。不要杀1号BOSS这样会失败。一旦你为3号BOSS点亮了圣殿，你就会获得成就。",
	["ShrineOfTheStorm_VolZith"] = "要获得%s debuff效果，你必须在最后尾王之前潜到水里，直到你看到周围漂浮着紫球，然后游过去。debuff将使你敌视所有玩家24秒，然后消失6秒，在这段时间里你的治疗者必须使用技能，并治疗你的全部生命。避免在BOSS身上使用aoe法术，而是尽可能地使用单加来帮助你的治疗者。\n\n在%s施放%s后，你将被传送到沉没领域，在那里你应该迅速杀死小怪，然后等待20-30秒冷却时间。%s也将施放%s，你将不得不控制5个%s小怪，这样他们就不会接触到BOSS。",
	["SiegeOfBoralus_DreadCaptainLockwood"] = "%s将一直尝试从使用%s从玩家那里撤退，除非她被控制。正如成就描述所暗示的，你必须控制她，并防止她使用%s。",
	["SiegeOfBoralus_Other"] = "正如成就的名字所暗示的，这是一个基于专业技能的成就，在这里你可以与物品互动来召唤BOSS。为了在整个副本中使用这些物品，至少需要75的技能等级。\n\n （锻造）%s-锤子在58，70处从楼梯下到码头被发现。\n（工程）%s-NPC在副本开始时被发现。\n（炼金术）%s-奇怪的小瓶在54，74处的桌子附近被发现。",
	["SiegeOfBoralus_ViqGoth"] = "在战斗中，%s将使用%s，这将在区域周围形成%s。在此过程中，有几个%s将被扔到陆地上，在打败BOSS之前，你必须将其踢回水中。",
	["TempleOfSethraliss_AvatarOfSethraliss"] = "为了这个成就，你必须/kiss %s，直到其中一个变成看起来像%s的“王子”。“王子”不会死，所以你不必担心使用AOE法术",
	["TempleOfSethraliss_Merektha"] = "要显示隐藏在骨骼顶部的%s，你必须使用%s、%s、%s或其他地板伤害技能。要使蛋孵化，让DPS和治疗重合在BOSS下面，等待它施放%s。一旦%s 产生，你可以杀死它，然后点击它以获得授予你成就的%s buff 。\n\n注意：%s可能会躲避攻击，但几秒钟后会传送到地面。如果有一个死亡骑士在队伍中，你应该用%s让%s下来，这将不仅绕过这个错误，而且使定位更容易。",
	["TempleOfSethraliss_Merektha_LootSnake"] = "现在击杀%s完成成就",
	["TempleOfSethraliss_Trash"] = "为了达成这个成就，你需要使用职业技能来控制%s，同时让双眼靠近。请注意，整个场地有几个%s会试图将眼睛偷走，每个眼睛附近都有一个，一个在眼睛和头骨之间，还有几个在场地中间。\n\n像%s、%s和%s这样的技能是理想的，因为可以控制小怪，然后完全忽略它们。",
	["TerraceOfEndlessSpring_DefeatedLast"] = "'%s 最后击杀'的部分完成",
	["TerraceOfEndlessSpring_ProtectorsOfTheEndless"] = "这项成就需要3周的时间来完成，你所需要做的就是每周轮换3个BOSS中的1个最后被杀",
	["The_Motherlode_CoinOperatedCrowdPummeler"] = "在BOSS前捡起%s，在开BOSS后扔给%s。%s将在整个战斗中施放%s，所以你应该打断这个法术并杀死他，而另一些小怪会仍grog，使你喝醉10秒。",
	["The_Motherlode_MogulRazdunk"] = "此成就与前几个版本的类似，这是一个个人成就，需要你避开BOSS大部分技能。",
	["TheEmeraldNightmare_Cenarius"] = "在最高等级，有足够的DPS你可以在任何一个%s被清除之前杀死BOSS。",
	["TheEmeraldNightmare_DragonsOfNightmare"] = "BOSS场地周围有4个入口。小队中的每个人都必须进入4个入口中的每一个，并从每个入口收集1个雾，这使他们获得一个buff。一旦组中所有玩家都有4个buff%s%s%s%s，你就可以杀死BOSS。你需要在战斗开始时留下至少一个玩家来拉BOSS，而其他人都在收集烟雾。",
	["TheEmeraldNightmare_EleretheRenferal"] = "为了达到这一效果，场地周围有7个带有红色发光效果的蛋。为了完成这一成就，所有的7个蛋都需要被碾过来销毁。只有使用%s或使用%s、%s或%s等技能的玩家才能到达某些蛋。一旦所有7个蛋都被摧毁，你可以杀死BOSS。\n\n注意：如果你看不到任何蛋，它们将在你拉BOSS后重生。",
	["TheEmeraldNightmare_IllgynothHeartOfCorruption"] = "=等待20个%s刷新并击杀。一旦你有20个%s存活，队伍中的每个人都需要站在眼前，然后把所有的小怪一起AOE掉。一旦你在10秒内在眼前击杀了20个小怪，你就可以杀死BOSS。",
	["TheEmeraldNightmare_Nythendra"] = "在%s阶段，%s将在场地边缘生成。一旦它们产生玩家需要点击虫子来压扁它们。一旦15个虫子被压扁，你就可以杀了BOSS。每个阶段会产生5个虫子，因此你至少需要3个%s阶段才能完成此项成就。",
	["TheEmeraldNightmare_Ursoc"] = "在BOSS所在的山洞入口外面，把右手边的小怪清掉。释放%s并等待他到BOSS那。在保持%s活着的同时杀死BOSS以获得此成就。",
	["TheEmeraldNightmare_Xavius"] = "要完成这个成就，你需要一个恶魔猎手来使用他的%s技能。在BOSS场地的外边缘，在战斗中3个点会产生%s。恶魔猎手将需要使用他的%s技能来找到小怪并将其拖到场地的中心。在100%%-65%%、65%%-30%%和30%%以下小怪刷新。一旦3个%s都被杀了，你就可以杀了BOSS。",
	["TheNighthold_ChronomaticAnomaly"] = "这个成就在英雄模式下更容易完成。随机玩家将获得%s debuff。这些玩家需要站在BOSS场地周围的蓝色圆圈上，直到%s debuff超时。一旦超时，你将看到一个聚光灯出现在%s 爆炸的位置。一旦房间周围至少有8个聚光灯，你就可以杀了BOSS。",
	["TheNighthold_Elisande"] = "为了达到这个成就，你需要召唤一个%s宠物，然后再拉BOSS。\n\n然后你要等待%s和%s产生，然后在彼此重叠击杀小怪。下一步将%s宠物拖到元素死亡产生的重叠气泡中。这将导致%s被杀死。一旦加完就可以杀了BOSS。",
	["TheNighthold_Guldan"] = "在P2，分组并等待%s生成。随着时间的推移，眼睛本身会产生越来越多的眼睛。一旦16个%s产生，在3秒内杀死他们，然后杀死BOSS。",
	["TheNighthold_HighBotanistTelarn"] = "BOSS区周围散落着神秘的水果。为了完成这个成就，每个玩家需要在拉BOSS之前吃这些水果中的一个，并且在BOSS战中不能死亡。神秘的水果会给玩家%s debuff。在满级，你可以简单地用爆发击杀BOSS。\n\n 注意：你必须至少有10名玩家才能完成这项成就。",
	["TheNighthold_Krosus"] = "为了完成这一成就，你必须让15个%s落在水里，当桥断了。在满级，你不能踩任何一个%s来最大化落入水中的%s的数量。\n\n注意：随着组中更多玩家的加入，产生的%s的数量会增加。",
	["TheNighthold_Skorpyron"] = "在满级，让你的整个团队站在场地中间的圆圈里，在BOSS施放%s之前杀死他。",
	["TheNighthold_StarAugurEtraeus"] = "为完成此成就，你需要将%s在%s boss场地中拖至%s。\n\n然后，你需要将BOSS打到30%%而不打小怪。然后小怪将转换为%s，此时你可以杀死小怪，然后杀死BOSS。",
	["TheNighthold_Tichondrius"] = "在满级，你可以在BOSS施放%s之前简单地杀死他。\n\n注意：这个成就是个人成就。",
	["TheUnderrot_ElderLeaxa"] = "%s技能对受到法术伤害的玩家使用%s。这意味着她所有的技能都必须被打断和闪避，以防止这个debuff。\n\n为了使成就更容易，你可以让治疗去DPS，这样你有一个额外的打断，也可以更快地杀死她。",
	["TheUnderrot_SporecallerZancha"] = "%s位于场地的左上角。若要激活他，你必须使BOSS向其方向施放%s。\n\n注意：如果%s躲过攻击，则只需走到场地中间，他很快就会传送到那里。",
	["TheUnderrot_UnboundAbomination"] = "%s的水坑偶尔会出%s并追随机玩家。你将不得不在没有任何%s死亡的情况下杀死BOSS，这很容易通过在场地周围放风筝圆圈来完成。\n\n使用控制来减缓他们的速度，记住要检查你的天赋、饰品和艾泽里特，以免意外杀死孢子。",
	["TolDagor_KnightCaptainValyri"] = "为了这个成就，你需要在场地的中央拉BOSS，并让其他4个玩家移动桶接近%s。你需要移动桶远离火：\n %s -这个法术是在玩家下面施放的，你只需要移动桶远离火。\n %s -当%s施放这个法术时，你需要移动桶远离火从BOSS面对的地方开始。\n %s -当玩家得到这个debuff效果时，他们必须立即离开桶，等待驱散。",
	["TolDagor_OverseerKorgus"] = "在你开始战斗后不久，%s向每个玩家发射%s发子弹并应用%s。每次玩家移动它的效果会变得更强，并最终导致玩家昏迷8秒，你应该在战斗开始时抱团，因为没有闪避的能力。",
	["TombOfSargeras_DemonicInquisition"] = "BOSS打到到20%%血左右。现在每当%s 达到100点能量时，他就会施放%s ，所以队中的每个人都应该攻击他，以使其快速获得最大痛苦值。\n\n 一旦队中的每个人都拥有最大痛苦值，就可以杀死BOSS。",
	["TombOfSargeras_FallenAvatar"] = "在满级，在BOSS施放%s之前杀死他。",
	["TombOfSargeras_Goroth"] = "为了这个成就，远程DPS和治疗重合在一起，这样%s会以一条指向他的直线产生%s。一旦有人被标记为%s，他们就必须走到柱子后面，这样恒星就会与%s碰撞并摧毁它们。\n\n一旦30个%s被摧毁，你就可以杀死BOSS。",
	["TombOfSargeras_Harjatan"] = "要生成%s，团队中的某个人必须使用%s玩具。\n\n 在战斗开始时使用玩具，集火%s，在他死后你可以杀死BOSS。",
	["TombOfSargeras_MistressSasszine"] = "为了完成这一成就，在BOSS站的P2（70%%）中，你需要将下面的每一个物品送到%s %s中。\n\n“多头蛇精华”来自于被%s击中的玩家在%s的外圆中。\n“墨汁沙司”来自于玩家踩%s的墨汁，该墨汁必须与%s的外圆接触。\n“风干玩家”来自于玩家死于%s的内圈。\n'生拌鳗鱼'来自被吸入到%s的外圈的%s。\n'鱼人肉片'来自被吸入到%s的外圈的%s。\n\n注意：在被吸入到%s之前，%s和%s需要大约10%%的生命值。%s只在P1产生，所以不要将BOSS打到P2直到至少有一个这样的小怪已经产生。",
	["TrialOfTheCrusader_Anubarak"] = "若要完成此成就，请拉住BOSS，然后等待25个%s生成。一旦生成了足够的小怪，请等待%s下地，然后AOE小怪。一旦小怪死了，你就可以杀了BOSS。",
	["TrialOfTheCrusader_LordJaraxxus"] = "若要完成此成就，请拉住BOSS，然后等待两个%s生成，然后只打BOSS。",
	["TrialOfValor_Guarm"] = "为了取得这个成就，玩家需要在战斗开始时在BOSS旁边捡起%s。这根骨头需要被拖入BOSS所施的三次呼吸中的每一次中（分别为%s、%s、%s）.\n\n注意：拿着骨头时不要做下列任何一项，否则会掉下来的。\n不要施法。\n不要被%s击中。\n拿着骨头时死亡。\n\n你需要一个单独的玩家来吃每一次吐息。因此，一旦一玩家已经吃了吐息，他们将需要放下骨头，以便另一名玩家可以拿起它。一旦三次吐息都吃了，你就可以杀死BOSS了。",
	["TrialOfValor_Helya"] = "在满级，这个成就更容易独自完成。只需杀死BOSS，而不需要%s debuff。这可以通过确保在杀死BOSS之前杀死%s。",
	["TrialOfValor_Odyn"] = "为了这个成就，你需要杀掉%s和%s才能进入P2。接下来你需要等待BOSS施放%s，此时地上的符文将亮起，并在其头顶上产生相应的符文。你需要记住符文在地板上的排列顺序，然后按该顺序杀死匹配符文上相应的小怪。\n\n一旦满足成就要求，你将获得%s，这意味着你可以杀死BOSS。",
	["Uldir_Fetid_Devourer_Tactics"] = "每四次近战攻击，BOSS会对离当前坦克最近的目标施放%s，造成相当于标准近战攻击300%%的物理伤害。\n\n每个玩家都必须被击中，并且建议使用个人减伤。战斗本身并不难，但是你应该优先考虑没有很好的个人减伤的人，因为BOSS在50%%（%s）时会狂暴，",
	["Uldir_GHuun_Tactics"] = "为完成此成就，必须让3人一组来执行%s：2 DPS+1治疗协助他们。\n\n如果人数太少，则应该邀请更多的人来帮助消灭小怪",
	["Uldir_MOTHER_Tactics"] = "要输入“密码”，你必须按特定顺序单击每个室中的按钮，该顺序对每个组随机排列。顺序可以是321、213、231或类似的组合。\n\n检查第一个房间的按钮是否停止闪烁，然后2-3 个DPS和一个治疗来单击第二个和第三个房间的按钮。如果按正确的顺序单击按钮，它们将停止闪烁，不再可单击。一旦你做到了这一点，你就可以杀死BOSS并取得成就。",
	["Uldir_Mythrax_Tactics"] = "截至2018年11月：成就现在的功能如前所述。\n\n这使成就变得更容易，因为你只需拿起你生成的球体。",
	["Uldir_Taloc_Tactics"] = "为了这个成就，当电梯在P2下降时，你必须收集4个%s。\n\n球体的位置似乎是随机的，但是恶魔猎手可以很容易地通过使用%s和%s获得所有的球体",
	["Uldir_Vectis_Tactics"] = "IAT_142148就在你去IIAT_134442之前就在平台上了。\n\n在你得到她身上的%s debuff后，你可以安全地杀死她，然后杀死BOSS，你就会获得成就。",
	["Uldir_ZekVoz_Tactics"] = "这个成就是相当容易的，但是你应该使用IAT_64482后，IAT_135129消失在P2。下一次IAT_135129出现时（第二次），这个谜题将激活，这有助于你的治疗者治疗和回蓝.\n\n %s会造成25k到35k的任何伤害，所以请确保尽可能躲开它们，这样你的治疗者就不会不知所措。",
	["Uldir_ZulReborn_Tactics"] = "这项成就是相当直接的，所有人不能踏上内圈的平台。这里有一些战斗的提示：\n\n坦克应该挑选所有的小怪，并将它们聚起来，这样近战DPS可以将它们杀掉。\n远程DPS应该24/7在BOSS身上，除非近战DPS不能及时杀死它们，否则不应该打小怪。\n如果你有两个牧师在一组中，然后，你应该将它们分配到不同的位置（组外的左侧和右侧），以便在小怪产生时覆盖两边。\n在40%%时，IAT_138967 将击退所有人，因此你应该将自己放置在靠近墙壁的位置，这样你就不会被击飞到平台上。",
	["Ulduar_AssemblyOfIron1"] = "要完成此成就，只需最后杀死%s",
	["Ulduar_FlameLeviathan1"] = "这项成就需要3次才能完成，因为你需要在3辆车内杀死BOSS",
	["Ulduar_FlameLeviathan2"] = "为了完成这一成就，你需要成为投石车中的乘客。当乘客按下%s按钮时，驾驶员会出现%s并使用%s动作。在%s的顶部，有两个炮塔。杀死其中一个炮塔将奖励这个成就",
	["Ulduar_FlameLeviathan3"] = "要完成此成就，你需要在副本开始时通过与%s对话来激活%s困难模式。在那之后，你只需要杀死BOSS，而不需要摧毁任何通向BOSS的塔楼。",
	["Ulduar_Other1"] = "在满级时，这一成就是很容易完成不使用车辆。只需在%s的两个支柱之间运行。下一步等待100个%s攻击你，然后将他们全部击杀，以获得这个成就。",
	["Ulduar_Other2"] = "杀死BOSS，不要修理任何车辆",
	["VaultOfTheWardens_AshGolm"] = "为了完成这一成就，你的团队中的每个人都需要在场地里踩%s，才能获得%s debuff。一旦团队中的每个人都有了%s debuff，你就可以杀了BOSS。",
	["VaultOfTheWardens_Cordana"] = "为了完成这一成就，在%s期间，该组中的任何玩家都不能被任何精灵击中。在%s期间，%s将发射一串箭，简要地显示精灵的位置。精灵们会沿着一条有一个小间隙的线穿过平台，玩家必须穿过这个间隙才能避开它们。将有4波灵魂需要避免。\n\n第二，携带%s的玩家必须在%s达到40%%生命值之前将其扔到地上，因为这是在%s的第一次施放开始时。%s不能用来显示精灵，因为这将使成就失败。\n\n一旦你在%s期间避开了所有4波精灵，并且所有的精灵都清空了平台，你可以杀死BOSS来获得此成就。\n\n注意：为了使成就更容易，你可以带来一个恶魔猎手，他可以使用自己的%s技能来显示精灵的位置，而不会失败。",
	["WaycrestManor_GorakTul"] = "在%s战中，BOSS会周期性地抛出%s，你需要用它来烧掉%s的尸体，这样他们就不能重生了。一旦BOSS施放%s并召唤第三个小怪，你就必须用爆发打小怪，然后快速使用%s烧死他们的尸体。",
	["WaycrestManor_Other"] = "正如成就的名字所暗示的，这是一个基于专业的成就，在这里你可以与物品互动来召唤BOSS。为了在整个副本中使用这些物品，至少需要75技能等级。\n\n （制皮）%s --召唤这个BOSS的地图在韦克雷斯特狩猎小屋的角落里，在克拉克壁炉房的角落里找到。\n（裁缝）%s -在顶层的宴会厅里找到了'%s'（一块布）.\n（炼金）%s -在%s所在的庭院对面的喷泉中找到%s。\n（铭文）%s -在下到酒窖前的左侧，在主楼的书架上找到了%s。\n（烹饪）%s -在酒窖中找到了葡萄酒，靠近其他酒桶。",
	["WaycrestManor_SoulboundGoliath"] = "%s每2秒获得一个名为%s的叠加buff，因此要获得这个成就，你必须通过在该区域产生的%s来风筝BOSS，以保持%s叠加减慢。"
}

core:RegisterLocale('zhCN', baseLocale)

-- core:RegisterLocale('enUS', baseLocale)
