SLASH_RNO1 = "/rno"
SLASH_RNO2 = "/raiderno"

SlashCmdList["RNO"] = function(msg)
   plist = GetHomePartyInfo();
   if plist then
		local groupprofile = UnitName("player") .. "-" .. GetRealmName()
		for k,v in pairs(plist) do
            vv = v
            if string.find(vv, "-") == nil then
                vv = vv .. "-" .. GetRealmName()
            end
			groupprofile = groupprofile .. '\n' .. vv
		end
		RnoCopyFrame:Show()
		RnoCopyFrameScroll:Show()
		RnoCopyFrameScrollText:Show()
		RnoCopyFrameScrollText:SetText(groupprofile)
		RnoCopyFrameScrollText:HighlightText()
		RnoCopyFrameScrollText:SetScript("OnEscapePressed", function(self)
		RnoCopyFrame:Hide()
		end)
	else
		print("当前队伍里没有其他人");
	end
end 

SLASH_RA1 = "/rna"
SLASH_RA2 = "/raidernoapplicants"

function Set (list)
  local set = {}
  for _, l in ipairs(list) do set[l] = true end
  return set
end

SlashCmdList["RA"] = function(msg)
    local entryData = C_LFGList.GetActiveEntryInfo()
    if entryData then
        local applicationsProfile = ""
        local fullName, shortName, categoryID, groupID, itemLevel, filters, minLevel, maxPlayers, displayType, orderIndex, useHonorLevel = C_LFGList.GetActivityInfo(entryData['activityID'])
        local dungeonName = string.gsub(fullName, "（史诗钥石）", "")
        local dungeonNames = Set { 
            "围攻伯拉勒斯",
            "地渊孢林",
            "塞塔里斯神庙",
            "托尔达戈",
            "暴富矿区!!",
            "维克雷斯庄园",
            "自由镇",
            "诸王之眠",
            "阿塔达萨",
            "风暴神殿" 
        }
        if dungeonNames[dungeonName] then
            applicationsProfile = applicationsProfile .. dungeonName .. "\n"
        end

        applicants = C_LFGList.GetApplicants();
        if applicants then
            local isFirst = true
            for k,v in pairs(applicants) do
                applicantInfo = C_LFGList.GetApplicantInfo(v)
                for i=1,applicantInfo['numMembers'],1 do
                    name, class, localizedClass, level, itemLevel, tank, healer, damage, assignedRole = C_LFGList.GetApplicantMemberInfo(applicantInfo['applicantID'], i)
                    print(name)
                    if string.find(name, "-") == nil then
                        name = name .. "-" .. GetRealmName()
                    end
                    if isFirst then
                        isFirst = false
                    else
                        applicationsProfile = applicationsProfile .. '\n'
                    end
                    applicationsProfile = applicationsProfile .. name
                end
            end
            RnoCopyFrame:Show()
            RnoCopyFrameScroll:Show()
            RnoCopyFrameScrollText:Show()
            RnoCopyFrameScrollText:SetText(applicationsProfile)
            RnoCopyFrameScrollText:HighlightText()
            RnoCopyFrameScrollText:SetScript("OnEscapePressed", function(self)
            RnoCopyFrame:Hide()
            end)
        else
            print("当前没有申请者")
        end
    else
        print("未创建活动")
    end
end