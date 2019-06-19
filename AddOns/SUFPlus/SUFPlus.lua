local function Event(event, handler)
    if _G.event == nil then
        _G.event = CreateFrame("Frame")
        _G.event.handler = {}
        _G.event.OnEvent = function(frame, event, ...)
            for key, handler in pairs(_G.event.handler[event]) do
                handler(...)
            end
        end
        _G.event:SetScript("OnEvent", _G.event.OnEvent)
    end
    if _G.event.handler[event] == nil then
        _G.event.handler[event] = {}
        _G.event:RegisterEvent(event)
    end
    table.insert(_G.event.handler[event], handler)
end

local function HookFormatNumber()
    if ShadowUF then
        ShadowUF.FormatLargeNumber = function(self, number)
            if (number < 9999) then
                return number
            elseif (number < 999999) then
                return string.format("%.2f万", number / 10000)
            elseif (number < 9999999) then
                return string.format("%.2f万", number / 10000)
            elseif (number < 99999999) then
                return string.format("%.2f万", number / 10000)
            elseif (number < 999999999) then
                return string.format("%.2f亿", number / 100000000)
            end
            
            return string.format("%d亿", number / 100000000)
        
        end
        
        function ShadowUF:SmartFormatNumber(number)
            if (number < 9999) then
                return number
            elseif (number < 999999) then
                return string.format("%.2f万", number / 10000)
            elseif (number < 9999999) then
                return string.format("%.2f万", number / 10000)
            elseif (number < 99999999) then
                return string.format("%.2f万", number / 10000)
            elseif (number < 999999999) then
                return string.format("%.2f亿", number / 100000000)
            end
            
            return string.format("%d亿", number / 100000000)
        end
    
    end
end

Event("PLAYER_ENTERING_WORLD", function()
    HookFormatNumber()
end)
