function GottaGoFast.UpdateTWInformation()
  if (GottaGoFast.CurrentTW) then
    if (GottaGoFast.CurrentTW["Completed"] == false) then
      for i = 1, GottaGoFast.CurrentTW["Steps"] do
        local name, _, status, curValue, finalValue = C_Scenario.GetCriteriaInfo(i);
        if (finalValue == 0 or not finalValue) then
          -- Final Value = 0 Means TW Complete
          GottaGoFast.CompleteTW();
          return false;
        end
        if (GottaGoFast.CurrentTW["CurrentValues"][i] ~= curValue) then
          -- Update Value
          GottaGoFast.CurrentTW["CurrentValues"][i] = curValue;
          if (curValue == finalValue) then
            -- Add Objective Time
            GottaGoFast.CurrentTW["ObjectiveTimes"][i] = GottaGoFast.ObjectiveCompleteString(GottaGoFast.CurrentTW["Time"]);
          end
        elseif (GottaGoFast.CurrentTW["CurrentValues"][i] == GottaGoFast.CurrentTW["FinalValues"][i] and not GottaGoFast.CurrentTW["ObjectiveTimes"][i]) then
          -- Objective Already Complete But No Time Filled Out (Re-Log / Re-Zone)
          GottaGoFast.CurrentTW["ObjectiveTimes"][i] = "?";
        end
      end
    end
  end
end

function GottaGoFast.UpdateTWTimer()
  if (GottaGoFast.CurrentTW and GottaGoFast.CurrentTW["StartTime"]) then
    if (GottaGoFast.CurrentTW["Completed"] == false) then
      local time = "";
      local startMin, startSec;
      local currentTime = GetTime();
      local secs = currentTime - GottaGoFast.CurrentTW["StartTime"];
      GottaGoFast.CurrentTW["CurrentTime"] = secs;
      startMin, startSec = GottaGoFast.SecondsToTime(secs);
      if (GottaGoFast.CurrentTW["StartTime"] and GottaGoFast.GetTimerType(nil) == "TrueTimerMS") then
        startMin = GottaGoFast.FormatTimeNoMS(startMin);
        startSec = GottaGoFast.FormatTimeMS(startSec);
      else
        startMin = GottaGoFast.FormatTimeNoMS(startMin);
        startSec = GottaGoFast.FormatTimeNoMS(startSec);
      end
      time = startMin .. ":" .. startSec;
      if (GottaGoFast.CurrentTW["LateStart"] == true) then
        time = time .. "*";
      end
      time = time .. " ";
      GottaGoFast.CurrentTW["Time"] = time;
      -- Update Frame
      GottaGoFastTimerFrame.font:SetText(GottaGoFast.ColorTimer(time));
      GottaGoFast.ResizeFrame();
    else
      GottaGoFastTimerFrame.font:SetText(GottaGoFast.ColorTimer(GottaGoFast.CurrentTW["Time"]));
    end
  else
    GottaGoFastTimerFrame.font:SetText(GottaGoFast.ColorTimer("00:00"));
  end
end
