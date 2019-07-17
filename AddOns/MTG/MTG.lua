local showReq = true --显示每个项目的要求。
local showAllButNotOnlyMeetsReq = false --显示每个项目，但不是仅显示当前要求。

local j_sort = 1  --按以下方式对buyString进行排序：1个NPC优先。2稀有优先
local j_MerchantShowDelay = 0.5 --延迟

local valueableList = {}
local fullNPC = {
    [151950] = true,
    [151951] = true,
    [151952] = true,
    [151953] = true,
    [152084] = true,
}
local replaceList  = {
    [167923] = 167916,
}

local j_fullNPCRaidTargetIndex = {
    [151950] = 6,
    [151951] = 5,
    [151952] = 1,
    [151953] = 3,
    [152084] = 2,
}
local check_List = {
  "|TInterface\\TARGETINGFRAME\\UI-RaidTargetingIcon_1:26|t ", -- 星星
  "|TInterface\\TARGETINGFRAME\\UI-RaidTargetingIcon_2:26|t ", -- 圆
  "|TInterface\\TARGETINGFRAME\\UI-RaidTargetingIcon_3:26|t ", -- 菱形
  "|TInterface\\TARGETINGFRAME\\UI-RaidTargetingIcon_4:26|t ", -- 三角形
  "|TInterface\\TARGETINGFRAME\\UI-RaidTargetingIcon_5:26|t ", -- 月亮
  "|TInterface\\TARGETINGFRAME\\UI-RaidTargetingIcon_6:26|t ", -- 正方形
  "|TInterface\\TARGETINGFRAME\\UI-RaidTargetingIcon_7:26|t ", -- 叉叉
  "|TInterface\\TARGETINGFRAME\\UI-RaidTargetingIcon_8:26|t ", -- 骷髅
}

local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED") 
frame:SetScript("OnEvent", function(self, event,...) 
    if self[event] then
        return self[event](self, event, ...)
    end
end )



local debug = {
    forceValueablePurchase = false, --# open up this to test under item daily locked.
    showCapeTacoTidestallion = false,
    showValueableList = false,
}
local j_playerIsWearingCape = function()
    return (GetInventoryItemID("player", 15) == 169489) and true or false
end
local initializeValueableList = function()   
    local playerIsWearingCape = j_playerIsWearingCape
    local playerHasTaco = (GetItemCount(170100, true) > 0) and true or false --查看身上的 可饼数量 大于0才买
    local playerLearnedCrimsonTidestallion = function() --玩家学习了深红色的小种马
        for k,v in pairs(C_MountJournal.GetMountIDs()) do
            local _, spellID, _, _, _, _, _, _, _, _, isCollected = C_MountJournal.GetMountInfoByID(v)
            if spellID == 300153 then
                return isCollected
            end
        end
        return false --# incorrectly not scanned (maybe in some case?) return as unlearned
    end
    
    if debug.showCapeTacoTidestallion then
        print("playerIsWearingCape - ", playerIsWearingCape)
        print("playerHasTaco - ", playerHasTaco)
        print("playerLearnedCrimsonTidestallion - ", playerLearnedCrimsonTidestallion())
        
    end
    local buyNormalItems = (j_BuyItemOption == 1) and 1 or 0
    local buyRareItemsNoTaco = (j_BuyRareItemOption <= 2) and playerIsWearingCape and 1 or 0
    local buyRareItemsWithTaco = (j_BuyRareItemOption == 2) and playerIsWearingCape and ((not j_CheckTacoFirst) or playerHasTaco) and 1 or 0
    
    valueableList = {
        [168053] = buyNormalItems,
        [168091] = buyNormalItems,
        [168092] = buyNormalItems,
        [168093] = buyNormalItems,
        [168094] = buyNormalItems,
        [168095] = buyNormalItems,
        [168096] = buyNormalItems,
        [168097] = buyNormalItems,
        --## the following items require Azsh'ari Stormsurger Cape
        --## as the wowhead data is not completed yet, some might skip taco check 
        [170159] = buyRareItemsNoTaco,
        [170152] = buyRareItemsNoTaco,
        [170153] = buyRareItemsWithTaco,
        [170157] = buyRareItemsNoTaco,
        [170161] = buyRareItemsWithTaco,
        [170162] = buyRareItemsNoTaco, --# no need taco
        [170101] = buyRareItemsNoTaco,
        [169202] = playerLearnedCrimsonTidestallion() and 0 or buyRareItemsWithTaco, --# Crimson Tidestallion
        [170158] = buyRareItemsWithTaco,
    }

    if debug.showValueableList then
        for k,v in pairs(valueableList) do 
            print(k, GetItemInfo(k), v)
        end        
    end
