local ggf = GottaGoFast;
local utility = ggf.Utility;

function GottaGoFast.InitState()
  -- Default AddOn Globals
  GottaGoFast.inTW = false;
  GottaGoFast.inCM = false;
  GottaGoFast.minWidth = 200;
  GottaGoFast.unlocked = false;
  GottaGoFast.defaultTooltip = "Not In A CM";
  GottaGoFast.tooltip = GottaGoFast.defaultTooltip;
  GottaGoFast.demoMode = false;
end

function GottaGoFast.TooltipOnEnter(self)
  GameTooltip:SetOwner(self, "ANCHOR_CURSOR");
  GameTooltip:SetText(GottaGoFast.tooltip, nil, nil, nil, nil, 1);
end

function GottaGoFast.TooltipOnLeave(self)
  GameTooltip_Hide();
end

function GottaGoFast.InitFrame()
  -- Register Textures
  GottaGoFastFrame.texture = GottaGoFastFrame:CreateTexture(nil,"BACKGROUND");
  GottaGoFastTimerFrame.texture = GottaGoFastTimerFrame:CreateTexture(nil, "BACKGROUND");
  GottaGoFastObjectiveFrame.texture = GottaGoFastObjectiveFrame:CreateTexture(nil, "BACKGROUND");

  -- Register Fonts
  GottaGoFastTimerFrame.font = GottaGoFastTimerFrame:CreateFontString(nil, "OVERLAY");
  GottaGoFastObjectiveFrame.font = GottaGoFastObjectiveFrame:CreateFontString(nil, "OVERLAY");

  -- Move Frame When Unlocked
  GottaGoFastFrame:SetScript("OnMouseDown", function(self, button)
    if GottaGoFast.unlocked and button == "LeftButton" and not self.isMoving then
     self:StartMoving();
     self.isMoving = true;
    end
  end);

  GottaGoFastFrame:SetScript("OnMouseUp", function(self, button)
    if button == "LeftButton" and self.isMoving then
     self:StopMovingOrSizing();
     self.isMoving = false;
     local point, relativeTo, relativePoint, xOffset, yOffset = GottaGoFastFrame:GetPoint(1);

     GottaGoFast.db.profile.FrameAnchor = point;
     GottaGoFast.db.profile.FrameX = xOffset;
     GottaGoFast.db.profile.FrameY = yOffset;
    end
  end);

  GottaGoFastFrame:SetScript("OnHide", function(self)
    if ( self.isMoving ) then
     self:StopMovingOrSizing();
     self.isMoving = false;
    end
  end);

  -- Set Frame Width / Height
  GottaGoFastFrame:SetHeight(340);
  GottaGoFastFrame:SetWidth(GottaGoFast.minWidth);
  GottaGoFastFrame:SetPoint(GottaGoFast.db.profile.FrameAnchor, GottaGoFast.db.profile.FrameX, GottaGoFast.db.profile.FrameY);
  GottaGoFastFrame:SetMovable(GottaGoFast.unlocked);
  GottaGoFastFrame:EnableMouse(GottaGoFast.unlocked);
  GottaGoFastTimerFrame:SetHeight(40);
  GottaGoFastTimerFrame:SetWidth(GottaGoFast.minWidth);
  GottaGoFastTimerFrame:SetPoint("TOP", GottaGoFast.db.profile.TimerX, GottaGoFast.db.profile.TimerY);
  GottaGoFastObjectiveFrame:SetHeight(300);
  GottaGoFastObjectiveFrame:SetWidth(GottaGoFast.minWidth);
  GottaGoFastObjectiveFrame:SetPoint("TOP", GottaGoFast.db.profile.ObjectiveX, GottaGoFast.db.profile.ObjectiveY);

  -- Set Font Settings
  GottaGoFastTimerFrame.font:SetAllPoints(true);
  GottaGoFastTimerFrame.font:SetJustifyH(GottaGoFast.db.profile.TimerAlign);
  GottaGoFastTimerFrame.font:SetJustifyV("BOTTOM");
  GottaGoFastTimerFrame.font:SetFont(GottaGoFast.LSM:Fetch("font", GottaGoFast.db.profile.TimerFont), GottaGoFast.db.profile.TimerFontSize, GottaGoFast.db.profile.TimerFontFlag);
  GottaGoFastTimerFrame.font:SetTextColor(1, 1, 1, 1);

  GottaGoFastObjectiveFrame.font:SetAllPoints(true);
  GottaGoFastObjectiveFrame.font:SetJustifyH(GottaGoFast.db.profile.ObjectiveAlign);
  GottaGoFastObjectiveFrame.font:SetJustifyV("TOP");
  GottaGoFastObjectiveFrame.font:SetFont(GottaGoFast.LSM:Fetch("font", GottaGoFast.db.profile.ObjectiveFont), GottaGoFast.db.profile.ObjectiveFontSize, GottaGoFast.db.profile.ObjectiveFontFlag);
  GottaGoFastObjectiveFrame.font:SetTextColor(1, 1, 1, 1);

  -- Remove Frame Background
  GottaGoFastFrame.texture:SetAllPoints(GottaGoFastFrame);
  GottaGoFastFrame.texture:SetTexture(0.5, 0.5, 0.5, 0);
  GottaGoFastTimerFrame.texture:SetAllPoints(GottaGoFastTimerFrame);
  GottaGoFastTimerFrame.texture:SetTexture(0, 1, 0, 0);
  GottaGoFastObjectiveFrame.texture:SetAllPoints(GottaGoFastObjectiveFrame);
  GottaGoFastObjectiveFrame.texture:SetTexture(0, 1, 0, 0);

  -- Create Tooltip
  if (GottaGoFast.GetTimerTooltip(nil)) then
    GottaGoFastTimerFrame:SetScript("OnEnter", GottaGoFast.TooltipOnEnter);
    GottaGoFastTimerFrame:SetScript("OnLeave", GottaGoFast.TooltipOnLeave);
  end
end
