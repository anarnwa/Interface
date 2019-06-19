local constants = GottaGoFast.Constants;

function GottaGoFast.GetUnlocked(info)
  return GottaGoFast.unlocked;
end

function GottaGoFast.SetUnlocked(info, value)
  GottaGoFast.unlocked = value;
  GottaGoFastFrame:SetMovable(GottaGoFast.unlocked);
  GottaGoFastFrame:EnableMouse(GottaGoFast.unlocked);
end

function GottaGoFast.GetGoldTimer(info)
  return GottaGoFast.db.profile.GoldTimer;
end

function GottaGoFast.SetGoldTimer(info, value)
  GottaGoFast.db.profile.GoldTimer = value;
  GottaGoFast.UpdateCMTimer();
  GottaGoFast.UpdateCMObjectives();
end

function GottaGoFast.GetTimerType(info)
  return GottaGoFast.db.profile.TimerType;
end

function GottaGoFast.SetTimerType(info, value)
  GottaGoFast.db.profile.TimerType = value;
  GottaGoFast.UpdateCMTimer();
end

function GottaGoFast.GetTrueTimer()
  local timerType = GottaGoFast.GetTimerType(nil);
  if (timerType == "TrueTimerMS" or timerType == "TrueTimerNoMS") then
    return true;
  else
    return false;
  end
end

function GottaGoFast.GetTimerX(info)
  return GottaGoFast.db.profile.TimerX;
end

function GottaGoFast.SetTimerX(info, value)
  GottaGoFast.db.profile.TimerX = value;
  GottaGoFastTimerFrame:ClearAllPoints();
  GottaGoFastTimerFrame:SetPoint("TOP", GottaGoFast.db.profile.TimerX, GottaGoFast.db.profile.TimerY);
end

function GottaGoFast.GetTimerY(info)
  return GottaGoFast.db.profile.TimerY;
end

function GottaGoFast.SetTimerY(info, value)
  GottaGoFast.db.profile.TimerY = value;
  GottaGoFastTimerFrame:ClearAllPoints();
  GottaGoFastTimerFrame:SetPoint("TOP", GottaGoFast.db.profile.TimerX, GottaGoFast.db.profile.TimerY);
end

function GottaGoFast.GetTimerFont(info)
  return GottaGoFast.db.profile.TimerFont;
end

function GottaGoFast.SetTimerFont(info, value)
  GottaGoFast.db.profile.TimerFont = value;
  GottaGoFastTimerFrame.font:SetFont(GottaGoFast.LSM:Fetch("font", GottaGoFast.db.profile.TimerFont), GottaGoFast.db.profile.TimerFontSize, GottaGoFast.db.profile.TimerFontFlag);
end

function GottaGoFast.GetObjectiveFont(info)
  return GottaGoFast.db.profile.ObjectiveFont;
end

function GottaGoFast.SetObjectiveFont(info, value)
  GottaGoFast.db.profile.ObjectiveFont = value;
  GottaGoFastObjectiveFrame.font:SetFont(GottaGoFast.LSM:Fetch("font", GottaGoFast.db.profile.ObjectiveFont), GottaGoFast.db.profile.ObjectiveFontSize, GottaGoFast.db.profile.ObjectiveFontFlag);
end

function GottaGoFast.GetTimerFontSize(info)
  return GottaGoFast.db.profile.TimerFontSize;
end

function GottaGoFast.SetTimerFontSize(info, value)
  GottaGoFast.db.profile.TimerFontSize = value;
  GottaGoFastTimerFrame.font:SetFont(GottaGoFast.LSM:Fetch("font", GottaGoFast.db.profile.TimerFont), GottaGoFast.db.profile.TimerFontSize, GottaGoFast.db.profile.TimerFontFlag);
end

function GottaGoFast.GetTimerAlign(info)
  return GottaGoFast.db.profile.TimerAlign;
end