end
local everGenerated = false

local function J_UpdavalueableList(J_id,J_Boolean)--更新数据表
    local playerIsWearingCape = j_playerIsWearingCape
    local playerHasTaco = (GetItemCount(170100, true) > 0) and true or false --查看身上的 可饼数量 大于0才买
    local buyRareItemsNoTaco = (j_BuyRareItemOption <= 2) and playerIsWearingCape and 1 or 0
    local buyRareItemsWithTaco = (j_BuyRareItemOption == 2) and playerIsWearingCape and ((not j_CheckTacoFirst) or playerHasTaco) and 1 or 0
    local playerLearnedCrimsonTidestallion = function() --玩家学习了深红色的小种马
        for k,v in pairs(C_MountJournal.GetMountIDs()) do
            local _, spellID, _, _, _, _, _, _, _, _, isCollected = C_MountJournal.GetMountInfoByID(v)
            if spellID == 300153 then
                return isCollected
            end
        end
        return false --# incorrectly not scanned (maybe in some case?) return as unlearned
    end
    local J_valueableList = {
        [170159] = buyRareItemsNoTaco,
        [170152] = buyRareItemsNoTaco,
        [170153] = buyRareItemsWithTaco,
        [170157] = buyRareItemsNoTaco,
        [170161] = buyRareItemsWithTaco,
        [170162] = buyRareItemsNoTaco, --# no need taco
        [170101] = buyRareItemsNoTaco,
        [169202] = playerLearnedCrimsonTidestallion() and 0 or buyRareItemsWithTaco, --# Crimson Tidestallion
        [170158] = buyRareItemsWithTaco,
    }
    if J_Boolean and J_valueableList[J_id]~=nil and valueableList[J_id] == buyRareItemsNoTaco and J_id ~= 169202 then
        valueableList[J_id] = buyRareItemsWithTaco
        print(J_id,"更新数据表-这个物品要塔饼")
    elseif not J_Boolean and J_valueableList[J_id]~=nil and valueableList[J_id] == buyRareItemsWithTaco and J_id ~= 169202 then
        valueableList[J_id] = buyRareItemsNoTaco
        print(J_id,"更新数据表-这个物品不要塔饼")
    end
end
--# Don't touch anything below!

local name, realm = UnitFullName("player")
    if not realm or realm=="" then
        if not PLAYER_REALM or PLAYER_REALM=="" then
            PLAYER_REALM = GetRealmName()
        end
        realm = PLAYER_REALM
    end
local playerFullName = name.."-"..realm

local talkedNPC = {}
local NPCNameList = {}
local merchantItemList = {}

local buyList = {}
local buyLists = {}
local GetItemID = function(itemLink)
    if not itemLink then return nil end
    local itemID = string.match(itemLink, "item:(%d+):")
    return itemID and tonumber(itemID) or nil
end

local getItemLink = function(itemID)
    if not itemID then return nil end
    return select(2,GetItemInfo(itemID))
end

local GetNPCID = function(unit)
    if not unit then return nil end
    local id = UnitGUID(unit)
    id = string.match(id, "-(%d+)-%x+$")
    return tonumber(id, 10)
end

local isSetContain = function(s1, s2)
    for k,v in pairs(s2) do
        if (not s1[k]) then
            return false
        end
    end
    return true
end

