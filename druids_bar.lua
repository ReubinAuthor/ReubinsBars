----------------------------------------
-- NAMESPACES
----------------------------------------
local myAddon, core = ...
local func   = core.func
local frames = core.frames
local colors = core.colors
----------------------------------------
-- DRUID'S BAR (mana)
----------------------------------------
function func:Create_Druids_Bar()
    local DruidsBar = CreateFrame("StatusBar", "ReubinsBars_DruidsBar")
    DruidsBar:SetParent("ReubinsBars_main")
    DruidsBar:SetSize(217, 25)
    DruidsBar:SetPoint("TOP", "ReubinsBars_PowerBar", "BOTTOM", 0, -4)
    DruidsBar:SetStatusBarTexture("Interface\\TARGETINGFRAME\\UI-StatusBar")
    DruidsBar:SetStatusBarColor(0, 0, 1)
    frames["DruidsBar"] = DruidsBar
    -- Background
    DruidsBar.Bg = DruidsBar:CreateTexture(nil, "BACKGROUND")
    DruidsBar.Bg:SetTexture("Interface\\TARGETINGFRAME\\UI-StatusBar")
    DruidsBar.Bg:SetAllPoints()
    DruidsBar.Bg:SetVertexColor(func:Unpack(colors.status_bar_bg))
    -- Spark
    DruidsBar.Spark = DruidsBar:CreateTexture(nil, "ARTWORK")
    DruidsBar.Spark:SetSize(10, 40)
    DruidsBar.Spark:SetBlendMode("ADD")
    DruidsBar.Spark:SetTexture("Interface\\UNITPOWERBARALT\\DeathwingBlood_Horizontal_Spark")
    DruidsBar.Spark:SetPoint("CENTER", DruidsBar:GetStatusBarTexture(), "RIGHT", 0, 0)
    DruidsBar.Spark:SetVertexColor(func:Unpack(colors.spark))
    frames["DruidsBar_Spark"] = DruidsBar.Spark
    -- Power Lost
	DruidsBar.Lost = DruidsBar:CreateFontString(nil, "ARTWORK")
	DruidsBar.Lost:SetPoint("LEFT", "ReubinsBars_DruidsBar", "LEFT", 4,0)
    DruidsBar.Lost:SetFont("Fonts\\FRIZQT__.TTF", 14, "OUTLINE")
    DruidsBar.Lost:SetTextColor(func:Unpack(colors.gray))
    DruidsBar.Lost:SetShadowColor(func:Unpack(colors.black))
    DruidsBar.Lost:SetShadowOffset(1, -1)
	frames["DruidsBar_Lost"] = DruidsBar.Lost
    -- Power Now
    DruidsBar.Now = DruidsBar:CreateFontString(nil, "ARTWORK")
    DruidsBar.Now:SetPoint("CENTER", "ReubinsBars_DruidsBar", "CENTER")
    DruidsBar.Now:SetFont("Fonts\\FRIZQT__.TTF", 14, "OUTLINE")
    DruidsBar.Now:SetTextColor(func:Unpack(colors.white))
    DruidsBar.Now:SetShadowColor(func:Unpack(colors.black))
    DruidsBar.Now:SetShadowOffset(1, -1)
    frames["DruidsBar_Now"] = DruidsBar.Now
    -- Power Max
	DruidsBar.Max = DruidsBar:CreateFontString(nil, "ARTWORK")
	DruidsBar.Max:SetPoint("RIGHT", "ReubinsBars_DruidsBar", "RIGHT", -4,0)
    DruidsBar.Max:SetFont("Fonts\\FRIZQT__.TTF", 14, "OUTLINE")
    DruidsBar.Max:SetTextColor(func:Unpack(colors.gray))
    DruidsBar.Max:SetShadowColor(func:Unpack(colors.black))
    DruidsBar.Max:SetShadowOffset(1, -1)
	frames["DruidsBar_Max"] = DruidsBar.Max
    -- Druid's mana border
    DruidsBar.Border = DruidsBar:CreateTexture(nil, "ARTWORK", nil, 7)
    DruidsBar.Border:SetSize(256, 32)
    DruidsBar.Border:SetTexture("Interface\\addons\\Reubinsbars\\media\\frame_druid")
    DruidsBar.Border:SetPoint("TOP", "ReubinsBars_DruidsBar", "TOP", 0, 0)
    DruidsBar.Border:SetVertexColor(func:Unpack(colors.gold))

    DruidsBar:Hide()
end