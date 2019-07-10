--http://nga.178.com/read.php?tid=11921035  DZ职业大厅自动对门扣门
--http://nga.178.com/read.php?tid=10529644  对话兽栏管理员时，自动治疗宠物
--http://nga.178.com/read.php?tid=5118571 自动点确认
-- 自定义要执行自动对话开始对战的NPC (没有添加进列表的NPC，在右键时不会执行任何动作，以游戏原生互动。)
--GarrisonCapacitiveDisplayFrame.CreateAllWorkOrdersButton  8.0 船上定单NPC

--if select(2, UnitClass("player")) ~= "ROGUE" then return end  
--https://www.wowhead.com/npc=91361
--https://www.wowdb.com/npcs/91361

local lusiNPC = { 
--旅店老板  (在列表里的旅店老板，右键直接打开售卖界面。除此以外的旅店老板右键则无任何操作)
	[120840] = true, --祖达萨--万灵旅店--无情的希莫
	[129556] = true, --祖达萨--猢狲王座(万灵旅店右下方，猴子旅店)--古克古克
	[122690] = true, --祖达萨--巨擘封印--“美人”布丽琳
	[135153] = true, --维斯雷·洛克霍德 LM 伯拉勒斯港旅店
--4.0 WLK 冠军的试炼 银色赛场 
	[35004] = true, --嘉伦·誓日 BL--第一次要选第二个(下面还有第二个)
	[35005] = true, --艾瑞莱丝·亮星 LM-第一次要选第二个(下面还有第二个)
}

