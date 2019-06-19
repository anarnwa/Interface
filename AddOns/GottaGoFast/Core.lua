local ggf = GottaGoFast;
local utility = ggf.Utility;
local debugPrint = utility.DebugPrint;

function GottaGoFast:OnInitialize()
    -- Called when the addon is loaded
    -- Register Frames
    GottaGoFastFrame = CreateFrame("Frame", "GottaGoFastFrame", UIParent);
    GottaGoFastTimerFrame = CreateFrame("Frame", "GottaGoFastTimerFrame", GottaGoFastFrame);
    GottaGoFastObjectiveFrame = CreateFrame("Frame", "GottaGoFastObjectiveFrame", GottaGoFastFrame);
    GottaGoFastHideFrame = CreateFrame("Frame");
    GottaGoFastHideFrame:Hide();
end

function GottaGoFast:OnEnable()
    -- Called when the addon is enabled
    -- Register Events
    C_ChatInfo.RegisterAddonMessagePrefix("GottaGoFast");
    C_ChatInfo.RegisterAddonMessagePrefix("GottaGoFastCM");
    C_ChatInfo.RegisterAddonMessagePrefix("GottaGoFastTW");
    self:RegisterEvent("CHALLENGE_MODE_COMPLETED");
    self:RegisterEvent("CHALLENGE_MODE_RESET");
    self:RegisterEvent("CHALLENGE_MODE_START")
    self:RegisterEvent("GOSSIP_SHOW");
    self:RegisterEvent("PLAYER_ENTERING_WORLD")
    self:RegisterEvent("SCENARIO_POI_UPDATE");
    self:RegisterEvent("WORLD_STATE_TIMER_START");
    self:RegisterEvent("ZONE_CHANGED_NEW_AREA")
    self:RegisterChatCommand("ggf", "ChatCommand");
    self:RegisterChatCommand("GottaGoFast", "ChatCommand");
    self:RegisterComm("GottaGoFast", "ChatComm");
    self:RegisterComm("GottaGoFastCM", "CMChatComm");
    self:RegisterComm("GottaGoFastTW", "TWChatComm");
    self:SecureHookScript(GameTooltip, "OnTooltipSetUnit", "GameTooltip_OnTooltipSetUnit")

    -- Setup AddOn
    GottaGoFast.InitState();
    GottaGoFast.InitOptions();
    GottaGoFast.InitFrame();
    GottaGoFast.VersionCheck();

end

function GottaGoFast:OnDisable()
  -- Called when the addon is disabled
end

function GottaGoFast:CHALLENGE_MODE_COMPLETED()
  GottaGoFast.Utility.DebugPrint("CM Complete");
  GottaGoFast.CompleteCM();
  if (GottaGoFast.CurrentCM and next(GottaGoFast.CurrentCM) ~= nil) then
    GottaGoFast.PrintNewBest(GottaGoFast.CurrentCM);
    GottaGoFast.CreateRun(GottaGoFast.CurrentCM);
  end
end

function GottaGoFast:CHALLENGE_MODE_RESET()
  GottaGoFast.Utility.DebugPrint("CM Reset")
  GottaGoFast.ResetState()
  GottaGoFast.HideObjectiveTracker()
end

function GottaGoFast:CHALLENGE_MODE_START()
  GottaGoFast.Utility.DebugPrint("CM Start")
  GottaGoFast.ResetState()
  GottaGoFast.HideObjectiveTracker()
end

function GottaGoFast:PLAYER_ENTERING_WORLD()
  GottaGoFast.Utility.DebugPrint("Player Entering World");
  GottaGoFast.WhereAmI()
end

function GottaGoFast:SCENARIO_POI_UPDATE()
  if (GottaGoFast.inCM) then
    GottaGoFast.Utility.DebugPrint("Scenario POI Update");
    if (GottaGoFast.CurrentCM["Steps"] == 0 and GottaGoFast.CurrentCM["Completed"] == false and next(GottaGoFast.CurrentCM["Bosses"]) == nil) then
      GottaGoFast.WhereAmI();
    end
    GottaGoFast.UpdateCMInformation();
    GottaGoFast.UpdateCMObjectives();
  end
end

function GottaGoFast:WORLD_STATE_TIMER_START()
  GottaGoFast.Utility.DebugPrint("World Start Timer Start")
  if (ggf.inCM == false or GottaGoFast.CurrentCM == nil or next(GottaGoFast.CurrentCM) == nil or GottaGoFast.CurrentCM["Steps"] == 0) then
    GottaGoFast.WhereAmI()
  end
  if (ggf.inCM and GottaGoFast.CurrentCM["Completed"] == false) then
      local _, timeCM = GetWorldElapsedTime(1);
      if (timeCM ~= nil and timeCM <= 2) then
        GottaGoFast.StartCM(0);
        GottaGoFast.UpdateCMObjectives();
      elseif (GottaGoFast.CurrentCM["Deaths"]) then
        GottaGoFast.CurrentCM["Deaths"] = GottaGoFast.CurrentCM["Deaths"] + 1;
        GottaGoFast.UpdateCMObjectives();
      end
  end
