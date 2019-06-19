function GottaGoFast.CheckTWTimer()
  -- Someone asked for a timer, send it to them!
  if (GottaGoFast.CurrentTW["LateStart"] == false and GottaGoFast.CurrentTW["StartTime"] and GottaGoFast.CurrentTW["CurrentTime"]) then
    local CurrentTWString = GottaGoFast:Serialize(GottaGoFast.CurrentTW);
    GottaGoFast.Utility.DebugPrint("Timer Sent");
    GottaGoFast:SendCommMessage("GottaGoFastTW", CurrentTWString, "PARTY", nil, "ALERT");
  end
end

function GottaGoFast.FixTWTimer(input)
  if (GottaGoFast.inTW == true and GottaGoFast.CurrentTW) then
    if (GottaGoFast.CurrentTW["LateStart"] == true) then
      GottaGoFast.Utility.DebugPrint("Replacing Timer");
      -- Set Table
      GottaGoFast:Deserialize(input);
      local DIW, ETW = GottaGoFast:Deserialize(input);
      if (DIW) then
        local CurrentTime = GetTime();
        ETW["StartTime"] = CurrentTime - ETW["CurrentTime"];
        GottaGoFast.CurrentTW = ETW;
        -- Update Timer
        GottaGoFast.UpdateTWTimer();
        GottaGoFast.UpdateTWObjectives();
      end
    end
  end
end
