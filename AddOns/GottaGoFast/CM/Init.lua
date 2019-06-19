local ggf = GottaGoFast;
local constants = ggf.Constants;
local utility = ggf.Utility;

function GottaGoFast.SetupCM(currentZoneID)
  local _, _, steps = C_Scenario.GetStepInfo();
  local cmLevel, affixes, empowered = C_ChallengeMode.GetActiveKeystoneInfo();
  local cmID = C_ChallengeMode.GetActiveChallengeMapID();
  GottaGoFast.CurrentCM = {};
  GottaGoFast.CurrentCM["Name"], GottaGoFast.CurrentCM["CmID"], GottaGoFast.CurrentCM["GoldTimer"] = C_ChallengeMode.GetMapUIInfo(cmID);
  GottaGoFast.CurrentCM["StartTime"] = nil;
  GottaGoFast.CurrentCM["Time"] = nil;
  GottaGoFast.CurrentCM["CurrentTime"] = nil;
  GottaGoFast.CurrentCM["String"] = nil;
  GottaGoFast.CurrentCM["ZoneID"] = currentZoneID;
  GottaGoFast.CurrentCM["Deaths"] = 0;
  GottaGoFast.CurrentCM["Steps"] = steps;
  GottaGoFast.CurrentCM["Level"] = cmLevel;
  GottaGoFast.CurrentCM["Empowered"] = empowered;
  GottaGoFast.CurrentCM["Bonus"] = nil;
  GottaGoFast.CurrentCM["Completed"] = false;
  GottaGoFast.CurrentCM["AskedTime"] = nil;
  GottaGoFast.CurrentCM["AskedForTimer"] = false;
  GottaGoFast.CurrentCM["Version"] = constants.Version;
  GottaGoFast.CurrentCM["Affixes"] = {};
  GottaGoFast.CurrentCM["CurrentValues"] = {};
  GottaGoFast.CurrentCM["FinalValues"] = {};
  GottaGoFast.CurrentCM["ObjectiveTimes"] = {};
  GottaGoFast.CurrentCM["Bosses"] = {};
  GottaGoFast.CurrentCM["IncreaseTimers"] = {};
  GottaGoFast.CurrentCM["BestRun"] = {};

  if (cmLevel) then
    GottaGoFast.CurrentCM["Bonus"] = C_ChallengeMode.GetPowerLevelDamageHealthMod(cmLevel);
  end

  if (GottaGoFast.CurrentCM["Bonus"] == nil) then
    GottaGoFast.CurrentCM["Bonus"] = "?"
  end

  for i, affixID in ipairs(affixes) do
    local affixName, affixDesc, affixNum = C_ChallengeMode.GetAffixInfo(affixID);
    GottaGoFast.CurrentCM["Affixes"][affixID] = {};
    GottaGoFast.CurrentCM["Affixes"][affixID]["name"] = affixName;
    GottaGoFast.CurrentCM["Affixes"][affixID]["desc"] = affixDesc;
  end

  for i = 1, steps do
    local name, _, status, curValue, finalValue, _, _, mobPoints = C_Scenario.GetCriteriaInfo(i);
    GottaGoFast.CurrentCM["CurrentValues"][i] = curValue;
    GottaGoFast.CurrentCM["FinalValues"][i] = finalValue;
    GottaGoFast.CurrentCM["Bosses"][i] = string.gsub(name, " defeated", "")
    if (i == steps) then
      GottaGoFast.CurrentCM["CurrentValues"][i] = GottaGoFast.MobPointsToInteger(mobPoints);
    end
  end

  if (GottaGoFast.CurrentCM["GoldTimer"]) then
    GottaGoFast.CurrentCM["IncreaseTimers"][1] = GottaGoFast.CurrentCM["GoldTimer"];
    GottaGoFast.CurrentCM["IncreaseTimers"][2] = GottaGoFast.CurrentCM["GoldTimer"] * 0.8;
    GottaGoFast.CurrentCM["IncreaseTimers"][3] = GottaGoFast.CurrentCM["GoldTimer"] * 0.6;
  end

  GottaGoFast.BuildCMTooltip();
  GottaGoFast.HideObjectiveTracker();
  GottaGoFast.CreateDungeon(GottaGoFast.CurrentCM["Name"], GottaGoFast.CurrentCM["ZoneID"], GottaGoFast.CurrentCM["Bosses"]);
  GottaGoFast.AskForBestRun(GottaGoFast.CurrentCM["ZoneID"], GottaGoFast.CurrentCM["Level"], GottaGoFast.CurrentCM["Affixes"]);
end

function GottaGoFast.SetupFakeCM()
  local affixes = {2, 7, 10};
  GottaGoFast.CurrentCM = {};
  GottaGoFast.CurrentCM["StartTime"] = GetTime() - (60*5);
  GottaGoFast.CurrentCM["Time"] = nil;
  GottaGoFast.CurrentCM["CurrentTime"] = nil;
  GottaGoFast.CurrentCM["String"] = nil;
  GottaGoFast.CurrentCM["Name"], GottaGoFast.CurrentCM["CmID"], GottaGoFast.CurrentCM["GoldTimer"] = C_ChallengeMode.GetMapUIInfo(206);
  GottaGoFast.CurrentCM["ZoneID"] = 1492;
  GottaGoFast.CurrentCM["Deaths"] = 4;
  GottaGoFast.CurrentCM["Steps"] = 5;
  GottaGoFast.CurrentCM["Level"] = 10;
  GottaGoFast.CurrentCM["Empowered"] = true;
  GottaGoFast.CurrentCM["Bonus"] = 100;
  GottaGoFast.CurrentCM["Completed"] = false;
  GottaGoFast.CurrentCM["AskedTime"] = nil;
  GottaGoFast.CurrentCM["AskedForTimer"] = false;
  GottaGoFast.CurrentCM["Version"] = constants.Version;
  GottaGoFast.CurrentCM["Affixes"] = {};
  GottaGoFast.CurrentCM["CurrentValues"] = {1, 1, 0, 0, 40};
  GottaGoFast.CurrentCM["FinalValues"] = {1, 1, 1, 1, 160};
  GottaGoFast.CurrentCM["ObjectiveTimes"] = {"1:15.460", "3:45.012"};
  GottaGoFast.CurrentCM["Bosses"] = {"Rokmora", "Ularogg Cragshaper", "Naraxas", "Dargrul", "Enemy Forces"};
  GottaGoFast.CurrentCM["IncreaseTimers"] = {};
  GottaGoFast.CurrentCM["BestRun"] = {};

  for i, affixID in ipairs(affixes) do
    local affixName, affixDesc, affixNum = C_ChallengeMode.GetAffixInfo(affixID);
    GottaGoFast.CurrentCM["Affixes"][affixID] = {};
    GottaGoFast.CurrentCM["Affixes"][affixID]["name"] = affixName;
    GottaGoFast.CurrentCM["Affixes"][affixID]["desc"] = affixDesc;
  end

  if (GottaGoFast.CurrentCM["GoldTimer"]) then
    GottaGoFast.CurrentCM["IncreaseTimers"][1] = GottaGoFast.CurrentCM["GoldTimer"];
    GottaGoFast.CurrentCM["IncreaseTimers"][2] = GottaGoFast.CurrentCM["GoldTimer"] * 0.8;
    GottaGoFast.CurrentCM["IncreaseTimers"][3] = GottaGoFast.CurrentCM["GoldTimer"] * 0.6;
  end

  GottaGoFast.BuildCMTooltip();
  GottaGoFast.HideObjectiveTracker();
end
