----------------------------------------
-- NAMESPACES
----------------------------------------
local myAddon, core = ...
local func   = core.func
local frames = core.frames
local colors = core.colors
----------------------------------------
-- POWER FRAME
----------------------------------------
function func:Create_Power_Bar()
	local Power = CreateFrame("StatusBar", "ReubinsBars_PowerBar")
	Power:SetParent("ReubinsBars_main")
	Power:SetSize(232, 25)
	Power:SetPoint("TOP", "ReubinsBars_HealthBar", "BOTTOM")
	Power:SetStatusBarTexture("Interface\\TARGETINGFRAME\\UI-StatusBar")
	frames.Power = Power
	-- Background
	Power.Bg = Power:CreateTexture(nil, "BACKGROUND")
	Power.Bg:SetTexture("Interface\\TARGETINGFRAME\\UI-StatusBar")
	Power.Bg:SetAllPoints()
	Power.Bg:SetVertexColor(func:Unpack(colors.status_bar_bg))
	-- Cost
	Power.Cost = Power:CreateTexture(nil, "ARTWORK")
	Power.Cost:SetTexture("Interface\\TARGETINGFRAME\\UI-StatusBar")
	Power.Cost:SetPoint("RIGHT", Power:GetStatusBarTexture(), "RIGHT")
	Power.Cost:SetBlendMode("ADD")
	Power.Cost:SetVertexColor(func:Unpack(colors.power_cost))
	Power.Cost:Hide()
	frames.Power_Cost = Power.Cost
	-- Spark
    Power.Spark = Power:CreateTexture(nil, "OVERLAY")
    Power.Spark:SetSize(10, 40)
    Power.Spark:SetBlendMode("ADD")
	Power.Spark:SetTexture("Interface\\UNITPOWERBARALT\\DeathwingBlood_Horizontal_Spark")
    Power.Spark:SetPoint("CENTER", Power:GetStatusBarTexture(), "RIGHT")
	Power.Spark:SetVertexColor(func:Unpack(colors.spark))
	frames.Power_Spark = Power.Spark
	-- Power Lost
	Power.Lost = Power:CreateFontString(nil, "OVERLAY")
	Power.Lost:SetPoint("LEFT", "ReubinsBars_PowerBar", "LEFT", 4,0)
    Power.Lost:SetFont("Fonts\\FRIZQT__.TTF", 16, "OUTLINE")
    Power.Lost:SetTextColor(func:Unpack(colors.gray))
    Power.Lost:SetShadowColor(func:Unpack(colors.black))
    Power.Lost:SetShadowOffset(1, -1)
	frames.Power_Lost = Power.Lost
	-- Power Now
	Power.Now = Power:CreateFontString(nil, "OVERLAY")
	Power.Now:SetPoint("CENTER", "ReubinsBars_PowerBar", "CENTER")
	Power.Now:SetFont("Fonts\\FRIZQT__.TTF", 16, "OUTLINE")
    Power.Now:SetTextColor(func:Unpack(colors.white))
    Power.Now:SetShadowColor(func:Unpack(colors.black))
    Power.Now:SetShadowOffset(1, -1)
	frames.Power_Now = Power.Now
	-- Power Max
	Power.Max = Power:CreateFontString(nil, "OVERLAY")
	Power.Max:SetPoint("RIGHT", "ReubinsBars_PowerBar", "RIGHT", -4,0)
    Power.Max:SetFont("Fonts\\FRIZQT__.TTF", 16, "OUTLINE")
    Power.Max:SetTextColor(func:Unpack(colors.gray))
    Power.Max:SetShadowColor(func:Unpack(colors.black))
    Power.Max:SetShadowOffset(1, -1)
	frames.Power_Max = Power.Max