end

function GottaGoFast:GOSSIP_SHOW()
  if (ggf.inCM == true and ggf.CurrentCM ~= nil and next(ggf.CurrentCM) ~= nil) then
    GottaGoFast.HandleGossip();
  end
end

function GottaGoFast:ZONE_CHANGED_NEW_AREA()
  GottaGoFast.Utility.DebugPrint("Zone Changed New Area")
  GottaGoFast.WhereAmI();
end

function GottaGoFast:GameTooltip_OnTooltipSetUnit()
  if (ggf.inCM == true and ggf.GetIndividualMobValue(nil) == true and ggf.CurrentCM ~= nil and next(ggf.CurrentCM) ~= nil) then
    GottaGoFast.AddMobPointsToTooltip();
  end
end

function GottaGoFast:ChatCommand(input)
  if (string.lower(input) == "debugmode") then
    --local setting = not GottaGoFast.GetDebugMode(nil);
    GottaGoFast.SetDebugMode(nil, (not GottaGoFast.GetDebugMode(nil)));
  elseif (string.lower(input) == "changelog") then
    GottaGoFast.Changelog();
  else
    InterfaceOptionsFrame_OpenToCategory(GottaGoFast.optionsFrame);
    InterfaceOptionsFrame_OpenToCategory(GottaGoFast.optionsFrame);
  end
end

function GottaGoFast:ChatComm(prefix, input, distribution, sender)
  GottaGoFast.Utility.DebugPrint("History Message (From History Addon) Received");
  if (prefix == "GottaGoFast" and input == "HistoryLoaded") then
    GottaGoFast.Utility.DebugPrint("Input: History Loaded")
    if (GottaGoFast.SendHistoryFlag == true) then
      GottaGoFast.SendHistory(ggf.db.profile.History);
    end
  end
end

function GottaGoFast:CMChatComm(prefix, input, distribution, sender)
  -- Right Now This Is Only Used For Syncing Timer
  GottaGoFast.Utility.DebugPrint("CM Message Received");
  if (prefix == "GottaGoFastCM" and input == "FixCM" and GottaGoFast.inCM == true and GottaGoFast.CurrentCM and next(GottaGoFast.CurrentCM) ~= nil) then
    GottaGoFast.CheckCMTimer();
  elseif (prefix == "GottaGoFastCM" and GottaGoFast.inCM == true and GottaGoFast.CurrentCM and next(GottaGoFast.CurrentCM) ~= nil) then
    local status, data = GottaGoFast:Deserialize(input);
    if (data["msg"] == "BestRun") then
      utility.DebugPrint("Received Best Run");
      GottaGoFast.AddBestRun(data["run"]);
    else
      -- Received Timer, See If You Need It, Then Update
      GottaGoFast.FixCMTimer(input)
    end
  end
end

function GottaGoFast:TWChatComm(prefix, input, distribution, sender)
  -- Right Now This Is Only Used For Syncing Timer
  GottaGoFast.Utility.DebugPrint("TW Message Received");
  if (prefix == "GottaGoFastTW" and input == "FixTW" and GottaGoFast.inTW == true and GottaGoFast.CurrentTW and next(GottaGoFast.CurrentTW) ~= nil) then
    GottaGoFast.CheckTWTimer();
  elseif (prefix == "GottaGoFastTW" and GottaGoFast.inTW == true and GottaGoFast.CurrentTW and next(GottaGoFast.CurrentTW) ~= nil) then
    GottaGoFast.FixTWTimer(input);
  end
end

function GottaGoFast.ResetState()
  GottaGoFast.WipeCM();
  GottaGoFast.WipeTW();
  GottaGoFast.inCM = false;
  GottaGoFast.inTW = false;
  GottaGoFast.demoMode = false;
  GottaGoFast.tooltip = GottaGoFast.defaultTooltip;
  GottaGoFastFrame:SetScript("OnUpdate", nil);
  GottaGoFast.HideFrames();
  GottaGoFast.ShowObjectiveTracker();
end

function GottaGoFast.WhereAmI()
  local _, _, difficulty, _, _, _, _, currentZoneID = GetInstanceInfo();
  GottaGoFast.Utility.DebugPrint("Difficulty: " .. difficulty);
  GottaGoFast.Utility.DebugPrint("Zone ID: " .. currentZoneID);
  if (difficulty == 8 and C_ChallengeMode.GetActiveChallengeMapID() ~= nil) then
    GottaGoFast.InitCM(currentZoneID)
  else
    GottaGoFast.ResetState()
  end
end