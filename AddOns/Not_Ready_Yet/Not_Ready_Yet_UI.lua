function AddSpellID(x)
    local n = tonumber(x)
    if n then
        -- n就是得到数字
        todo = true
    for k, v in pairs(SpellID[reportcdplayerclass][reportcdplayerspecialization]) do
        if v == n then
            todo = false
            break
        end
    end
    if todo then
        table.insert(SpellID[reportcdplayerclass][reportcdplayerspecialization], n)
    end
        return true
    else
        -- 转数字失败,不是数字, 这时n == nil
        return false
    end
end

local function CreateUIFrames()
    if MainFrame ~= nil then
        MainFrame:Show()
        return
    end
    MainFrame = CreateFrame('Frame', 'reportcd', UIParent, 'PortraitFrameTemplate')
    MainFrame:SetFrameStrata('DIALOG')
    MainFrame:SetWidth(500)
    MainFrame:SetHeight(400)
    MainFrame:SetPoint('CENTER', UIParent)
    MainFrame:SetMovable(true)
    MainFrame:EnableMouse(true)
    MainFrame:RegisterForDrag('LeftButton', 'RightButton')
    MainFrame:SetClampedToScreen(true)
    MainFrame.title = _G['reportcdTitleText']
    MainFrame.title:SetText('Not_Ready_Yet')
    MainFrame:SetScript(
        'OnMouseDown',
        function(self)
            self:StartMoving()
            self.isMoving = true
        end
    )

    MainFrame:SetScript(
        'OnMouseUp',
        function(self)
            if self.isMoving then
                self:StopMovingOrSizing()
                self.isMoving = false
            end
        end
    )

    local icon = MainFrame:CreateTexture('$parentIcon', 'OVERLAY', nil, -8)
    --图标
    icon:SetSize(60, 60)
    icon:SetPoint('TOPLEFT', -5, 7)
    icon:SetTexture('Interface\\FriendsFrame\\Battlenet-Portrait')
    --标题
    Text = MainFrame:CreateFontString('FontString', 'OVERLAY', 'GameFontNormalLarge')
    Text:SetPoint('TOPLEFT', MainFrame, 'TOPLEFT', 20, -25)
    Text:SetWidth(200)
    Text:SetText('Not_Ready_Yet设置')
    --是否开启插件
    Button = CreateFrame('CheckButton', 'reportcdopened', MainFrame, 'UICheckButtonTemplate')
    Button:SetPoint('TOPLEFT', Text, 'BOTTOMLEFT', 30, -10)
    _G[Button:GetName() .. 'Text']:SetText('开启插件')
    _G[Button:GetName() .. 'Text']:SetFontObject('GameFontHighlight')
    Button:SetChecked(Setting.open == true)
    Button:SetScript(
        'OnClick',
        function(self)
            Setting.open = (self:GetChecked() or false)
        end
    )
    --清除所有法术
    Button = CreateFrame('Button', 'reportcdcleanall', MainFrame, 'UIPanelButtonTemplate')
    Button:SetSize(200, 30)
    Button:SetNormalFontObject('GameFontNormalSmall')
    Button:SetText('清除所有法术')
    Button:SetPoint('TOPLEFT', Text, 'BOTTOMLEFT', 200, -10)
    Button:SetScript(
        'OnClick',
        function(self)
            SpellID[reportcdplayerclass][reportcdplayerspecialization]={}
        end
    )
    --添加spellID
    tipText = reportcd:CreateFontString('FontString', 'OVERLAY', 'GameFontNormalLarge')
    tipText:SetPoint('TOPLEFT', MainFrame, 'TOPLEFT', 10, -100)
    tipText:SetWidth(200)
    tipText:SetText('添加法术ID（数字）')
    
    Button = CreateFrame('EditBox', 'reportcdaddspellid', MainFrame, 'InputBoxTemplate')
    Button:SetPoint('TOPLEFT', Text, 'BOTTOMLEFT', 40, -90)
    Button:SetWidth(150)
    Button:SetHeight(20)
    Button:SetAutoFocus(false)
    Button:SetText('')
    Button:SetScript(
        'OnEnterPressed',
        function(self)
            if AddSpellID(self:GetText()) then
                tipText:SetText('添加成功  继续添加法术ID（数字）')
                self:SetText('')
            else
                tipText:SetText('添加失败  重新添加法术ID（数字）')
                self:SetText('')
            end
        end
    )
    Button:SetScript(
        'OnEscapePressed',
        function(self)
            tipText:SetText('添加法术ID（数字）')
        end
    )
    --设置喊话间隔 
    CD = reportcd:CreateFontString('FontString', 'OVERLAY', 'GameFontNormalLarge')
    CD:SetPoint('TOPLEFT', MainFrame, 'TOPLEFT', 10, -170)
    CD:SetWidth(200)
    CD:SetText('设置喊话间隔')
     Button = CreateFrame('EditBox', 'reportcdCD', MainFrame, 'InputBoxTemplate')
     Button:SetPoint('TOPLEFT', Text, 'BOTTOMLEFT', 40, -150)
     Button:SetWidth(150)
     Button:SetHeight(20)
     Button:SetAutoFocus(false)
     Button:SetText(Setting.CD)
     Button:SetScript(
         'OnEnterPressed',
         function(self)
             if tonumber(self:GetText()) then
                Setting.CD=tonumber(self:GetText())
                 self:SetText(Setting.CD)
             else
                 self:SetText(Setting.CD)
             end
         end
     )
     Button:SetScript(
         'OnEscapePressed',
         function(self)
            self:SetText(Setting.CD)
         end
     )
     --最小时间
     Button = CreateFrame('EditBox', 'reportcdminCD', MainFrame, 'InputBoxTemplate')
     Button:SetPoint('TOPLEFT', Text, 'BOTTOMLEFT', 100, -190)
     Button:SetWidth(30)
     Button:SetHeight(20)
     Button:SetAutoFocus(false)
     Button:SetText(Setting.mincd)
     Button:SetScript(
         'OnEnterPressed',
         function(self)
             if tonumber(self:GetText()) then
                Setting.mincd=tonumber(self:GetText())
                 self:SetText(Setting.mincd)
             else
                 self:SetText(Setting.mincd)
             end
         end
     )
     Button:SetScript(
         'OnEscapePressed',
         function(self)
            self:SetText(Setting.mincd)
         end
     )
     minCD1 = reportcd:CreateFontString('FontString', 'OVERLAY', 'GameFontNormalLarge')
     minCD1:SetPoint('TOPLEFT', reportcdminCD, 'TOPLEFT', -150, 0)
     minCD1:SetWidth(200)
     minCD1:SetText('施放法术后')
     minCD2 = reportcd:CreateFontString('FontString', 'OVERLAY', 'GameFontNormalLarge')
     minCD2:SetPoint('TOPLEFT', reportcdminCD, 'TOPLEFT', -30, 0)
     minCD2:SetWidth(200)
     minCD2:SetText('秒内不通报')
     --大时间
     Button = CreateFrame('EditBox', 'reportcdmaxCD', MainFrame, 'InputBoxTemplate')
     Button:SetPoint('TOPLEFT', Text, 'BOTTOMLEFT', 100, -230)
     Button:SetWidth(30)
     Button:SetHeight(20)
     Button:SetAutoFocus(false)
     Button:SetText(Setting.maxcd)
     Button:SetScript(
         'OnEnterPressed',
         function(self)
             if tonumber(self:GetText()) then
                Setting.maxcd=tonumber(self:GetText())
                 self:SetText(Setting.maxcd)
             else
                 self:SetText(Setting.maxcd)
             end
         end
     )
     Button:SetScript(
         'OnEscapePressed',
         function(self)
            self:SetText(Setting.maxcd)
         end
     )
     maxCD1 = reportcd:CreateFontString('FontString', 'OVERLAY', 'GameFontNormalLarge')
     maxCD1:SetPoint('TOPLEFT', reportcdmaxCD, 'TOPLEFT', -150, 0)
     maxCD1:SetWidth(200)
     maxCD1:SetText('法术CD小于')
     maxCD2 = reportcd:CreateFontString('FontString', 'OVERLAY', 'GameFontNormalLarge')
     maxCD2:SetPoint('TOPLEFT', reportcdmaxCD, 'TOPLEFT', -30, 0)
     maxCD2:SetWidth(200)
     maxCD2:SetText('秒时不通报')

     --自定义喊话内容
     Button = CreateFrame('EditBox', 'reportcdreport', MainFrame, 'InputBoxTemplate')
     Button:SetPoint('TOPLEFT', Text, 'BOTTOMLEFT', 10, -300)
     Button:SetWidth(450)
     Button:SetHeight(20)
     Button:SetAutoFocus(false)
     Button:SetText(Setting.report)
     Button:SetScript(
         'OnEnterPressed',
         function(self)
            Setting.report=self:GetText()
         end
     )
     Button:SetScript(
         'OnEscapePressed',
         function(self)
            self:SetText(Setting.report)
         end
     )
     text=reportcd:CreateFontString('FontString', 'OVERLAY', 'GameFontNormalLarge')
     text:SetPoint('TOPLEFT', reportcdreport, 'TOPLEFT', -40, 30)
     text:SetWidth(500)
     text:SetText('自定义通报文字  {SpellName}为技能名  {CD} 为CD')
    --下拉菜单
    CreateFrame('Button', 'reportcddropdownlist', MainFrame, 'UIDropDownMenuTemplate')
    reportcddropdownlist:SetPoint('TOPLEFT', Text, 'BOTTOMLEFT', 200, -85)
    local tempformat = 0
    local function reportcddropdownlist_OnClick(self, arg1, arg2, checked)
        -- Update temp variable
        tempformat = arg1
        -- Update dropdownmenu text
        UIDropDownMenu_SetText(reportcddropdownlist,GetSpellInfo(SpellID[reportcdplayerclass][reportcdplayerspecialization][tempformat]))
    end
    local function reportcddropdownlist_Initialize(self, level)
        local info = UIDropDownMenu_CreateInfo()
        info.func = reportcddropdownlist_OnClick
        for i, v in ipairs(SpellID[reportcdplayerclass][reportcdplayerspecialization]) do
            info.arg1, info.text = i, GetSpellInfo(v)
            UIDropDownMenu_AddButton(info)
        end
    end
    UIDropDownMenu_Initialize(reportcddropdownlist, reportcddropdownlist_Initialize)
    UIDropDownMenu_SetWidth(reportcddropdownlist, 148)
    UIDropDownMenu_SetButtonWidth(reportcddropdownlist, 124)
    UIDropDownMenu_SetText(reportcddropdownlist, '移除法术')
    UIDropDownMenu_JustifyText(reportcddropdownlist, 'LEFT')
    --清除spellid
    Button = CreateFrame('Button', 'reportcdclean', MainFrame, 'UIPanelButtonTemplate')
    Button:SetSize(50, 30)
    Button:SetNormalFontObject('GameFontNormalSmall')
    Button:SetText('清除')
    Button:SetPoint('TOPLEFT', Text, 'BOTTOMLEFT', 400, -85)
    Button:SetScript(
        'OnClick',
        function(self)
            if tempformat ~= 0 then
                table.remove(SpellID[reportcdplayerclass][reportcdplayerspecialization] , tempformat)
                UIDropDownMenu_SetText(reportcddropdownlist, '移除黑名单')
            end
        end
    )
    --显示窗口
    MainFrame:Show()
end

function SlashCmdList.ReportCD(msg)
    CreateUIFrames()
end

SLASH_ReportCD1 = '/NRY'
