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

Event("AUCTION_HOUSE_SHOW", function()
    if BuyoutCheckButton == nil then
        CreateFrame("CheckButton", "BuyoutCheckButton", AuctionFrameBrowse, "UICheckButtonTemplate")
        BuyoutCheckButton:SetPoint("LEFT", BrowseDropDownButton, "RIGHT", 100, 13)
        BuyoutCheckButton:SetSize(24, 24)
        BuyoutCheckButtonText:SetFontObject(GameFontHighlightSmall);
        BuyoutCheckButtonText:SetText("一键购买");
        hooksecurefunc("BrowseButton_OnClick", function(button)
            if BuyoutCheckButton:GetChecked() then
                if AuctionFrame.buyoutPrice then
                    if AuctionFrame.buyoutPrice > 100000000 then
                        StaticPopup_Show("BUYOUT_AUCTION");
                    else
                        PlaceAuctionBid(AuctionFrame.type, GetSelectedAuctionItem(AuctionFrame.type), AuctionFrame.buyoutPrice)
                    end
                end
            end
        end)
    end
end)