local NPC = {
--添加右键NPC后，自动对话，自动点确定，自动下定单的NPC ID。
--8.0 飞行管理员NPC
	[138097] = true, --穆卡·破风者  BL 斯托颂--战牙要塞
	[135383] = true, --“碎天者”巴纳德·贝斯沃斯  LM沃顿--碎石码头
--8.0 始姐龟
    --龟壳游戏NPC
    [144351] = true, --收集者寇乔  斯托颂--求知者之眺
    [144350] = true, --收集者寇乔  提拉加德海峡--山顶上
    [144353] = true, --收集者寇乔  沃顿--虔敬者平台
    [144352] = true, --收集者寇乔  纳兹米尔--林阴巨木
    [144354] = true, --收集者寇乔  祖达萨--希巴拉海边
    [138476] = true, --收集者寇乔  德鲁斯瓦--雪林教堂
    --小洛快跑
    [144360] = true, --托基  斯托颂--翠石草甸
    [138480] = true, --托基  沃顿--托塔卡避难所
    [144361] = true, --托基  提拉加德海峡--托瓦斯营地
    [144362] = true, --托基  祖达萨--阿塔格罗尔
    --滩头阵线
    [138478] = true, --书卷贤者诺拉 德鲁斯瓦--雪林教堂 
    [144358] = true, --书卷贤者诺拉 沃顿 托塔卡避难所
    [144359] = true, --书卷贤者诺拉 祖达萨 港口处
    [144357] = true, --书卷贤者诺拉 纳兹米尔 托加之眠
    [144356] = true, --书卷贤者诺拉 提拉加德海峡  左边下角
    [144355] = true, --书卷贤者诺拉 斯托颂谷地 戴林要塞下边
--8.0 船上下定单的NPC
	[135614] = true, --马迪亚斯·肖尔大师      LM船上下随从定单的NPC
	[138708] = true, --半兽人迦罗娜               BL船上下随从定单的NPC
--7.2 宠物对战师
	[124617] = true, --环境学者伯特  诺莫瑞根宠物对战师
	[115286] = true, --克丽萨 贫瘠之地宠物对战师
--8.0宠物对战师
    --LM
	[140315] = true, --斯托颂谷地--艾迪·快手
	[141046] = true, --斯托颂谷地--莉娜·暗风 风暴神殿FB门口
	[141002] = true, --斯托颂谷地--艾丽·维恩
	[140880] = true, --德鲁斯瓦--迈克尔·斯卡恩 三只小蜜蜂
	[140461] = true, --德鲁斯瓦--呆伯特·麦克林特 三只蜘蛛
	[139489] = true, --德鲁斯瓦--赫尔墨斯船长
	[140813] = true, --德鲁斯瓦--菲基·闪哨
	[141077] = true, --提拉加德海峡--昆特 水底
	[141292] = true, --提拉加德海峡--德莉亚·哈那科
	[141479] = true, --提拉加德海峡--布尔利
    --BL
	[142054] = true, --沃顿--库萨
	[141945] = true, --沃顿--希兹克
	[141879] = true, --沃顿--基约
	[142096] = true, --祖达萨--卡拉加
	[142114] = true, --祖达萨--泰莉亚·火眉 阿塔达萨处
	[142234] = true, --祖达萨--祖加伊
	[141529] = true, --纳兹米尔--罗祖
	[141814] = true, --纳兹米尔--考瓦尔·暗须
	[141799] = true, --纳兹米尔--格雷迪·普雷特 (群兽领主)
--5.0 宠物对战师
	[66675] = true, --北极--派恩少校
	[68465] = true, --熊猫人雷霆之灵
	--[68564] = true, --橙宠--多斯里加，没有对话，右键就直接开始对战
	--[68563] = true, --橙宠--咖菲，没有对话，右键就直接开始对战
	[66738] = true, --勇敢的尹勇
	[68463] = true, --熊猫人烈焰之灵
	[66918] = true, --探索者祖什
	--[68562] = true, --橙宠--云游者啼乌，没有对话，右键就直接开始对战
	--[68559] = true, --橙宠--诺诺，没有对话，右键就直接开始对战
	[66741] = true, --天选者亚济
	[66739] = true, --废土行者苏游
	--[68558] = true, --橙宠--血刺，没有对话，右键就直接开始对战
	[68462] = true, --熊猫人流水之灵
	--[68560] = true, --橙宠--灰蹄，没有对话，右键就直接开始对战
	--[68566] = true, --橙宠--飞掠者溪雅，没有对话，右键就直接开始对战
	[66733] = true, --莫鲁克
	--[68561] = true, --橙宠--幸运的小艺，没有对话，右键就直接开始对战
	[66734] = true, --农夫倪石
	--[68555] = true, --橙宠--贪吃的卡瓦，没有对话，右键就直接开始对战
	[66730] = true, --圣地的俞娜
	--[68565] = true, --橙宠--尼顿，没有对话，右键就直接开始对战
	[68464] = true, --熊猫人微风之灵
-- 暗月马戏团宠物对战师
	[67370] = true, --左边 杰里米·费舍尔
	[85519] = true, --右边 克里斯托弗·冯·费舍尔
-- 5.0 永恒岛 小汤米
	[73626] = true, --新手小汤米
--7.0 破碎海滩
	[120076] = true, --宝藏大师伊克里格德  宝藏洞里那个虫语者
	[120898] = true, --战斗法师凯丝琳  修理和卖东西的女NPC
--7.0 DZ职业大厅守门NPC
	[96782] = true, --鲁希安·提亚斯      DZ职业大厅守门NPC
	[93188] = true, --墨戈                       DZ职业大厅守门NPC
	[97004] = true, --“红发”杰克·芬德"  DZ职业大厅守门NPC
--7.0 职业大厅下定单的NPC
	[110348] = true, --DZ--随从装备--马尔
	[105979] = true, --DZ--1阶随从人物--洛妮卡·静刃
	[106083] = true, --DZ--2阶随从人物--扬希·格里尔森
	[110434] = true, --SQ --随从装备--克里斯托弗
	[106447] = true, --SQ--1阶随从人物--指挥官安瑟拉
	[106448] = true, --SQ--2阶随从人物--指挥官伯恩
	[105015] = true, --WS--1阶随从人物--田吉
	[105019] = true, --WS--2阶随从人物--金莱
	[108393] = true, --XD--1阶随从人物--莉莉丝
	[106442] = true, --XD--2阶随从人物--亚里斯·黑爪
	[110433] = true, --DH--随从装备--斯丽特什
	[103025] = true, --DH--1阶随从人物--战争领主加尔顿
	[103760] = true, --DH--2阶随从人物--阿里亚娜·火心
	[110410] = true, --DK--随从装备--亡灵收藏家贝恩
	[106435] = true, --DK--1阶随从人物--黑暗召唤师马洛格
	[106436] = true, --DK--2阶随从人物--考加兹·亡斧
	[110408] = true, --SS--随从装备--穆尔
	[106216] = true, --SS--1阶随从人物--鬼母德雅拉
	[106217] = true, --SS--2阶随从人物--贾瑞德
	[110427] = true, --FS--随从装备--米娜蒂
	[106377] = true, --FS--1阶随从人物--大法师欧妮娅拉
	[106433] = true, --FS--2阶随从人物--大咒术师米米克
	[110412] = true, --LR--随从装备--坚定的贝格
	[106444] = true, --LR--1阶随从人物--乐娜拉
	[106446] = true, --LR--2阶随从人物--辛普森
	[106457] = true, --SM--1阶随从人物--召唤师摩恩
	[112208] = true, --SM--2阶随从人物--菲琳达·弗莱伊
	[109829] = true, --SM--3阶随从人物--阿莱克索
	[106459] = true, --ZS--1阶随从人物--哈尔玛·斯塔索姆队长     --https://cn.wowhead.com/npc=106459      输入ID，就能显示中文名字了。
	[106460] = true, --ZS--2阶随从人物--萨薇·勇裔
	[110595] = true, --MS--随从装备--莉莉丝
	[106450] = true, --MS--1阶随从人物--资深学者格斯拉
	[106451] = true, --MS--2阶随从人物--传教士伊丽扎
--6.0 要塞机率刷新的日常宠物对战，奖励包包。
    --BL
	[91026] = true, --库拉·雷蹄1
	[91361] = true, --库拉·雷蹄2
	[91362] = true, --库拉·雷蹄3
	[91363] = true, --库拉·雷蹄4
	[91364] = true, --库拉·雷蹄5
    --LM
	[90675] = true, --收藏家爱瑞斯1
	[91014] = true, --收藏家爱瑞斯2
	[91015] = true, --收藏家爱瑞斯3
	[91016] = true, --收藏家爱瑞斯4
	[91017] = true, --收藏家爱瑞斯5
--4.0 WLK 冠军的试炼FB   银色赛场 
	[35004] = true, --嘉伦·誓日 BL--第二次要选第一个
	[35005] = true, --艾瑞莱丝·亮星 LM--第二次要选第一个
	[35117] = true, --圈养的银色角鹰兽
--暗月马戏团传送NPC
	[55382] = true, --暗月马戏团秘法师  BL友善
	[54334] = true, --暗月马戏团秘法师  LM友善
}

