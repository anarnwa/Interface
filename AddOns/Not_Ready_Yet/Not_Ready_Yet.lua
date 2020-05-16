local ADDON, ns = ...
local NotReadyYet = LibStub('AceAddon-3.0'):NewAddon(ADDON, 'AceConsole-3.0', 'AceEvent-3.0')
local nexttime = {}
local report = {}
local GetTime1 = GetTime
local GetSpellLink1 = GetSpellLink
local specialization
local options_table

function NotReadyYet:ShowConfig()
    LibStub('AceConfigDialog-3.0'):SetDefaultSize(ADDON, 550, 550)
    LibStub('AceConfigDialog-3.0'):Open(ADDON)
end

local send_chat_message_types = {
    SAY = '说（副本内生效）',
    EMOTE = '表情',
    YELL = '喊（副本内生效）',
    PARTY = '小队',
    RAID = '团队',
    SMARTRAID = '副本频道>团队>小队>战斗信息>聊天栏',
    INSTANCE_CHAT = '副本频道',
    COMBAT = '战斗信息',
    PRINT = '聊天栏'
}

function NotReadyYet:OnInitialize()
    self.db = LibStub('AceDB-3.0'):New('Not_Ready_Yet_DB')
    specialization = GetSpecialization()
    options_table = {
        order = 1,
        name = 'CD通报',
        type = 'group',
        args = {
            enable = {
                order = 1,
                name = '开启插件',
                type = 'toggle',
                set = function(info, val)
                    NotReadyYet.db.global.enable = val
                end,
                get = function(info)
                    return NotReadyYet.db.global.enable
                end
            },
            addspellid = {
                order = 2,
                name = '添加法术ID',
                type = 'input',
                set = function(info, val)
                    if val == nil or val == '' then
                        return
                    end
                    local id = tonumber(val) or tonumber(val:match(':[0-9]+'):sub(2))
                    if id then
                        NotReadyYet.db.class[specialization][id] = GetSpellInfo(id)
                    end
                end,
                get = function(info)
                    return
                end
            },
            removespellid = {
                order = 3,
                name = '移除法术',
                type = 'select',
                values = NotReadyYet.db.class[specialization],
                set = function(info, val)
                    NotReadyYet.db.class[specialization][val] = nil
                end,
                get = function(info)
                    return
                end
            },
            reportcd = {
                order = 4,
                name = '喊话间隔',
                type = 'input',
                set = function(info, val)
                    local id = tonumber(val) or tonumber(val:match('[0-9]+'))
                    if id then
                        NotReadyYet.db.global.CD = id
                    end
                end,
                get = function(info)
                    return tostring(NotReadyYet.db.global.CD) .. '秒'
                end,
                width = 0.75
            },
            mincd = {
                order = 5,
                name = '施法成功后不通报的时间',
                type = 'input',
                set = function(info, val)
                    local id = tonumber(val) or tonumber(val:match('[0-9]+'))
                    if id then
                        NotReadyYet.db.global.mincd = id
                    end
                end,
                get = function(info)
                    return tostring(NotReadyYet.db.global.mincd) .. '秒'
                end
            },
            maxcd = {
                order = 6,
                name = '法术CD小于此项时不通报',
                type = 'input',
                set = function(info, val)
                    local id = tonumber(val) or tonumber(val:match('[0-9]+'))
                    if id then
                        NotReadyYet.db.global.maxcd = id
                    end
                end,
                get = function(info)
                    return tostring(NotReadyYet.db.global.maxcd) .. '秒'
                end
            },
            succeededenable = {
                order = 7,
                name = '开启施法成功喊话',
                type = 'toggle',
                set = function(info, val)
                    NotReadyYet.db.global.succeededenable = val
                end,
                get = function(info)
                    return NotReadyYet.db.global.succeededenable
                end,
            },
            SUCCEEDEDchannel = {
                order = 8,
                name = '发送频道',
                type = 'select',
                values = send_chat_message_types,
                set = function(info, val)
                    NotReadyYet.db.global.succeededchannel = val
                end,
                get = function(info)
                    return NotReadyYet.db.global.succeededchannel
                end,
                width = 2
            },
            SUCCEEDEDreport = {
                order = 9,
                name = '自定义施法成功的喊话  {SpellName}为技能名',
                type = 'input',
                set = function(info, val)
                    NotReadyYet.db.global.SUCCEEDEDreport = val
                end,
                get = function(info)
                    return NotReadyYet.db.global.SUCCEEDEDreport
                end,
                width = 'full'
            },
            FaILEDenable = {
                order = 10,
                name = '开启施法失败喊话',
                type = 'toggle',
                set = function(info, val)
                    NotReadyYet.db.global.failedenable = val
                end,
                get = function(info)
                    return NotReadyYet.db.global.failedenable
                end,
            },
            FaILEDchannel = {
                order = 11,
                name = '发送频道',
                type = 'select',
                values = send_chat_message_types,
                set = function(info, val)
                    NotReadyYet.db.global.failedchannel = val
                end,
                get = function(info)
                    return NotReadyYet.db.global.failedchannel
                end,
                width = 2
            },
            FaILEDreport = {
                order = 12,
                name = '自定义施法失败的喊话  {SpellName}为技能名  {CD} 为CD',
                type = 'input',
                set = function(info, val)
                    NotReadyYet.db.global.FaILEDreport = val
                end,
                get = function(info)
                    return NotReadyYet.db.global.FaILEDreport
                end,
                width = 'full'
            },
            readyenable = {
                order = 13,
                name = '开启法术就绪喊话',
                type = 'toggle',
                set = function(info, val)
                    NotReadyYet.db.global.readyenable = val
                end,
                get = function(info)
                    return NotReadyYet.db.global.readyenable
                end,
            },
            readychannel = {
                order = 14,
                name = '发送频道',
                type = 'select',
                values = send_chat_message_types,
                set = function(info, val)
                    NotReadyYet.db.global.readychannel = val
                end,
                get = function(info)
                    return NotReadyYet.db.global.readychannel
                end,
                width = 2
            },
            readyreport = {
                order = 15,
                name = '自定义施法CD结束时的喊话  {SpellName}为技能名',
                type = 'input',
                set = function(info, val)
                    NotReadyYet.db.global.readyreport = val
                end,
                get = function(info)
                    return NotReadyYet.db.global.readyreport
                end,
                width = 'full'
            },
            INTERRUPTenable = {
                order = 16,
                name = '开启打断/驱散喊话',
                type = 'toggle',
                set = function(info, val)
                    NotReadyYet.db.global.interruptenable = val
                end,
                get = function(info)
                    return NotReadyYet.db.global.interruptenable
                end,
            },
            INTERRUPTchannel = {
                order = 17,
                name = '发送频道',
                type = 'select',
                values = send_chat_message_types,
                set = function(info, val)
                    NotReadyYet.db.global.interruptchannel = val
                end,
                get = function(info)
                    return NotReadyYet.db.global.interruptchannel
                end,
                width = 2
            }
        }
    }
    LibStub('AceConfigRegistry-3.0'):RegisterOptionsTable(ADDON, options_table)
    self:RegisterChatCommand('nry', 'ShowConfig')
    self:RegisterChatCommand('notreadyyet', 'ShowConfig')
