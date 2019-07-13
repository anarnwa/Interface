GossipFrame:HookScript(
    'OnShow',
    function()
        local targetid = tonumber(string.match(tostring(UnitGUID('target')), '-([^-]+)-[^-]+$'))

        -- Stop if modifier key is held down
        if (IsModifierKeyDown()) then
            return
        end
        -- 不自动对话的NPC
        if
            (targetid == 155261 or --斯坦索姆 第一个对话出本NPC
                targetid == 155264 or --斯坦索姆 第二个对话出本NPC
                targetid == 155270)
         then --斯坦索姆 第三个对话出本NPC
            return
        end

        -- Stop if NPC has quests or quest turn-ins
        if (GetNumGossipActiveQuests() > 0 or GetNumGossipAvailableQuests() > 0) then
            return
        end

        -- Auto select option if only 1 is available
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

        -- Auto select option 1 if more than one option is available for the listed NPCs
        if (GetNumGossipOptions() > 1) then
            if
                (targetid == 39188 or -- Mongar (Legion Dalaran)
                    targetid == 96782 or -- Lucian Trias (Legion Dalaran)
                    targetid == 97004 or -- "Red" Jack Findle (Legion Dalaran)
                    targetid == 138708 or -- Garona Halforcen (BFA)
                    targetid == 135614 or -- Master Mathias Shaw (BFA)
                    targetid == 131287 or -- Natal'hakata (Horde Zandalari Emissary)
                    targetid == 138097 or -- Muka Stormbreaker (Stormsong Valley Horde flight master)
                    targetid == 35642)
             then -- Jeeves
                SelectGossipOption(1)
            end
        end
    end
)
