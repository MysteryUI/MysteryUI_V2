local BarScale = 0.9

local MenuButtonFrames = {
	CharacterMicroButton,
	SpellbookMicroButton,
	TalentMicroButton,
	AchievementMicroButton,
	QuestLogMicroButton,
	GuildMicroButton,
	PVPMicroButton,
	LFDMicroButton,
	MainMenuMicroButton,
	HelpMicroButton,
	EJMicroButton,
	RaidMicroButton,
}

local BagButtonFrameList = {
	MainMenuBarBackpackButton,
	CharacterBag0Slot,
	CharacterBag1Slot,
	CharacterBag2Slot,
	CharacterBag3Slot,
	KeyRingButton,
}

local ButtonGridIsShown = false
local Empty_Art = "Interface\\Addons\\MysteryUI\\MyMedia\\Empty"
local MouseInSidebar, MouseInCorner = false

local Bar = CreateFrame("Frame", "Bar", WorldFrame)
local CornerMenuFrame = CreateFrame("Frame", "Bar_CornerMenuFrame", UIParent)
local SideMouseoverFrame = CreateFrame("Frame", "Bar_SideBarMouseoverFrame", UIParent)
local CornerMouseoverFrame = CreateFrame("Frame", "Bar_CornerBarMouseoverFrame", UIParent)

local SetSidebarAlpha

CornerMenuFrame:SetFrameStrata("LOW")
CornerMenuFrame:SetWidth(300)
CornerMenuFrame:SetHeight(128)
CornerMenuFrame:SetPoint("BOTTOMRIGHT")
CornerMenuFrame:SetScale(BarScale)

CornerMenuFrame.MicroButtons = CreateFrame("Frame", nil, CornerMenuFrame)
CornerMenuFrame.BagButtonFrame = CreateFrame("Frame", nil, CornerMenuFrame)

-- 事件更新
local DelayedEventWatcher = CreateFrame("Frame")
local DelayedEvents = {}
local function CheckDelayedEvent(self)
	local pendingEvents, currentTime = 0, GetTime()
	for functionToCall, timeToCall in pairs(DelayedEvents) do
		if currentTime > timeToCall then
			DelayedEvents[functionToCall] = nil
			functionToCall()
		end
	end
	-- 检查后放置丢失
	for functionToCall, timeToCall in pairs(DelayedEvents) do pendingEvents = pendingEvents + 1 end
	if pendingEvents == 0 then DelayedEventWatcher:SetScript("OnUpdate", nil) end
end
local function DelayEvent(functionToCall, timeToCall)
	DelayedEvents[functionToCall] = timeToCall
	DelayedEventWatcher:SetScript("OnUpdate", CheckDelayedEvent)
end
-- 事件更新

local function ForceTransparent(frame) 
		frame:Hide()
		frame:SetAlpha(0)
end

local function RefreshMainActionBars()
	local anchor
	local anchorOffset = 2
	local repOffset = 0
	
	if MainMenuExpBar:IsShown() then repOffset = 7 end
	if ReputationWatchBar:IsShown() then repOffset = repOffset + 7 end
		
	if MultiBarBottomLeft:IsShown() then        
		anchor = MultiBarBottomLeft
		anchorOffset = 2
	else
		anchor = ActionButton1;
		anchorOffset = 2
	end    

    if MultiBarBottomRight:IsShown() then
		MultiBarBottomRight:ClearAllPoints()
		MultiBarBottomRight:SetPoint("BOTTOMLEFT", anchor, "TOPLEFT", 0, anchorOffset )
		anchor = MultiBarBottomRight
		anchorOffset = 2
	end

	if ShapeshiftButton1:IsShown() then
		ShapeshiftButton1:ClearAllPoints();
		ShapeshiftButton1:SetPoint("BOTTOMLEFT", anchor, "TOPLEFT", 25, anchorOffset+2);
		anchor = ShapeshiftButton1
		anchorOffset = 2
	end
	
	if MultiCastActionBarFrame:IsShown() then	-- 图腾
		MultiCastActionBarFrame:ClearAllPoints();
		MultiCastActionBarFrame:SetPoint("BOTTOMLEFT", anchor, "TOPLEFT", 25, anchorOffset+2);
		anchor = MultiCastActionBarFrame
		anchorOffset = 2
	end

	PetActionButton1:ClearAllPoints()
	PetActionButton1:SetPoint("BOTTOMLEFT", anchor, "TOPLEFT", 63, anchorOffset+2)
	anchor = PetActionButton1
	anchorOffset = 2

	PossessButton1:ClearAllPoints();
	PossessButton1:SetPoint("BOTTOMLEFT", anchor, "TOPLEFT", 0, anchorOffset);
end