local queueBuyMerchantItem = function(itemIndex, amount)
    local amountLeft = amount
    local max = math.min(GetMerchantItemMaxStack(itemIndex), 255)
    while amountLeft > 0  do
        BuyMerchantItem(itemIndex, min(amountLeft, max))
        amountLeft  = amountLeft - min(amountLeft, max)

    end
end

generateBuyList = function(amount, itemID)

    if not merchantItemList[itemID] then 
        return 
    end
   
    local currentItemReq, currentItemNPC = merchantItemList[itemID].Req, merchantItemList[itemID].NPC
    local currentNeedAmount
    if buyList[itemID] then
        currentNeedAmount = amount + buyList[itemID].amount
    else
        currentNeedAmount = amount - GetItemCount(itemID) --# delete the num on player on first look
    end
    
    if currentNeedAmount > 0 then
        for k, req in pairs(currentItemReq) do
            if req.item ~= "c" then
                if buyList[itemID] then
                    
                    generateBuyList(amount * req.amount, replaceList[req.item] or req.item)
                else
                    
                    generateBuyList(currentNeedAmount * req.amount, replaceList[req.item] or req.item)
                end
            end
        end
    end

    buyList[itemID] = {
        amount = currentNeedAmount,
        NPC = currentItemNPC,
    }
        buyLists[itemID] = {
        amount = currentNeedAmount,
        NPC = currentItemNPC,
    }

    return 
end

local meetsReq = function(itemID)
    if not buyList[itemID] then return false end
    if not merchantItemList[itemID] then return false end
    local currentItemReq = merchantItemList[itemID].Req
    local amount = buyList[itemID].amount
    for k, req in pairs(currentItemReq) do
        if (req.item ~= "c") and (GetItemCount(req.item) < amount * req.amount) then
            return false
        end
    end
    return true
end

local generateBuyListFromValueable = function()

    for itemID, itemNum in pairs(valueableList) do
        if itemNum > 0 then

            generateBuyList(itemNum, itemID)
        end
        
        if buyList[itemID] then
            
            valueableList[itemID] = valueableList[itemID] - buyList[itemID].amount
        end
        
    end
end

local generatebuyString = function()
    local compare
    if j_sort == 1 then
        compare = function(a, b)
            if a.NPC < b.NPC then
                return true
            elseif a.NPC > b.NPC then
                return false
            elseif a.rarity < b.rarity then
                return true
            elseif a.rarity > b.rarity then
                return false
            elseif a.itemID < b.itemID then
                return true
            elseif a.itemID > b.itemID then
                return false
            end
        end
    elseif j_sort == 2 then
        compare = function(a, b)
            if a.rarity < b.rarity then
                return true
            elseif a.rarity > b.rarity then
                return false
            elseif a.NPC < b.NPC then
                return true
            elseif a.NPC > b.NPC then
                return false
            elseif a.itemID < b.itemID then
                return true
            elseif a.itemID > b.itemID then
                return false
            end
        end
    end

    
    local tempStrnSet = {}
    
    for itemID, itemBuyInfo in pairs(buyList) do
        local ReqStrn = showReq and string.format(" (%s)", generateReqString(itemID)) or ""
        local strn
        
        if meetsReq(itemID) or showAllButNotOnlyMeetsReq then--满足要求
            if itemBuyInfo.amount > 1 then
                strn = string.format(" %s 购买 %sx%d%s",NPCNameList[itemBuyInfo.NPC], getItemLink(itemID), itemBuyInfo.amount, ReqStrn)
            elseif itemBuyInfo.amount > 0 then
                strn = string.format(" %s 购买 %s%s",NPCNameList[itemBuyInfo.NPC], getItemLink(itemID), ReqStrn)
            end
            
            table.insert(tempStrnSet, {
                    itemID = itemID,            
                    strn = strn,
                    NPC = itemBuyInfo.NPC,
                    rarity = merchantItemList[itemID].rarity,
            })
        end        
    end
    
    table.sort(tempStrnSet, compare)
    
    local retStrn = ""
    for k,v in pairs(tempStrnSet) do
        if v.strn then
            retStrn = retStrn .. v.strn .. "\n"
        end
    end
    
    return retStrn