function GottaGoFast.SetTimerAlign(info, value)
  GottaGoFast.db.profile.TimerAlign = value;
  GottaGoFastTimerFrame.font:SetJustifyH(GottaGoFast.db.profile.TimerAlign);
  GottaGoFast.UpdateCMTimer();
end

function GottaGoFast.GetObjectiveX(info)
  return GottaGoFast.db.profile.ObjectiveX;
end

function GottaGoFast.SetObjectiveX(info, value)
  GottaGoFast.db.profile.ObjectiveX = value;
  GottaGoFastObjectiveFrame:ClearAllPoints();
  GottaGoFastObjectiveFrame:SetPoint("TOP", GottaGoFast.db.profile.ObjectiveX, GottaGoFast.db.profile.ObjectiveY);
end

function GottaGoFast.GetObjectiveY(info)
  return GottaGoFast.db.profile.ObjectiveY;
end

function GottaGoFast.SetObjectiveY(info, value)
  GottaGoFast.db.profile.ObjectiveY = value;
  GottaGoFastObjectiveFrame:ClearAllPoints();
  GottaGoFastObjectiveFrame:SetPoint("TOP", GottaGoFast.db.profile.ObjectiveX, GottaGoFast.db.profile.ObjectiveY);
end

function GottaGoFast.GetObjectiveFontSize(info)
  return GottaGoFast.db.profile.ObjectiveFontSize;
end

function GottaGoFast.SetObjectiveFontSize(info, value)
  GottaGoFast.db.profile.ObjectiveFontSize = value;
  GottaGoFastObjectiveFrame.font:SetFont(GottaGoFast.LSM:Fetch("font", GottaGoFast.db.profile.ObjectiveFont), GottaGoFast.db.profile.ObjectiveFontSize, GottaGoFast.db.profile.ObjectiveFontFlag);
end

function GottaGoFast.GetObjectiveAlign(info)
  return GottaGoFast.db.profile.ObjectiveAlign;
end

function GottaGoFast.SetObjectiveAlign(info, value)
  GottaGoFast.db.profile.ObjectiveAlign = value;
  GottaGoFastObjectiveFrame.font:SetJustifyH(GottaGoFast.db.profile.ObjectiveAlign);
  GottaGoFast.UpdateCMObjectives();
end

function GottaGoFast.GetObjectiveCollapsed(info)
  return GottaGoFast.db.profile.ObjectiveCollapsed;
end

function GottaGoFast.SetObjectiveCollapsed(info, value)
  GottaGoFast.db.profile.ObjectiveCollapsed = value;
end

function GottaGoFast.GetTimerColor(info)
  local a, r, g, b = GottaGoFast.HexToRGB(GottaGoFast.db.profile.TimerColor);
  return r, g, b, a;
end

function GottaGoFast.SetTimerColor(info, r, g, b, a)
  GottaGoFast.db.profile.TimerColor = GottaGoFast.RGBToHex(r, g, b, a);
  GottaGoFast.UpdateCMTimer();
end

function GottaGoFast.GetObjectiveColor(info)
  local a, r, g, b = GottaGoFast.HexToRGB(GottaGoFast.db.profile.ObjectiveColor);
  return r, g, b, a;
end

function GottaGoFast.SetObjectiveColor(info, r, g, b, a)
  GottaGoFast.db.profile.ObjectiveColor = GottaGoFast.RGBToHex(r, g, b, a);
  GottaGoFast.UpdateCMObjectives();
end

function GottaGoFast.GetObjectiveCompleteColor(info)
  local a, r, g, b = GottaGoFast.HexToRGB(GottaGoFast.db.profile.ObjectiveCompleteColor);
  return r, g, b, a;
end

function GottaGoFast.SetObjectiveCompleteColor(info, r, g, b, a)
  GottaGoFast.db.profile.ObjectiveCompleteColor = GottaGoFast.RGBToHex(r, g, b, a);
  GottaGoFast.UpdateCMObjectives();
