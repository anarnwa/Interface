local ggf = GottaGoFast;
local utility = ggf.Utility;

function GottaGoFast.InitTW(currentZoneID)
  if (GottaGoFastInstanceInfo[currentZoneID]["TW"]) then
    utility.DebugPrint("Player Entered Timewalking Dungeon");
    GottaGoFast.WipeTW();
    GottaGoFast.SetupTW(currentZoneID);
    GottaGoFast.UpdateTWTimer();
    GottaGoFast.UpdateTWObjectives();
    GottaGoFast.inCM = false;
    GottaGoFast.inTW = true;
    GottaGoFastFrame:SetScript("OnUpdate", GottaGoFast.UpdateTW);
    -- Hiding Frames For Now
    GottaGoFast.ShowFrames();
  end
end

function GottaGoFast.SetupTW(currentZoneID)
  local _, _, steps = C_Scenario.GetStepInfo();
  GottaGoFast.CurrentTW = {};
  GottaGoFast.CurrentTW["StartTime"] = nil;
  GottaGoFast.CurrentTW["CurrentTime"] = nil;
  GottaGoFast.CurrentTW["Time"] = nil;
  GottaGoFast.CurrentTW["LateStart"] = false;
  GottaGoFast.CurrentTW["String"] = nil;
  GottaGoFast.CurrentTW["Steps"] = steps;
  GottaGoFast.CurrentTW["CurrentZoneID"] = currentZoneID;
  GottaGoFast.CurrentTW["Completed"] = false;
  GottaGoFast.CurrentTW["CurrentValues"] = {};
  GottaGoFast.CurrentTW["FinalValues"] = {};
  GottaGoFast.CurrentTW["ObjectiveTimes"] = {};
  GottaGoFast.CurrentTW["Bosses"] = {};

  for i = 1, steps do
    local name, _, status, curValue, finalValue = C_Scenario.GetCriteriaInfo(i);
    name = string.gsub(name, " defeated", "");
    GottaGoFast.CurrentTW["CurrentValues"][i] = curValue;
    GottaGoFast.CurrentTW["FinalValues"][i] = finalValue;
    GottaGoFast.CurrentTW["Bosses"][i] = name;
    if (curValue ~= 0) then
      GottaGoFast.CurrentTW["LateStart"] = true;
      GottaGoFast.StartTW();
    end
  end

  if (GottaGoFast.CheckPositions(GottaGoFast.CurrentTW["CurrentZoneID"])) then
    GottaGoFast.CurrentTW["LateStart"] = true;
  end

  if (GottaGoFast.CurrentTW["LateStart"] == true) then
    --GottaGoFast:Print("Asked To Fix Timer");
    GottaGoFast:SendCommMessage("GottaGoFastTW", "FixTW", "PARTY", nil, "ALERT");
  end

  GottaGoFast.HideObjectiveTracker();
end
