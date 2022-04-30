----------------------------------------
-- NAMESPACES
----------------------------------------
local myAddon, core = ...
local func   = core.func
local frames = core.frames
local colors = core.colors
----------------------------------------
-- HP FRAME
----------------------------------------
function func:Create_HP_Bar()
    local HP = CreateFrame("StatusBar", "ReubinsBars_HealthBar")
    HP:SetParent("ReubinsBars_main")
    HP:SetSize(232, 25)
    HP:SetPoint("CENTER", "ReubinsBars_main", "CENTER", 0, 3)
    HP:SetStatusBarTexture("Interface\\TARGETINGFRAME\\UI-StatusBar")
    frames.HP = HP
    -- Background
    HP.Bg = HP:CreateTexture(nil, "BACKGROUND")
    HP.Bg:SetTexture("Interface\\TARGETINGFRAME\\UI-StatusBar")
    HP.Bg:SetAllPoints()
    HP.Bg:SetVertexColor(func:Unpack(colors.status_bar_bg))
    -- Spark
    HP.Spark = HP:CreateTexture(nil, "OVERLAY")
    HP.Spark:SetSize(10, 40)
    HP.Spark:SetBlendMode("ADD")
    HP.Spark:SetTexture("Interface\\UNITPOWERBARALT\\DeathwingBlood_Horizontal_Spark")
    HP.Spark:SetPoint("CENTER", HP:GetStatusBarTexture(), "RIGHT", 0, 0)
    HP.Spark:SetVertexColor(func:Unpack(colors.spark))
    frames.HP_Spark = HP.Spark
    -- HP Lost
    HP.Lost = HP:CreateFontString(nil, "OVERLAY")
    HP.Lost:SetPoint("LEFT", "ReubinsBars_HealthBar", "LEFT", 4,0)
    HP.Lost:SetFont("Fonts\\FRIZQT__.TTF", 16, "OUTLINE")
    HP.Lost:SetTextColor(func:Unpack(colors.gray))
    HP.Lost:SetShadowColor(func:Unpack(colors.black))
    HP.Lost:SetShadowOffset(1, -1)
    frames.HP_Lost = HP.Lost
    -- HP Now
    HP.Now = HP:CreateFontString(nil, "OVERLAY")
    HP.Now:SetPoint("CENTER", "ReubinsBars_HealthBar", "CENTER")
    HP.Now:SetFont("Fonts\\FRIZQT__.TTF", 16, "OUTLINE")
    HP.Now:SetTextColor(func:Unpack(colors.white))
    HP.Now:SetShadowColor(func:Unpack(colors.black))
    HP.Now:SetShadowOffset(1, -1)
    frames.HP_Now = HP.Now
    -- HP Max
    HP.Max = HP:CreateFontString(nil, "OVERLAY")
    HP.Max:SetPoint("RIGHT", "ReubinsBars_HealthBar", "RIGHT", -4,0)
    HP.Max:SetFont("Fonts\\FRIZQT__.TTF", 16, "OUTLINE")
    HP.Max:SetTextColor(func:Unpack(colors.gray))
    HP.Max:SetShadowColor(func:Unpack(colors.black))
    HP.Max:SetShadowOffset(1, -1)
    frames.HP_Max = HP.Max
end