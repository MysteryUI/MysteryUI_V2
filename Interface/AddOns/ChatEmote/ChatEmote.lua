local _, ns = ...
local CurEB = "ChatFrame1EditBox"

local Config = {
	iconSize = 24,
	enableEmoteInput = true,
	enableBubbleEmote = true,
}

local customEmoteStartIndex = 9

local emotes = {
	{"{rt1}",	[=[Interface\TargetingFrame\UI-RaidTargetingIcon_1]=]},
	{"{rt2}",	[=[Interface\TargetingFrame\UI-RaidTargetingIcon_2]=]},
	{"{rt3}",	[=[Interface\TargetingFrame\UI-RaidTargetingIcon_3]=]},
	{"{rt4}",	[=[Interface\TargetingFrame\UI-RaidTargetingIcon_4]=]},
	{"{rt5}",	[=[Interface\TargetingFrame\UI-RaidTargetingIcon_5]=]},
	{"{rt6}",	[=[Interface\TargetingFrame\UI-RaidTargetingIcon_6]=]},
	{"{rt7}",	[=[Interface\TargetingFrame\UI-RaidTargetingIcon_7]=]},
	{"{rt8}",	[=[Interface\TargetingFrame\UI-RaidTargetingIcon_8]=]},
	{"{天使}",	[=[Interface\Addons\ChatEmote\icon\Angel]=]},
	{"{生气}",	[=[Interface\Addons\ChatEmote\icon\Angry]=]},

	{"{大笑}",	[=[Interface\Addons\ChatEmote\icon\Biglaugh]=]},
	{"{鼓掌}",	[=[Interface\Addons\ChatEmote\icon\Clap]=]},
	{"{酷}",	[=[Interface\Addons\ChatEmote\icon\Cool]=]},
	{"{哭}",	[=[Interface\Addons\ChatEmote\icon\Cry]=]},
	{"{可爱}",	[=[Interface\Addons\ChatEmote\icon\Cutie]=]},
	{"{鄙视}",	[=[Interface\Addons\ChatEmote\icon\Despise]=]},
	{"{美梦}",	[=[Interface\Addons\ChatEmote\icon\Dreamsmile]=]},
	{"{尴尬}",	[=[Interface\Addons\ChatEmote\icon\Embarrass]=]},
	{"{邪恶}",	[=[Interface\Addons\ChatEmote\icon\Evil]=]},
	{"{兴奋}",	[=[Interface\Addons\ChatEmote\icon\Excited]=]},

	{"{晕}",	[=[Interface\Addons\ChatEmote\icon\Faint]=]},
	{"{打架}",	[=[Interface\Addons\ChatEmote\icon\Fight]=]},
	{"{流感}",	[=[Interface\Addons\ChatEmote\icon\Flu]=]},
	{"{呆}",	[=[Interface\Addons\ChatEmote\icon\Freeze]=]},
	{"{皱眉}",	[=[Interface\Addons\ChatEmote\icon\Frown]=]},
	{"{致敬}",	[=[Interface\Addons\ChatEmote\icon\Greet]=]},
	{"{鬼脸}",	[=[Interface\Addons\ChatEmote\icon\Grimace]=]},
	{"{龇牙}",	[=[Interface\Addons\ChatEmote\icon\Growl]=]},
	{"{开心}",	[=[Interface\Addons\ChatEmote\icon\Happy]=]},
	{"{心}",	[=[Interface\Addons\ChatEmote\icon\Heart]=]},

	{"{恐惧}",	[=[Interface\Addons\ChatEmote\icon\Horror]=]},
	{"{生病}",	[=[Interface\Addons\ChatEmote\icon\Ill]=]},
	{"{无辜}",	[=[Interface\Addons\ChatEmote\icon\Innocent]=]},
	{"{功夫}",	[=[Interface\Addons\ChatEmote\icon\Kongfu]=]},
	{"{花痴}",	[=[Interface\Addons\ChatEmote\icon\Love]=]},
	{"{邮件}",	[=[Interface\Addons\ChatEmote\icon\Mail]=]},
	{"{化妆}",	[=[Interface\Addons\ChatEmote\icon\Makeup]=]},
	{"{马里奥}",	[=[Interface\Addons\ChatEmote\icon\Mario]=]},
	{"{沉思}",	[=[Interface\Addons\ChatEmote\icon\Meditate]=]},
	{"{可怜}",	[=[Interface\Addons\ChatEmote\icon\Miserable]=]},

	{"{好}",	[=[Interface\Addons\ChatEmote\icon\Okay]=]},
	{"{漂亮}",	[=[Interface\Addons\ChatEmote\icon\Pretty]=]},
	{"{吐}",	[=[Interface\Addons\ChatEmote\icon\Puke]=]},
	{"{握手}",	[=[Interface\Addons\ChatEmote\icon\Shake]=]},
	{"{喊}",	[=[Interface\Addons\ChatEmote\icon\Shout]=]},
	{"{闭嘴}",	[=[Interface\Addons\ChatEmote\icon\Shuuuu]=]},
	{"{害羞}",	[=[Interface\Addons\ChatEmote\icon\Shy]=]},
	{"{睡觉}",	[=[Interface\Addons\ChatEmote\icon\Sleep]=]},
	{"{微笑}",	[=[Interface\Addons\ChatEmote\icon\Smile]=]},
	{"{吃惊}",	[=[Interface\Addons\ChatEmote\icon\Suprise]=]},

	{"{失败}",	[=[Interface\Addons\ChatEmote\icon\Surrender]=]},
	{"{流汗}",	[=[Interface\Addons\ChatEmote\icon\Sweat]=]},
	{"{流泪}",	[=[Interface\Addons\ChatEmote\icon\Tear]=]},
	{"{悲剧}",	[=[Interface\Addons\ChatEmote\icon\Tears]=]},
	{"{想}",	[=[Interface\Addons\ChatEmote\icon\Think]=]},
	{"{偷笑}",	[=[Interface\Addons\ChatEmote\icon\Titter]=]},
	{"{猥琐}",	[=[Interface\Addons\ChatEmote\icon\Ugly]=]},
	{"{胜利}",	[=[Interface\Addons\ChatEmote\icon\Victory]=]},
	{"{雷锋}",	[=[Interface\Addons\ChatEmote\icon\Volunteer]=]},
	{"{委屈}",	[=[Interface\Addons\ChatEmote\icon\Wronged]=]},
}

