----------------------------------------
-- NAMESPACES
----------------------------------------
local myAddon, core = ...
core.func   = {}
core.frames = {}
core.colors = {}
local func   = core.func
local frames = core.frames
local colors = core.colors
----------------------------------------
-- COLORS
----------------------------------------
colors.red    = {255, 0, 0}
colors.green  = {0, 255, 0}
colors.blue   = {0, 0, 255}
colors.white  = {255, 255, 255}
colors.gray   = {0.69, 0.69, 0.69}
colors.yellow = {1, 1, 0}
colors.gold   = {1, 0.99, 0.32}
colors.orange = {1, 0.6, 0}
colors.black  = {0, 0, 0,}
-- Health
colors.health_100 = {0, 255, 0}
colors.health_90  = {111, 237, 0}
colors.health_80  = {152, 219, 0}
colors.health_70  = {182, 199, 0}
colors.health_60  = {205, 178, 0}
colors.health_50  = {223, 155, 0}
colors.health_40  = {238, 130, 0}
colors.health_30  = {248, 102, 0}
colors.health_20  = {254, 68, 0}
colors.health_10  = {255, 0, 0}
-- Special ones
colors.spark = {1, 0.99, 0.32}
colors.status_bar_bg = {0, 0, 0, 0.66}
colors.power_cost = {1, 1, 1, 0.4}
----------------------------------------
-- UNPACKING COLORS 
----------------------------------------
function func:Unpack(color)
	if #color > 3 then
		r,g,b,a = unpack{color[1],color[2],color[3],color[4]}
		if r > 1 or g > 1 or b > 1 or a > 1 then
			return r/255, g/255, b/255, a/255
		else return r,g,b,a end
	else
		r,g,b = unpack{color[1],color[2],color[3]}
		if r > 1 or g > 1 or b > 1 then
			return r/255, g/255, b/255
		else return r,g,b end
	end
end
----------------------------------------
-- FORMATING NUMBERS
----------------------------------------
function func:Format(number)
    if number >= 10^4 then
        return string.format("%.1fk", number / 10^4)
    else return tostring(number) end
end
----------------------------------------
-- HP BAR COLOR
----------------------------------------
function func:HP_Color()
	local Now = UnitHealth("player")
	local Max = UnitHealthMax("player")
	local Lost = Max - Now
	local Left = 100 - Lost * 100 / Max -- Health left in percent
	    if Left < 10 then return func:Unpack(colors.health_10)
	elseif Left < 20 then return func:Unpack(colors.health_20)
	elseif Left < 30 then return func:Unpack(colors.health_30)
	elseif Left < 40 then return func:Unpack(colors.health_40)
	elseif Left < 50 then return func:Unpack(colors.health_50)
	elseif Left < 60 then return func:Unpack(colors.health_60)
	elseif Left < 70 then return func:Unpack(colors.health_70)
	elseif Left < 80 then return func:Unpack(colors.health_80)
	elseif Left < 90 then return func:Unpack(colors.health_90)
	elseif Left <= 100 then return func:Unpack(colors.health_100)
	end
end
----------------------------------------
-- POWER BAR COLORS
----------------------------------------
function func:Power_Color(val)
	local pType = UnitPowerType("player")
	local val = val or pType
	local power = {}
	power[0] = {0, 0, 1}              -- mana
	power[1] = {1, 0, 0}              -- rage
	power[2] = {1, 0.5, 0.25}         -- focus
	power[3] = {1, 1, 0}              -- energy
	power[4] = {1, 0.96, 0.41}        -- combo points
	power[5] = {0.5, 0.5, 0.5}        -- runes
	power[6] = {0, 0.82, 1}           -- runic power
	power[7] = {0.5, 0.32, 0.55}      -- soul shards
	power[8] = {0.30, 0.52, 0.90}     -- lunar power
	power[9] = {0.95, 0.90, 0.60}     -- holy power
	power[11] = {0, 0.5, 1}           -- maelstrom
	power[12] = {0.71, 1, 0.92}       -- chi
	power[13] = {0.4, 0, 0.8}         -- insanity
	power[16] = {0.1, 0.1, 0.98}      -- arcane charges
	power[17] = {0.788, 0.259, 0.992} -- fury
	power[18] = {1, 0.61, 0}          -- pain
	for k,v in pairs(power) do
		if val == k then
			r,g,b = unpack{v[1],v[2],v[3]}
			return r,g,b
		end
	end
end
----------------------------------------
-- CHECK STATUS
----------------------------------------
function func:Hide_or_Show()
	local _, _, id = UnitClass("player") -- Checking player's class
	local x = {}
	local function Check()
		if UnitPowerType("player", 1) == 1 then x.k = 0 else x.k = UnitPowerMax("player") end 
		if UnitHealth("player") == UnitHealthMax("player") -- if full health
		and UnitPower("player") == x.k                     -- if full power or empty rage
		and UnitAffectingCombat("player") == false         -- if not in combat
		and ReubinsBars_settings.Always == false then
			return false -- hide
		else
			return true  -- show
		end
	end
	if UnitIsDeadOrGhost("player") == true then -- if players is dead
		return false     -- hide
	elseif id == 11 then -- if player is a druid
		if UnitPower("player", 0) >= UnitPowerMax("player", 0) and Check() == false then
			return false -- hide
		elseif UnitPower("player", 0) < UnitPowerMax("player", 0) or Check() == true then
			return true  -- show
		end
	else -- do normal check
		return Check()
	end