end

local checkDealReplacementString = function()
    local strn = ""

    for _, itemID in pairs(replaceList) do
        if GetItemCount(itemID) >= 1 then
            strn = string.format("%s 去水里手动使用 %s", strn, getItemLink(itemID))
        end
    end
    
    return strn
end

generateReqString = function(itemID)
    if not buyList[itemID] then return false end
    if not merchantItemList[itemID] then return false end
    local Req = merchantItemList[itemID].Req
    local Amount = buyList[itemID].amount
    local strn = ""
    if Amount > 0 then        
        for k, req in pairs(Req) do
            if req.item == "c" then
                strn = GetCoinText(Amount * req.amount, "+")
                break
            else
                if strn == "" then
                    strn = (Amount * req.amount > 1) and string.format("%sx%d", getItemLink(req.item), Amount * req.amount) or string.format("%s", getItemLink(req.item))
                else
                    strn = (Amount * req.amount > 1) and string.format("%s+%sx%d", strn, getItemLink(req.item), Amount * req.amount) or string.format("%s+%s", strn, getItemLink(req.item))
                end
            end
        end    
    end
    return strn
end



function J_MRRL_DELAYED_MERCHANT_SHOW()
    local NPCID, NPCname = GetNPCID("target"), UnitName("target")
    if j_fullNPCRaidTargetIndex[NPCID] and not GetRaidTargetIndex("target") then
        SetRaidTarget("target", j_fullNPCRaidTargetIndex[NPCID])
    end

    if NPCID and fullNPC[NPCID] then
        for itemIndex = 1, GetMerchantNumItems() do
            local currentItem = GetMerchantItemLink(itemIndex)
            
            if currentItem then
               
                local currentItemID = GetItemID(currentItem)
                local currentItemReq = {}
                
                if (NPCID == 152084) and (not talkedNPC[NPCID]) then
                    if not valueableList[currentItemID] then
                        valueableList[currentItemID] = 1
                    end
                end
                
                --# 满足需求检查购买列表。这是自动购买功能，并且只有在生成买单后才会使用。
                if meetsReq(currentItemID) then
                    if buyList[currentItemID].amount > 0 then
                        queueBuyMerchantItem(itemIndex, buyList[currentItemID].amount)
                        
                    end
                end
                
                local _, _, price, _, _, isPurchasable = GetMerchantItemInfo(itemIndex)
                if isPurchasable or debug.forceValueablePurchase then
                    if price == 0 then --# 这件物品是用货币买的。                       
                        for currencyIndex = 1, GetMerchantItemCostInfo(itemIndex) do
                            local _, currentCurrencyNum, currentCurrency = GetMerchantItemCostItem(itemIndex, currencyIndex)

                            currentItemReq[currencyIndex] = {
                                amount = currentCurrencyNum,
                                item = GetItemID(currentCurrency),
                            }                                
                        end
                    else --# 这件东西是用钱买的                    
                        currentItemReq[1] = {
                            amount = price,
                            item = "c",
                        }                            
                    end
                    
                    local _, _, rarity = GetItemInfo(currentItemID)

                    
                    merchantItemList[currentItemID] = {
                        Req = currentItemReq,
                        NPC = NPCID,
                        rarity = rarity,
                    }

                    if (NPCID == 152084) then --更新数据表
                        if currentItemReq[1].item ==170100 or currentItemReq[2].item ==170100 or currentItemReq[3].item ==170100 then 
                            J_UpdavalueableList(currentItemID,true)
                        else
                            J_UpdavalueableList(currentItemID,false)
                        end
                    end

                end 
            if not talkedNPC[NPCID] then
                print("扫描", NPCname,"物品信息",currentItem)
            end
                              
            else
                print(string.format("|cff999900未扫描物品信息. 重新和 %s 对话!", NPCname))
                return false
            end                
        end 
        talkedNPC[NPCID] = true
        NPCNameList[NPCID] = "|TInterface\\TARGETINGFRAME\\UI-RaidTargetingIcon_"..j_fullNPCRaidTargetIndex[NPCID]..":"..j_Markersize.."|t "..NPCname or NPCname
    end

    if isSetContain(talkedNPC, fullNPC) then --or talkedNPC[152084] 

        if everGenerated == false then
            initializeValueableList()
            generateBuyListFromValueable()--从Valuable生成购买列表
            everGenerated = true
        end
        
    end
    if fullNPC[NPCID] then 
        JNAYDBM_Purchase_prompt(string.format("%s%s", generatebuyString(), checkDealReplacementString()),5.0,false)
    end
    return true