local fmtstring = format("\124T%%s:%d\124t",max(floor(select(2,SELECTED_CHAT_FRAME:GetFont())),Config.iconSize))

local function myChatFilter(self, event, msg, ...)
	for i = customEmoteStartIndex, #emotes do
		if msg:find(emotes[i][1]) then
			msg = msg:gsub(emotes[i][1],format(fmtstring,emotes[i][2]),1)
			break
		end
	end
	return false, msg, ...
end

local ShowEmoteTableButton
local EmoteTableFrame

function EmoteIconMouseUp(frame, button)
	if (button == "LeftButton") then
		local ChatFrameEditBox = ChatEdit_ChooseBoxForSend()
		if (not ChatFrameEditBox:IsShown()) then
			ChatEdit_ActivateChat(ChatFrameEditBox)
		end
		ChatFrameEditBox:Insert(frame.text)
	end
	ToggleEmoteTable()
end

function CreateEmoteTableFrame()
	EmoteTableFrame = CreateFrame("Frame", "EmoteTableFrame", UIParent)

	EmoteTableFrame:SetBackdrop({
		bgFile = "Interface\\Buttons\\WHITE8x8", 
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", 
		tile = true, tileSize = 16, edgeSize = 16, 
		insets = { left = 3, right = 3, top = 3, bottom = 3 }
	})
	EmoteTableFrame:SetBackdropColor(0.05, 0.05, 0.05)
	EmoteTableFrame:SetBackdropBorderColor(0.3, 0.3, 0.3)
	EmoteTableFrame:SetWidth((Config.iconSize+2) * 12+10)
	EmoteTableFrame:SetHeight((Config.iconSize+2) * 5+10)
	EmoteTableFrame:SetPoint("BOTTOM", ChatFrame1EditBox, 0, 30)
	EmoteTableFrame:Hide()
	EmoteTableFrame:SetFrameStrata("DIALOG")

	local icon, row, col
	row = 1
	col = 1
	for i=1,#emotes do 
		text = emotes[i][1]
		texture = emotes[i][2]
		icon = CreateFrame("Frame", format("IconButton%d",i), EmoteTableFrame)
		icon:SetWidth(Config.iconSize)
		icon:SetHeight(Config.iconSize)
		icon.text = text
		icon.texture = icon:CreateTexture(nil,"ARTWORK")
		icon.texture:SetTexture(texture)
		icon.texture:SetAllPoints(icon)
		icon:Show()
		icon:SetPoint("TOPLEFT", 5+(col-1)*(Config.iconSize+2), -5-(row-1)*(Config.iconSize+2))
		icon:SetScript("OnMouseUp", EmoteIconMouseUp)
		icon:EnableMouse(true)
		col = col + 1 
		if (col>12) then
			row = row + 1
			col = 1
		end
	end
end

function ToggleEmoteTable()
	if (not EmoteTableFrame) then CreateEmoteTableFrame() end
	if (EmoteTableFrame:IsShown()) then
		EmoteTableFrame:Hide()
	else
		EmoteTableFrame:Show()
	end