local function GetNPCID()
	return tonumber(string.match(UnitGUID('npc') or '', 'Creature%-.-%-.-%-.-%-.-%-(.-)%-'))
end

local OnGossip = function()
	if IsAltKeyDown() or IsShiftKeyDown() or IsControlKeyDown() then
		return
	end
    local npcID = GetNPCID()
    if lusiNPC[npcID] then    --如果是旅店老板，且上面列表里有ID的，就直接打开售卖界面。
		SelectGossipOption(2)
	end
	if NPC[npcID] then
		SelectGossipOption(1)
	end
end
local f = CreateFrame("Frame") 
f:RegisterEvent("GOSSIP_SHOW") 
f:SetScript("OnEvent", OnGossip)

--自动点击确认
local AotuClick = CreateFrame("Frame") 
AotuClick:RegisterEvent("GOSSIP_SHOW")       
AotuClick:SetScript("OnEvent", function(self, event, ...) 
    local dialog = StaticPopup_FindVisible("GOSSIP_CONFIRM") 
    local npcID = GetNPCID() 
      if dialog and NPC[npcID] then
         StaticPopup_OnClick(dialog, 1) 
      end 
end)

--8.0 船上招募随从NPC，右键自动对话，并自动点击全部招募。 代码抄： bulkorder  http://nga.178.com/read.php?tid=7679581
--GarrisonCapacitiveDisplayFrame.CreateAllWorkOrdersButton
function XiaDinDan()
    z:SetScript("OnUpdate", function(self)
        C_Garrison.RequestShipmentCreation()
        local npcID = GetNPCID() 
        if NPC[npcID] then
            self:SetScript("OnUpdate", nil)
        end
    end)
end

local f2 = CreateFrame("Frame", 'z', UIParent)
f2:RegisterEvent("SHIPMENT_CRAFTER_INFO")
f2:RegisterEvent("SHIPMENT_CRAFTER_OPENED")
function f2:SHIPMENT_CRAFTER_OPENED ()
    if IsAltKeyDown() or IsShiftKeyDown() or IsControlKeyDown() then
	    return
    end
      -- btn:SetScript("OnClick", XiaDinDan)
      -- btn:Hide()
end

function f2:SHIPMENT_CRAFTER_INFO()
    XiaDinDan()
end

f2:SetScript("OnEvent", function(self, event, ...)
    local npcID = GetNPCID() 
    if NPC[npcID] then
       self[event] (self, ...)
    end
end)