local ADDON, ns = ...
local FakeItemLink = LibStub('AceAddon-3.0'):NewAddon(ADDON, 'AceConsole-3.0')
local temp
local defaults = {
    ['LinkLevel'] = '',
    ['uniqueID'] = '',
    ['BounsIDs'] = {
        {
            1522, -- [1]
            '等级变动' -- [2]
        } -- [5]
    },
    ['upgradeValues'] = {},
    ['gemIDs'] = {},
    ['enchantID'] = nil,
    ['sufficID'] = '',
    ['itemID'] = '',
    ['relics'] = {},
    ['instanceDifficultyID'] = '',
    ['upgradeTypeID'] = '',
    ['itemlink'] = '|Hitem:',
    ['specializationID'] = ''
}
local gemName = {
    ['暴击50'] = 168639,
    ['全能50'] = 168642,
    ['精通50'] = 168640,
    ['急速50'] = 168641,
    ['力量120'] = 168636,
    ['敏捷120'] = 168637,
    ['智力120'] = 168638
}
local enchantName = {
    ['机械师的智慧'] = 6112,
    ['迅捷远航'] = 5963,
    ['致命远航'] = 5965,
    ['全能远航'] = 5962,
    ['增幅冲击'] = 6148,
    ['赞达拉采矿'] = 5933
}
local source = {
    ['普通地下城'] = 4777,
    ['英雄地下城'] = 4778,
    ['史诗地下城'] = 4779,
    ['M2'] = 4780,
    ['随机团本'] = 4801,
    ['英雄团本'] = 4823,
    ['史诗团本'] = 4824,
    ['M15'] = 6536,
    ['M13'] = 6532,
    ['M14'] = 6534
}
local quality = {
    ['精良品质 战火'] = 4781,
    ['精良品质 泰坦造物'] = 4782,
    ['史诗品质 战火'] = 4783,
    ['史诗品质 泰坦造物'] = 4784,
    ['精良品质'] = 4785,
    ['史诗品质'] = 4786
}
local levelup = {}

local attribute = {
    ['棱彩插槽'] = 4802,
    ['闪避'] = 40,
    ['永不磨损'] = 43,
    ['吸血'] = 41,
    ['加速'] = 42
}

local Corruption = {
    ['闪避者1级'] = 6483,
    ['闪避者2级'] = 6484,
    ['闪避者3级'] = 6485,
    ['权宜之计1级'] = 6474,
    ['权宜之计2级'] = 6475,
    ['权宜之计3级'] = 6476,
    ['娴熟1级'] = 6471,
    ['娴熟2级'] = 6472,
    ['娴熟3级'] = 6473,
    ['暴戾1级'] = 6480,
    ['暴戾2级'] = 6481,
    ['暴戾3级'] = 6482,
    ['渠道全能1级'] = 6477,
    ['渠道全能2级'] = 6478,
    ['渠道全能3级'] = 6479,
    ['虹吸者1级'] = 6493,
    ['虹吸者2级'] = 6494,
    ['虹吸者3级'] = 6495,
    ['爆伤1级'] = 6437,
    ['爆伤2级'] = 6438,
    ['爆伤3级'] = 6439,
    ['急速脉搏1级'] = 6555,
    ['急速脉搏2级'] = 6559,
    ['急速脉搏3级'] = 6560,
    ['触发暴击1级'] = 6556,
    ['触发暴击2级'] = 6561,
    ['触发暴击3级'] = 6562,
    ['活力涌动1级'] = 6558,
    ['活力涌动2级'] = 6565,
    ['活力涌动3级'] = 6566,
    ['磨砺心灵1级'] = 6557,
    ['磨砺心灵2级'] = 6563,
    ['磨砺心灵3级'] = 6564,
    ['虚空回响1级'] = 6549,
    ['虚空回响2级'] = 6550,
    ['虚空回响3级'] = 6551,
    ['无尽之星1级'] = 6552,
    ['无尽之星2级'] = 6553,
    ['无尽之星3级'] = 6554,
    ['不可言喻的真相1级'] = 6547,
    ['不可言喻的真相2级'] = 6548,
    ['暮光毁灭1级'] = 6537,
    ['暮光毁灭2级'] = 6538,
    ['暮光毁灭3级'] = 6539,
    ['扭曲的附肢1级'] = 6543,
    ['扭曲的附肢2级'] = 6544,
    ['扭曲的附肢3级'] = 6545,
    ['虚空仪式1级'] = 6540,
    ['虚空仪式2级'] = 6541,
    ['虚空仪式3级'] = 6542,
    ['龟裂创伤'] = 6573,
    ['须臾洞察'] = 6546,
    ['灼热烈焰'] = 6571,
    ['黑曜石之肤'] = 6572,
    ['吞噬活力'] = 6567,
    ['低语真相'] = 6568,
    ['灵光一闪'] = 6570,
    ['虚空鞭笞'] = 6569
}