end

function NotReadyYet:PLAYER_ENTERING_WORLD()
    if not self.db.global.mincd then
        self.db.global.mincd = 2
    end
    if not self.db.global.maxcd then
        self.db.global.maxcd = 2
    end
    if not self.db.global.CD then
        self.db.global.CD = 5
    end
    if self.db.global.failedenable == nil then
        self.db.global.failedenable = true
    end
    if not self.db.global.failedchannel then
        self.db.global.failedchannel = 'SMARTRAID'
    end
    if not self.db.global.FaILEDreport then
        self.db.global.FaILEDreport = '{SpellName} 释放失败 CD {CD} 秒'
    end
    if self.db.global.succeededenable == nil then
        self.db.global.succeededenable = true
    end
    if not self.db.global.succeededchannel then
        self.db.global.succeededchannel = 'SMARTRAID'
    end
    if not self.db.global.SUCCEEDEDreport then
        self.db.global.SUCCEEDEDreport = '已施放{SpellName}'
    end
    if self.db.global.enable == nil then
        self.db.global.enable = true
    end
    if self.db.global.readyenable == nil then
        self.db.global.readyenable = true
    end
    if not self.db.global.readychannel then
        self.db.global.readychannel = 'SMARTRAID'
    end
    if not self.db.global.readyreport then
        self.db.global.readyreport = '{SpellName} 已就绪'
    end
    if self.db.global.interruptenable == nil then
        self.db.global.interruptenable = true
    end
    if not self.db.global.interruptchannel then
        self.db.global.interruptchannel = 'SMARTRAID'
    end

    specialization = GetSpecialization()
    if not self.db.class[specialization] then
        self.db.class[specialization] = {}
    end
    options_table.args.removespellid.values = NotReadyYet.db.class[specialization]
