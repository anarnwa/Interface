function GottaGoFast.StringToTime(time)
  time = GottaGoFast.Utility.TrimStr(time);
  time = GottaGoFast.Utility.ExplodeStr(":", time);
  if (time[1] ~= nil and time[2] ~= nil) then
    local mins = tonumber(time[1]);
    local secs = tonumber(time[2]);
    time = (mins * 60) + secs;
    time = GetTime() - time;
  else
    time = -1;
  end
  return time;
end

function GottaGoFast.SecondsToTime(seconds)
  local min = math.floor(seconds/60);
  local sec = seconds - (min * 60);
  return min, sec;
end

function GottaGoFast.FormatTimeNoMS(time)
  if (time < 10) then
    time = string.format("0%d", time);
  else
    time = string.format("%d", time);
  end
  return time;
end

function GottaGoFast.FormatTimeMS(time)
  if (time < 10) then
    time = string.format("0%.3f", time);
  else
    time = string.format("%.3f", time);
  end
  return time;
end

function GottaGoFast.SecsToTimeMS(secs)
  local startMin, startSec = GottaGoFast.SecondsToTime(secs);
  startMin = GottaGoFast.FormatTimeNoMS(startMin);
  startSec = GottaGoFast.FormatTimeMS(startSec);
  return startMin .. ":" .. startSec;
end

function GottaGoFast.CalculateRunTime(startTime, endTime, deaths, corrupt)
  local time = endTime - startTime;
  if (corrupt == false) then
    time = time + (deaths * 5);
  end
  return time;
end

function GottaGoFast.RGBToHex(r, g, b, a)
	r = math.ceil(255 * r)
	g = math.ceil(255 * g)
	b = math.ceil(255 * b)
	if a == nil then
		return string.format("ff%02x%02x%02x", r, g, b)
	else
		a = math.ceil(255 * a)
		return string.format("%02x%02x%02x%02x", a, r, g, b)
	end
end

function GottaGoFast.HexToRGB(hex)
	if string.len(hex) == 8 then
		return tonumber("0x"..hex:sub(1,2)) / 255, tonumber("0x"..hex:sub(3,4)) / 255, tonumber("0x"..hex:sub(5,6)) / 255, tonumber("0x"..hex:sub(7,8)) / 255
	else
		return tonumber("0x"..hex:sub(1,2)) / 255, tonumber("0x"..hex:sub(3,4)) / 255, tonumber("0x"..hex:sub(5,6)) / 255
	end
end

function GottaGoFast.ObjectiveString(boss, curValue, finalValue)
  return string.format("|c%s%s - %d/%d|r", GottaGoFast.db.profile.ObjectiveColor, boss, curValue, finalValue);
end

function GottaGoFast.ObjectiveEnemyString(boss, curValue, finalValue)
  local percent = (curValue / finalValue) * 100;
  if (GottaGoFast.GetMobPoints(nil)) then
    return string.format("|c%s%s - %.1f%% (%d/%d)|r", GottaGoFast.db.profile.ObjectiveColor, boss, percent, curValue, finalValue);
  else
    return string.format("|c%s%s - %.1f%%|r", GottaGoFast.db.profile.ObjectiveColor, boss, percent);
  end

end


function GottaGoFast.ObjectiveCompleteString(time)
  return string.format("%s", time);
end

function GottaGoFast.ObjectiveExtraString(value, color)
  return string.format("|c%s%s|r", color, value);
end

function GottaGoFast.ObjectiveCompletedString(time)
  return string.format("|c%s - |r|c%s%s|r", GottaGoFast.db.profile.ObjectiveColor, GottaGoFast.db.profile.ObjectiveCompleteColor, time);
end

function GottaGoFast.ColorTimer(time)
  return string.format("|c%s%s|r", GottaGoFast.db.profile.TimerColor, time);
end

function GottaGoFast.IncreaseColorString(value)
  return string.format("|c%s%s|r", GottaGoFast.db.profile.IncreaseColor, value);
end

function GottaGoFast.HideObjectiveTracker()
  ObjectiveTrackerFrame:SetParent(GottaGoFastHideFrame);
end

function GottaGoFast.ShowObjectiveTracker()
  ObjectiveTrackerFrame:SetParent(UIParent);
  if (GottaGoFast.db.profile.ObjectiveCollapsed == true) then
    ObjectiveTracker_Collapse();
  end
end

function GottaGoFast.ToggleDemoMode()
  if (GottaGoFast.inCM == false and GottaGoFast.inTW == false) then
    -- Demo Mode Goes Here
    if (GottaGoFast.demoMode == false) then
      GottaGoFast.SetupFakeCM();
      GottaGoFast.UpdateCMTimer();
      GottaGoFast.UpdateCMObjectives();
      GottaGoFastFrame:SetScript("OnUpdate", GottaGoFast.UpdateCM);
      GottaGoFast.ShowFrames();
      GottaGoFast.demoMode = true;
    else
      GottaGoFast.ResetState();
      GottaGoFast.demoMode = false;
    end
  end
end
