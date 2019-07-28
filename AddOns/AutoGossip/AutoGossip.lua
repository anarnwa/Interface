--不自动对话的NPC列表
local DoNotAutoGossip = {
    [155261] = true, --斯坦索姆宠物地下城  第一个对话出本NPC
    [155264] = true, --斯坦索姆宠物地下城  第二个对话出本NPC
    [155270] = true, --斯坦索姆宠物地下城  第三个对话出本NPC
    [43929] = true, --布灵顿4000
    [77789] = true, --布灵顿5000
    [101527] = true --布灵顿6000
}

--不止一个选项的NPC
local AUtoGossipOnlyOnce = {
    [39188] = 1, -- Mongar (Legion Dalaran)
    [96782] = 1, -- Lucian Trias (Legion Dalaran)
    [97004] = 1, -- "Red" Jack Findle (Legion Dalaran)
    [138708] = 1, -- Garona Halforcen (BFA)
    [135614] = 1, -- Master Mathias Shaw (BFA)
    [131287] = 1, -- Natal'hakata (Horde Zandalari Emissary)
    [138097] = 1, -- Muka Stormbreaker (Stormsong Valley Horde flight master)
    [35642] = 1 -- Jeeves
}

GossipFrame:HookScript(
    'OnShow',
    function()
        local targetid = tonumber(string.match(tostring(UnitGUID('target')), '-([^-]+)-[^-]+$'))

        -- 如果按下控制键就不自动对话
        if (IsModifierKeyDown()) then
            return
        end
        -- 不自动对话的NPC
        if (DoNotAutoGossip[targetid]) then
            return
        end

        -- 如果这个NPC有任务，就不自动对话
        if (GetNumGossipActiveQuests() > 0 or GetNumGossipAvailableQuests() > 0) then
            return
        end
        --如果不止一个选项且在AUtoGossipOnlyOnce表里 就根据表数据选择
        if (AUtoGossipOnlyOnce[targetid] ~= nil) then
            SelectGossipOption(AUtoGossipOnlyOnce[targetid])
        end

        -- 如果只有一个选项，就自动对话
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
                                StaticPopup_OnClick(StaticPopup_FindVisible('GOSSIP_CONFIRM'), 1)
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
