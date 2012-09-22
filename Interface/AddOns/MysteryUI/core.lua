--MysteryUI核心设置

local _G = _G  --解决头像在换类似天赋，符文的时候出现暴雪禁用插件的情况。

--[[ 选项 ]]
local SellGreyCrap = true           -- 是否自动出售灰色物品.
local HideHotKeys = true            -- 是否隐藏快捷键和宏在技能栏里的文本
local HideShapeShift = true         -- 是否隐藏姿态栏
local HideClock = false             -- 是否隐藏暴雪时钟
local checkthrown = false           -- 是否检毒药
local MoveWatchFrame = true         -- 是否移动任务追踪框体

--[[ 添加命令 ]]
SlashCmdList["FRAME"] = function() print(GetMouseFocus():GetName()) end
SLASH_FRAME1 = "/frame"--输入此命令检查鼠标位置框体的名称

SlashCmdList["GETPARENT"] = function() print(GetMouseFocus():GetParent():GetName()) end
SLASH_GETPARENT1 = "/gp"
SLASH_GETPARENT2 = "/parent"--输入次命令用来检查鼠标位置框体的父框的名称

SlashCmdList["RELOADUI"] = function() ReloadUI() end
SLASH_RELOADUI1 = "/rl"--重载命令

SlashCmdList["RCSLASH"] = function() DoReadyCheck() end
SLASH_RCSLASH1 = "/rc"--就位确认

SlashCmdList["TICKET"] = function() ToggleHelpFrame() end
SLASH_TICKET1 = "/gm"--找GM的命令

--[[ 隐藏姿态栏 ]]
if (HideShapeShift == true) then
StanceBarFrame:Hide()
end

--[[ 隐藏快捷键和宏在技能栏里的文本 ]]
if (HideHotKeys == true) then
local format = string.format;
local match = string.match;
local upper = strupper;
local _G = getfenv(0);
local f = {"ActionButton%d", "MultiBarBottomLeftButton%d", "MultiBarBottomRightButton%d", "MultiBarRightButton%d",
			"MultiBarLeftButton%d"}           
do
	for k, v in pairs(f) do
		for i = 1, 12 do
			local str = format(v, i);
			_G[str.."HotKey"].Show = function() end;
			_G[str.."Name"].Show = function() end;
			_G[str.."Name"]:Hide();
		end
	end
end
end


--[[ 自动出售垃圾 ]]
local function OnEvent()
	for bag=0,4 do
		for slot=0,GetContainerNumSlots(bag) do
			local link = GetContainerItemLink(bag, slot)
			if link and select(3, GetItemInfo(link)) == 0 then
				ShowMerchantSellCursor(1)
				UseContainerItem(bag, slot)
			end
		end
	end
end

local f = CreateFrame("Frame")
f:RegisterEvent("MERCHANT_SHOW")
f:SetScript("OnEvent", OnEvent)

if MerchantFrame:IsVisible() then OnEvent() end

--[[ 修理 - 变量是可以改变的，只要你想 ]]--
local 	iRepair_Chatter 	= true
local 	iRepair_GRF		= true
local 	iRepair_ROGR		= false

--[[ AUTO REPAIR SERVICES ]]--
local iRepair = CreateFrame("Frame", "iRepair")
	iRepair:RegisterEvent("MERCHANT_SHOW")
	iRepair:SetScript("OnEvent", function()
	local cost = GetRepairAllCost()
	local function iRepair_Guild()
		if iRepair_Chatter then
			print(" 公會銀行自動修理修理: ".. GetCoinTextureString(cost) )
		end
		RepairAllItems(1)
	end
	local function iRepair_Self()
		if iRepair_Chatter then
			print(" 你支付的修理費用: ".. GetCoinTextureString(cost) )
		end
		RepairAllItems()
	end
	if IsModifierKeyDown() then
		return
	elseif CanMerchantRepair() and cost ~= 0 then
		if iRepair_GRF and CanGuildBankRepair() and cost <= GetGuildBankMoney() and (cost <= GetGuildBankWithdrawMoney() or GetGuildBankWithdrawMoney() == -1) then
			if iRepair_ROGR and GetNumRaidMembers() ~= 0 then
				iRepair_Guild()
			elseif not iRepair_ROGR then
				iRepair_Guild()
			elseif cost <= GetMoney() then
				iRepair_Self()
			else
				print(" 公會沒有足夠的資金修理，請嘗試手動.")
			end
		elseif cost <= GetMoney() then
			iRepair_Self()
		else
			print(" 你沒有足夠的資金修理。你需要 "..GetCoinTextureString(cost).." 修理費." )
		end
	end
end)


