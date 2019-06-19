function GottaGoFastHistory:InitOptions()
  local defaults = {
    profile = {
      History = {},
      DayFix = false,
    },
  }
  GottaGoFastHistory.db = LibStub("AceDB-3.0"):New("GottaGoFastHistoryDB", defaults, true);
end

function GottaGoFastHistory:DayFix()
  local history = GottaGoFastHistory:GetHistory();

  for dungeonKey, dungeon in pairs(history) do
      local runs = dungeon["runs"];

      for runKey, run in pairs(runs) do
          if (GottaGoFastHistory:RunHasBadTimeStamp(run)) then
              -- Perhaps Run Model Should Own This?
              GottaGoFastHistory.db.profile.History[dungeonKey].runs[runKey]["timeStamp"]["day"] = 32;
          end
      end
  end
end

function GottaGoFastHistory:BugFixes()
  -- Day Fix
  if (not GottaGoFastHistory:GetDayFix()) then
    GottaGoFastHistory:DayFix();

    GottaGoFastHistory:SetDayFix(true);
  end
end