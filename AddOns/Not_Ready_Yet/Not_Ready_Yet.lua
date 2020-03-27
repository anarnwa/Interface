reportcdplayerspecialization = nil
reportcdplayerclass = nil
local function isInSpellID(t)
    for _, v in ipairs(SpellID[reportcdplayerclass][reportcdplayerspecialization]) do
        if v == t then
            return true
        end
    end
    return false
end
local function Event(event, handler)
    if _G.event == nil then
        _G.event = CreateFrame('Frame')
        _G.event.handler = {}
        _G.event.OnEvent = function(frame, event, ...)
            for key, handler in pairs(_G.event.handler[event]) do
                handler(...)
            end
        end
        _G.event:SetScript('OnEvent', _G.event.OnEvent)
    end
    if _G.event.handler[event] == nil then
        _G.event.handler[event] = {}
        _G.event:RegisterEvent(event)
    end
    table.insert(_G.event.handler[event], handler)
end
local function getreport(name, cd)
    local text = string.gsub(Setting.report, '{SpellName}', name)
    text = string.gsub(text, '{CD}', string.format('%d', cd))
    return text
end
Event(
    'PLAYER_ENTERING_WORLD',
    function()
        if not SpellID or SpellID == nil then
            SpellID = {}
        end
        if not Setting or Setting == nil then
            Setting = {}
            Setting.open = true
        end
        if not Setting.mincd or Setting.mincd == nil then
            Setting.mincd = 2
        end
        if not Setting.maxcd or Setting.maxcd == nil then
            Setting.maxcd = 2
        end
        if not Setting.CD or Setting.CD == nil then
            Setting.CD = 5
        end
        if not Setting.report or Setting.report == nil then
            Setting.report = '{SpellName} 释放失败 CD {CD} 秒'
        end
        reportcdplayerspecialization = GetSpecialization()
        reportcdplayerclass = select(2, UnitClass('player'))
        if not SpellID[reportcdplayerclass] or SpellID[reportcdplayerclass] == nil then
            SpellID[reportcdplayerclass] = {}
        end
        if
            not SpellID[reportcdplayerclass][reportcdplayerspecialization] or
                SpellID[reportcdplayerclass][reportcdplayerspecialization] == nil
         then
            SpellID[reportcdplayerclass][reportcdplayerspecialization] = {}
        end
    end
)
local nexttime = {}

Event(
    'UNIT_SPELLCAST_SUCCEEDED',
    function(unitTarget, castGUID, spellID)
        if unitTarget == "player" and isInSpellID(spellID) then
            nexttime[spellID] = GetTime() +Setting.mincd
        end
    end
)

Event(
    'UNIT_SPELLCAST_FAILED',
    function(unit, castGUID, spellID)
        if not Setting.open then
            return
        end
        if unit == 'player' and isInSpellID(spellID) then
            local start, dur = GetSpellCooldown(spellID)
            local name = GetSpellInfo(spellID)
            local expirationTime = start + dur
            if expirationTime <= GetTime() then
                return
            end
            if nexttime[spellID] == nil then
                nexttime[spellID] = GetTime() - 1
            end
            if nexttime[spellID] > GetTime() then
                return
            end
            if (expirationTime - GetTime()) < Setting.maxcd then
                return
            end
            local cd = expirationTime - GetTime()
            local stringtext = getreport(name, cd)
            if IsInGroup() and not IsInRaid() then
                SendChatMessage(stringtext, 'PARTY')
                nexttime[spellID] = GetTime() + Setting.CD
            end
            if IsInRaid() then
                SendChatMessage(stringtext, 'Raid')
                nexttime[spellID] = GetTime() + Setting.CD
            end
        end
    end
)

Event(
    'PLAYER_SPECIALIZATION_CHANGED',
    function()
        reportcdplayerspecialization = GetSpecialization()
        reportcdplayerclass = select(2, UnitClass('player'))
        if
            not SpellID[reportcdplayerclass][reportcdplayerspecialization] or
                SpellID[reportcdplayerclass][reportcdplayerspecialization] == nil
         then
            SpellID[reportcdplayerclass][reportcdplayerspecialization] = {}
        end
    end
)