end

local function getreport(str, spelllink, cd)
    local text = string.gsub(str, '{SpellName}', spelllink)
    text = string.gsub(text, '{CD}', string.format('%d', cd))
    return text
end

function NotReadyYet:OnEnable()
    self:RegisterEvent('PLAYER_ENTERING_WORLD')
    self:RegisterEvent('UNIT_SPELLCAST_FAILED')
    self:RegisterEvent('UNIT_SPELLCAST_SUCCEEDED')
    self:RegisterEvent('ACTIONBAR_UPDATE_COOLDOWN')
    self:RegisterEvent('COMBAT_LOG_EVENT_UNFILTERED')
    self:RegisterEvent('PLAYER_SPECIALIZATION_CHANGED')
end
function NotReadyYet:PLAYER_SPECIALIZATION_CHANGED()
    specialization = GetSpecialization()
    if not self.db.class[specialization] then
        self.db.class[specialization] = {}
    end
    options_table.args.removespellid.values = NotReadyYet.db.class[specialization]
end

function NotReadyYet:Print(message, message_type)
    if (message_type == 'PRINT') then
        print(message)
    elseif (message_type == 'COMBAT') then
        if (CombatText_AddMessage) then
            CombatText_AddMessage(message, COMBAT_TEXT_SCROLL_FUNCTION)
        end
    elseif (message_type == 'SMARTRAID') then
        local isInstanceGroup = IsInGroup(LE_PARTY_CATEGORY_INSTANCE)
        if UnitInBattleground('player') then
            pcall(
                function()
                    SendChatMessage(message, 'INSTANCE_CHAT')
                end
            )
        elseif UnitInRaid('player') then
            pcall(
                function()
                    SendChatMessage(message, 'RAID')
                end
            )
        elseif UnitInParty('player') then
            if isInstanceGroup then
                pcall(
                    function()
                        SendChatMessage(message, 'INSTANCE_CHAT')
                    end
                )
            else
                pcall(
                    function()
                        SendChatMessage(message, 'PARTY')
                    end
                )
            end
        elseif (CombatText_AddMessage) then
            CombatText_AddMessage(message, COMBAT_TEXT_SCROLL_FUNCTION)
        else
            if IsInInstance() then
                pcall(
                    function()
                        SendChatMessage(message, 'SAY')
                    end
                )
            else
                print(message)
            end
        end
    elseif (message_type == 'SAY' or message_type == 'YELL') then
        if IsInInstance() then
            pcall(
                function()
                    SendChatMessage(message, message_type, nil, nil)
                end
            )
        end
    else
        pcall(
            function()
                SendChatMessage(message, message_type, nil, nil)
            end
        )
    end
end

