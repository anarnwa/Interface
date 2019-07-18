--不自动对话的NPC列表
local DoNotAutoGossip = {
    [155261] = true, --斯坦索姆宠物地下城  第一个对话出本NPC
    [155264] = true, --斯坦索姆宠物地下城  第二个对话出本NPC
    [155270] = true, --斯坦索姆宠物地下城  第三个对话出本NPC
    [43929] = true, --布灵顿4000
    [77789] = true, --布灵顿5000
    [101527] = true --布灵顿6000
}
local AutoGossipOption_1 = {
    [39188] = true, -- Mongar (Legion Dalaran)
    [96782] = true, -- Lucian Trias (Legion Dalaran)
    [97004] = true, -- "Red" Jack Findle (Legion Dalaran)
    [138708] = true, -- Garona Halforcen (BFA)
    [135614] = true, -- Master Mathias Shaw (BFA)
    [131287] = true, -- Natal'hakata (Horde Zandalari Emissary)
    [138097] = true, -- Muka Stormbreaker (Stormsong Valley Horde flight master)
    [35642] = true -- Jeeves
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
        if (DoNotAutoGossip[targetid] == true) then
            return
        end

        -- 如果这个NPC有任务，就不自动对话
        if (GetNumGossipActiveQuests() > 0 or GetNumGossipAvailableQuests() > 0) then
            return
        end

        -- 在列表1里的自动选择选项1
        if (AutoGossipOption_1[targetid] == true) then
            SelectGossipOption(1)
        end
        -- 如果只有一个选项，就自动对话
        local ticker =
            C_Timer.NewTicker(
            0.1,
            function(ticker)
                if (GetNumGossipOptions() == 1) then
                    SelectGossipOption(1)
                else
                    ticker:Cancel()
                end
            end
        )
    end
)
