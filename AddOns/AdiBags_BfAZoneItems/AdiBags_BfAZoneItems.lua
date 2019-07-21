--[[
AdiBags_PriorExpansions - Seperates items from current expansion from those from prior ones, an addition to Adirelle's fantastic bag addon AdiBags.
Copyright 2019 Ggreg Taylor
All rights reserved.
--]]
local addon = LibStub('AceAddon-3.0'):GetAddon('AdiBags')
local L = setmetatable({}, {__index = addon.L})

local kCategory = 'Zone Item'
local kPfx = '|cff00ffff'
local kSfx = '|r'
local arrZoneItems = {
    '166846:麦卡贡',
    '166970:麦卡贡',
    '166971:麦卡贡',
    '166973:麦卡贡',
    '167012:纳沙塔尔',
    '167077:纳沙塔尔',
    '167562:麦卡贡',
    '167649:麦卡贡',
    '167893:纳沙塔尔',
    '167896:纳沙塔尔',
    '167902:纳沙塔尔',
    '167902:纳沙塔尔',
    '167903:纳沙塔尔',
    '167903:纳沙塔尔',
    '167904:纳沙塔尔',
    '167905:纳沙塔尔',
    '167906:纳沙塔尔',
    '167907:纳沙塔尔',
    '167908:纳沙塔尔',
    '167909:纳沙塔尔',
    '167910:纳沙塔尔',
    '167911:纳沙塔尔',
    '167912:纳沙塔尔',
    '167913:纳沙塔尔',
    '167914:纳沙塔尔',
    '167915:纳沙塔尔',
    '167916:纳沙塔尔',
    '167923:纳沙塔尔',
    '168045:麦卡贡',
    '168161:纳沙塔尔',
    '168213:麦卡贡',
    '168215:麦卡贡',
    '168216:麦卡贡',
    '168217:麦卡贡',
    '168233:麦卡贡',
    '168261:纳沙塔尔',
    '168262:麦卡贡',
    '168327:麦卡贡',
    '168832:麦卡贡',
    '168950:麦卡贡',
    '168951:麦卡贡',
    '168952:麦卡贡',
    '168961:麦卡贡',
    '169218:麦卡贡',
    '169332:纳沙塔尔',
    '169333:纳沙塔尔',
    '169334:纳沙塔尔',
    '169477:Benthic',
    '169478:Benthic',
    '169479:Benthic',
    '169480:Benthic',
    '169481:Benthic',
    '169482:Benthic',
    '169483:Benthic',
    '169484:Benthic',
    '169485:Benthic',
    '169610:麦卡贡',
    '169674:麦卡贡',
    '169675:麦卡贡',
    '169780:纳沙塔尔',
    '169781:纳沙塔尔',
    '169782:纳沙塔尔',
    '169783:纳沙塔尔',
    '169868:麦卡贡',
    '169872:麦卡贡',
    '169873:麦卡贡',
    '169878:麦卡贡',
    '170100:纳沙塔尔',
    '170180:纳沙塔尔',
    '170186:纳沙塔尔',
    '170189:纳沙塔尔',
    '170191:纳沙塔尔',
    '170472:纳沙塔尔',
    '170512:纳沙塔尔',
    '170547:纳沙塔尔'
}
local Ggbug = false

local tooltip
local function create()
    local tip, leftTip = CreateFrame('GameTooltip'), {}
    for x = 1, 6 do
        local L, R = tip:CreateFontString(), tip:CreateFontString()
        L:SetFontObject(GameFontNormal)
        R:SetFontObject(GameFontNormal)
        tip:AddFontStrings(L, R)
        leftTip[x] = L
    end
    tip.leftTip = leftTip
    return tip
end

local setFilter = addon:RegisterFilter('ZoneItems', 47, 'ABEvent-1.0')
setFilter.uiName = L['Zone Specific Items']
setFilter.uiDesc = L['Group zone specific items together.']

function setFilter:OnInitialize()
    self.db =
        addon.db:RegisterNamespace(
        'ZoneItems',
        {
            profile = {enable = true},
            char = {}
        }
    )
end

function setFilter:Update()
    self:SendMessage('AdiBags_FiltersChanged')
end
function setFilter:OnEnable()
    addon:UpdateFilters()
end
function setFilter:OnDisable()
    addon:UpdateFilters()
end

local setNames = {}

function setFilter:GetOptions()
    return {
        enableZoneItem = {
            name = L['Enable Zone Item groups'],
            desc = L['Check this if you want to automatically seperate Nazjatar and Mechagon items.'],
            type = 'toggle',
            order = 25
        },
        groupBenthic = {
            name = L['Group Benthic BoA gear'],
            desc = L['Check this if you want group Benthic Bind on Account not Soulbound, items.'],
            type = 'toggle',
            order = 26
        }
    }, addon:GetOptionHandler(
        self,
        false,
        function()
            return self:Update()
        end
    )
end

function setFilter:Filter(slotData)
    -- Exit if profile not enabled
    if (self.db.profile.enableZoneItem == false) or (slotData.itemId == false) then
        return
    end

    local item = Item:CreateFromBagAndSlot(slotData.bag, slotData.slot)
    --Check for slotData.itemId in the array
    local currCategory, currSubCategory, currID, currVal, delim
    for index, value in ipairs(arrZoneItems) do
        delim = string.find(value, ':')
        currID = tonumber(string.sub(value, 1, delim - 1))
        currVal = string.sub(value, delim + 1)
        if slotData.itemId == currID then
            if (self.db.profile.groupBenthic) and (currVal == 'Benthic') then
                currCategory = 'Zone Items'
                currSubCategory = 'Benthic'
                return kPfx .. currSubCategory .. kSfx, currCategory
            elseif currVal ~= 'Benthic' then
                currCategory = 'Zone Items'
                currSubCategory = currVal
                return kPfx .. currSubCategory .. kSfx, currCategory
            end
        end
    end
end