end



function frame:MERCHANT_SHOW(event,...)
    C_Timer.After(j_MerchantShowDelay, J_MRRL_DELAYED_MERCHANT_SHOW)
end


function frame:MERCHANT_CLOSED(event,...)

    return true
end

local buyitems = ""
function frame:CHAT_MSG_LOOT(event,...)
    local line, _, _, _, unit = ...
    if unit == playerFullName then
        for itemID, _ in pairs(buyList) do
            local item = GetItemInfo(itemID)
            if string.match(line, item) then
                local lootAmount = string.match(line, item .. "]|h|rx(%d+)") or 1
                buyitems = buyitems ..itemID.."("..lootAmount..")"..unit.."】【"
                buyList[itemID].amount = buyList[itemID].amount - lootAmount
                break
            end
        end
    
    end
    MTGDB ={
    ["talkedNPC"] = talkedNPC,
    ["NPCNameList"] = NPCNameList,
    ["merchantItemList"] = merchantItemList,
    ["buyList"] = buyList,
    ["buyLists"] = buyLists,
    ["购买详情"] = buyitems,
    }
    return true
end
function JNAYDBM_Purchase_prompt(message,duration,clear)
    -- center-screen raid notice is easy
    if(clear)then
        RaidNotice_Clear(RaidBossEmoteFrame)
    end
    RaidNotice_AddMessage(RaidBossEmoteFrame, message, ChatTypeInfo["RAID_BOSS_EMOTE"],duration)
    -- chat messages are trickier
    local i
    for i = 1, NUM_CHAT_WINDOWS do
        local chatframes = { GetChatWindowMessages(i) }         
        local v
        for _, v in ipairs(chatframes) do
            if v == "MONSTER_BOSS_EMOTE" then
                local frame = 'ChatFrame' .. i
                if _G[frame] then
                    _G[frame]:AddMessage(message,1.0,1.0,0.0,GetChatTypeIndex(ChatTypeInfo["RAID_BOSS_EMOTE"].id))
                end
                break
            end
        end
    end
end
function frame:ADDON_LOADED(event,...)
    if j_BuyRareItemOption == nil then j_BuyRareItemOption = 2 end --1 购买不含塔可的稀有品。2 购买每一件珍稀物品。3 不要买稀有品
    if j_BuyItemOption == nil then j_BuyItemOption = 1 end --1购买普通物品  2不购买普通物品
    if j_Markersize == nil then j_Markersize = 26 end
    if j_CheckTacoFirst == nil then j_CheckTacoFirst = true end  --先检查玉米卷，然后再用玉米卷购买稀有品。
      frame:RegisterEvent("MERCHANT_SHOW")
      frame:RegisterEvent("MERCHANT_CLOSED")
      frame:RegisterEvent("CHAT_MSG_LOOT")
      

    initializeValueableList()
end