function SetSidebarAlpha()
	local Alpha = 0
	if MouseInSidebar or ButtonGridIsShown then Alpha = 1 end
	if SpellFlyout:IsShown() then 
		DelayEvent(SetSidebarAlpha, GetTime()+.5)
	else
		for i = 1, 12 do
			--_G["MultiBarRightButton"..i]:SetAlpha(Alpha);
			_G["MultiBarLeftButton"..i]:SetAlpha(Alpha);
		end
	end

end

local function HookFrame_Microbuttons(frameTarget)
	frameTarget:HookScript("OnEnter", function() if not UnitHasVehicleUI("player") then CornerMenuFrame:SetAlpha(1) end end)
	frameTarget:HookScript("OnLeave", function() CornerMenuFrame:SetAlpha(0) end)
end

local function HookFrame_CornerBar(frameTarget)
	frameTarget:HookScript("OnEnter", function() CornerMenuFrame:SetAlpha(1) end)
	frameTarget:HookScript("OnLeave", function() CornerMenuFrame:SetAlpha(0) end)
end

local function HookFrame_SideBar(frameTarget)
	frameTarget:HookScript("OnEnter", function() MouseInSidebar = true; SetSidebarAlpha() end)
	frameTarget:HookScript("OnLeave", function() MouseInSidebar = false; SetSidebarAlpha() end)
end

local function ConfigureCornerBars()
	if not UnitHasVehicleUI("player") then 
		CharacterMicroButton:ClearAllPoints();
		CharacterMicroButton:SetPoint("BOTTOMRIGHT", CornerMenuFrame.MicroButtons, "BOTTOMRIGHT", -270, 0);
		for i, name in pairs(MenuButtonFrames) do name:SetParent(CornerMenuFrame.MicroButtons) end
	end
end

local function ConfigureSideBars()
	-- 右侧动作条
	if MultiBarRight:IsShown() then
		SideMouseoverFrame:Show()
		MultiBarRight:EnableMouse();
		SideMouseoverFrame:SetPoint("BOTTOMRIGHT", MultiBarRight, "BOTTOMRIGHT", 0,0)
		-- 右2动作条
		if MultiBarLeft:IsShown() then
			MultiBarLeft:EnableMouse();
			SideMouseoverFrame:SetPoint("TOPLEFT", MultiBarLeft, "TOPLEFT", -6,0)	
		else SideMouseoverFrame:SetPoint("TOPLEFT", MultiBarRight, "TOPLEFT", -6,0) end
	else SideMouseoverFrame:Hide() 	end	
end

local function RefreshPositions()
	if InCombatLockdown() then return end 
	-- 改变中央按钮和状态栏的大小
    MainMenuBar:SetWidth(512);
   	MainMenuExpBar:SetWidth(512);
    ReputationWatchBar:SetWidth(512);
    MainMenuBarMaxLevelBar:SetWidth(512);
    ReputationWatchStatusBar:SetWidth(512);
	
	-- 隐藏背景
	ForceTransparent(SlidingActionBarTexture0)
	ForceTransparent(SlidingActionBarTexture1)
    ForceTransparent(ShapeshiftBarLeft)
    ForceTransparent(ShapeshiftBarMiddle)
    ForceTransparent(ShapeshiftBarRight)
    ForceTransparent(PossessBackground1)
    ForceTransparent(PossessBackground2)

	ConfigureSideBars()
    RefreshMainActionBars()
	ConfigureCornerBars()
end

	
-- 事件处理程序
local events = {}

function events:ACTIONBAR_SHOWGRID() ButtonGridIsShown = true; SetSidebarAlpha() end
function events:ACTIONBAR_HIDEGRID() ButtonGridIsShown = false; SetSidebarAlpha() end
function events:UNIT_EXITED_VEHICLE()  RefreshPositions(); DelayEvent(ConfigureCornerBars, GetTime()+1) end	-- Echos the event to verify positions
events.PLAYER_ENTERING_WORLD = RefreshPositions
events.UPDATE_INSTANCE_INFO = RefreshPositions	
events.PLAYER_TALENT_UPDATE = RefreshPositions
events.PLAYER_LEVEL_UP = RefreshPositions
events.ACTIVE_TALENT_GROUP_CHANGED = RefreshPositions
events.SPELL_UPDATE_USEABLE = RefreshPositions
events.PET_BAR_UPDATE = RefreshPositions
events.UNIT_ENTERED_VEHICLE = RefreshPositions
events.UPDATE_BONUS_ACTIONBAR = RefreshPositions
events.UPDATE_MULTI_CAST_ACTIONBAR = RefreshPositions
events.CLOSE_WORLD_MAP = RefreshPositions
events.PLAYER_LEVEL_UP = RefreshPositions

