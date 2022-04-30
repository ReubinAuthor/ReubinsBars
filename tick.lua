----------------------------------------
-- NAMESPACES
----------------------------------------
local myAddon, core = ...
local func   = core.func
local frames = core.frames
local colors = core.colors
----------------------------------------
-- ENERGY TICK
----------------------------------------
function func:Create_EnergyTick()
	local EnergyTick = CreateFrame("Frame", "ReubinsBars_EnergyTick")
    EnergyTick:SetParent("ReubinsBars_main")
	EnergyTick:SetPoint("CENTER", "ReubinsBars_PowerBar", "CENTER")
	EnergyTick:SetSize(232, 25)
	frames["EnergyTick"] = EnergyTick
	-- Texture
	EnergyTick.Texture = EnergyTick:CreateTexture(nil, "OVERLAY")
	EnergyTick.Texture:SetSize(10, 40)
	EnergyTick.Texture:SetBlendMode("ADD")
	EnergyTick.Texture:SetTexture("Interface\\UNITPOWERBARALT\\DeathwingBlood_Horizontal_Spark")
	EnergyTick.Texture:SetPoint("CENTER", "ReubinsBars_PowerBar", "LEFT")
	EnergyTick.Texture:SetVertexColor(func:Unpack(colors.spark))
	-- Animation
	local EnergyTick_Group = EnergyTick:CreateAnimationGroup()
	local EnergyTick_Animation = EnergyTick_Group:CreateAnimation("Translation")
	EnergyTick_Animation:SetDuration(2)
	EnergyTick_Animation:SetOrder(1)
	EnergyTick_Animation:SetOffset(232, 0)
    local EnergyTick_Animation_Alpha = EnergyTick_Group:CreateAnimation("Alpha")
	EnergyTick_Animation_Alpha:SetDuration(0.5)
	EnergyTick_Animation_Alpha:SetOrder(1)
    EnergyTick_Animation_Alpha:SetFromAlpha(0)
	EnergyTick_Animation_Alpha:SetToAlpha(1)

    frames["EnergyTick_Animation"] = EnergyTick_Animation
    frames["EnergyTick_Animation_Alpha"] = EnergyTick_Animation_Alpha
	frames["EnergyTick_Group"] = EnergyTick_Group

    EnergyTick_Group:SetScript("OnPlay", function()
        EnergyTick:Show()
    end)
    EnergyTick_Group:SetScript("OnFinished", function()
        EnergyTick:Hide()
    end)
    EnergyTick_Group:SetScript("OnStop", function()
        EnergyTick:Hide()
    end)

    EnergyTick:Hide()
    EnergyTick_Group:Stop()
end
----------------------------------------
-- MANA TICK
----------------------------------------
function func:Create_ManaTick()
	local ManaTick = CreateFrame("Frame", "ReubinsBars_ManaTick")
    ManaTick:SetParent("ReubinsBars_main")
	ManaTick:SetPoint("CENTER", "ReubinsBars_PowerBar", "CENTER")
	ManaTick:SetSize(232, 25)
	frames["ManaTick"] = ManaTick
	-- Texture
	ManaTick.Texture = ManaTick:CreateTexture(nil, "OVERLAY")
	ManaTick.Texture:SetSize(10, 40)
	ManaTick.Texture:SetBlendMode("ADD")
	ManaTick.Texture:SetTexture("Interface\\UNITPOWERBARALT\\DeathwingBlood_Horizontal_Spark")
	ManaTick.Texture:SetPoint("CENTER", "ReubinsBars_PowerBar", "LEFT")
	ManaTick.Texture:SetVertexColor(func:Unpack(colors.spark))
	-- Animation
	local ManaTick_Group = ManaTick:CreateAnimationGroup()
	local ManaTick_Animation = ManaTick_Group:CreateAnimation("Translation")
	ManaTick_Animation:SetDuration(2)
	ManaTick_Animation:SetOrder(1)
	ManaTick_Animation:SetOffset(232, 0)
    local ManaTick_Animation_Alpha = ManaTick_Group:CreateAnimation("Alpha")
	ManaTick_Animation_Alpha:SetDuration(0.5)
	ManaTick_Animation_Alpha:SetOrder(1)
    ManaTick_Animation_Alpha:SetFromAlpha(0)
	ManaTick_Animation_Alpha:SetToAlpha(1)

    frames["ManaTick_Animation"] = ManaTick_Animation
    frames["ManaTick_Animation_Alpha"] = ManaTick_Animation_Alpha
	frames["ManaTick_Group"] = ManaTick_Group

    ManaTick_Group:SetScript("OnPlay", function()
        ManaTick:Show()
    end)
    ManaTick_Group:SetScript("OnFinished", function()
        ManaTick:Hide()
    end)
    ManaTick_Group:SetScript("OnStop", function()
        ManaTick:Hide()
    end)

    ManaTick:Hide()
    ManaTick_Group:Stop()
end