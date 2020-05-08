local floor,ceil,format,tostring=floor,ceil,format,tostring
local pairs,ipairs,next,wipe,assert,type,tinsert,select,tremove,GetTime = pairs,ipairs,next,wipe,assert,type,tinsert,select,tremove,GetTime
local n2s,safecall,u1copy,tinsertdata,tremovedata = n2s,safecall,u1copy,tinsertdata,tremovedata
local U2, _, U1 = 163, ...
local L = U1.L;
U1.PINYIN = U1.PINYIN or {}

local addonInfo = {} --- 所有插件的信息
local tagInfo = {} --所有标签信息, 包括text和num, 点击时间在别的位置
local currAddons = {} --中央图标的names
local currTags = {} --左侧的标签
local additionalFilter -- 额外过滤器 [string] (enabled|disabled)
local reloadList = {} --需要reload的情况
local initComplete 	--- 是否已经延迟加载完所有插件
local currList = strrep(strchar(U2%65),U2%0x10); --插件名保护
local AceDBs = {}
local loadedNormalAddons = {}
--U1.variableLoaded     --- if VARIABLES_LOADED event is fired.
--U1.playerLogin        --- if PLAYER_LOGIN event is fired

CoreAddEvent("CURRENT_ADDONS_UPDATED")
CoreAddEvent("CURRENT_TAGS_UPDATED")
CoreAddEvent("ADDON_SELECTED")
CoreAddEvent("DB_LOADED")
CoreAddEvent("INIT_COMPLETED")

local addonToLoadSecure, addonToLoad = {}, {}





local defaultDB = {
    --checkVendor = 1, --无爱不易标记的插件但是在整合包列表中，是否算爱不易的。现在用 UI163_USER_MODE
    selectedTag = UI163_USER_MODE and "ALL" or "ABYUI",
    showOrigin = nil, --插件原名
    disableLaterLoading = false,
    --框体位置
    frames = {
        ["RaidAlerter_Attack_Frame"] = {
            nil, nil, nil, nil, nil,
            "TOP",
            "UIParent",
            "TOP",
            0,
            -45,
        },
    },
    --minimapPos = 217, --in U1_CreateMinimapButton
    --tags = {}, --保存每个tag的点击时间和次数
    addons = {}, --保存每个插件的状态
    configs = {}, --各个配置项
}
local db;
--U1DB = nil local db = defaultDB;

local pcall = safecall; --pcall;

_G["U1"] = U1
U1.addonInfo = addonInfo
U1.tagInfo = tagInfo
U1.currTags = currTags;
U1.currAddons = currAddons;
gai = function(...) return U1GetAddonInfo(...) end

