--不自动对话的NPC列表
local DoNotAutoGossip = {
    [155261] = true, --斯坦索姆宠物地下城  第一个对话出本NPC
    [155264] = true, --斯坦索姆宠物地下城  第二个对话出本NPC
    [155270] = true, --斯坦索姆宠物地下城  第三个对话出本NPC
    [43929] = true, --布灵顿4000
    [77789] = true, --布灵顿5000
    [101527] = true --布灵顿6000
}
local OtherOption = {
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
        if (DoNotAutoGossip[targetid] == true) then
            return
        end

        -- 如果这个NPC有任务，就不自动对话
        if (GetNumGossipActiveQuests() > 0 or GetNumGossipAvailableQuests() > 0) then
            return
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
        --如果不止一个选项且在other表里 就根据表数据选择
        if (OtherOption[targetid] ~= nil) then
            SelectGossipOption(OtherOption[targetid])
        end
    end
)