end

function EmoteTable_Button_OnUpdate(self)
	local CheckEB = "";
	local ShowButton = false;
	if (not EmoteTableFrame) then CreateEmoteTableFrame() end
	for i = 1, NUM_CHAT_WINDOWS do
		CheckEB = format("%s%d%s", "ChatFrame", i, "EditBox");
		if _G[CheckEB]:GetAlpha() ==1 and _G[CheckEB]:IsShown() then
			CurEB = CheckEB;
			ShowButton = true;
		end
	end
	if ShowButton then
		EmoteTable_Button:Show();
	else
		EmoteTable_Button:Hide();
		EmoteTableFrame:Hide();
	end
end

function ChatEmoteButtons()
	local cf = _G["ChatFrame1"]
	local button = CreateFrame("Button", format("ShowEmoteTableButton"), UIParent)
	local bg = button:CreateTexture(nil, "BACKGROUND")
	bg:SetTexture("Interface\\Buttons\\WHITE8x8")
	bg:SetAllPoints(button)
	bg:SetVertexColor(0.05, 0.05, 0.05)
	button:SetPoint("BOTTOMRIGHT", ChatFrame1 , 0, 0)
	button:SetHeight(20)
	button:SetWidth(20)
	button:SetAlpha(0)
	--TukuiDB.SetTemplate(button)

	local buttontext = button:CreateFontString(nil,"OVERLAY",nil)
	buttontext:SetFont("fonts\\ARIALN.TTF",12,"OUTLINE")
	buttontext:SetText("M")
	buttontext:SetPoint("CENTER")
	buttontext:SetJustifyH("CENTER")
	buttontext:SetJustifyV("CENTER")

	button:SetScript("OnMouseUp", function(self, btn)
		ToggleEmoteTable()
	end)
	button:SetScript("OnEnter", function() 
		button:SetAlpha(1) 
	end)
	button:SetScript("OnLeave", function() button:SetAlpha(0) end)
	button:Show()
	ShowEmoteTableButton = button
end

local MaxBubbleWidth = 250

function HandleBubbleEmote(frame, fontstring)
	if not frame:IsShown() then 
		fontstring.cachedText = nil
		return 
	end

	MaxBubbleWidth = math.max(frame:GetWidth(), MaxBubbleWidth)

	local text = fontstring:GetText() or ""

	if text == fontstring.cachedText then return end

	frame:SetBackdropBorderColor(fontstring:GetTextColor())
	--fontstring:SetFont(ChatFrame1:GetFont(),select(2,ChatFrame1:GetFont()))
	local term;
	for tag in string.gmatch(text, "%b{}") do
		term = strlower(string.gsub(tag, "[{}]", ""));
		if ( ICON_TAG_LIST[term] and ICON_LIST[ICON_TAG_LIST[term]] ) then
			text = string.gsub(text, tag, ICON_LIST[ICON_TAG_LIST[term]] .. "0|t");
		end
	end  

	for i = customEmoteStartIndex, #emotes do
		if text:find(emotes[i][1]) then
			text = text:gsub(emotes[i][1],format(fmtstring,emotes[i][2]),1)
			break
		end
	end
	fontstring:SetText(text)    
	fontstring.cachedText = text  
	fontstring:SetWidth(math.min(fontstring:GetStringWidth(), MaxBubbleWidth - 14))
end

function CheckBubbles()
	for i=1,WorldFrame:GetNumChildren() do
		local v = select(i, WorldFrame:GetChildren())
		local b = v:GetBackdrop()
		if b and b.bgFile == "Interface\\Tooltips\\ChatBubble-Background" then
			for i=1,v:GetNumRegions() do
				local frame = v
				local v = select(i, v:GetRegions())
				if v:GetObjectType() == "FontString" then
					HandleBubbleEmote(frame, v)
				end
			end
		end
	end
end

ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL", myChatFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_SAY", myChatFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_YELL", myChatFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER", myChatFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_BN_WHISPER", myChatFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER_INFORM", myChatFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID", myChatFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_LEADER", myChatFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY", myChatFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY_LEADER", myChatFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_GUILD", myChatFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_BATTLEGROUND", myChatFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_AFK", myChatFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_DND", myChatFilter)

if (Config.enableEmoteInput) then
	CreateEmoteTableFrame()
end



if (Config.enableBubbleEmote) then
	local BubbleScanInterval = 0.15
	AddonFrame = CreateFrame("Frame")
	AddonFrame.interval = BubbleScanInterval
	AddonFrame:SetScript("OnUpdate", 
	function(frame, elapsed) 
		frame.interval = frame.interval - elapsed
		if frame.interval < 0 then
			frame.interval = BubbleScanInterval
			CheckBubbles()
		end
	end) 
end

