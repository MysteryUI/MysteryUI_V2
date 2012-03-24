-- By Aprikot - http://aprikot.wowinterface.com
-- Based upon functions within nMainbar by Neal, and thek: Buttonskin by thek

-- 配置
local tr, tg, tb, ta = 1, 1, 1, 1 -- 顶部颜色
local br, bg, bb, ba = .1, .1, .1, 1 -- 底部颜色
local auraborder = false -- make & color aura borders

-- 功能
hooksecurefunc("ActionButton_Update", function(self)
if self:GetName():match("ExtraActionButton") then return end
	local bu = _G[self:GetName()]
	local ic = _G[self:GetName().."Icon"]
	local bo = _G[self:GetName().."NormalTexture"]
	bu:SetNormalTexture("Interface\\BUTTONS\\UI-Quickslot2")
	ic:SetTexCoord(.05, .95, .05, .95);
	ic:SetPoint("TOPLEFT", bu, 0, 0);
	ic:SetPoint("BOTTOMRIGHT", bu, 0, 0);
	bo:ClearAllPoints()
	bo:SetPoint("TOPLEFT", bu, -14, 14)
	bo:SetPoint("BOTTOMRIGHT", bu, 14, -14)
	bo:SetGradientAlpha("VERTICAL", br, bg, bb, ba, tr, tg, tb, ta)
end);

hooksecurefunc("ActionButton_UpdateUsable", function(self)
if self:GetName():match("ExtraActionButton") then return end
	(_G[self:GetName().."NormalTexture"]):SetGradientAlpha("VERTICAL", br, bg, bb, ba, tr, tg, tb, ta)
end);

hooksecurefunc("ActionButton_ShowGrid", function(self)
if self:GetName():match("ExtraActionButton") then return end
	(_G[self:GetName().."NormalTexture"]):SetGradientAlpha("VERTICAL", br, bg, bb, ba, tr, tg, tb, ta)
end);

hooksecurefunc("PetActionBar_Update",  function()
	for i, v in pairs({"PetActionButton", "ShapeshiftButton", "PossessButton"}) do
		for i = 1, 12 do
			local bu = _G[v..i]
			if bu then
				bu:SetNormalTexture("Interface\\BUTTONS\\UI-Quickslot2")
				local ic = _G[v..i.."Icon"];
				ic:SetTexCoord(.05, .95, .05, .95);
				ic:SetPoint("TOPLEFT", bu, -1, 1);
				ic:SetPoint("BOTTOMRIGHT", bu, 1, -1);
				local bo = _G[v..i.."NormalTexture2"] or _G[v..i.."NormalTexture"]
				bo:ClearAllPoints()
				bo:SetPoint("TOPLEFT", bu, -15, 15)
				bo:SetPoint("BOTTOMRIGHT", bu, 15, -15)
				bo:SetGradientAlpha("VERTICAL", br, bg, bb, ba, tr, tg, tb, ta)
				end
			end
		end
	end);

hooksecurefunc("AuraButton_Update", function(self, index)
	if auraborder then
		local bu = _G[self..index]
		local ic = _G[self..index.."Icon"]
		local bo = _G[self..index.."Border"]
		if ic then 
			ic:SetTexCoord(.07, .93, .07, .93);
		end
		if bo then
			bo:SetTexture("Interface\\BUTTONS\\UI-Quickslot2")
			bo:ClearAllPoints()
			bo:SetPoint("TOPLEFT", bu, -12, 12)
			bo:SetPoint("BOTTOMRIGHT", bu, 12, -12)
			bo:SetTexCoord(0, 1, 0, 1)
			bo:SetGradientAlpha("VERTICAL", br, bg, bb, ba, tr, tg, tb, ta)
		end
		if bu and not bo then 
			nbo = bu:CreateTexture("$parentOverlay", "ARTWORK")
			nbo:SetParent(bu)
			nbo:SetTexture("Interface\\BUTTONS\\UI-Quickslot2")
			nbo:SetPoint("TOPLEFT", bu, -12, 12)
			nbo:SetPoint("BOTTOMRIGHT", bu, 12, -12)
			nbo:SetGradientAlpha("VERTICAL", br, bg, bb, ba, tr, tg, tb, ta)
		end
	end
end);

for i = 1, 3 do
	local bu = _G["TempEnchant"..i]
	local ic = _G["TempEnchant"..i.."Icon"]
	ic:SetTexCoord(.07, .93, .07, .93);
	local bo = _G["TempEnchant"..i.."Border"]
	bo:SetTexture("Interface\\BUTTONS\\UI-Quickslot2")
	bo:ClearAllPoints()
	bo:SetPoint("TOPLEFT", bu, -12, 12)
	bo:SetPoint("BOTTOMRIGHT", bu, 12, -12)
	bo:SetTexCoord(0, 1, 0, 1)
	bo:SetGradientAlpha("VERTICAL", br, bg, bb, ba, tr, tg, tb, ta)
end