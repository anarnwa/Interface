-- Quest-o-matic
-- Copyright (c) 2010-2016, RiskyNet <riskynet@gmail.com>
-- All rights reserved.

--添加右键NPC后不自动执行的NPC ID。
local ignoreQuestNPC = {
	[64029] = true,  --长者林曦  (5.0 LM 锦绣谷-七星殿换战火徽记的NPC)
	[63996] = true,  --长者廖禄  (5.0 BL 锦绣谷-双月殿换战火徽记的NPC)
	[88570] = true,  -- 命运扭曲者提拉尔 (7.0 BL 战争之矛换既定命运印记的NPC）
	[87391] = true,  -- 命运扭曲者赛瑞斯 (7.0 LM 风暴之盾换既定命运印记的NPC）
	[90481] = true,  --德拉卡 (7.0 塔纳安丛林--BL 沃玛尔要塞发放日常任务的NPC)
	[90309] = true,  --大主教伊瑞尔 (7.0 塔纳安丛林--LM 雄狮之巢发放日常任务的NPC)
	[111243] = true, -- 大法师兰达洛克 (7.0兑换破碎命运印记的NPC-新达拉然）
	[103792] = true, -- 格里伏塔 (DZ大厅每周交空气币的NPC）
	[119388] = true, -- 酋长哈顿 （阿古斯交资源给随从的NPC-克罗库恩）
	[127037] = true, -- 纳毕鲁 （阿古斯交资源给随从的NPC-玛凯雷 洞里那个）
	[124312] = true, -- 大主教图拉扬  （阿古斯交资源给随从的NPC-飞船上）
	[126954] = true, -- 大主教图拉扬  （阿古斯交资源给随从的NPC-另一艘飞船上）
	[98489] = true,  -- 尾锚NPC--海难俘虏
	[43929] = true,	 -- 布林顿4000
	[77789] = true,	 -- 布林顿5000
	--[101527] = true, -- 布林顿6000
	[141584] = true, -- 祖尔温 (8.0 BL 赞达拉兑换战痕命运徽记的NPC)
	[142063] = true, -- 特兹兰 (8.0 LM 伯拉勒斯兑换战痕命运徽记的NPC)
}

local function GetNPCID()
	return tonumber(string.match(UnitGUID('npc') or '', 'Creature%-.-%-.-%-.-%-.-%-(.-)%-'))
end

local QOM = LibStub("AceAddon-3.0"):NewAddon("Questomatic", "AceConsole-3.0", "AceEvent-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("Questomatic", true)
local LibQTip = LibStub("LibQTip-1.0")
local icon = LibStub("LibDBIcon-1.0")
local tooltip

local QOMLDB = LibStub("LibDataBroker-1.1"):NewDataObject("Questomatic",{
    type = "data source",
    text = "",
    label = "Questomatic",
    icon = "Interface\\GossipFrame\\AvailableQuestIcon",
    OnClick = function(self, button)
        if button == "LeftButton" then
            if QOM.db.char.toggle then
                QOM.db.char.toggle = false
            else
                QOM.db.char.toggle = true
            end
            QOM:toggleIcon(QOM.db.char.toggle)
        else
            InterfaceOptionsFrame_OpenToCategory("Questomatic")
        end

        LibQTip:Release(tooltip)
        self.tooltip = nil
    end,
})

local dateFormats = {
    ["%Y.%m.%d"] = "YYYY.MM.DD",
    ["%Y/%m/%d"] = "YYYY/MM/DD",
    ["%d.%m.%y"] = "DD.MM.YYYY",
    ["%d/%m/%y"] = "DD/MM/YYYY",
    ["%m/%d/%Y"] = "MM/DD/YYYY",
    ["%m/%d/%y"] = "MM/DD/YYYY",
}

local defaults = {
    char = {
        toggle = true,
        accept = true,
        greeting = true,
        escort = false,
        complete = true,
        inraid = true,
        dailiesonly = false,
        pvp = false,
        mapbutton = {
            hide = false,
        },
        questlevels = false,
        tooltipHint = true,
        diskey = 1,  --用Shift键  1=Alt   2=Ctrl   3=Shift
        record = 0,
        recorddate = nil,
        dateformat = "%Y.%m.%d",
    },
}

local options = {
    name = "Quest-o-matic",
    handler = Questomatic,
    type = "group",
    args = {
        intro = {
            order = 1,
            type = "description",
            name = L["QOM_DESC"],
            cmdHidden = true,
        },
        general = {
            order = 2,
            type = "group",
            inline = true,
            name = L["General Settings"],
            args = {
                toggle = {
                    order = 3,
                    type = "toggle",
                    name = L["AddOn Enable"],
                    desc = L["Enable/Disable Quest-o-matic"],
                    get = function() return QOM.db.char.toggle end,
                    set = function( info, value )
                        QOM.db.char.toggle = value
                        QOM:toggleIcon(QOM.db.char.toggle)
                    end
                },
                accept = {
                    order = 4,
                    type = "toggle",
                    name = L["Auto Accept Quests"],
                    desc = L["Enable/Disable auto quest accepting"],
                    get = function() return QOM.db.char.accept end,
                    set = function( info, value ) QOM.db.char.accept = value end
                },
                complete = {
                    order = 5,
                    type = "toggle",
                    name = L["Auto Complete Quests"],
                    desc = L["Enable/Disable auto quest complete"],
                    get = function() return QOM.db.char.complete end,
                    set = function( info, value ) QOM.db.char.complete = value end
                },
            },
        },
        types = {
            order = 6,
            type = "group",
            inline = true,
            name = L["Types settings"],
            args = {
                dailiesonly = {
                    order = 7,
                    type = "toggle",
                    name = L["Dailies Only"],
                    desc = L["Enable/Disable auto accepting for daily quests only"],
                    get = function() return QOM.db.char.dailiesonly end,
                    set = function( info, value ) QOM.db.char.dailiesonly = value end
                },
                pvp = {
                    order = 8,
                    type = "toggle",
                    name = L["Accept PVP Quests"],
                    desc = L["Enable/Disable auto accepting for PvP flagging quests"],
                    get = function() return QOM.db.char.pvp end,
                    set = function( info, value ) QOM.db.char.pvp = value end
                },
                escort = {
                    order = 9,
                    type = "toggle",
                    name = L["Auto Accept Escorts"],
                    desc = L["Enable/Disable auto escort accepting"],
                    get = function() return QOM.db.char.escort end,
                    set = function( info, value) QOM.db.char.escort = value end
                },
            },
        },
        other = {
            order = 10,
            type = "group",
            inline = true,
            name = L["Other settings"],
            args = {
                inraid = {
                    order = 11,
                    type = "toggle",
                    name = L["Enable in Raid"],
                    desc = L["Enable/Disable auto accepting quests in raid"],
                    get = function() return QOM.db.char.inraid end,
                    set = function( info, value ) QOM.db.char.inraid = value end
                },
                greeting = {
                    order = 12,
                    type = "toggle",
                    name = L["Skip Greetings"],
                    desc = L["Enable/Disable NPC's greetings skip for one or more quests"],
                    get = function() return QOM.db.char.greeting end,
                    set = function( info, value ) QOM.db.char.greeting = value end
                },
                mapbutton = {
                    order = 13,
                    type = "toggle",
                    name = L["Minimap Button"],
                    desc = L["Enable/Disable minimap button"],
                    get = function() return not QOM.db.char.mapbutton.hide end,
                    set = function( info, value )
                        QOM.db.char.mapbutton.hide = not value
                        if value == false then
                            icon:Hide("Questomatic")
                        else
                            icon:Show("Questomatic")
                        end
                    end
                },
                questlevels = {
                    order = 14,
                    type = "toggle",
                    name = L["Quest Levels"],
                    desc = L["Show/Hide quest levels in quest log"],
                    get = function() return QOM.db.char.questlevels end,
                    set = function( info, value ) QOM.db.char.questlevels = value end,
                    disabled = true
                },
                tooltipHint = {
                    order = 15,
                    type = "toggle",
                    name = L["Show tooltip hint"],
                    get = function() return QOM.db.char.tooltipHint end,
                    set = function(info, value) QOM.db.char.tooltipHint = value end
                },
                spacer1 = {
                    order = 16,
                    name = "",
                    type = "description",
                    width = "full",
                    cmdHidden = true
                },
                diskey = {
                    order = 17,
                    type = "select",
                    name = L["Disable Key"],
                    get = function() return QOM.db.char.diskey end,
                    set = function( info, value ) QOM.db.char.diskey = value end,
                    values = { "Alt", "Ctrl", "Shift" },
                },
                spacer2 = {
                    order = 18,
                    name = "",
                    type = "description",
                    width = "full",
                    cmdHidden = true
                },
                dateformat = {
                    order = 18,
                    type = "select",
                    name = L["Date format"],
                    values = dateFormats,
                    get = function() return QOM.db.char.dateformat end,
                    set = function( info, value ) QOM.db.char.dateformat = value end,
                },
            },
        },
        config = {
            order = 17,
            type = "execute",
            name = L["Config"],
            desc = L["Open configuration"],
            func = function() InterfaceOptionsFrame_OpenToCategory("Questomatic") end,
            guiHidden = true,
        },
    },
}

function QOM:OnInitialize()
    self.db = LibStub("AceDB-3.0"):New("QOMDB", defaults)
    LibStub("AceConfig-3.0"):RegisterOptionsTable("Questomatic", options, {"qm", "qom"})
    LibStub("AceConfigDialog-3.0"):AddToBlizOptions("Questomatic", "Questomatic")
    icon:Register("Questomatic", QOMLDB, QOM.db.char.mapbutton)
    QOM:toggleIcon(QOM.db.char.toggle)
end

function QOM:OnEnable()
    self:RegisterEvent("QUEST_GREETING")
    self:RegisterEvent("GOSSIP_SHOW")
    self:RegisterEvent("QUEST_DETAIL")
    self:RegisterEvent("QUEST_ACCEPT_CONFIRM")
    self:RegisterEvent("QUEST_PROGRESS")
    self:RegisterEvent("QUEST_COMPLETE")
    self:RegisterEvent("QUEST_LOG_UPDATE")
end

function QOM:OnDisable()
    self:UnregisterAllEvents()
    self.db.char.toggle = false
end

function QOM:toggleIcon(val)
    if val then
        QOMLDB.icon = "Interface\\GossipFrame\\ActiveQuestIcon"
    else
        QOMLDB.icon = "Interface\\GossipFrame\\AvailableQuestIcon"
    end
end

function QOM:CheckConfigs()
    if ( not self.db.char.toggle ) then return end
    if UnitInRaid("player") and ( not self.db.char.inraid ) then return end

    if IsModifierKeyDown() then
        if     ( self.db.char.diskey == 1 ) and IsAltKeyDown() then return
        elseif ( self.db.char.diskey == 2 ) and IsControlKeyDown() then return
        elseif ( self.db.char.diskey == 3 ) and IsShiftKeyDown() then return end
    end

    return true
end

function QOM:CheckQuestData() --不自动接
         local npcID = GetNPCID()                   --添加NPC ID就不自动接任务
         if (ignoreQuestNPC[npcID]) then return end  --添加NPC ID就不自动接任务
    if ( not QuestIsDaily() ) and self.db.char.dailiesonly then return end
    if QuestFlagsPVP() and ( not self.db.char.pvp ) then return end
       return true
end

function QOM:QUEST_GREETING(eventName, ...) --当NPC有大于2个以上任务时，不自动读泡泡。
        local npcID = GetNPCID()                  --添加NPC ID就不自动读2个以上泡泡
	    if (ignoreQuestNPC[npcID]) then return end --添加NPC ID就不自动读2个以上泡泡
    if QOM:CheckConfigs() and self.db.char.greeting then
        local numact,numava = GetNumActiveQuests(), GetNumAvailableQuests()
        if numact+numava == 0 then return end
        if numava > 0 then
            SelectAvailableQuest(1)
        end
        if numact > 0 then
            SelectActiveQuest(1)
        end
    end
end

function QOM:GOSSIP_SHOW(eventName, ...) --不自动读泡泡
         local npcID = GetNPCID()                  --添加NPC ID就不自动读泡泡
         if (ignoreQuestNPC[npcID]) then return end --添加NPC ID就不自动读泡泡
    if QOM:CheckConfigs() and self.db.char.greeting then
        if GetGossipAvailableQuests() then   --这一行，如果把if写成elseif，那么有泡泡的NPC界面就不会自动接/完成任务了。
            SelectGossipAvailableQuest(1)
        elseif GetGossipActiveQuests() then
            SelectGossipActiveQuest(1)
        end
    end
end

function QOM:QUEST_DETAIL(eventName, ...)
         local npcID = GetNPCID()                  --未知
         if (ignoreQuestNPC[npcID]) then return end --未知
    if QOM:CheckConfigs() and QOM:CheckQuestData() and self.db.char.accept then
        AcceptQuest()
    end
end

function QOM:QUEST_ACCEPT_CONFIRM(eventName, ...)
         local npcID = GetNPCID()                  --未知
         if (ignoreQuestNPC[npcID]) then return end --未知
    if QOM:CheckConfigs() and self.db.char.escort then
        ConfirmAcceptQuest()
    end
end

function QOM:QUEST_PROGRESS(eventName, ...) --不自动下一步
         local npcID = GetNPCID()                  --添加NPC ID就不自动下一步 比如阿古斯交资源，对话NPC，会先弹出来说明要交150资源窗口，下一步是继续，此条就是这是个下一步。
	     if (ignoreQuestNPC[npcID]) then return end --添加NPC ID就不自动下一步 比如阿古斯交资源，对话NPC，会先弹出来说明要交150资源窗口，下一步是继续，此条就是这是个下一步。
    if QOM:CheckConfigs() and self.db.char.complete then
        CompleteQuest()
    end
end

function QOM:QUEST_COMPLETE(eventName, ...)  --不自动交，完成任务
        local npcID = GetNPCID()                   --添加NPC ID就不自动交，完成任务
	    if (ignoreQuestNPC[npcID]) then return end --添加NPC ID就不自动交，完成任务
    if QOM:CheckConfigs() and self.db.char.complete then
        if GetNumQuestChoices() == 0 then
            GetQuestReward(QuestFrameRewardPanel.itemChoice)
        elseif GetNumQuestChoices() == 1 and QuestFrameRewardPanel.itemChoice == nil then
            GetQuestReward(1)
        end
    end
end

function QOM:QUEST_LOG_UPDATE(eventName, ...)
    numEntries, numQuests = GetNumQuestLogEntries()
    dailyComplete = GetDailyQuestsCompleted()
    if self.db.char.record < dailyComplete then
        self.db.char.record = dailyComplete
        self.db.char.recorddate = time()
    end
    QOMLDB.text = "Q: |cffffd200" .. numQuests .. "|r D: |cffffd200" .. dailyComplete .. "|r R: |cffffd200" .. self.db.char.record
end

--Broker tooltip section
function QOMLDB.OnEnter(self)
    if tooltip then
        LibQTip:Release(tooltip)
    end

    tooltip = LibQTip:Acquire("QuestomaticTooltip", 2, "LEFT", "LEFT")
    tooltip:Clear()
    self.tooltip = tooltip
    local columnCount = tooltip:GetColumnCount()
    local recordinfo = QOM.db.char.record
    local lineNum
    if ( QOM.db.char.recorddate ~= nil ) then
        if tonumber(QOM.db.char.recorddate) ~= nil then
            recordinfo = recordinfo .. " (" .. date(QOM.db.char.dateformat, QOM.db.char.recorddate) .. ")"
        else
            recordinfo = recordinfo .. " (" .. QOM.db.char.recorddate .. ")"
        end
    end

    lineNum = tooltip:AddLine(" ")
    tooltip:SetCell(lineNum, 1, L["Active quests"] .. ":", "LEFT")
    tooltip:SetCell(lineNum, 2, "|cffffd200" .. numQuests)

    lineNum = tooltip:AddLine(" ")
    tooltip:SetCell(lineNum, 1, L["Dailies completed"] .. ":", "LEFT")
    tooltip:SetCell(lineNum, 2, "|cffffd200" .. dailyComplete)

    lineNum = tooltip:AddLine(" ")
    tooltip:SetCell(lineNum, 1, L["Daily record"] .. ":", "LEFT")
    tooltip:SetCell(lineNum, 2, "|cffffd200" .. recordinfo)

    lineNum = tooltip:AddLine(" ")
    tooltip:SetCell(lineNum, 1, L["New day starts in"] .. ":", "LEFT")
    tooltip:SetCell(lineNum, 2, "|cffffd200" .. SecondsToTime(GetQuestResetTime()))

    if QOM.db.char.tooltipHint == true then
        tooltip:AddLine(" ")
        lineNum = tooltip:AddLine(" ")
        tooltip:SetCell(lineNum, 1, L["Left-click to toggle Quest-o-matic"], nil, "LEFT", columnCount)
        lineNum = tooltip:AddLine(" ")
        tooltip:SetCell(lineNum, 1, L["Right-click to open Quest-o-matic config"], nil, "LEFT", columnCount)
    end

    tooltip:SmartAnchorTo(self)
    tooltip:Show()
end

function QOMLDB.OnLeave(self)
    LibQTip:Release(tooltip)
    self.tooltip = nil
end