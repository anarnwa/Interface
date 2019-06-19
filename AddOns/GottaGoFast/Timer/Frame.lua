function GottaGoFast.ResizeFrame()
  local width;
  local minWidth = GottaGoFast.minWidth;
  local timerWidth = GottaGoFastTimerFrame.font:GetStringWidth();
  local objectiveWidth = GottaGoFastObjectiveFrame.font:GetStringWidth();
  if (minWidth >= timerWidth and minWidth >= objectiveWidth) then
    -- minWidth
    width = minWidth;
  elseif (timerWidth >= minWidth and timerWidth >= objectiveWidth) then
    -- Timer Width
    width = timerWidth;
  else
    -- Objective Width
    width = objectiveWidth
  end
  GottaGoFastObjectiveFrame:SetWidth(width);
  GottaGoFastTimerFrame:SetWidth(width);
  GottaGoFastFrame:SetWidth(width);
end

function GottaGoFast.ShowFrames()
  if (GottaGoFastFrame:IsShown() == false) then
    GottaGoFastFrame:Show();
  end
  if (GottaGoFastTimerFrame:IsShown() == false) then
    GottaGoFastTimerFrame:Show();
  end
  if (GottaGoFastObjectiveFrame:IsShown() == false) then
    GottaGoFastObjectiveFrame:Show();
  end
end

function GottaGoFast.HideFrames()
  if (GottaGoFastFrame:IsShown()) then
    GottaGoFastFrame:Hide();
  end
  if (GottaGoFastTimerFrame:IsShown()) then
    GottaGoFastTimerFrame:Hide();
  end
  if (GottaGoFastObjectiveFrame:IsShown()) then
    GottaGoFastObjectiveFrame:Hide();
  end
end
