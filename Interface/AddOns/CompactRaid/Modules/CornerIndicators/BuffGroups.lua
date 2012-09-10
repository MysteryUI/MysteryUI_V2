------------------------------------------------------------
-- BuffGroups.lua
--
-- Abin
-- 2010/10/27
------------------------------------------------------------

local tinsert = tinsert
local select = select
local GetSpellInfo = GetSpellInfo
local UnitBuff = UnitBuff
local UnitDebuff = UnitDebuff

local module = CompactRaid:FindModule("CornerIndicators")
if not module then return end

local groupList = {}
local buffList = {}

local function AddBuffGroup(...)
	local list = {}
	tinsert(groupList, list)
	local groupId = #groupList

	local i
	for i = 1, select("#", ...) do
		local id = select(i, ...)
		local name = GetSpellInfo(id)
		if name then
			list[name] = groupId
			buffList[name] = groupId
		end
	end
end

function module:GetBuffGroup(buff)
	return buff and buffList[buff]
end

function module:GetGroupBuffs(group)
	local list = groupList[group]
	if list then
		return CompactRaid:CloneTable(list)
	end
end

local function FindBuff(list, unit, exclude, func)
	local i, name, icon, count, duration, expires
	for i = 1, 100 do
		name, _, icon, count, _, duration, expires = func(unit, i)
		if not name or (name ~= exclude and list[name]) then
			return name, icon, count, duration, expires
		end
	end
end

function module:FindSimilarBuff(unit, buff)
	if not unit or not buff then
		return
	end

	local list = groupList[buffList[buff]]
	if not list then
		return
	end

	local name, icon, count, duration, expires, harmful
	local name, icon, count, duration, expires = FindBuff(list, unit, buff, UnitBuff)
	if not name then
		harmful = 1
		name, icon, count, duration, expires = FindBuff(list, unit, buff, UnitDebuff)
	end

	return name, icon, count, duration, expires, harmful
end

function module:BuffsSameGroup(buff1, buff2)
	if buff1 and buff2 and buff1 ~= buff2 then
		local group1, group2 = buffList[buff1], buffList[buff2]
		if group1 and group2 and group1 == group2 then
			return 1
		end
	end
end

AddBuffGroup(1126, 20217) -- Mark of the wild, Blessing of Kings
AddBuffGroup(90364, 21562, 6307, 469) -- Qiraji Fortitude, Power Word: Fortitude, Blood Pact, Commanding Shout
AddBuffGroup(1459, 61316) -- Arcane Brilliance, Dalaran Brilliance
AddBuffGroup(57330, 93435, 8076, 6673) -- Horn of the Winter, Roar of Courage, Strength of Earth Totem, Battle Shout
AddBuffGroup(53138, 19506, 19740, 30808) -- Abomination's Might, Trueshot Aura, Blessing of Might, Unleashed Rage
AddBuffGroup(32182, 57723, 2825, 57724, 80353, 80354, 90355) -- Heroism, Exhausted, Bloodlust, Sated, Time Warp, Temporal Displacement, Ancient Hysteria
AddBuffGroup(27619, 41425) -- Ice Block, Hypothermia
AddBuffGroup(642, 1022, 25771) -- Divine Shield, Hand of Protection, Forbearance
AddBuffGroup(17, 6788) -- Power Word: Shield, Weakened Soul