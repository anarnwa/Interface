function GottaGoFastHistory:GetHistory()
  return GottaGoFastHistory.db.profile.History;
end

function GottaGoFastHistory:SetHistory(val)
  GottaGoFastHistory.db.profile.History = val;
end

function GottaGoFastHistory:GetDayFix()
  return GottaGoFastHistory.db.profile.DayFix;
end

function GottaGoFastHistory:SetDayFix(val)
  GottaGoFastHistory.db.profile.DayFix = val;
end