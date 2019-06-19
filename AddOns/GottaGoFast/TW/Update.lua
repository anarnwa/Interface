function GottaGoFast.UpdateTW()
  if (GottaGoFast.CurrentTW) then
    if (not GottaGoFast.CurrentTW["StartTime"]) then
      GottaGoFast.CheckPositions(GottaGoFast.CurrentTW["CurrentZoneID"]);
    end
    GottaGoFast.UpdateTWTimer();
  end
end

function GottaGoFast.UpdateTWObjectives()
  if (GottaGoFast.CurrentTW) then
    local objectiveString = "";
    for i = 1, GottaGoFast.CurrentTW["Steps"] do
      objectiveString = objectiveString .. GottaGoFast.ObjectiveString(GottaGoFast.CurrentTW["Bosses"][i], GottaGoFast.CurrentTW["CurrentValues"][i], GottaGoFast.CurrentTW["FinalValues"][i]);
      if (GottaGoFast.CurrentTW["ObjectiveTimes"][i]) then
        -- Completed Objective
        objectiveString = objectiveString .. GottaGoFast.ObjectiveCompletedString(GottaGoFast.CurrentTW["ObjectiveTimes"][i]);
      end
      objectiveString = objectiveString .. "\n";
    end
    GottaGoFastObjectiveFrame.font:SetText(objectiveString);
    GottaGoFast.ResizeFrame();
  end
end

function GottaGoFast.TWFinalParse()
  if (GottaGoFast.CurrentTW) then
    for i = 1, GottaGoFast.CurrentTW["Steps"] do
      GottaGoFast.CurrentTW["CurrentValues"][i] = GottaGoFast.CurrentTW["FinalValues"][i];
      if (not GottaGoFast.CurrentTW["ObjectiveTimes"][i]) then
        GottaGoFast.CurrentTW["ObjectiveTimes"][i] = GottaGoFast.ObjectiveCompleteString(GottaGoFast.CurrentTW["Time"]);
      end
    end
  end
end

function GottaGoFast.CompleteTW()
  if (GottaGoFast.CurrentTW) then
    GottaGoFast.CurrentTW["Completed"] = true;
    GottaGoFast.TWFinalParse();
  end
end

function GottaGoFast.WipeTW()
  if (GottaGoFast.CurrentTW) then
    GottaGoFast.CurrentTW = table.wipe(GottaGoFast.CurrentTW);
  end
end

function GottaGoFast.StartTW()
  if (GottaGoFast.CurrentTW) then
    GottaGoFast.CurrentTW["StartTime"] = GetTime();
  end
end