end

function GottaGoFast.GetIncreaseColor(info)
  local a, r, g, b = GottaGoFast.HexToRGB(GottaGoFast.db.profile.IncreaseColor);
  return r, g, b, a;
end

function GottaGoFast.SetIncreaseColor(info, r, g, b, a)
  GottaGoFast.db.profile.IncreaseColor = GottaGoFast.RGBToHex(r, g, b, a);
  GottaGoFast.UpdateCMObjectives();
end

function GottaGoFast.GetAffixesColor(info)
  local a, r, g, b = GottaGoFast.HexToRGB(GottaGoFast.db.profile.AffixesColor);
  return r, g, b, a;
end

function GottaGoFast.SetAffixesColor(info, r, g, b, a)
  GottaGoFast.db.profile.AffixesColor = GottaGoFast.RGBToHex(r, g, b, a);
  GottaGoFast.UpdateCMObjectives();
end

function GottaGoFast.GetLevelColor(info)
  local a, r, g, b = GottaGoFast.HexToRGB(GottaGoFast.db.profile.LevelColor);
  return r, g, b, a;
end

function GottaGoFast.SetLevelColor(info, r, g, b, a)
  GottaGoFast.db.profile.LevelColor = GottaGoFast.RGBToHex(r, g, b, a);
  GottaGoFast.UpdateCMObjectives();
end

function GottaGoFast.GetDeathColor(info)
  local a, r, g, b = GottaGoFast.HexToRGB(GottaGoFast.db.profile.DeathColor);
  return r, g, b, a;
end

function GottaGoFast.SetDeathColor(info, r, g, b, a)
  GottaGoFast.db.profile.DeathColor = GottaGoFast.RGBToHex(r, g, b, a);
  GottaGoFast.UpdateCMObjectives();
end

function GottaGoFast.GetLevelInTimer(info)
  return GottaGoFast.db.profile.LevelInTimer;
end

function GottaGoFast.SetLevelInTimer(info, value)
  GottaGoFast.db.profile.LevelInTimer = value;
  GottaGoFast.UpdateCMTimer();
end

function GottaGoFast.GetLevelInObjectives(info)
  return GottaGoFast.db.profile.LevelInObjectives;
end

function GottaGoFast.SetLevelInObjectives(info, value)
  GottaGoFast.db.profile.LevelInObjectives = value;
  GottaGoFast.UpdateCMObjectives();
end

function GottaGoFast.GetAffixesInObjectives(info)
  return GottaGoFast.db.profile.AffixesInObjectives;
end

function GottaGoFast.SetAffixesInObjectives(info, value)
  GottaGoFast.db.profile.AffixesInObjectives = value;
  GottaGoFast.UpdateCMObjectives();
end

function GottaGoFast.GetIncreaseInObjectives(info)
  return GottaGoFast.db.profile.IncreaseInObjectives;
end

function GottaGoFast.SetIncreaseInObjectives(info, value)
  GottaGoFast.db.profile.IncreaseInObjectives = value;
  GottaGoFast.UpdateCMObjectives();
end

function GottaGoFast.GetObjectiveCompleteInObjectives(info)
  return GottaGoFast.db.profile.ObjectiveCompleteInObjectives;
end

function GottaGoFast.SetObjectiveCompleteInObjectives(info, value)
  GottaGoFast.db.profile.ObjectiveCompleteInObjectives = value;
  GottaGoFast.UpdateCMObjectives();
end

function GottaGoFast.GetDeathInObjectives(info)
  return GottaGoFast.db.profile.DeathInObjectives;
end

function GottaGoFast.SetDeathInObjectives(info, value)
  GottaGoFast.db.profile.DeathInObjectives = value;
  GottaGoFast.UpdateCMObjectives();
end

function GottaGoFast.GetMobPoints(info)
  return GottaGoFast.db.profile.MobPoints;
end

