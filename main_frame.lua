----------------------------------------
-- NAMESPACES
----------------------------------------
local myAddon, core = ...
local func   = core.func
local frames = core.frames
local colors = core.colors
----------------------------------------
-- MAIN FRAME
----------------------------------------
function func:Create_mainParent()
	local mainParent = CreateFrame("Frame", "ReubinsBars_mainParent", UIParent)
	mainParent:SetPoint("CENTER", UIParent, "CENTER", 0, -300)
	mainParent:SetSize(256, 64)
	frames.mainParent = mainParent
	-- Dragging
	mainParent:SetMovable(true)
	mainParent:RegisterForDrag("LeftButton")
	mainParent:SetScript("OnDragStart", function(self)
		self:StartMoving()
	end)
	mainParent:SetScript("OnDragStop", function(self)
		self:StopMovingOrSizing()
	end)
end

function func:Create_MainFrame()
	local MainFrame = CreateFrame("Frame", "ReubinsBars_main", UIParent)
	MainFrame:SetPoint("CENTER", "ReubinsBars_mainParent", "CENTER")
	MainFrame:SetSize(256, 64)
	MainFrame:SetScale(1)
	frames.MainFrame = MainFrame
	-- Border
	local Border = CreateFrame("Frame", "ReubinsBars_Border", MainFrame)
	Border = Border:CreateTexture(nil, "OVERLAY")
	Border:SetSize(256, 64)
	Border:SetTexture("Interface\\addons\\Reubinsbars\\media\\frame")
	Border:SetPoint("CENTER", "ReubinsBars_main", "CENTER", 0, -10)
	Border:SetVertexColor(func:Unpack(colors.gold))
	-- Show / Hide
	MainFrame:SetShown(func:Hide_or_Show())
end