function NotReadyYet:COMBAT_LOG_EVENT_UNFILTERED()
    if not self.db.global.enable then
        return
    end
    if not self.db.global.interruptenable then
        return
    end
    local timestamp,
        eventType,
        hideCaster,
        sourceGUID,
        sourceName,
        sourceFlags,
        sourceRaidFlags,
        destGUID,
        destName,
        destFlags,
        destRaidFlags = CombatLogGetCurrentEventInfo()
    if eventType == 'SPELL_INTERRUPT' then
        local spellId, spellName, spellSchool, extraSpellId, extraSpellName, extraSchool =
            select(12, CombatLogGetCurrentEventInfo())
        if sourceName == UnitName('player') or sourceName == UnitName('pet') then
            self:Print('打断-->' .. GetSpellLink1(extraSpellId), self.db.global.interruptchannel)
        end
    elseif eventType == 'SPELL_DISPEL' then
        local spellId, spellName, spellSchool, extraSpellId, extraSpellName, extraSchool, auraType =
            select(12, CombatLogGetCurrentEventInfo())
        if sourceName == UnitName('player') or sourceName == UnitName('pet') then
            self:Print('驱散-->' .. GetSpellLink1(extraSpellId), self.db.global.interruptchannel)
        end
    elseif eventType == 'SPELL_STOLEN' then
        local spellId, spellName, spellSchool, extraSpellId, extraSpellName, extraSchool, auraType =
            select(12, CombatLogGetCurrentEventInfo())
        if sourceName == UnitName('player') then
            self:Print('偷取-->' .. GetSpellLink1(extraSpellId), self.db.global.interruptchannel)
        end
    elseif eventType == 'SPELL_MISSED' then
        local spellId, spellName, spellSchool, missType, isOffHand, amountMissed =
            select(12, CombatLogGetCurrentEventInfo())
        if missType == 'REFLECT' and destName == UnitName('player') then
            self:Print('反射-->' .. GetSpellLink1(spellId), self.db.global.interruptchannel)
        elseif missType == 'ABSORB' and destName == '根基图腾' and destFlags == 8465 then
            self:Print('吸收-->' .. GetSpellLink1(spellId), self.db.global.interruptchannel)
        end
    end
end

function NotReadyYet:ACTIONBAR_UPDATE_COOLDOWN()
    if not self.db.global.enable then
        return
    end
    if not self.db.global.readyenable then
        return
    end
    local start, dur
    for k, v in pairs(report) do
        start, dur = GetSpellCooldown(k)
        if dur == 0 then
            self:Print(getreport(self.db.global.readyreport, GetSpellLink1(k), nil), self.db.global.readychannel)
            report[k] = nil
        end
    end
end

function NotReadyYet:UNIT_SPELLCAST_SUCCEEDED(event, unitTarget, castGUID, spellID)
    if not self.db.global.enable then
        return
    end
    if not self.db.global.succeededenable then
        return
    end
    if unitTarget == 'player' and self.db.class[specialization][spellID] ~= nil then
        nexttime[spellID] = GetTime1() + self.db.global.mincd
        report[spellID] = true
        self:Print(
            getreport(self.db.global.SUCCEEDEDreport, GetSpellLink1(spellID), nil),
            self.db.global.succeededchannel
        )
    end
end

function NotReadyYet:UNIT_SPELLCAST_FAILED(event, unit, castGUID, spellID)
    if not self.db.global.enable then
        return
    end
    if not self.db.global.failedenable then
        return
    end
    if unit == 'player' and self.db.class[specialization][spellID] ~= nil then
        local start, dur = GetSpellCooldown(spellID)
        local expirationTime = start + dur
        if expirationTime <= GetTime1() then
            return
        end
        if nexttime[spellID] == nil then
            nexttime[spellID] = GetTime1() - 1
        end
        if nexttime[spellID] > GetTime1() then
            return
        end
        if (expirationTime - GetTime1()) < self.db.global.maxcd then
            return
        end
        local cd = expirationTime - GetTime1()
        self:Print(getreport(self.db.global.FaILEDreport, GetSpellLink1(spellID), cd),self.db.global.succeededchannel)
        nexttime[spellID] = GetTime1() + self.db.global.CD
    end
end
