------------------------------------------------------------
-- DisableBlizzard.lua
--
-- Abin
-- 2012/1/03
------------------------------------------------------------

local _G = _G
local RegisterStateDriver = RegisterStateDriver
local SetCVar = SetCVar

local _, addon = ...
local L = addon.L

local function DisableBlizzardFrame(frame)
	if not frame then
		return
	end

	frame:UnregisterAllEvents()
	frame:SetScript("OnEvent", nil)
	frame:SetScript("OnUpdate", nil)
	frame:SetScript("OnSizeChanged", nil)
	frame:EnableMouse(false)
	frame:EnableKeyboard(false)
	frame:Hide()
	frame:SetAlpha(0)
	frame:SetScale(0.01)
	RegisterStateDriver(frame, "visibility", "hide")
end

DisableBlizzardFrame(CompactRaidFrameManager)
DisableBlizzardFrame(CompactRaidFrameContainer)
DisableBlizzardFrame(CompactUnitFrameProfilesGeneralOptionsFrame)
DisableBlizzardFrame(CompactUnitFrameProfilesRaidStylePartyFrames)
DisableBlizzardFrame(CompactUnitFrameProfilesProfileSelector)
DisableBlizzardFrame(CompactUnitFrameProfilesSaveButton)
DisableBlizzardFrame(CompactUnitFrameProfilesDeleteButton)

CompactUnitFrameProfiles:UnregisterAllEvents()
CompactUnitFrameProfiles:SetScript("OnEvent", nil)
UIParent:UnregisterEvent("RAID_ROSTER_UPDATE")

-- Display some infomation so the user won't get confused when he sees a blank page
local prompt = CompactUnitFrameProfiles:CreateFontString(nil, "ARTWORK", "GameFontNormal")
prompt:SetText(L["over ride prompt"])
prompt:SetPoint("TOP", 0, -120)

local button = CreateFrame("Button", "CompactRaidOverrideButton", CompactUnitFrameProfiles, "UIPanelButtonTemplate")
button:SetSize(120, 24)
button:SetPoint("TOP", prompt, "BOTTOM", 0, -16)
button:SetText(SETTINGS)

button:RegisterEvent("VARIABLES_LOADED")
button:SetScript("OnEvent", function(self)
	self:UnregisterAllEvents()
	SetCVar("useCompactPartyFrames", "0")
end)

button:SetScript("OnClick", function(self)
	addon.optionFrame:Show()
end)

--[[
addon:RegisterOptionCallback("showParty", function(value)
	local i
	for i = 1, 4 do
		local frame = _G["PartyMemberFrame"..i]
		if value then
			RegisterStateDriver(frame, "visibility", "hide")
			frame:SetAlpha(0)
			frame:SetScale(0.01)
		else
			local frame = _G["PartyMemberFrame"..i]
			RegisterStateDriver(frame, "visibility", "[nogroup] hide; [group:raid] hide; [@party"..i..",exists] show; hide")
			frame:SetAlpha(1)
			frame:SetScale(1)
		end
	end
end)
--]]