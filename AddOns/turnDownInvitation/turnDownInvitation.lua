local send = SendChatMessage
local bad = {}

function SendChatMessage(msg, chatType, languageID, target)
    if chatType == 'WHISPER' then
        local a, b = msg:find("BadBoy_Levels")
        if a then
            bad[Ambiguate(target, 'none')] = true
        else
            bad[Ambiguate(target, 'none')] = nil
        end
    end
    send(msg, chatType, languageID, target)
end

turnDownInvitation = CreateFrame('Frame')
turnDownInvitation:RegisterEvent('PARTY_INVITE_REQUEST')
turnDownInvitation:SetScript(
    'OnEvent',
    function(f, e, n)
        if bad[Ambiguate(n, 'none')] then
            StaticPopup1Button2:Click()
            print("已阻止|Hplayer:"..n.."|h["..n.."]|h的邀请")
        end
    end
)