end
----------------------------------------
-- SHOW COST
----------------------------------------
function func:Cost(Cost)
	local Max = UnitPowerMax("player")
	if Cost > 0 then
		frames.Power_Cost:SetSize((Cost / Max * 242), 25)
		frames.Power_Cost:Show()
	end
end
----------------------------------------
-- UPDATE HEALTH
----------------------------------------
function func:UpdateHealth()
	local Now = UnitHealth("player")
	local Max = UnitHealthMax("player")
	local Lost = Max - Now
	frames.HP:SetMinMaxValues(0, Max)
    frames.HP:SetValue(Now)
    frames.HP:SetStatusBarColor(func:HP_Color())
    frames.HP_Now:SetText(Now)
    if Lost > 0 then
        frames.HP_Lost:SetText(Lost)
        frames.HP_Spark:Show()
    else
        frames.HP_Lost:SetText("")
		frames.HP_Now:SetText("Full")
        frames.HP_Spark:Hide()
    end
    frames.MainFrame:SetShown(func:Hide_or_Show())
end
----------------------------------------
-- UPDATE HEALTH MAX
----------------------------------------
function func:UpdateHealthMax()
	local Max = UnitHealthMax("player")
	frames.HP:SetMinMaxValues(0, Max)
	frames.HP_Max:SetText(Max)
end
----------------------------------------
-- UPDATE POWER
----------------------------------------
function func:UpdatePower()
	local pType = UnitPowerType("player", 1)
	local _, _, id = UnitClass("player")
	local Now = UnitPower("player")
	local Max = UnitPowerMax("player")
	local Lost = Max - Now
	frames.Power:SetMinMaxValues(0, Max)
	frames.Power:SetValue(Now)
	frames.Power_Now:SetText(Now)
	frames.Power:SetStatusBarColor(func:Power_Color(pType))
	if pType == 1 then
		if Lost == 0 then
			frames.Power_Lost:SetText("")
			frames.Power_Spark:Hide()
		elseif Now == 0 then
			frames.Power_Lost:SetText("")
			frames.Power_Now:SetText("Empty")
			frames.Power_Spark:Hide()
		else
			frames.Power_Lost:SetText(Lost)
			frames.Power_Spark:Show()
		end
	else
		if Lost == Max then
			frames.Power_Lost:SetText("")
			frames.Power_Now:SetText("Empty")
			frames.Power_Spark:Hide()
		elseif Lost > 0 then
			frames.Power_Lost:SetText(Lost)
			frames.Power_Spark:Show()
		else
			frames.Power_Lost:SetText("")
			frames.Power_Now:SetText("Full")
			frames.Power_Spark:Hide()
			frames.ManaTick:Hide() -- Hidding mana tick if power full
		end
	end
	frames.MainFrame:SetShown(func:Hide_or_Show())

    -- DRUID'S BAR
    if id == 11 then
        local Now = UnitPower("player", 0)
        local Max = UnitPowerMax("player", 0)
        local Lost = Max - Now
        frames.DruidsBar:SetValue(Now)
        frames.DruidsBar_Now:SetText(Now)
        if Type == 0 then
            frames.DruidsBar:Hide()
        end
        if Lost > 0 then
			frames.DruidsBar_Lost:SetText(Lost)
            frames.DruidsBar_Spark:Show()
        else
			frames.DruidsBar_Lost:SetText("")
			frames.DruidsBar_Now:SetText("Full")
            frames.DruidsBar_Spark:Hide()
        end
    end
end
----------------------------------------
-- UPDATE POWER MAX
----------------------------------------
function func:UpdatePowerMax()
	local _, _, id = UnitClass("player") 
	local Max = UnitPowerMax("player")
	frames.Power_Max:SetText(Max)
	frames.Power:SetMinMaxValues(0, Max)
	
    -- DRUID'S BAR
	if id == 11 then
		local Max = UnitPowerMax("player", 0)
		frames.DruidsBar:SetMinMaxValues(0, Max)
		frames.DruidsBar_Max:SetText(Max)
	end
end
----------------------------------------
-- UPDATE DRUID'S BAR
----------------------------------------
function func:UpdateDruidsBar()
	local pType = UnitPowerType("player", 1)
	if pType ~= 0 then
		local Max = UnitPowerMax("player", 0)
		local Now = UnitPower("player", 0)
		local Lost = Max - Now
		frames.DruidsBar:SetMinMaxValues(0, Max)
		frames.DruidsBar:SetValue(Now)
		frames.DruidsBar:Show()
		if Lost > 0 then
			frames.DruidsBar_Now:SetText(Now)
		else
			frames.DruidsBar_Now:SetText("Full")
		end
	else
		frames.DruidsBar:Hide()
	end
end
----------------------------------------
-- SHAPESHIFT
----------------------------------------
function func:Shapeshift()
	local pType = UnitPowerType("player")
	func:UpdatePowerMax()
	func:UpdatePower()
	frames.Power:SetStatusBarColor(func:Power_Color(pType))
end
----------------------------------------
-- COMBO POINTS
----------------------------------------
function func:ComboPoints()
	local comboPoints = GetComboPoints("player", "target")
	if comboPoints > 0 then
		for i = 1, comboPoints do
			frames.ComboPoint1:SetPoint("BOTTOM", "ReubinsBars_main", "TOP", (-(comboPoints -1) * 20), -10)
			frames["ComboPoint" .. i]:Show()
		end
	else
		for i = 1,6 do
			frames["ComboPoint" .. i]:Hide()
		end
	end
end