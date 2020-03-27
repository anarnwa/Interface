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

Event(
    'ADDON_LOADED',
    function()
        if not AutoGossipNPCID then
            AutoGossipNPCID = {}
        end
    end
)

GossipFrame:HookScript(
    'OnShow',
    function()
        local targetid = tonumber(string.match(tostring(UnitGUID('target')), '-([^-]+)-[^-]+$'))

        -- 如果按下控制键就不自动对话
        if (IsModifierKeyDown()) then
            return
        end

        -- 如果这个NPC有任务，就不自动对话
        if (GetNumGossipActiveQuests() > 0 or GetNumGossipAvailableQuests() > 0) then
            return
        end
        --如果在AutoGossipNPCID表里 就根据表数据选择
        if (AutoGossipNPCID[targetid] ~= nil) then
            if AutoGossipNPCID[targetid] ~= 0 then
                SelectGossipOption(AutoGossipNPCID[targetid])
            else
                return
            end
        end

        -- 如果只有一个选项，就自动对话
        if (GetNumGossipOptions() == 1) then
            SelectGossipOption(1)
        end

        C_Timer.After(
            0.1,
            function()
                if (StaticPopup1:IsVisible()) then
                    pcall(
                        function()
                            StaticPopup_OnClick(StaticPopup_FindVisible('GOSSIP_CONFIRM'), 1)
                        end
                    )
                end
            end
        )

        local ticker =
            C_Timer.NewTicker(
            0.3,
            function(ticker)
                if (GetNumGossipOptions() == 1) then
                    SelectGossipOption(1)
                    C_Timer.After(
                        0.1,
                        function()
                            if (StaticPopup1:IsVisible()) then
                                pcall(
                                    function()
                                        StaticPopup_OnClick(StaticPopup_FindVisible('GOSSIP_CONFIRM'), 1)
                                    end
                                )
                            end
                        end
                    )
                else
                    ticker:Cancel()
                end
            end
        )
    end
)

SLASH_AutoGossip1 = '/ac'
SlashCmdList['AutoGossip'] = function(cmd, editbox)
    cmd = string.lower(cmd)
    if cmd == '' or cmd == 'help' then
        print('/ac add/+ NPCID  选项')
        print('/ac remove/- NPCID')
        return
    end
    local a, b = string.find(cmd, ' ')
    if not a or not b then
        print('格式输入错误')
        return
    end
    local cmd1 = string.sub(cmd, 1, a - 1)
    local cmd2 = string.sub(cmd, b + 1, -1)
    if cmd1 == 'add' or cmd1 == '+' then
        a, b = string.find(cmd2, ' ')
        cmd1 = string.sub(cmd2, 1, a - 1)
        cmd2 = string.sub(cmd2, b + 1, -1)
        if not tonumber(cmd1) or not tonumber(cmd2) then
            print('格式输入错误')
            return
        end
        AutoGossipNPCID[tonumber(cmd1)] = tonumber(cmd2)
        if cmd2 ~= '0' then
            print('已将NPC ' .. cmd1 .. ' 添加至自动对话列表 将自动选择第 ' .. cmd2 .. ' 项')
        else
            print('已将NPC ' .. cmd1 .. ' 添加至自动对话列表 将不进行自动对话')
        end
        return
    end
    if cmd1 == 'remove' or cmd1 == '-' then
        if not tonumber(cmd2) then
            print('格式输入错误')
            return
        end
        AutoGossipNPCID[tonumber(cmd2)] = nil
        print('已将NPC ' .. cmd2 .. ' 从自动对话列表移除 将默认选择唯一选择项')
    end
    print('格式输入错误')
end