local function EventHandler(frame, event) 
	if events[event] then 
		--print(GetTime(), event)
		events[event]() 
	end 
end

-- 设置事件监测
for eventname in pairs(events) do 
	Bar:RegisterEvent(eventname)
end

-----------------------------------------------------------------------------
-- 系统菜单以及杂项
do
	-- 默认界面更新变化
	hooksecurefunc("UIParent_ManageFramePositions", RefreshPositions);
	-- 需要移动
	UIPARENT_MANAGED_FRAME_POSITIONS["MultiBarBottomRight"] = nil
	UIPARENT_MANAGED_FRAME_POSITIONS["PetActionBarFrame"] = nil
	UIPARENT_MANAGED_FRAME_POSITIONS["ShapeshiftBarFrame"] = nil
	UIPARENT_MANAGED_FRAME_POSITIONS["PossessBarFrame"] = nil
	UIPARENT_MANAGED_FRAME_POSITIONS["MultiCastActionBarFrame"] = nil
	
	-- 缩放
	MainMenuBar:SetScale(BarScale)
	MultiBarRight:SetScale(BarScale)
	MultiBarLeft:SetScale(BarScale)

	-- 调整填充
	MainMenuBarTexture0:SetPoint("LEFT", MainMenuBar, "LEFT", 0, 0);
    MainMenuBarTexture1:SetPoint("RIGHT", MainMenuBar, "RIGHT", 0, 0);
 	MainMenuBarLeftEndCap:SetPoint("RIGHT", MainMenuBar, "LEFT", 32, 0);
    MainMenuBarRightEndCap:SetPoint("LEFT", MainMenuBar, "RIGHT", -32, 0); 
	

	
	-- 隐藏无用的
	MainMenuBarPageNumber:Hide();
    ActionBarUpButton:Hide();
    ActionBarDownButton:Hide();
	-- 经验条
	MainMenuBarTexture2:SetTexture(Empty_Art)
	MainMenuBarTexture3:SetTexture(Empty_Art)
	MainMenuBarTexture2:SetAlpha(0)
	MainMenuBarTexture3:SetAlpha(0)
	for i=1,19 do _G["MainMenuXPBarDiv"..i]:SetTexture(Empty_Art) end
	
	-- 隐藏休息状态
	ExhaustionLevelFillBar:SetTexture(Empty_Art)
	ExhaustionTick:SetAlpha(0)
	
	-- 最高等级声望条
	MainMenuMaxLevelBar0:SetAlpha(0)
	MainMenuMaxLevelBar1:SetAlpha(0)
	MainMenuMaxLevelBar2:SetAlpha(0)
	MainMenuMaxLevelBar3:SetAlpha(0)
	-- 声望条背景 (对于声望条)
	ReputationWatchBarTexture0:SetAlpha(0)
	ReputationWatchBarTexture1:SetAlpha(0)
	ReputationWatchBarTexture2:SetAlpha(0)
	ReputationWatchBarTexture3:SetAlpha(0)
	-- 声望条背景 (对于经验条)
	ReputationXPBarTexture0:SetAlpha(0)
	ReputationXPBarTexture1:SetAlpha(0)
	ReputationXPBarTexture2:SetAlpha(0)
	ReputationXPBarTexture3:SetAlpha(0)

	-- 设置宠物动作条
	PetActionBarFrame:SetAttribute("unit", "pet")
	RegisterUnitWatch(PetActionBarFrame)

	--实质鼠标悬停
	ConfigureSideBars()
	SetSidebarAlpha()
	ConfigureCornerBars()
	CornerMenuFrame:SetAlpha(0)
	
	MainMenuBar:HookScript("OnShow", function() 
		--print("Showing")
		RefreshPositions() 
	end)
end

-----------------------------------------------------------------------------
-- 侧面动作条
do
	-- 设置
	SideMouseoverFrame:SetScript("OnEnter", function() MouseInSidebar = true; SetSidebarAlpha() end)
	SideMouseoverFrame:SetScript("OnLeave", function() MouseInSidebar = false;SetSidebarAlpha() end)
	SideMouseoverFrame:EnableMouse();
		
	HookFrame_SideBar(MultiBarRight)
	HookFrame_SideBar(MultiBarLeft)
	for i = 1, 12 do HookFrame_SideBar( _G["MultiBarRightButton"..i] ) end
	for i = 1, 12 do HookFrame_SideBar( _G["MultiBarLeftButton"..i] ) end
end


