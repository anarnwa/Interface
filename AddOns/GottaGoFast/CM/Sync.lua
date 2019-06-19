local ggf = GottaGoFast;
local constants = ggf.Constants;
local utility = ggf.Utility;

function GottaGoFast.AskForTimer(timeCM)
  if (GottaGoFast.CurrentCM["StartTime"] == nil and timeCM > 1 and GottaGoFast.CurrentCM["AskedForTimer"] == false) then
    GottaGoFast.Utility.DebugPrint("Asking For Timer");
    GottaGoFast.CurrentCM["AskedTime"] = GetTime();
    GottaGoFast.CurrentCM["AskedForTimer"] = true;
    GottaGoFast:SendCommMessage("GottaGoFastCM", "FixCM", "PARTY", nil, "ALERT");
  end
end

function GottaGoFast.CheckCMTimer()
  if (GottaGoFast.CurrentCM and next(GottaGoFast.CurrentCM) ~= nil and GottaGoFast.CurrentCM["StartTime"] ~= nil and GottaGoFast.CurrentCM["Steps"] ~= 0 and GottaGoFast.CurrentCM["CurrentTime"] ~= nil) then
    local CurrentCMString = GottaGoFast:Serialize(GottaGoFast.CurrentCM);
    GottaGoFast.Utility.DebugPrint("CM Timer Sent");
    GottaGoFast:SendCommMessage("GottaGoFastCM", CurrentCMString, "PARTY", nil, "ALERT");
  end
end

function GottaGoFast.FixCMTimer(input)
  if (GottaGoFast.inCM == true and GottaGoFast.CurrentCM and next(GottaGoFast.CurrentCM) ~= nil) then
    if (GottaGoFast.CurrentCM["StartTime"] == nil and GottaGoFast.CurrentCM["AskedTime"] ~= nil) then
      GottaGoFast.Utility.DebugPrint("Replacing CM Timer");
      local status, newCM = GottaGoFast:Deserialize(input);
      if (status and newCM and newCM["CurrentTime"] and newCM["Version"] ~= nil and newCM["Version"] >= constants.Version) then
        newCM["StartTime"] = GottaGoFast.CurrentCM["AskedTime"] - newCM["CurrentTime"];
        GottaGoFast.CurrentCM = newCM;
        -- Update Timer
        GottaGoFast.UpdateCMTimer();
        GottaGoFast.UpdateCMObjectives();
      end
    end
  end
end

function GottaGoFast.CreateDungeon(name, zoneID, objectives)
  local data = {};
  data["name"] = name;
  data["zoneID"] = zoneID;
  data["objectives"] = objectives;
  data["msg"] = "CreateDungeon";
  local dataString = GottaGoFast:Serialize(data);
  GottaGoFast:SendCommMessage(constants.HistoryPrefix, dataString, "WHISPER", GetUnitName("player"), "ALERT");
end

function GottaGoFast.CreateRun(data)
  -- Why was this called twice?
  data["msg"] = "CreateRun";
  local dataString = GottaGoFast:Serialize(data);
  GottaGoFast:SendCommMessage(constants.HistoryPrefix, dataString, "WHISPER", GetUnitName("player"), "ALERT");
end

function GottaGoFast.SendHistory(data)
  if (data ~= nil and next(data) ~= nil) then
    data["msg"] = "InitHistory";
    local dataString = GottaGoFast:Serialize(data);
    utility.DebugPrint("Sending History For Sync");
    GottaGoFast:SendCommMessage(constants.HistoryPrefix, dataString, "WHISPER", GetUnitName("player"), "ALERT")
    utility.DebugPrint("Clearing History");
    ggf.db.profile.History = {};
  end
end

function GottaGoFast.AskForBestRun(zoneID, level, affixes)
  local data = {};
  data["msg"] = "AskForBestRun";
  data["zoneID"] = zoneID;
  data["level"] = level;
  data["affixes"] = affixes;
  local dataString = GottaGoFast:Serialize(data);
  utility.DebugPrint("Asking For Best Run");
  GottaGoFast:SendCommMessage(constants.HistoryPrefix, dataString, "WHISPER", GetUnitName("player"), "ALERT");
end
