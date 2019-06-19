-- Items
--
-- Handle using items with complex requirements.

-- 5.0.4 has a problem with a global "_" (see some for loops below)
local _

local FL = LibStub("LibFishing-1.0");

local GSB = FishingBuddy.GetSettingBool;

local CurLoc = GetLocale();

local RAFT_RESET_TIME = 30
local RAFT_ID = 85500;
local BERG_ID = 107950;

local RaftItems = {};
RaftItems[RAFT_ID] = {
    ["enUS"] =  "Angler's Fishing Raft",
    spell = 124036,
    setting = "UseAnglersRaft",
    toy = 1,
};
RaftItems[BERG_ID] = {
    ["enUS"] = "Bipsi's Bobbing Berg",
    spell = 152421,
    setting = "UseBobbingBerg",
};

local function HasRaftBuff()
	local hasberg = FL:HasBuff(RaftItems[BERG_ID].spell);
	local hasraft = FL:HasBuff(RaftItems[RAFT_ID].spell);

	return RaftItems[BERG_ID].spell, RaftItems[RAFT_ID].spell, hasberg, hasraft
end
FishingBuddy.HasRaftBuff = HasRaftBuff

-- have to check this because C_ToyBox.IsToyUsable(RAFT_ID) also
-- checks for revered, which is only necesssar to buy the raft.
local function HasPandarianFishing()
    local skill, _, _, _ = FL:GetContinentSkill(FBConstants.PANDARIA);
    return skill > 0;
end

local function HaveRafts()
    local haveRaft = PlayerHasToy(RAFT_ID) and HasPandarianFishing();
    local haveBerg = GetItemCount(BERG_ID) > 0;
    return (haveRaft or haveBerg), haveRaft, haveBerg
end

local function SetupRaftOptions()
    local haveAny, haveRaft, haveBerg = HaveRafts();
    local options = {};
    -- if we have both, be smarter about rafts
    options["UseRaft"] = {
        ["tooltip"] = FBConstants.CONFIG_USERAFTS_INFO,
        ["tooltipd"] = FBConstants.CONFIG_USERAFTS_INFOD,
        ["text"] = FBConstants.CONFIG_USERAFTS_ONOFF,
        ["enabled"] = HaveRafts;
        ["v"] = 1,
        ["default"] = true
    };
    options["UseBobbingBerg"] = {
        ["text"] = FBConstants.CONFIG_BOBBINGBERG_ONOFF,
        ["tooltip"] = FBConstants.CONFIG_BOBBINGBERG_INFO,
        ["enabled"] = function()
            local _, _, berg = HaveRafts();
            return berg;
        end;
        ["v"] = 1,
        ["default"] = true,
        ["parents"] = { ["UseRaft"] = "d", },
    };

    options["BergMaintainOnly"] = {
        ["text"] = FBConstants.CONFIG_MAINTAINRAFTBERG_ONOFF,
        ["tooltip"] = FBConstants.CONFIG_MAINTAINRAFT_INFO,
        ["default"] = true,
        ["v"] = 1,
        ["parents"] = { ["UseRaft"] = "d", }
    };
    options["OverWalking"] = {
        ["text"] = FBConstants.CONFIG_OVERWALKING_ONOFF,
        ["tooltip"] = FBConstants.CONFIG_OVERWALKING_INFO,
        ["default"] = false,
        ["v"] = 1,
        ["parents"] = { ["UseRaft"] = "d", }
    };

    return options
end

-- Don't cast the angler's raft if we're doing Scavenger Hunt or on Inkgill Mere
local function RaftBergUsable()
    if (not GSB("UseRaft") or IsMounted()) then
        return false
    elseif FL:HasBuff(201944) then
        -- Surface Tension
        return GSB("OverWalking");
    else
        -- Raft quests
        return not (FL:HasBuff(116032) or FL:HasBuff(119700));
    end
end

local function RaftingPlan(queue)
    local haveAny, haveRaft, haveBerg = HaveRafts()
    if (haveAny and RaftBergUsable()) then
        local bergbuff, raftbuff, hasberg, hasraft = HasRaftBuff();

        local need = not (hasberg or hasraft);

        -- if we need it, but we're maintaining only, skip it
        if (GSB("BergMaintainOnly") and need) then
            return;
        end

        local buff, itemid, name;
        buff = nil
        if (haveBerg and GSB("UseBobbingBerg")) then
            buff = bergbuff;
            itemid = BERG_ID;
            name = RaftItems[itemid][CurLoc];
        elseif (haveRaft) then
            buff = raftbuff;
            _, itemid = C_ToyBox.GetToyInfo(RAFT_ID)
            name = RaftItems[RAFT_ID][CurLoc];
        end
        if buff then
            local et = select(6, FL:GetBuff(buff));
            et = (et or 0) - GetTime();
            if (need or et <= RAFT_RESET_TIME) then
                tinsert(queue, {
                    ["itemid"] = itemid,
                    ["name"] = name,
                })
            end
        end
    end
end
FishingBuddy.RaftingPlan = RaftingPlan;

local RaftEvents = {}
RaftEvents[FBConstants.FIRST_UPDATE_EVT] = function()
    FishingBuddy.SetupSpecialItems(RaftItems, false, true, true)
    local options = SetupRaftOptions();
    FishingBuddy.raftoptions = options
    if options then
        FishingBuddy.AddFluffOptions(options);
        FishingBuddy.RegisterPlan(RaftingPlan)
    end
end

FishingBuddy.RegisterHandlers(RaftEvents);

FishingBuddy.Commands["raft"] = {};
FishingBuddy.Commands["raft"].func =
    function()
        local skill, _, _, _ = FL:GetContinentSkill(FBConstants.PANDARIA);
        FishingBuddy_Info["RaftDebug"] = {
            ["RaftOption"] = GSB("UseRaft"),
            ["RaftQuests"] = {
                ["116032"] = FL:HasBuff(116032),
                ["119700"] = FL:HasBuff(119700),
            },
            ["SurfaceTension"] = GSB("OverWalking"),
            ["HaveRaft"] = PlayerHasToy(RAFT_ID),
            ["UseableRaft"] = C_ToyBox.IsToyUsable(RAFT_ID),
            ["RaftInfo"] = C_ToyBox.GetToyInfo(RAFT_ID),
            ["BergCount"] = GetItemCount(BERG_ID),
            ["Maintain"] = GSB("BergMaintainOnly"),
            ["UseBerg"] = GSB("UseBobbingBerg"),
            ["PandarenSkill"] = skill
        };
        return true;
    end
