----------------------------------------
-- NAMESPACES
----------------------------------------
local myAddon, core = ...
local func   = core.func
local frames = core.frames
local colors = core.colors
----------------------------------------
-- FIVE SECONDS RULE
----------------------------------------
function func:Create_FiveSeconds()
	local FiveSecond = CreateFrame("Frame", "ReubinsBars_FiveSecond")
    FiveSecond:SetParent("ReubinsBars_main")
	FiveSecond:SetPoint("CENTER", "ReubinsBars_PowerBar", "CENTER")
	FiveSecond:SetSize(232, 25)
	frames["PowerTick2"] = FiveSecond
	-- Texture
	FiveSecond.Texture = FiveSecond:CreateTexture(nil, "OVERLAY")
	FiveSecond.Texture:SetSize(10, 40)
	FiveSecond.Texture:SetBlendMode("ADD")
	FiveSecond.Texture:SetTexture("Interface\\UNITPOWERBARALT\\DeathwingBlood_Horizontal_Spark")
	FiveSecond.Texture:SetPoint("CENTER", "ReubinsBars_PowerBar", "RIGHT")
	FiveSecond.Texture:SetVertexColor(func:Unpack(colors.spark))
	-- Animation
	local FiveSecond_Group = FiveSecond:CreateAnimationGroup()
	local FiveSecond_Animation = FiveSecond_Group:CreateAnimation("Translation")
	FiveSecond_Animation:SetDuration(5)
	FiveSecond_Animation:SetOrder(1)
	FiveSecond_Animation:SetOffset(-232, 0)
	local FiveSecond_Animation_Alpha = FiveSecond_Group:CreateAnimation("Alpha")
	FiveSecond_Animation_Alpha:SetDuration(0.5)
	FiveSecond_Animation_Alpha:SetOrder(1)
    FiveSecond_Animation_Alpha:SetFromAlpha(0)
	FiveSecond_Animation_Alpha:SetToAlpha(1)

	frames["FiveSecond_Animation"] = FiveSecond_Animation
	frames["FiveSecond_Animation_Alpha"] = FiveSecond_Animation_Alpha
	frames["FiveSecond_Group"] = FiveSecond_Group

	FiveSecond_Group:SetScript("OnPlay", function()
        FiveSecond:Show()
    end)
    FiveSecond_Group:SetScript("OnFinished", function()
        FiveSecond:Hide()
    end)
	FiveSecond_Group:SetScript("OnStop", function()
        FiveSecond:Hide()
    end)

	FiveSecond:Hide()
    FiveSecond_Group:Stop()
end