local function deep_clone(src)
    if type(src) ~= 'table' then
        return src
    end
    local copy_table
    local level = 0
    local function clone_table(t)
        level = level + 1
        if level > 20 then
            --for a,b in pairs(src) do print(a,b) end -- for debug
            error('table clone failed, source table is too deep!')
        end
        local k, v
        local rel = {}
        for k, v in pairs(t) do
            if type(v) == 'table' then
                rel[k] = clone_table(v)
            else
                rel[k] = v
            end
        end
        level = level - 1
        return rel
    end
    return clone_table(src)
end

function FakeItemLink:PrintItemLink()
    if Fake_Item_Link_DB.itemID == '' or Fake_Item_Link_DB.itemID == nil then
        print('物品ID为空')
        return
    end
    local itemlink = Fake_Item_Link_DB.itemlink .. Fake_Item_Link_DB.itemID .. ':'
    if Fake_Item_Link_DB.enchantID and #Fake_Item_Link_DB.enchantID == 2 then
        itemlink = itemlink .. Fake_Item_Link_DB.enchantID[1] .. ':'
    else
        itemlink = itemlink .. ':'
    end

    for i = 1, 4, 1 do
        if Fake_Item_Link_DB.gemIDs[i] ~= nil then
            itemlink = itemlink .. Fake_Item_Link_DB.gemIDs[i][1] .. ':'
        else
            itemlink = itemlink .. ':'
        end
    end
    itemlink =
        itemlink ..
        Fake_Item_Link_DB.sufficID ..
            ':' ..
                Fake_Item_Link_DB.uniqueID ..
                    ':' ..
                        Fake_Item_Link_DB.LinkLevel ..
                            ':' ..
                                Fake_Item_Link_DB.specializationID ..
                                    ':' ..
                                        Fake_Item_Link_DB.upgradeTypeID ..
                                            ':' .. Fake_Item_Link_DB.instanceDifficultyID .. ':'

    if #Fake_Item_Link_DB.BounsIDs ~= 0 then
        itemlink = itemlink .. #Fake_Item_Link_DB.BounsIDs .. ':'
        for i = 1, #Fake_Item_Link_DB.BounsIDs, 1 do
            itemlink = itemlink .. Fake_Item_Link_DB.BounsIDs[i][1] .. ':'
        end
    end
    itemlink = itemlink .. '|h[' .. select(1, GetItemInfo(Fake_Item_Link_DB.itemID)) .. ']|h'
    DEFAULT_CHAT_FRAME:AddMessage(
        format(LOOT_ITEM_PUSHED_SELF, ITEM_QUALITY_COLORS[C_Item.GetItemQualityByID(itemlink)].hex .. itemlink .. '|r'),
        ChatTypeInfo['LOOT'].r,
        ChatTypeInfo['LOOT'].g,
        ChatTypeInfo['LOOT'].b
    )
    --ChatFrame1:AddMessage(itemlink .. linkend)
end