-----------------------------------------------------------------------------
-- 新东西
do

	--for i = 1, 12 do HookFrame_SideBar( _G["MultiBarRightButton"..i] ) end
	
	--[[
		MainMenuBar:SetScale(BarScale)
		MultiBarRight:SetScale(BarScale)
		MultiBarLeft
	--]]
	
	--MainMenuBarTexture0:SetTexture(Empty_art)
	--MainMenuBarTexture1:SetTexture(Empty_art)
	--MainMenuBarLeftEndCap:SetTexture(Empty_art)
	--MainMenuBarRightEndCap:SetTexture(Empty_art)
	
	local function dummy() end
	
	-- [[
	-- /run SetAllButtonShapes()
	function SetAllButtonShapes()
		for i = 1, 12 do 
			local name = "ActionButton"..i
			local bu = _G["ActionButton"..i]
			local ic = _G[name.."Icon"]
			local co  = _G[name.."Count"]
			local bo  = _G[name.."Border"]
			local ho  = _G[name.."HotKey"]
			local cd  = _G[name.."Cooldown"]
			local na  = _G[name.."Name"]
			local fl  = _G[name.."Flash"]
			local nt  = _G[name.."NormalTexture"]
			
			--bu:ClearAllPoints()
			bu:SetHeight(16)

			ic:SetAlpha(.25)
			ic:ClearAllPoints()
			ic:SetHeight(16)
			ic:SetWidth(25)
			ic:SetPoint("TOPLEFT", bu)
			print(ic:GetTexture())
			
			--local OldSetHeight = ic.SetHeight
			local function NewSetHeight(...)
				print(...)
				--return OldSetHeight(...)
			end
			
			--ic.SetHeight = NewSetHeight
			
			--nt:SetAllPoints(bu)
			--ic:SetAllPoints(bu)
			--bo:SetAllPoints(bu)
			
			--disable resetting of textures
			--fl.SetTexture = dummy
			--bu.SetHighlightTexture = dummy
			--bu.SetPushedTexture = dummy
			--bu.SetCheckedTexture = dummy
			--bu.SetNormalTexture = dummy
			
			--bo.SetAllPoints = function() bo:SetAllPoints(bu) end
			--bo.SetPoint = dummy
			--bo.SetHeight = dummy
			--bo.SetWidth = dummy
			--bo.SetSize = dummy

			
		end
		
		print(GetTime(), "Setting Buttons")
	end
	
end

-----------------------------------------------------------------------------
-- 角落菜单
do
	-- 钥匙链等等
	for i, name in pairs(BagButtonFrameList) do
		name:SetParent(CornerMenuFrame.BagButtonFrame)
	end
	
    MainMenuBarBackpackButton:ClearAllPoints();
	MainMenuBarBackpackButton:SetPoint("BOTTOM");
	MainMenuBarBackpackButton:SetPoint("RIGHT", -55, 0);
	--MainMenuBarBackpackButton:SetScale(.8)
	
	-- 设置上下翻查按钮
	for i, name in pairs(BagButtonFrameList) do HookFrame_CornerBar( name) end
	for i, name in pairs(MenuButtonFrames) do HookFrame_Microbuttons( name) end

	-- 两只鸟
	CornerMenuFrame:SetScale(BarScale)
	CornerMenuFrame.MicroButtons:SetAllPoints(CornerMenuFrame)
	CornerMenuFrame.BagButtonFrame:SetPoint("TOPRIGHT", 2, -18)
	CornerMenuFrame.BagButtonFrame:SetHeight(64)
	CornerMenuFrame.BagButtonFrame:SetWidth(256)
	CornerMenuFrame.BagButtonFrame:SetScale(1.02)

	-- 系统菜单鼠标悬停设置
	CornerMouseoverFrame:EnableMouse();
	CornerMouseoverFrame:SetFrameStrata("BACKGROUND")

	CornerMouseoverFrame:SetPoint("TOP", MainMenuBarBackpackButton, "TOP", 0,10)
	CornerMouseoverFrame:SetPoint("RIGHT", UIParent, "RIGHT")
	CornerMouseoverFrame:SetPoint("BOTTOM", UIParent, "BOTTOM")
	CornerMouseoverFrame:SetWidth(322)

	CornerMouseoverFrame:SetScript("OnEnter", function() CornerMenuFrame:SetAlpha(1)   end)
	CornerMouseoverFrame:SetScript("OnLeave", function() CornerMenuFrame:SetAlpha(0)   end)
end

-- 开始菜单
Bar:SetScript("OnEvent", EventHandler);
Bar:SetFrameStrata("TOOLTIP")
Bar:Show()

--[[
local function TestEvent(frame, event, ...)
	if event == "COMBAT_LOG_EVENT_UNFILTERED" or event == "COMBAT_LOG_EVENT" then return end
	print(event, ...)
end
local tester = CreateFrame("Frame", nil, WorldFrame)
tester:SetScript("OnEvent", TestEvent)
tester:RegisterAllEvents()
--]]