function GottaGoFast.SetMobPoints(info, value)
  GottaGoFast.db.profile.MobPoints = value;
  GottaGoFast.UpdateCMObjectives();
end

function GottaGoFast.GetIndividualMobValue(info)
  return GottaGoFast.db.profile.IndividualMobValue;
end

function GottaGoFast.SetIndividualMobValue(info, value)
  GottaGoFast.db.profile.IndividualMobValue = value;
end

function GottaGoFast.GetUseMdt(info)
  return GottaGoFast.db.profile.UseMdt;
end

function GottaGoFast.SetUseMdt(info, value)
  GottaGoFast.db.profile.UseMdt = value;
end

function GottaGoFast.GetTimerFontFlag(info)
  return GottaGoFast.db.profile.TimerFontFlag;
end

function GottaGoFast.SetTimerFontFlag(info, value)
  GottaGoFast.db.profile.TimerFontFlag = value;
  GottaGoFastTimerFrame.font:SetFont(GottaGoFast.LSM:Fetch("font", GottaGoFast.db.profile.TimerFont), GottaGoFast.db.profile.TimerFontSize, GottaGoFast.db.profile.TimerFontFlag);
end

function GottaGoFast.GetObjectiveFontFlag(info)
  return GottaGoFast.db.profile.ObjectiveFontFlag;
end

function GottaGoFast.SetObjectiveFontFlag(info, value)
  GottaGoFast.db.profile.ObjectiveFontFlag = value;
  GottaGoFastObjectiveFrame.font:SetFont(GottaGoFast.LSM:Fetch("font", GottaGoFast.db.profile.ObjectiveFont), GottaGoFast.db.profile.ObjectiveFontSize, GottaGoFast.db.profile.ObjectiveFontFlag);
end

function GottaGoFast.GetDebugMode(info)
  return GottaGoFast.db.profile.DebugMode;
end

function GottaGoFast.SetDebugMode(info, value)
  GottaGoFast.db.profile.DebugMode = value;
  GottaGoFast:Print("Debug Mode = " .. tostring(value));
end

function GottaGoFast.GetVersion(info)
  return GottaGoFast.db.profile.Version;
end

function GottaGoFast.SetVersion(info, value)
  GottaGoFast.db.profile.Version = value;
end

function GottaGoFast.GetTimerTooltip(info)
  return GottaGoFast.db.profile.TimerTooltip;
end

function GottaGoFast.SetTimerTooltip(info, value)
  GottaGoFast.db.profile.TimerTooltip = value;
  if (value) then
    GottaGoFastTimerFrame:SetScript("OnEnter", GottaGoFast.TooltipOnEnter);
    GottaGoFastTimerFrame:SetScript("OnLeave", GottaGoFast.TooltipOnLeave);
  else
    GottaGoFastTimerFrame:SetScript("OnEnter", nil);
    GottaGoFastTimerFrame:SetScript("OnLeave", nil);
  end
end

function GottaGoFast.GetAutoDialog(info)
  return GottaGoFast.db.profile.AutoDialog;
end

function GottaGoFast.SetAutoDialog(info, value)
  GottaGoFast.db.profile.AutoDialog = value;
end

function GottaGoFast.GetSpyHelper(info)
  return GottaGoFast.db.profile.SpyHelper;
end

function GottaGoFast.SetSpyHelper(info, value)
  GottaGoFast.db.profile.SpyHelper = value;
end

function GottaGoFast.GetBestReport(info)
  return GottaGoFast.db.profile.BestReport;
end

function GottaGoFast.SetBestReport(info, value)
  GottaGoFast.db.profile.BestReport = value;
end

function GottaGoFast.History()
  local data = {["msg"] = "OpenHistory"};
  local dataString = GottaGoFast:Serialize(data);
  GottaGoFast:SendCommMessage(constants.HistoryPrefix, dataString, "WHISPER", GetUnitName("player"), "ALERT")
end
