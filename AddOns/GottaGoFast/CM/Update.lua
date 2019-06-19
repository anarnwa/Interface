function GottaGoFast.UpdateCM()
  if (GottaGoFast.CurrentCM and next(GottaGoFast.CurrentCM)) then
    GottaGoFast.UpdateCMTimer();
  end
end

function GottaGoFast.UpdateCMInformation()
  if (GottaGoFast.CurrentCM and next(GottaGoFast.CurrentCM)) then
    if (GottaGoFast.CurrentCM["Completed"] == false) then
      for i = 1, GottaGoFast.CurrentCM["Steps"] do
        local name, _, status, curValue, finalValue, _, _, mobPoints = C_Scenario.GetCriteriaInfo(i);
        if (finalValue == 0 or not finalValue) then
          -- Final Value = 0 Means CM Complete
          GottaGoFast.CompleteCM();
          return false;
        end
        if (GottaGoFast.CurrentCM["CurrentValues"][i] ~= curValue) then
          -- Update Value
          if (i ~= GottaGoFast.CurrentCM["Steps"]) then
            GottaGoFast.CurrentCM["CurrentValues"][i] = curValue;
          else
            GottaGoFast.CurrentCM["CurrentValues"][i] = GottaGoFast.MobPointsToInteger(mobPoints);
          end
          if (curValue == finalValue or ((i == GottaGoFast.CurrentCM["Steps"]) and (curValue == 100))) then
            -- Add Objective Time
            GottaGoFast.CurrentCM["ObjectiveTimes"][i] = GottaGoFast.ObjectiveCompleteString(GottaGoFast.Utility.ShortenStr(GottaGoFast.CurrentCM["Time"], 1));
          end
        elseif (GottaGoFast.CurrentCM["CurrentValues"][i] == GottaGoFast.CurrentCM["FinalValues"][i] and not GottaGoFast.CurrentCM["ObjectiveTimes"][i]) then
          -- Objective Already Complete But No Time Filled Out (Re-Log / Re-Zone)
          GottaGoFast.CurrentCM["ObjectiveTimes"][i] = "?";
        end
      end
    end
  end
end

function GottaGoFast.CMFinalParse()
  if (GottaGoFast.CurrentCM and next(GottaGoFast.CurrentCM)) then
    for i = 1, GottaGoFast.CurrentCM["Steps"] do
      GottaGoFast.CurrentCM["CurrentValues"][i] = GottaGoFast.CurrentCM["FinalValues"][i];
      if (not GottaGoFast.CurrentCM["ObjectiveTimes"][i]) then
        GottaGoFast.CurrentCM["ObjectiveTimes"][i] = GottaGoFast.ObjectiveCompleteString(GottaGoFast.Utility.ShortenStr(GottaGoFast.CurrentCM["Time"], 1));
      end
    end
  end
end

function GottaGoFast.AddBestRun(run)
  if (GottaGoFast.CurrentCM and next(GottaGoFast.CurrentCM) and run ~= "NF") then
    GottaGoFast.CurrentCM["BestRun"] = run;
    GottaGoFast.PrintBestRun(GottaGoFast.CurrentCM["BestRun"]);
  end
end

function GottaGoFast.StartCM(offset)
  if (GottaGoFast.CurrentCM and next(GottaGoFast.CurrentCM)) then
    GottaGoFast.CurrentCM["StartTime"] = GetTime() + offset;
    GottaGoFast.BuildCMTooltip();
  end
end

function GottaGoFast.CompleteCM()
  if (GottaGoFast.CurrentCM and next(GottaGoFast.CurrentCM)) then
    GottaGoFast.CurrentCM["Completed"] = true;
    GottaGoFast.CMFinalParse();
  end
end

function GottaGoFast.WipeCM()
  if (GottaGoFast.CurrentCM and next(GottaGoFast.CurrentCM)) then
    GottaGoFast.CurrentCM = table.wipe(GottaGoFast.CurrentCM);
  end
end