local function get_function(info)
    return Fake_Item_Link_DB[info[#info]]
end

local function set_function(info, val)
    Fake_Item_Link_DB[info[#info]] = val
end

function FakeItemLink:ShowConfig()
    LibStub('AceConfigDialog-3.0'):SetDefaultSize(ADDON, 550, 450)
    LibStub('AceConfigDialog-3.0'):Open(ADDON)
end

function FakeItemLink:OnInitialize()
    Fake_Item_Link_DB = Fake_Item_Link_DB or deep_clone(defaults)

    local options_table = {
        order = 1,
        name = '伪造物品',
        type = 'group',
        args = {
            itemID = {
                order = 1,
                name = '物品ID',
                type = 'input',
                get = function()
                    return tostring(Fake_Item_Link_DB.itemID)
                end,
                set = function(info, val)
                    Fake_Item_Link_DB[info[#info]] = tonumber(val) or tonumber(val:match('|Hitem:(%d+)'))
                end,
                width = 1.5
            },
            LinkLevel = {
                order = 2,
                name = '物品可装备等级(主要影响传家宝)',
                type = 'input',
                get = get_function,
                set = set_function,
                width = 1.5
            },
            enchantID = {
                order = 3,
                name = '添加附魔ID',
                type = 'input',
                get = function()
                    if Fake_Item_Link_DB.enchantID == nil then
                        return '无'
                    else
                        return Fake_Item_Link_DB.enchantID[2]
                    end
                end,
                set = function(info, val)
                    val = tonumber(val)
                    temp = val
                    for i in pairs(enchantName) do
                        if val == enchantName[i] then
                            temp = i
                            break
                        end
                    end
                    Fake_Item_Link_DB.enchantID = {val, temp}
                end,
                width = 1.5
            },
            selsetenchantID = {
                order = 4,
                name = '选择附魔',
                type = 'select',
                values = function()
                    local a = {}
                    for i in pairs(enchantName) do
                        a[i] = i
                    end
                    return a
                end,
                get = function()
                    return
                end,
                set = function(info, val)
                    Fake_Item_Link_DB.enchantID = {enchantName[val], val}
                end,
                width = 1.5
            },
            gemIDs = {
                order = 5,
                name = '添加宝石ID',
                type = 'input',
                get = function()
                    return
                end,
                set = function(info, val)
                    val = tonumber(val)
                    temp = val
                    for i in pairs(gemName) do
                        if val == gemName[i] then
                            temp = i
                            break
                        end
                    end
                    table.insert(Fake_Item_Link_DB.gemIDs, val)
                end
            },
            selectgemIDs = {
                order = 6,
                name = '选择宝石',
                type = 'select',
                values = function()
                    local a = {}
                    for i in pairs(gemName) do
                        a[i] = i
                    end
                    return a
                end,
                get = function()
                    return
                end,
                set = function(info, val)
                    if #Fake_Item_Link_DB.gemIDs < 4 then
                        table.insert(Fake_Item_Link_DB.gemIDs, {gemName[val], val})
                    end
                end
            },
            remomegemIDs = {
                order = 7,
                name = '移除宝石',
                type = 'select',
                values = function()
                    local a = {}
                    if #Fake_Item_Link_DB.gemIDs == 0 then
                        return {'无'}
                    else
                        for i in pairs(Fake_Item_Link_DB.gemIDs) do
                            table.insert(a, Fake_Item_Link_DB.gemIDs[i][2])
                        end
                    end
                    return a
                end,
                get = function()
                    return
                end,
                set = function(info, val)
                    table.remove(Fake_Item_Link_DB.gemIDs, val)
                end
            },
            BounsIDs = {
                order = 8,
                name = '手动输入额外信息ID',
                type = 'input',
                get = function()
                    return
                end,
                set = function(info, val)
                    val = tonumber(val)
                    temp = val
                    for i in pairs(Corruption) do
                        if val == Corruption[i] then
                            temp = i
                            break
                        end
                    end
                    for i in pairs(levelup) do
                        if val == levelup[i] then
                            temp = i
                            break
                        end
                    end
                    for i in pairs(source) do
                        if val == source[i] then
                            temp = i
                            break
                        end
                    end
                    for i in pairs(quality) do
                        if val == quality[i] then
                            temp = i
                            break
                        end
                    end
                    for i in pairs(attribute) do
                        if val == attribute[i] then
                            temp = i
                            break
                        end
                    end
                    table.insert(Fake_Item_Link_DB.BounsIDs, {val, temp})
                end
            },
            selectsource = {
                order = 9,
                name = '选择来源',
                type = 'select',
                values = function()
                    local a = {}
                    for i in pairs(source) do
                        a[i] = i
                    end
                    return a
                end,
                get = function()
                    return
                end,
                set = function(info, val)
                    table.insert(Fake_Item_Link_DB.BounsIDs, {source[val], val})
                end
            },
            selectquality = {
                order = 10,
                name = '选择品质',
                type = 'select',
                values = function()
                    local a = {}
                    for i in pairs(quality) do
                        a[i] = i
                    end
                    return a
                end,
                get = function()
                    return
                end,
                set = function(info, val)
                    table.insert(Fake_Item_Link_DB.BounsIDs, {quality[val], val})
                end
            },
            selectattribute = {
                order = 11,
                name = '选择额外绿字',
                type = 'select',
                values = function()
                    local a = {}
                    for i in pairs(attribute) do
                        a[i] = i
                    end
                    return a
                end,
                get = function()
                    return
                end,
                set = function(info, val)
                    table.insert(Fake_Item_Link_DB.BounsIDs, {attribute[val], val})
                end
            },
            selectlevelup = {
                order = 12,
                name = '选择升级进度',
                type = 'select',
                values = function()
                    local a = {}
                    for i in pairs(levelup) do
                        a[i] = i
                    end
                    return a
                end,
                get = function()
                    return
                end,
                set = function(info, val)
                    table.insert(Fake_Item_Link_DB.BounsIDs, {levelup[val], val})
                end
            },
            removeBounsIDs = {
                order = 13,
                name = '移除额外信息',
                type = 'select',
                values = function()
                    local a = {}
                    if #Fake_Item_Link_DB.BounsIDs == 0 then
                        return {'无'}
                    else
                        for i in pairs(Fake_Item_Link_DB.BounsIDs) do
                            table.insert(a, Fake_Item_Link_DB.BounsIDs[i][2])
                        end
                    end
                    return a
                end,
                get = function()
                    return
                end,
                set = function(info, val)
                    table.remove(Fake_Item_Link_DB.BounsIDs, val)
                end
            },
            selectCorruption = {
                order = 14,
                name = '选择腐蚀',
                type = 'select',
                values = function()
                    local a = {}
                    for i in pairs(Corruption) do
                        a[i] = i
                    end
                    return a
                end,
                get = function()
                    return
                end,
                set = function(info, val)
                    table.insert(Fake_Item_Link_DB.BounsIDs, {Corruption[val], val})
                end,
                width = 1.5
            },
            level = {
                name = '等级变动',
                order = 15,
                type = 'range',
                min = -300,
                max = 300,
                step = 5,
                get = function()
                    for i in pairs(Fake_Item_Link_DB.BounsIDs) do
                        if Fake_Item_Link_DB.BounsIDs[i][2] == '等级变动' then
                            return tonumber(Fake_Item_Link_DB.BounsIDs[i][1]) - 1522
                        end
                    end
                    return 0
                end,
                set = function(info, val)
                    for i in pairs(Fake_Item_Link_DB.BounsIDs) do
                        if Fake_Item_Link_DB.BounsIDs[i][2] == '等级变动' then
                            table.remove(Fake_Item_Link_DB.BounsIDs, i)
                        end
                    end
                    table.insert(Fake_Item_Link_DB.BounsIDs, {val + 1522, '等级变动'})
                end,
                width = 1.5
            },
            printLK = {
                order = 16,
                name = '打印',
                desc = '打印物品链接到聊天栏',
                type = 'execute',
                func = function()
                    FakeItemLink:PrintItemLink()
                end,
                width = 1.5
            },
            reset = {
                order = 17,
                name = '还原',
                desc = '还原目前所有设置项',
                type = 'execute',
                func = function()
                    Fake_Item_Link_DB = deep_clone(defaults)
                end,
                width = 1.5
            }
        }
    }
    LibStub('AceConfigRegistry-3.0'):RegisterOptionsTable(ADDON, options_table)
    self:RegisterChatCommand('fil', 'ShowConfig')
    self:RegisterChatCommand('fakeitemlink', 'ShowConfig')
end