--[[ 隐藏暴雪时钟]]
if (HideClock == true) then
local name, addon = ...
local event1, event2 = "ADDON_LOADED", "PLAYER_ENTERING_WORLD"
local frame = CreateFrame("Frame")
frame:RegisterEvent(event1)
frame:RegisterEvent(event2)
frame:SetScript("OnEvent", function(self, event, arg1)

	if((event == event2 and name == arg1) or (event==event1)) then
		self:UnregisterEvent(event)
		LoadAddOn("Blizzard_TimeManager")
		TimeManagerClockButton:SetScript("OnUpdate", nil)
		TimeManagerClockButton:SetScript("OnEvent", nil)
		TimeManagerClockButton:SetScript("OnShow", function(self) 
			self:Hide()
		end)
		TimeManagerClockButton:Hide()
		if(event == event1) then
			self:RegisterEvent(event)
		end
	end
end)
end
---------------------------
--[[移动任务追踪框体]]
---------------------------
if (MoveWatchFrame == true) then
  local pos = { a1 = "RIGHT", a2 = "RIGHT", af = "UIParent", x = -100, y = -70  }
  local watchframeheight = 450

  --提示图标功能
  local function QWFM_Tooltip(self)
    GameTooltip:SetOwner(self, "ANCHOR_TOP")
    GameTooltip:AddLine("拖动!", 0, 1, 0.5, 1, 1, 1)
    GameTooltip:Show()
  end

  --让任务追踪框体可以移动
  local wf = WatchFrame
  wf:SetClampedToScreen(true)
  wf:SetMovable(true)
  wf:SetUserPlaced(true)
  wf:ClearAllPoints()
  wf.ClearAllPoints = function() end
  wf:SetPoint(pos.a1,pos.af,pos.a2,pos.x,pos.y)
  wf.SetPoint = function() end
  wf:SetHeight(watchframeheight)

  local wfh = WatchFrameHeader
  wfh:EnableMouse(true)
  wfh:RegisterForDrag("LeftButton")
  wfh:SetHitRectInsets(-15, -15, -5, -5)
  wfh:SetScript("OnDragStart", function(s)
    local f = s:GetParent()
    f:StartMoving()
  end)
  wfh:SetScript("OnDragStop", function(s)
    local f = s:GetParent()
    f:StopMovingOrSizing()
  end)
  wfh:SetScript("OnEnter", function(s)
    QWFM_Tooltip(s)
  end)
  wfh:SetScript("OnLeave", function(s)
    GameTooltip:Hide()
  end)
end
 
--[[ 盗贼毒药检查 ]]
if(select(2,UnitClass("player")) ~= "ROGUE" or UnitLevel("player") < 20) then return end
local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_ENTERING_WORLD") 
f:RegisterEvent("UPDATE_STEALTH") 
f:RegisterEvent("PLAYER_LEAVE_COMBAT") 
f:SetScript("OnEvent", function()
	local main, _, _, off, _, _, thrown = GetWeaponEnchantInfo()
	if not UnitInVehicle("player") and(not main or not off or(not thrown and checkthrown == true)) then
		--DEFAULT_CHAT_FRAME:AddMessage("##### 沒毒藥了 #####", 1.0,0.96,0.41)  --聊天框提示.
		UIErrorsFrame:AddMessage("##### 沒毒藥了 #####", 1.0, 0.96, 0.41, 1.0);  --屏幕醒目提示.
	end
end)

-------------

local f = CreateFrame("Frame")
f:SetScript("OnEvent", function()
	SetCVar("cameraDistanceMax", 50)
	SetCVar("CameraDistanceMaxFactor", 3.4)
end)
f:RegisterEvent("PLAYER_ENTERING_WORLD")

--离开战斗回收插件内存
local F = CreateFrame("Frame") 
   F:RegisterEvent("PLAYER_REGEN_ENABLED") 
   F:SetScript("OnEvent", function() _G.collectgarbage("collect") end) 