local MTG_OptionsFrame = CreateFrame("Frame", nil, InterfaceOptionsFramePanelContainer)
MTG_OptionsFrame:Hide()
MTG_OptionsFrame.name = "MTG"
MTG_OptionsFrame:SetScript("OnShow", function(self)
    if self.show then return end

    local guangao = MTG_OptionsFrame:CreateFontString(nil,"ARTWORK","GameFontNormal")
    guangao:SetTextColor(255,255,0)
    guangao:SetPoint("TOP")
    guangao:SetFont(GameFontNormal:GetFont(), 30)
    guangao:SetText("鱼人购买助手")

    local dropDown = CreateFrame("FRAME", "WPDemoDropDown", MTG_OptionsFrame, "UIDropDownMenuTemplate")
    dropDown:SetPoint("LEFT",0,-30)
    UIDropDownMenu_SetWidth(dropDown, 200)
    local j_fonts = {"购买普通物品", "不购买普通物品"}
    UIDropDownMenu_SetText(dropDown,j_fonts[j_BuyItemOption])
    UIDropDownMenu_Initialize(dropDown, function(self, level, menuList)
        local info = UIDropDownMenu_CreateInfo()
        info.func = function(self)
            j_BuyItemOption = self.value
            print("设置:"..j_fonts[j_BuyItemOption])
            UIDropDownMenu_SetText(dropDown,j_fonts[j_BuyItemOption])
        end
        for i, font in next, j_fonts do
            info.value = i
            info.text, info.arg1, info.checked = font, i, i == j_BuyItemOption
            UIDropDownMenu_AddButton(info)
        end
    end)

    local BuyRareItemdropDown = CreateFrame("FRAME", "WPDemoDropDown", MTG_OptionsFrame, "UIDropDownMenuTemplate")
    BuyRareItemdropDown:SetPoint("LEFT")
    UIDropDownMenu_SetWidth(BuyRareItemdropDown, 200)
    local fonts = {"购买不含饼干的的稀有品", "购买每一件珍稀物品", "不要买稀有品"}
    UIDropDownMenu_SetText(BuyRareItemdropDown,fonts[j_BuyRareItemOption])
    UIDropDownMenu_Initialize(BuyRareItemdropDown, function(self, level, menuList)
        local info = UIDropDownMenu_CreateInfo()
        info.func = function(self)
            j_BuyRareItemOption = self.value
            print("设置:"..fonts[j_BuyRareItemOption])
            UIDropDownMenu_SetText(BuyRareItemdropDown,fonts[j_BuyRareItemOption])
        end
        for i, font in next, fonts do
            info.value = i
            info.text, info.arg1, info.checked = font, i, i == j_BuyRareItemOption
            UIDropDownMenu_AddButton(info)
        end
    end)



    local Markersizetext = MTG_OptionsFrame:CreateFontString(nil,"ARTWORK","GameFontNormal")
    Markersizetext:SetTextColor(1,1,1)
    Markersizetext:SetPoint("LEFT",0,60)
    Markersizetext:SetText("标记图标大小")
    local MarkersizeEditBox = CreateFrame("EditBox", "Markersize", MTG_OptionsFrame, "InputBoxTemplate")
    MarkersizeEditBox:SetSize(100, 20)
    MarkersizeEditBox:SetPoint("LEFT",0,30)
    MarkersizeEditBox:SetAutoFocus(false)
    MarkersizeEditBox:SetText(j_Markersize)
    MarkersizeEditBox:SetCursorPosition(0)

    local J_button = CreateFrame("CheckButton", "j_s_CheckTacoFirst", MTG_OptionsFrame, "InterfaceOptionsCheckButtonTemplate")
    J_button:SetPoint("LEFT",0,-60)
    getglobal(J_button:GetName().."Text"):SetText("先检查塔可饼，然后再用塔可饼购买稀有品。")
    if j_CheckTacoFirst == true then J_button:SetChecked(true) else J_button:SetChecked(false) end


    self.show = true
    MTG_OptionsFrame:SetScript("OnHide", function(self)
    if _G["Markersize"]:GetText() then
        j_Markersize=_G["Markersize"]:GetText()
    end


    if _G["j_s_CheckTacoFirst"]:GetChecked() then
        if j_CheckTacoFirst ~= true then
            j_CheckTacoFirst = true       
        end
    else
        if j_CheckTacoFirst ~= false then
            j_CheckTacoFirst = false
        end
    end
    end)
end)
InterfaceOptions_AddCategory(MTG_OptionsFrame)