--[[------------------------------------------------------------
局部函数
---------------------------------------------------------------]]
--多重依赖的情况，适应其他整合插件
local knownAddonPacks = { "elvui", "duowan", "bigfoot", "mogu", "ace2", "ace3", "fish!!!" }
local function getInitialAddonInfo()
    local x = strchar(33) x={x,x,x,163,"ui",x,x,x} x=table.concat(x); GetNumAddons = strlower(_)==x  --插件名称保护
    for i = 1, GetNumAddOns() do
        local name, title, notes, _, reason = GetAddOnInfo(i)
        title = title:gsub("%|cff880303%[爱不易%]%|r ", ""):gsub("%|cff880303%[爱不易%]%|r ", "")

        local realDeps = { GetAddOnDependencies(i) }
        local realOptDeps = { GetAddOnOptionalDependencies(i) }
        for k = 1, #realDeps do realDeps[k] = realDeps[k]:lower() end
        for k = 1, #realOptDeps do realOptDeps[k] = realOptDeps[k]:lower() end

        --- copy a deps is mainly to calc parent, and the table is used later as info.optdeps
        --- there is no deps in raw_infos
        local deps = u1copy(realDeps)
        for _, known in ipairs(knownAddonPacks) do
            tremovedata(deps, known:lower())
        end
        -- GarrisonMissionManager depends on Blizzard, will got an uninstalled parent
        for j=#deps, 1, -1 do
            if (deps[j]:find("^blizzard_") and select(6, GetAddOnInfo(deps[j]))=="SECURE") then
                tremove(deps, j);
            end
        end

        addonInfo[name:lower()] = {
            name = name,
            title = title or name,
            author = GetAddOnMetadata(i, "Author"),
            modifier = GetAddOnMetadata(i, "X-Modifier"),
            parent = deps[1] and deps[1]:lower(),
            realDeps = realDeps,
            realOptDeps = realOptDeps,
            desc = notes,

            installed = i, --如果installed==nil表示插件未安装，只是注册的.
            realLOD = IsAddOnLoadOnDemand(i),
            lod = IsAddOnLoadOnDemand(i),
            vendor = GetAddOnMetadata(i, "X-Vendor") == "AbyUI",
            version = GetAddOnMetadata(i, "Version"),
            xcategories = UI163_USE_X_CATEGORIES and GetAddOnMetadata(i, "X-Category"),

            -- 6.0 开始 GetAddOnInfo() 第四个返回值含义不明, 需要使用新增的 GetAddOnEnableState() 函数
            -- (nil, <部分开启>)=1 (nil, <全部开启>)=2 (player, "开启的")=2  ("任意字符串", "开启的")=2或0
            originEnabled = GetAddOnEnableState(U1PlayerName,i)>=2,
        }

        --- transform multiple dependencies (which can't show in control panel) to optional dependencies
        if (#deps > 1) then
            if DEBUG_MODE then print("MultiDependencies: " .. name .. " depends on " .. table.concat(deps, ",")) end
            table.remove(deps, 1)
            addonInfo[name:lower()].optdeps = deps
        end

        --DisableAddOn(name); --关闭插件, 在VARIABLE_LOADED事件时再打开 --改为在 ConfigsLoaded 里面调用
    end

    -- clean up realDeps and realOptDeps to save memory
    for k, v in pairs(addonInfo) do
        for i = #v.realDeps,    1, -1 do if not addonInfo[v.realDeps[i]]    then tremove(v.realDeps, i)    end end
        for i = #v.realOptDeps, 1, -1 do if not addonInfo[v.realOptDeps[i]] then tremove(v.realOptDeps, i) end end
        if #v.realDeps == 0    then v.realDeps = nil    end
        if #v.realOptDeps == 0 then v.realOptDeps = nil end
        if v.realOptDeps then
            v.optdeps = v.optdeps or {}
            for _, dep in ipairs(v.realOptDeps) do tinsert(v.optdeps, dep) end
        end
    end

    for _, v in ipairs(U1.removedAddOns or _empty_table) do
        local info = addonInfo[v:lower()]
        if info and info.vendor then
            -- DisableAddOn(v);
            -- info.originEnabled = nil;
        end
    end
end

function U1IsInitComplete()
    return initComplete and IsLoggedIn();
end

function U1EncodeNIL(value)
    return (value==nil) and "_NIL" or value
end
function U1DecodeNIL(value)
    if value == "_NIL" then return nil end
    return value;
end

function U1LoadDBDefault(cfg)
    if cfg.default then
        if type(cfg.default) == "function" then
            return true, cfg.default()
        else
            return true, cfg.default
        end
    else
        return false, nil
    end
end

function U1LoadDBValue(cfg)
    local v = db.configs[cfg._path]
    if(v == nil) then
        local has, default = U1LoadDBDefault(cfg)
        if has then
            if type(default) == "table" then
                v = u1copy(default)
            else
                v = default
            end
        end
    end
    return U1DecodeNIL(v)
end

--3处调用此函数 登出时的deepSave(getvalue), Control里的OnShow(getvalue) 和 RegularSave
--默认值default不会被保存，但是有getvalue的则每次登出和show都会重置
function U1SaveDBValue(cfg, value)
    if U1.PROFILE_CHANGED then return end
    local old = U1EncodeNIL(U1LoadDBValue(cfg))
    -- 配合 U1CfgMakeCVarOption 的，强制保存设置，不清理
    if cfg.dontCompareDefaultWhenSave then
        U1DB.configs[cfg._path] = U1EncodeNIL(value);
        return old
    end
    local has_default, default = U1LoadDBDefault(cfg)
    if type(value) == "table" then
        if has_default and type(default) == "table" and tcovers(value, default) and tcovers(default, value) then
            U1DB.configs[cfg._path] = nil
        else
            U1DB.configs[cfg._path] = value
        end
    elseif has_default and value == default then
        U1DB.configs[cfg._path] = nil
    else
        U1DB.configs[cfg._path] = U1EncodeNIL(value);
    end
    return old
end
--调用一个配置项
function U1CfgCallBack(cfg, forceValue, loading)
    local value = forceValue;
    if value == nil then value = U1LoadDBValue(cfg); end
    if cfg.visible ~= false and cfg.callback then
        pcall(cfg.callback, cfg, value, loading);
    end
end

--- change a cfg to value and call sub
function U1ChangeCfg(path, value)
    local _, cfg = U1GetCfgValue(path)
    if(cfg)then
        U1SaveDBValue(cfg, value)
        U1CfgCallBack(cfg)
    end
end

--调用一个子配置项, 如果v是假则强制使用false，如果是true则使用nil，表示使用子配置项的配置值。因为父子有关联，父关了子一定关，但父开了子不一定开
function U1CfgCallSub(cfg, sub, parentEnabled)
    U1CfgCallBack(U1CfgFindChild(cfg, sub), not not parentEnabled and nil);
end

function U1CfgFindChild(cfg, var)
    local children = cfg;
    if type(cfg) == "string" then --AddonPage top config
        children = U1GetPage(cfg);
    end
    if children then
        for _, sub in ipairs(children) do
            if(sub.var==var or sub.id==var) then return sub end
        end
        --支持查找分类下的内容.
        for _, sub in ipairs(children) do
            if sub.type == "text" then
                local textsub = U1CfgFindChild(sub, var)
                if textsub then return textsub end
            end
        end
    end
end

local function U1GetCfgValueDeep(cfg, first, ...)
    cfg = U1CfgFindChild(cfg, first)
    if cfg then
        if select('#', ...) == 0 then
            return cfg
        else
            return U1GetCfgValueDeep(cfg, ...)
        end
    end
end
--如果只提供一个参数，则表示完整path，适用于cfg._path
function U1GetCfgValue(addon, path, safe)
    if not path then
        local pos = addon:find("/")
        path = addon:sub(pos+1)
        addon = addon:sub(1, pos-1)
    end
    local cfg = U1GetCfgValueDeep(addon:lower(), strsplit("/", path));
    if safe and not cfg then return end
    assert(cfg, format("Error, can't find config [%s] of addon [%s].", path, addon));
    return U1LoadDBValue(cfg), cfg;
end



-- 生成tagInfo，并计数加1
function U1RegisterTag(v)
    local tag = tagInfo[v];
    if not tag then
        local tagDef = U1.TAGS[v];
        --if(type(tagDef)=="table" and tagDef.hide) then return end; --隐藏的不注册
        tag = {
            num = 0,
            text = type(tagDef)=="table" and tagDef.text or L["TAG_" .. v] or v,
            order = type(tagDef)=="table" and tagDef.order or nil,
        }
        tagInfo[v] = tag;
    end
    tag.num = tag.num + 1;
end


------------------------------------------------------------
-- 标签相关API
------------------------------------------------------------
--- 重新计算标签, 启动或者修改checkVendor设置后调用.
--@param onlyAffectLoaded 只有当前标签是LOADED的时候才更新
--@param addonName 只有当前插件是addonName的时候才更新
function U1UpdateTags(onlyAffectLoaded, addonName)
    --对于没有filter的标签来说, 数量肯定是固定的, 所以不需要计算
    --处理ALL,ABYUI,SINGLE三个含有filter的标签
    --hide的不加入tagInfo
    for k, v in pairs(U1.TAGS) do
        if (type(v)=="table" and v.filter) then
            --计数清0
            if not tagInfo[k] then U1RegisterTag(k) end
            tagInfo[k].num = 0;
            tagInfo[k].caption = nil;  --caption是字符串缓存
            for name, info in pairs(addonInfo) do
                if (info.parent == nil and not info.hide) then
                    --子插件我们不关心
                    info.tags = info.tags or {};
                    info.tags[k] = v.filter(name, info);
                    if(info.tags[k])then
                        U1RegisterTag(k);
                    end
                end
            end
        end
    end

    wipe(currTags);
    for k, v in pairs(tagInfo) do
        local tagDef = U1.TAGS[k]
        local hide = type(tagDef)=='table' and tagDef.hide
        if v.num > 0 and not hide then
            tinsert(currTags, k);
        end
    end

    if(not onlyAffectLoaded) then -- or db.selectedTag == "LOADED") then
        U1SelectTag(db.selectedTag, 1);
    else
        U1SortTag()
        CoreFireEvent("CURRENT_ADDONS_UPDATED") --更新数量，按钮等信息
    end
	
    --这里屏蔽右侧的更新，但是如果是其他插件加载了插件，右侧不会更新
    if(not addonName or addonName==db.selectedAddon) then
        if(db.selectedAddon)then U1SelectAddon(db.selectedAddon) end;
    end
end

function U1AddonHasTag(name, tag)
    --对于filter的, 在UpdateTags时已经设置好了.
    name = name:lower();
    local info = addonInfo[name]
    return info.tags and info.tags[tag];
end

function U1GetNumTags()
    return #currTags;
end

local tagComparator = function(v1, v2)
    local o1 = tagInfo[v1].order or math.huge;
    local o2 = tagInfo[v2].order or math.huge;
    if o1 < 0 and o2 > 0 then
        return false
    elseif o1 > 0 and o2 < 0 then
        return true
    elseif (o1 == o2) then
            return v1 < v2
    else
        return o1 < o2;
    end
end

function U1SortTag()
    table.sort(currTags, tagComparator);
    CoreFireEvent("CURRENT_TAGS_UPDATED");
end


function U1SelectTag(tag, keepSelectedAddon)
    db.selectedTag = tag;
    U1SelectAddon(keepSelectedAddon and db.selectedAddon or nil);
    U1UpdateTags("LOADED", keepSelectedAddon and db.selectedAddon or nil);
    U1UpdateCurrentAddOns();
    U1SortTag();
end

function U1GetSelectedTag()
    return db.selectedTag;
end

function U1GetTagInfoByName(name)
    local info = tagInfo[name];
    if not info then
        name = UI163_USER_MODE and "ALL" or "ABYUI"
        info = tagInfo[name]
    end
    info.caption = info.caption or info.text .. ((name=="LOADED" or name=="NLOADED") and "(" .. info.num .. ")" or "");
    local desc = L["TAG_DESC_" .. name] or ""
    return name, info.num, info.caption, info.order and true, desc;
end

-- @return name, num, caption, special;
function U1GetTagInfo(index)
    local name = currTags[index];
    return U1GetTagInfoByName(name)
end

function U1SetAdditionalFilter(tag)
    additionalFilter = tag
    U1UpdateCurrentAddOns()
end

function U1GetAdditionalFilter()
    return additionalFilter
end

--[[------------------------------------------------------------
插件相关API
---------------------------------------------------------------]]
local order = 1;
U1.parentTags = {}; --只记录tags，供子使用
function U1RegisterAddon(name, infoReg)
    local infoRaw = addonInfo[name:lower()];
    if not infoRaw and not infoReg.dummy then U1.parentTags[name:lower()] = infoReg.tags return end --未安装的插件，没必要保留空目录，可以节省内存
    if infoReg.dummy then
        --dummy的如果没有任何子插件就隐藏
        local hasOne;
        for _, v in ipairs(infoReg.children) do if U1IsAddonInstalled(v) then hasOne = true break; end end
        if not hasOne then return end
    end
    --2015.2.7暂时不要求 vendor
    --if infoRaw and not infoRaw.vendor and (not UI163_USER_MODE and not infoReg.alwaysRegister and not infoReg.parent) then return end

    --if not info and not reg.dummy then return end --如果没装插件则不显示
    infoReg.name = name; --保持原名
    infoReg.order = order;
    order = order + 1;
    if infoReg.registered ~= false then infoReg.registered = true end --标记为注册的插件, 自动注册时可以传一个registered=false过来
    infoReg.ldbIcon = infoReg.ldbIcon == 1 and infoReg.icon or infoReg.ldbIcon;
    if(infoReg.minimap)then CoreCall("U1_MMBAddDefaultCollect", infoReg.minimap) end --添加小地图按钮至白名单.
    name = name:lower();

    addonInfo[name] = infoReg;
    if (infoRaw) then
        --设置非LOD的默认的加载方式为LATER
        if(not infoRaw.realLOD and infoReg.load == nil) then
            --尝试设置为父插件的load方式, 2015.9.14 因为SkadaFriendlyFire加上，但有奇怪的问题，又去掉
            --local parentInfo = (infoRaw.parent or infoReg.parent) and U1GetAddonInfo(infoRaw.parent or infoReg.parent);
            --if parentInfo then infoReg.load = parentInfo.load end
            --如果是我们整合的插件则默认是LATER，否则默认是NORMAL
            infoReg.load = infoReg.load or (UI163_USER_MODE and not infoRaw.vendor and "NORMAL" or "LATER") --设置非LOD的默认的加载方式为LATER
        end
       
        infoRaw.lod = (infoRaw.realLOD and infoReg.load==nil) or (infoReg.load=="DEMAND"); --reg.load可以覆盖LoadOnDemand，因为大脚魔盒之类的一些插件都加了标签
        --复制系统获取的addonInfo数据到注册的table中,因为注册的table大
        for k, v in pairs(infoRaw) do
            --if (reg[k] and reg[k] ~= v and k ~= "title" and k ~= "author" and k ~= "modifier" and k ~= "load" and k~="desc") then
            --    debug("Conflict " .. name .. "." .. k .. "='" .. v .. "' conflict with '" .. reg[k] .. "'")
            --end
            if k=="optdeps" then
                --合并两个optdeps
                if infoReg.optdeps then
                    for _, opt in ipairs(infoReg.optdeps) do
                        if addonInfo[opt:lower()] then
                            tinsertdata(v, opt:lower())
                        end
                    end
                end
                infoReg[k] = v
            else
                infoReg[k] = infoReg[k] or v --((k=="title" or k=="parent" or k=="author" or k=="modifier" or k=="load" or k=="desc") and
            end
        end

        wipe(infoRaw)
    end

    if infoReg.deps then
        for i=1, #infoReg.deps do infoReg.deps[i] = infoReg.deps[i]:lower() end
    end

    --如果有子模块模式，则判断所有未注册的插件哪个是其子模块
    --注册的插件自带parent属性,所以不需要处理
    if (infoReg.children) then
        for k, v in pairs(addonInfo) do
            if ( k~= name and (not v.registered or not v.parent)) then
                for _, pattern in ipairs(infoReg.children) do
                    if (strfind(strlower(k), strlower(pattern))) then
                        v.parent = name;
                        break;
                    end
                end
            end
        end
    end

    infoReg.parent = infoReg.parent and infoReg.parent~="" and infoReg.parent~=0 and infoReg.parent:lower() or nil
end if strupper(...) ~= currList..tostring(0xA3).."\85\73"..currList then return end --插件名称保护

function U1ChangeTags(name, tags, add)
    local info = U1GetAddonInfo(name)
    if info and (UI163_USER_MODE or info.registered) then
        if not add then
            for _, v in ipairs(info.tags or _empty_table) do
                if v == "CLASS" then info._classAddon = nil end
                info.tags[v] = nil;
                tagInfo[v].num = tagInfo[v].num - 1;
            end
            info.tags = {};
        end
        for _, v in ipairs(tags) do
            if v == "CLASS" then info._classAddon = true end
            info.tags[v] = true;
            U1RegisterTag(v)
        end
    end
end

--必须用ipairs
function U1GetPage(name)
    local info = U1GetAddonInfo(name);
    if info and #info > 0 then return info end
end

function U1GetAddonInfo(name)
    name = name:lower();
    return addonInfo[name]
end

function U1IterateAllAddons()
    return pairs(addonInfo);
end

function U1IsAddonInstalled(name)
    name = name:lower();
    local info = addonInfo[name]
    return info and info.installed and true
end

--返回是否注册及是否是163的toc
function U1IsAddonRegistered(name)
    name = name:lower();
    local info = addonInfo[name]
    return info and info.registered, info and (info.vendor or info.dummy)
end

function U1GetAddonModsAndMemory(addonName)
    local subNum, subLoaded, mem, subMem = 0, 0, 0, 0
    local info = U1GetAddonInfo(addonName);
    if (info.dummy and U1IsAddonEnabled(addonName)) or IsAddOnLoaded(addonName) then
        mem = GetAddOnMemoryUsage(addonName);
        for subName, subInfo in U1IterateAllAddons() do
            if subInfo.parent == addonName then --and not subInfo.hide then
                subNum = subNum + 1;
                --这里可以用IsAddOnLoaded或者U1IsAddonEnabled，还能分别用不同的条件
                if (U1IsAddonEnabled(subName))then
                    subLoaded = subLoaded + 1;
                    subMem = subMem + GetAddOnMemoryUsage(subName);
                end
            end
        end
    end
    return subNum, subLoaded, mem+subMem
end

local comparatorAddonMemory = function(v1, v2)
    local _, _, mem1 = U1GetAddonModsAndMemory(v1);
    local _, _, mem2 = U1GetAddonModsAndMemory(v2);
    if(mem2==mem1)then
        return v1<v2;
    else
        return mem2<mem1;
    end
end

local comparatorAddonTitle = function(v1, v2)
    local t1 = U1GetAddonTitle(v1);
    t1 = U1.PINYIN[t1] and U1.PINYIN[t1][1] or t1;
    local t2 = U1GetAddonTitle(v2);
    t2 = U1.PINYIN[t2] and U1.PINYIN[t2][1] or t2;
    return t1 < t2;
end

function U1SortAddons()
    if U1DB.sortByName then
        table.sort(currAddons, comparatorAddonTitle);
    else
        table.sort(currAddons, comparatorAddonMemory)
    end
    CoreFireEvent("CURRENT_ADDONS_UPDATED")
end

function U1UpdateCurrentAddOns(searching)
    wipe(currAddons);
    local selectedTag = db.selectedTag
    local addFilter = additionalFilter and U1.TAGS[additionalFilter] and U1.TAGS[additionalFilter].filter

    for k, v in pairs(addonInfo) do
        if(not v.filtered and v.parent==nil and not v.hide)
                and (searching or (U1AddonHasTag(k, selectedTag) and (not addFilter or addFilter(k)))) then
            tinsert(currAddons, k);
        end
    end

    U1SortAddons()
end

function U1GetNumCurrentAddOns()
    return #currAddons;
end

---返回name, info，name是原始插件
function U1GetCurrentAddOnInfo(i)
    local name = currAddons[i]
    return name, addonInfo[name];
end

function U1SelectAddon(name, noevent)
    name = name and name:lower()
    if(name and not U1GetAddonInfo(name)) then name = nil end
    db.selectedAddon = name;
    if not noevent then CoreFireEvent("ADDON_SELECTED", name); end
end

function U1GetSelectedAddon()
    return db.selectedAddon;
end

local function deepSearch(cfg, pattern)
    --todo:其他类型的search，主要就是选项, 按钮文本等
    if cfg.text then
        if(cfg.text and cfg.text:find(pattern)) then return 1 end
    end
    if #cfg > 0 then
        for _, v in ipairs(cfg) do
            if deepSearch(v, pattern) then return 1 end
        end
    end
end


local function searchAddonDesc(addonName, addonInfo, pattern)
    if addonInfo.desc then
        if type(addonInfo.desc)=="table" then
            for _, s in ipairs(addonInfo.desc) do
                if s:find(pattern) then return true end
            end
        else
            if addonInfo.desc:find(pattern) then return true end
        end
    end
    do return end --- no need search subs desc
    for subName, subInfo in U1IterateAllAddons() do
        if subInfo.parent == addonName then
            if searchAddonDesc(subName, subInfo, pattern) then
                return true
            end
        end
    end
end


local outputOnce = {} --在全部插件加载完后才设置上值, 用来控制初始的显示
function U1OutputAddonState(text, addon, force)
    if force or (DEBUG_MODE or initComplete and not outputOnce[addon]) then
        if not U1GetAddonInfo(addon).hide and (not U1GetAddonInfo(addon).parent or U1GetAddonInfo(U1GetAddonInfo(addon).parent).dummy) then
            U1Message(format(text, format(L["插件-|cffffd100%s|r-"], U1GetAddonTitle(addon))));
        end
        outputOnce[addon] = 1;
    end
end
function U1OutputAddonLoaded(name, loaded, reason)
    if(loaded)then
        U1OutputAddonState(L["%s加载成功"], name);
    else
        U1OutputAddonState(L["%s加载失败, 原因："]..(reason and _G["U1REASON_"..reason] or reason or L["未知"]), name);
    end
end

function U1GetReloadList()
    return reloadList;
end

---添加需要重载提示的, 当isCfg的时候，必然是oldValue~=newValue（有变动）, 其中old和new都是encode了的
function U1ChangeReloadList(name, isCfg, oldValue, newValue)
    if not isCfg then
        reloadList[name.."/__disable"] = oldValue
    else
        if(reloadList[name]) then
            if(type(newValue)~="table" and reloadList[name]==newValue) then
                reloadList[name] = nil --值恢复了，不需要提示了
            else
                --修改了但是还是和原来不一样，则不需要处理
            end
        else
            reloadList[name] = oldValue
        end
    end
end

function U1IsAddonEnabled(name)
    name = name:lower()
    local info = U1GetAddonInfo(name);
    if not info then return nil end
    local state = db and db.addons[name];
    if(not state) then return info.originEnabled end --不知为何, 似乎有时ENTERING_WORLD会早于VARIABLES_LOADED
    return state==1 and (info.installed or info.dummy or info.protected) --没有安装的插件是不会被设置上的
end

--*****************************************************************
-- 上排按钮操作
--*****************************************************************
function U1SetShowOrigin(enabled)
    db.showOrigin = enabled;
end

function U1GetShowOrigin()
    return db and db.showOrigin;
end

function U1GetAddonTitle(name)
    local info = U1GetAddonInfo(name);
    if info.dummy then return info.title end --dummy has no Folder
    local originName = info.name
    return U1GetShowOrigin() and originName or uncolor(info.title or originName) --or select(2, GetAddOnInfo(name)) --已经设置好了的.
end

--[[------------------------------------------------------------
后加载插件的功能, 模拟事件
---------------------------------------------------------------]]
--用来捕捉LoadAddOn之中调用的事件
local eventCaptured = {
    --ADDON_LOADED = {}, --不再需要，最初是ace3用。现在ADDON_LOADED不模拟，而是用U1:ADDON_LOADED来处理
    VARIABLES_LOADED = {},
    PLAYER_LOGIN = {},
    PLAYER_ENTERING_WORLD = {},
    SPELLS_CHANGED = {},
    --PLAYER_REGEN_DISABLED = {}, --去掉的原因：1.DISABLED的时候IsCombatLockdown()应该是nil，无法模拟这种情况 2.没有插件会用这个作为启动点
    PLAYER_REGEN_ENABLED = {},
    GROUP_ROSTER_UPDATE = {},
    PLAYER_ALIVE = {},
    PLAYER_DEAD = {},
    WORLD_MAP_UPDATE = {},
    QUEST_LOG_UPDATE = {},
    UPDATE_FACTION = {},
    LOADING_SCREEN_DISABLED = {},
}
U1.captureEvents = eventCaptured

--搜索Secure*.*的RegisterEvent得到的
local secureEvents = {
    GROUP_ROSTER_UPDATE = 1,
    UNIT_AURA = 1,
    UNIT_NAME_UPDATE = 1,
    UNIT_PET = 1,
}

local capturing; --在模拟事件中再注册其他事件的情况，似乎没啥用，大概能防止hook到其他插件
local bundleLoading; --在即时加载的时候标记是否在加载插件，用来让ace3暂时不响应ADDON_LOADED的标记
local bundleSimNames = {}; --记录哪些是我们加载的插件的，然后批量执行操作
function U1IsBundleLoading() return bundleLoading end

local captureHook = function(frame, event, special)
    if not capturing then return end
    if frame:GetName() == "AceEvent30Frame" then return end --AceEvent用自己的方式触发

    --主要是SecureGroupHeaders的问题，其他的则问题不大，比如TrinketMenu的安全按钮，只要事件处理函数不是写在暴雪代码里的就行
    --现在使用了IsProtected的第二个返回值，应该不需要secureEvents来判断了
    if secureEvents[event] and select(2, frame:IsProtected()) then return end

    if(eventCaptured[event])then
        --if(event=="ADDON_LOADED")then debug(capturing, frame:GetName(), event) end
        --不重复添加，防止死循环
        if not tContains(eventCaptured[event], frame) then
            tinsert(eventCaptured[event], frame);
        end
    end
end

--copied from CallbackHandler, --不支持多余的参数
local captureHookAceEvent = function(self, eventname, method, ... --[[actually just a single arg]])
    if(capturing and type(eventname)=="string" and eventCaptured[eventname]) then
        local RegisterName = "RegisterEvent"

        method = method or eventname

        if type(method) ~= "string" and type(method) ~= "function" then
            error("Usage: "..RegisterName.."(\"eventname\", \"methodname\"): 'methodname' - string or function expected.", 2)
        end

        local regfunc

        if type(method) == "string" then
            -- self["method"] calling style
            if type(self) ~= "table" then
                error("Usage: "..RegisterName.."(\"eventname\", \"methodname\"): self was not a table?", 2)
            elseif self==target then
                error("Usage: "..RegisterName.."(\"eventname\", \"methodname\"): do not use Library:"..RegisterName.."(), use your own 'self'", 2)
            elseif type(self[method]) ~= "function" then
                error("Usage: "..RegisterName.."(\"eventname\", \"methodname\"): 'methodname' - method '"..tostring(method).."' not found on self.", 2)
            end

            if select("#",...)>=1 then  -- this is not the same as testing for arg==nil!
                local arg=select(1,...)
                regfunc = function(...) if self[method] then self[method](self,arg,...) elseif DEBUG_MODE then print("ERROR", capturing, method) end end
            else
                regfunc = function(...) if self[method] then self[method](self,...) elseif DEBUG_MODE then print("ERROR", capturing, method) end end
            end
        else
            -- function ref with self=object or self="addonId" or self=thread
            if type(self)~="table" and type(self)~="string" and type(self)~="thread" then
                error("Usage: "..RegisterName.."(self or \"addonId\", eventname, method): 'self or addonId': table or string or thread expected.", 2)
            end

            if select("#",...)>=1 then  -- this is not the same as testing for arg==nil!
                local arg=select(1,...)
                regfunc = function(...) method(arg,...) end
            else
                regfunc = method
            end
        end

        --print("captured", self, eventname, regfunc);
        --替代原有的，不会造成死循环
        for i, v in ipairs(eventCaptured[eventname]) do
            if v[1] and v[1]==self then v[2]=regfunc return end
        end
        tinsert(eventCaptured[eventname], {self, regfunc})
    end
end

--[[
local SupportedTypes = {"Frame", "Button", "CheckButton", "ColorSelect", "Cooldown", "GameTooltip", "ScrollFrame", "SimpleHTML", "Slider", "StatusBar", "EditBox", "MessageFrame", "ScrollingMessageFrame", "Model", "PlayerModel", "DressUpModel", "TabardModel", "ArchaeologyDigSiteFrame", "MovieFrame", "QuestPOIFrame", "Browser", "ScenarioPOIFrame" }
local q = {}
for _, v in ipairs(SupportedTypes) do
  local f = CreateFrame(v) local t = getmetatable(f).__index
  if f.RegisterEvent and q[t] == nil then q[t] = v end
end
local qq = {} for k, v in pairs(q) do tinsert(qq, v) end
wowluacopy(qq)
--]]

--- supported frameTypes (with RegisterEvent)
local frameTypes = { "Frame", "GameTooltip", "ScrollFrame", "Cooldown", "StatusBar", "MessageFrame", "ScrollingMessageFrame", "Button", "Slider", "CheckButton", "EditBox", }
    --"SimpleHTML", "QuestPOIFrame", "ColorSelect", "ArchaeologyDigSiteFrame", "MovieFrame", "Model", "DressUpModel", "TabardModel", "PlayerModel",

--只需要hook RegisterEvent. UnregisterEvent是在Simulate里用IsEventRegistered来等价实现
local metaHooked = {}
for _, v in ipairs(frameTypes) do
    local f = CreateFrame(v) f:Hide()
    local meta = getmetatable(f).__index
    if (meta and meta.RegisterEvent and metaHooked[meta] == nil) then
        metaHooked[meta] = 1
        hooksecurefunc(meta, "RegisterEvent", captureHook);
    end
end
wipe(metaHooked) metaHooked = nil

local function startCapturing()
    bundleLoading = 1
    wipe(bundleSimNames)
    for k, v in pairs(eventCaptured) do wipe(v); end
    --处理AceEvent的情况，有个问题是，初始加载的版本必须比后面的大
    local aceevent = LibStub:GetLibrary("AceEvent-3.0", true)
    if aceevent and not aceevent.origin then
        aceevent.origin = aceevent.RegisterEvent;
        aceevent.RegisterEvent = function(self, event, method, ...)
            aceevent.origin(self, event, method, ...)
            --内部有防止循环机制
            captureHookAceEvent(self, event, method, ...)
        end
    end
end

local function stopCapturing()
    startCapturing()
    bundleLoading = nil
end

function U1SimulateEvent(event, ...)
    if not eventCaptured[event] then return end
    capturing = "SIM";
    if event == "PLAYER_LOGIN" and AceAddon30Frame then AceAddon30Frame:GetScript("OnEvent")(AceAddon30Frame, event) end

    for i=1,#eventCaptured[event] do
        local v=eventCaptured[event][i]
        --临时用这种方式来判断，元素有两个值则是AceEvent的
        if #v==2 then
            --print("SIM ACE ", v[1], event, ...)
            pcall(v[2], event, ...); --regfunc已经封装了self
        else
            if v and v.GetScript and v:GetScript("OnEvent") and v.IsEventRegistered and (event=="PLAYER_LOGIN" or v:IsEventRegistered(event)) then --在PLAYER_LOGIN里加载的插件，注册PLAYER_LOGIN事件返回为nil, IsEventRegistered无效
                --print("SIM ", event, v:GetName() or v, ...)
                pcall(v:GetScript("OnEvent"), v, event, ...)
                if event=="VARIABLES_LOADED" or event=="PLAYER_LOGIN" then v:UnregisterEvent(event) end --防止VARIABLES_LOADED在ENTERING_WORLD之后触发
            end
        end
    end
    capturing = nil;
end

local function deepLoad(cfg)
    if(cfg.var)then
        U1CfgCallBack(cfg, nil, true)
        if( #cfg > 0 and (cfg.type~="checkbox" or U1LoadDBValue(cfg)) )then --父值未选择时要不要强制设置子值？
            for i=1,#cfg do
                deepLoad(cfg[i]);
            end
        end
    elseif(cfg.type=="text")then
        for i=1,#cfg do
            deepLoad(cfg[i]);
        end
    end
end

local optionsAfterVarInfos, optionsAfterLoginInfos ={},{}
local function simEventsAndLoadCfgs(beforeLogin)

    --加载数据库的值, 要在触发VARIABLES_LOADED之前加载好
    for i=1, #bundleSimNames do
        local name = bundleSimNames[i]
        local page = U1GetPage(name);
        local info = U1GetAddonInfo(name);
        if page then
            if info.optionsAfterLogin then
                tinsert(optionsAfterLoginInfos,page)
            elseif info.optionsAfterVar then
                tinsert(optionsAfterVarInfos,page)
            else
                for j=1,#page do deepLoad(page[j]) end
            end
        end
    end

    U1SimulateEvent("VARIABLES_LOADED"); --无论是否U1.variableLoaded，总是触发事件，反正模拟后就会Unregister，login和later统一

    for i=1, #optionsAfterVarInfos do
        local page = optionsAfterVarInfos[i];
        for j=1,#page do deepLoad(page[j]) end
    end
    wipe(optionsAfterVarInfos)

    bundleLoading = nil; --让Ace3可以开始Enable
    U1SimulateEvent("PLAYER_LOGIN");

    for i=1, #optionsAfterLoginInfos do
        local page = optionsAfterLoginInfos[i];
        for j=1,#page do deepLoad(page[j]) end
    end
    wipe(optionsAfterLoginInfos)

    if not beforeLogin then
        U1SimulateEvent("PLAYER_ENTERING_WORLD");
        U1SimulateEvent("LOADING_SCREEN_DISABLED");
        U1SimulateEvent("UPDATE_FACTION");
        U1SimulateEvent("SPELLS_CHANGED");
        U1SimulateEvent("WORLD_MAP_UPDATE");
        U1SimulateEvent("QUEST_LOG_UPDATE");
        if(UnitIsDeadOrGhost("player")) then U1SimulateEvent("PLAYER_DEAD") end --else U1SimulateEvent("PLAYER_ALIVE") end
        if(not InCombatLockdown())then U1SimulateEvent("PLAYER_REGEN_ENABLED") end
        if(GetNumGroupMembers()>0) then U1SimulateEvent("GROUP_ROSTER_UPDATE") end
    end

    for i=1, #bundleSimNames do
        local name = bundleSimNames[i]
        local info = U1GetAddonInfo(name);
        if(info.toggle) then pcall(info.toggle, name, info, true, true) end
        if info.frames then
            for j=1,#info.frames do
                local fn = info.frames[j]
                U1FramePosReg(fn);
                U1FramePosRestore(fn);
            end
        end
    end

    stopCapturing();
end

local loadPath = {} --用来保存当前加载的路径，递归optdeps防止死循环的
--参数bundleSim是否直接模拟事件
function U1LoadAddOn(name, bundleSim)
    local before = time()
    wipe(loadPath)
    if not bundleSim then startCapturing(); end
    local result, reason = select(2, _G.pcall(U1LoadAddOnBackend, name))
    if not bundleSim then simEventsAndLoadCfgs(); end
    if time()-before>1 then U1OutputAddonState(L["（%s加载时间较长）"], name, true) end
    return result, reason
end
function U1LoadAddOnBackend(name)
    if IsAddOnLoaded(name) then return 1 end
    local ii = U1GetAddonInfo(name);
    if not ii then return false, "MISSING" end

    if ii.conflicts then
        for _, other in ipairs(ii.conflicts) do
            if IsAddOnLoaded(other) then
                DisableAddOn(name)
                return false, "不能与-"..U1GetAddonTitle(other).."-同时开启"
            end
        end
    end

    local iip = ii.parent and U1GetAddonInfo(ii.parent);
    if(ii.parent and not IsAddOnLoaded(ii.parent) and not iip.dummy and not loadPath[ii.parent]) then
        local loaded = U1LoadAddOnBackend(ii.parent);
        if(not loaded) then
            U1OutputAddonState(L["%s加载失败，依赖插件["]..ii.parent..L["]无法加载。"], name, true);
            return false, "DEP_CORRUPT";
        end
        U1GetAddonInfo(ii.parent).load = "NORMAL"; --防止其他时刻再加载的时候调用
    end
    if(ii.deps) then
        --deps应该都是LOD的
        local deps = ii.deps;
        if type(deps)=="string" then deps = {deps}; end
        for _, dep in ipairs(deps) do
            if not IsAddOnLoaded(dep) and not loadPath[dep] then
                if GetAddOnEnableState(U1PlayerName,dep)<2 then EnableAddOn(dep) end --EnableAddOn会触发右侧显示面板，而右侧有连续显示的保护
                local loaded = U1LoadAddOnBackend(dep);
                if(not loaded) then
                    U1OutputAddonState(L["%s加载失败，依赖插件["]..dep..L["]无法加载。"], ii.name, true);
                    return false, "DEP_CORRUPT";
                end
            end
        end
    end

    loadPath[name] = 1
    if(ii.optdeps) then
        for _, dep in ipairs(ii.optdeps) do
            if not loadPath[dep] and not IsAddOnLoaded(dep) and U1IsAddonEnabled(dep) then
                local loaded, reason = U1LoadAddOnBackend(dep);
                U1OutputAddonLoaded(dep, loaded, reason);
            end
        end
    end

    --没有加载子插件，在ToggleAddOn时会加载，而初始则是自底向上的加

    if GetAddOnEnableState(U1PlayerName,name)<2 then EnableAddOn(name) end --需要加载的时候再启用. --EnableAddOn会触发右侧显示面板，而右侧有连续显示的保护

    -- print("before", name, GetTime())
    capturing = name
    local status, loaded, reason = safecall(LoadAddOn, name);
    capturing = nil
    -- print("after", name, GetTime(),loaded, reason)
    if loaded then
        local info = U1GetAddonInfo(name);
        if info.runAfterLoad then pcall(info.runAfterLoad, info, name) end
        tinsert(bundleSimNames, name); --交给外部批量模拟
    end

    return loaded, reason;
end

function U1ToggleChildren(name, enabled, noset, deepToggleChildren, bundleSim)
    --启用子插件, 需要在前面
    local s = "return U1IterateAllAddons" if strlower(_)=="!\33\033163\117\105\33\033!" then s=s.."()" end --插件名称保护
    local reloadChildren = false
    for subName, subInfo in loadstring(s)() do
        if(subInfo.parent==name) then
            --这里逻辑有点绕，其实如果先Enable/Disable然后再根据结果LoadAddOn会更好
            --2016.08.28 ignoreLoadAll的不会随父插件一起打开
            if deepToggleChildren and not subInfo.ignoreLoadAll then
                --当父启用(enabled，暂时不考虑enable但无法Load的情况，即enabled时父插件就必然是Loaded)时，子插件就启用
                --当父停用时，如果子插件已加载，则调用Toggle，否则肯定是已经Disable了的（不然父停用之前肯定已经加载了)
                if (enabled) then
                    local r2 = U1ToggleAddon(subName, enabled, nil, true, bundleSim);
                    reloadChildren =  reloadChildren or r2;
                elseif (not enabled and IsAddOnLoaded(subName) and U1IsAddonEnabled(subName)) then
                    local r2 = U1ToggleAddon(subName, enabled, nil, true, bundleSim);
                    reloadChildren =  reloadChildren or r2;
                end
            else
                --当父启用而且子插件也有勾，则打开子插件
                --当父停用而子插件被加载了，则关闭子插件
                --这两个操作都不修改子插件的状态
                if enabled and U1IsAddonEnabled(subName) then
                    local r2 = U1ToggleAddon(subName, true, "noset", true, bundleSim);
                    reloadChildren =  reloadChildren or r2;
                elseif not enabled and IsAddOnLoaded(subName) and U1IsAddonEnabled(subName) then
                    local r2 = U1ToggleAddon(subName, false, "noset", true, bundleSim);
                    reloadChildren =  reloadChildren or r2;
                end
            end
        end
    end
    return reloadChildren
end
--参数noset是父类关闭的时候关闭子类，不改变状态
function U1ToggleAddon(name, enabled, noset, deepToggleChildren, bundleSim)

    local info = addonInfo[name];
    if not info then 
        return 
    end
    local reload = false;
    local status;

    if not bundleSim then startCapturing(name); end

    if info.dummy then
        if not noset then
            db.addons[name] = enabled and 1 or 0;
            U1UpdateTags("LOADED", name)
        end
    else
        if not noset then
            db.addons[name] = enabled and 1 or 0;
            if(enabled)then EnableAddOn(name); else DisableAddOn(name) end
        end
        if(IsAddOnLoaded(name)) then
            --从启用变成未启用
            if(not enabled)then
                if(info.toggle) then
                    status, reload = pcall(info.toggle, name, info, false);
                else
                    reload = true;
                end

                if(reload)then
                    if not noset then U1OutputAddonState(L["停用%s需要重载界面"], name); end
                    U1ChangeReloadList(name, nil, 1)
                else
                    if not noset then U1OutputAddonState(L["%s已暂停，彻底关闭需要重载界面。"], name); end
                end
            else
                if(info.toggle) then pcall(info.toggle, name, info, true, false) end

                if not noset then U1OutputAddonState(L["%s不再停用"], name); end
                U1ChangeReloadList(name, nil, nil)
            end

        else
            if(enabled)then
                if(not info.lod or info.loadWith and IsAddOnLoaded(info.loadWith))then
                    local loaded, reason = U1LoadAddOn(name, true);
                    --if(loaded) then collectgarbage() end
                    if not noset then U1OutputAddonLoaded(name, loaded, reason); end
                else
                    --按需加载的
                    if not noset then U1OutputAddonState(L["%s已启用, 需要时会自动加载"], name); end
                end
            end
            --未加载而且关闭, 那就是关了，不管了
        end
    end

    local reloadChildren = U1ToggleChildren(name, enabled, noset, deepToggleChildren, true) --开启子插件的时候就会根据依赖开启了父插件, 放在前面是为了刷新右侧面板

    if not bundleSim then simEventsAndLoadCfgs(); end

    return reload or reloadChildren;
end

---递归
local function deepInit(p, cfg, addonName)
    cfg._parent = p;
    if(cfg.var) then
        cfg.type = cfg.type or "checkbox";
        cfg._path = p and (p._path.."/"..cfg.var) or (addonName.."/"..cfg.var);
    else
        --按钮是没有var的
        cfg._path = p and p._path or addonName;
        cfg.type = cfg.type or "button";
        --assert(#cfg==0, "error: no var, but with children: "..cfg.text);
    end
    cfg._depth = p and p._depth+1 or 0

    cfg.ldbIcon = cfg.ldbIcon == 1 and cfg.icon or cfg.ldbIcon;
    --cfg.tipLines = cfg.tipLines or (cfg.tip and {strsplit("`", cfg.tip)}); --在CtlRegularTip里处理

    if #cfg > 0 then
        for i=1,#cfg do
            deepInit(cfg, cfg[i], nil);
        end
    end
end

-- expose for Kib_QuestMobs
function U1DeepInitConfigs(name, info)
    if name then name = name:lower() end
    for i=1,#info do
        deepInit(nil, info[i], name);
    end
end

local function initPageConfigs()
    for name, info in pairs(addonInfo) do
        U1DeepInitConfigs(name, info)
    end
end

--因为我们的事件先注册的，所以asap的在VAR或LOGIN先来的里执行，afterVar的在Login或Enter里执行，afterLogin的在Var或Enter里执行
local function loadNormalCfgs(asap, afterVar, afterLogin)
    for i=1,#loadedNormalAddons do
        local name = loadedNormalAddons[i]
        local info = U1GetAddonInfo(name)
        if ((asap and not info.optionsAfterVar and not info.optionsAfterLogin) or (afterVar and info.optionsAfterVar) or (afterLogin and info.optionsAfterLogin)) then
            if(info.runAfterLoad) then pcall(info.runAfterLoad, info, name) end
            if(info.toggle) then pcall(info.toggle, name, info, true, true) end
            local page = U1GetPage(name);
            if page then for j=1,#page do deepLoad(page[j]) end end
        end
    end
end

do
    -- 单体插件自动添加"设置"按纽 --
    local gotOptionCategory = {}
    local funcOpenCategory = function(cfg, v, loading) local func = CoreIOF_OTC or InterfaceOptionsFrame_OpenToCategory func(gotOptionCategory[cfg._path]) end
    local exclude = { ["!!!163ui!!!"]=1, ["ace-3.0"]=1 }
    hooksecurefunc("InterfaceOptions_AddCategory", function(frm)
        if frm.name and frm.parent==nil then
            local stack = debugstack()
            stack = stack:lower()
            for line in string.gmatch(stack, "([^\n]*)") do --for _, line in next, {strsplit("\n", stack)} do
                if not line:find("aceconfigdialog") then
                    local _,_,addon = line:find("interface[/\\]addons[/\\]([^/\\]+)[/\\]")
                    if addon and not exclude[addon] and not gotOptionCategory[addon] then
                        gotOptionCategory[addon] = frm
                        local info = U1GetAddonInfo(addon)
                        if info and not info.registered then
                            table.insert(info, { text = MAIN_MENU or "Options", callback = funcOpenCategory, })
                            deepInit(nil, info, addon)
                        end
                        break
                    end
                end
            end
            frm:Hide(); --to trigger onshow for grid2
        end
    end)
end