end
----------------------------------------
-- COMBO POINTS
----------------------------------------
function func:Create_ComboPoints()
	local ComboPoint = CreateFrame("Frame", "ReubinsBars_ComboPoint")
    ComboPoint:SetParent("ReubinsBars_main")
	ComboPoint:SetPoint("CENTER", "ReubinsBars_PowerBar", "CENTER")
	frames.ComboPoint = ComboPoint
	-- Point 1
	ComboPoint.One = ComboPoint:CreateTexture("ReubinsBars_ComboPoint_1", "OVERLAY")
	ComboPoint.One:SetSize(40, 40)
	ComboPoint.One:SetTexture("Interface\\addons\\Reubinsbars\\media\\frame_cp")
	ComboPoint.One:SetPoint("BOTTOM", "ReubinsBars_main", "TOP", 0, -10)
	ComboPoint.One:SetVertexColor(func:Unpack(colors.spark))
	frames.ComboPoint1 = ComboPoint.One
	-- Point 2
	ComboPoint.Two = ComboPoint:CreateTexture("ReubinsBars_ComboPoint_2", "OVERLAY")
	ComboPoint.Two:SetSize(40, 40)
	ComboPoint.Two:SetTexture("Interface\\addons\\Reubinsbars\\media\\frame_cp")
	ComboPoint.Two:SetPoint("LEFT", "ReubinsBars_ComboPoint_1", "LEFT", 40, 0)
	ComboPoint.Two:SetVertexColor(func:Unpack(colors.spark))
	frames.ComboPoint2 = ComboPoint.Two
	-- Point 3
	ComboPoint.Three = ComboPoint:CreateTexture("ReubinsBars_ComboPoint_3", "OVERLAY")
	ComboPoint.Three:SetSize(40, 40)
	ComboPoint.Three:SetTexture("Interface\\addons\\Reubinsbars\\media\\frame_cp")
	ComboPoint.Three:SetPoint("LEFT", "ReubinsBars_ComboPoint_2", "LEFT", 40, 0)
	ComboPoint.Three:SetVertexColor(func:Unpack(colors.spark))
	frames.ComboPoint3 = ComboPoint.Three
	-- Point 4
	ComboPoint.Four = ComboPoint:CreateTexture("ReubinsBars_ComboPoint_4", "OVERLAY")
	ComboPoint.Four:SetSize(40, 40)
	ComboPoint.Four:SetTexture("Interface\\addons\\Reubinsbars\\media\\frame_cp")
	ComboPoint.Four:SetPoint("LEFT", "ReubinsBars_ComboPoint_3", "LEFT", 40, 0)
	ComboPoint.Four:SetVertexColor(func:Unpack(colors.spark))
	frames.ComboPoint4 = ComboPoint.Four
	-- Point 5
	ComboPoint.Five = ComboPoint:CreateTexture("ReubinsBars_ComboPoint_5", "OVERLAY")
	ComboPoint.Five:SetSize(40, 40)
	ComboPoint.Five:SetTexture("Interface\\addons\\Reubinsbars\\media\\frame_cp")
	ComboPoint.Five:SetPoint("LEFT", "ReubinsBars_ComboPoint_4", "LEFT", 40, 0)
	ComboPoint.Five:SetVertexColor(func:Unpack(colors.spark))
	frames.ComboPoint5 = ComboPoint.Five
	-- Point 6
	ComboPoint.Six = ComboPoint:CreateTexture("ReubinsBars_ComboPoint_5", "OVERLAY")
	ComboPoint.Six:SetSize(40, 40)
	ComboPoint.Six:SetTexture("Interface\\addons\\Reubinsbars\\media\\frame_cp")
	ComboPoint.Six:SetPoint("LEFT", "ReubinsBars_ComboPoint_4", "LEFT", 40, 0)
	ComboPoint.Six:SetVertexColor(func:Unpack(colors.spark))
	frames.ComboPoint6 = ComboPoint.Six
	
	ComboPoint.One:Hide()
	ComboPoint.Two:Hide()
	ComboPoint.Three:Hide()
	ComboPoint.Four:Hide()
    ComboPoint.Five:Hide()
	ComboPoint.Six:Hide()
end