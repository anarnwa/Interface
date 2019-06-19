function GottaGoFast.UpdateCMTimer()
  if (GottaGoFast.CurrentCM and next(GottaGoFast.CurrentCM)) then
    if (GottaGoFast.CurrentCM["Completed"] == false) then
      local time = "";
      local startMin, startSec, goldMin, goldSec;
      if (GottaGoFast.CurrentCM["StartTime"] and GottaGoFast.GetTrueTimer()) then
        local currentTime = GetTime();
        local deaths = GottaGoFast.CurrentCM["Deaths"] * 5;
        local secs = currentTime - GottaGoFast.CurrentCM["StartTime"];
        GottaGoFast.CurrentCM["CurrentTime"] = secs;
        secs = secs + deaths;
        if (secs < 0) then
          startMin = "-00";
          if (GottaGoFast.GetTimerType(nil) == "TrueTimerMS") then
            startSec = GottaGoFast.FormatTimeMS(math.abs(secs));
          else
            startSec = GottaGoFast.FormatTimeNoMS(math.abs(secs));
          end
        else
          startMin, startSec = GottaGoFast.SecondsToTime(secs);
          startMin = GottaGoFast.FormatTimeNoMS(startMin);
          if (GottaGoFast.GetTimerType(nil) == "TrueTimerMS") then
            startSec = GottaGoFast.FormatTimeMS(startSec);
          else
            startSec = GottaGoFast.FormatTimeNoMS(startSec);
          end
        end
      else
        _, timeCM = GetWorldElapsedTime(1);
        GottaGoFast.AskForTimer(timeCM);
        startMin, startSec = GottaGoFast.SecondsToTime(timeCM);
        startMin = GottaGoFast.FormatTimeNoMS(startMin);
        startSec = GottaGoFast.FormatTimeNoMS(startSec);
      end
      time = startMin .. ":" .. startSec .. " ";
      GottaGoFast.CurrentCM["Time"] = time;
      goldMin, goldSec = GottaGoFast.SecondsToTime(GottaGoFast.CurrentCM["GoldTimer"]);
      goldMin = GottaGoFast.FormatTimeNoMS(goldMin);
      goldSec = GottaGoFast.FormatTimeNoMS(goldSec);

      if (GottaGoFast.db.profile.GoldTimer) then
        time = time .. "/ " .. goldMin .. ":" .. goldSec;
      end

      if (GottaGoFast.db.profile.LevelInTimer and GottaGoFast.CurrentCM["Level"]) then
        local depleted = "";
        if (GottaGoFast.CurrentCM["Empowered"] == false) then
          depleted = "d";
        end
        time = "[" .. GottaGoFast.CurrentCM["Level"] .. depleted .. "] " .. time;
      end

      -- Update Frame
      GottaGoFastTimerFrame.font:SetText(GottaGoFast.ColorTimer(time));
      GottaGoFast.ResizeFrame();
    end
  end
end

function GottaGoFast.UpdateCMObjectives()
  if (GottaGoFast.CurrentCM and next(GottaGoFast.CurrentCM)) then
    local empowered = GottaGoFast.EmpoweredString();
    local objectiveString = "";
    local affixString = "";
    local increaseString = "";
    local goldMin, goldSec;
    local curCM = GottaGoFast.CurrentCM;
    if (GottaGoFast.db.profile.IncreaseInObjectives and next(GottaGoFast.CurrentCM["IncreaseTimers"])) then
      for k, v in pairs(GottaGoFast.CurrentCM["IncreaseTimers"]) do
        if (k ~= 1 or GottaGoFast.db.profile.GoldTimer == false) then
          goldMin, goldSec = GottaGoFast.SecondsToTime(v);
          goldMin = GottaGoFast.FormatTimeNoMS(goldMin);
          goldSec = GottaGoFast.FormatTimeNoMS(goldSec);
          increaseString = increaseString .. "+" .. k .. " = " .. goldMin .. ":" .. goldSec .. " / ";
        end
      end
      objectiveString = objectiveString .. GottaGoFast.IncreaseColorString(GottaGoFast.Utility.ShortenStr(increaseString, 3) .. "\n");
    end
    if (GottaGoFast.db.profile.LevelInObjectives and GottaGoFast.CurrentCM["Level"]) then
      objectiveString = objectiveString .. GottaGoFast.ObjectiveExtraString("Level " .. GottaGoFast.CurrentCM["Level"] .. " - (+" .. GottaGoFast.CurrentCM["Bonus"] .. "%) - " .. empowered .. "\n", GottaGoFast.db.profile.LevelColor);
    end
    if (GottaGoFast.db.profile.AffixesInObjectives and next(GottaGoFast.CurrentCM["Affixes"])) then
      for k, v in pairs(GottaGoFast.CurrentCM["Affixes"]) do
        affixString = affixString .. v["name"] .. " - ";
      end
      objectiveString = objectiveString .. GottaGoFast.ObjectiveExtraString(GottaGoFast.Utility.ShortenStr(affixString, 3) .. "\n", GottaGoFast.db.profile.AffixesColor);
    end
    if (GottaGoFast.GetDeathInObjectives(nil) and GottaGoFast.CurrentCM["Deaths"]) then
      local deathString = "";
      local deathMin, deathSec = GottaGoFast.SecondsToTime((GottaGoFast.CurrentCM["Deaths"] * 5));
      deathMin = GottaGoFast.FormatTimeNoMS(deathMin);
      deathSec = GottaGoFast.FormatTimeNoMS(deathSec);
      if (GottaGoFast.CurrentCM["StartTime"] ~= nil) then
        deathString = "Deaths: " .. curCM["Deaths"] .. " - Time Lost: " .. deathMin .. ":" .. deathSec;
      else
        deathString = "Deaths: " .. curCM["Deaths"] .. "* - Time Lost: " .. deathMin .. ":" .. deathSec;
      end
      deathString = deathString .. "\n";
      objectiveString = objectiveString .. GottaGoFast.ObjectiveExtraString(deathString, GottaGoFast.db.profile.DeathColor);
    end
    for i = 1, GottaGoFast.CurrentCM["Steps"] do
      if (i == GottaGoFast.CurrentCM["Steps"]) then
        -- Last Step Should Be Enemies
        objectiveString = objectiveString .. GottaGoFast.ObjectiveEnemyString(GottaGoFast.CurrentCM["Bosses"][i], GottaGoFast.CurrentCM["CurrentValues"][i], GottaGoFast.CurrentCM["FinalValues"][i]);
      else
        objectiveString = objectiveString .. GottaGoFast.ObjectiveString(GottaGoFast.CurrentCM["Bosses"][i], GottaGoFast.CurrentCM["CurrentValues"][i], GottaGoFast.CurrentCM["FinalValues"][i]);
      end
      if (GottaGoFast.db.profile.ObjectiveCompleteInObjectives and GottaGoFast.CurrentCM["ObjectiveTimes"][i]) then
        -- Completed Objective
        objectiveString = objectiveString .. GottaGoFast.ObjectiveCompletedString(GottaGoFast.CurrentCM["ObjectiveTimes"][i]);
      end
      objectiveString = objectiveString .. "\n";
    end
    GottaGoFastObjectiveFrame.font:SetText(objectiveString);
    GottaGoFast.ResizeFrame();
  end
end
