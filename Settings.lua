----------------------------------------
-- NAMESPACES
----------------------------------------
local myAddon, core = ...
local func   = core.func
local frames = core.frames
local colors = core.colors
----------------------------------------
-- DEFAULT SETTINGS (for the first launch)
----------------------------------------
local defaults = {
	Lock = false,
	Scale = 1,
	Always = false,
}
ReubinsBars_settings = ReubinsBars_settings or {}
for k, v in pairs(defaults) do
	if ReubinsBars_settings[k] == nil then
		ReubinsBars_settings[k] = v
	end
end
----------------------------------------
-- ADDON SETTINGS
----------------------------------------
function func:Settings()
    -- Applying settings
    frames.MainFrame:SetShown(func:Hide_or_Show()) -- Always
    frames.mainParent:EnableMouse(not ReubinsBars_settings.Lock) -- Lock
    frames.MainFrame:SetScale(ReubinsBars_settings.Scale) -- Scale

    -- Create a frame to use as the panel
    local panel = CreateFrame("FRAME", "ReubinsBars_Addon_Settings")
    panel.name = "Reubin's Bars"
    frames.panel = panel

    -- Title
    local title = panel:CreateFontString("ReubinsBars_Addon_Settings_title", "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("TOPLEFT", "ReubinsBars_Addon_Settings", "TOPLEFT", 16, -16)
    title:SetText("Reubin's Bar")

    -- Check button
    local AlwaysCheck = CreateFrame("CheckButton", "ReubinsBars_Addon_Settings_AlwaysCheck", panel, "InterfaceOptionsCheckButtonTemplate")
    AlwaysCheck:SetPoint("TOPLEFT", "ReubinsBars_Addon_Settings_title", "BOTTOMLEFT", 0, -16)
    AlwaysCheck.Text:SetText("Always show")
    AlwaysCheck:SetChecked(ReubinsBars_settings.Always)
    frames.AlwaysCheck = AlwaysCheck

    -- Check button
    local LockCheck = CreateFrame("CheckButton", "ReubinsBars_Addon_Settings_LockCheck", panel, "InterfaceOptionsCheckButtonTemplate")
    LockCheck:SetPoint("TOPLEFT", "ReubinsBars_Addon_Settings_AlwaysCheck", "BOTTOMLEFT", 0, -8)
    LockCheck.Text:SetText("Lock")
    LockCheck:SetChecked(ReubinsBars_settings.Lock)
    frames.LockCheck = LockCheck

    -- Scale slider
    local ScaleSlider = CreateFrame("Slider", "ReubinsBars_Addon_Settings_ScaleSlider", panel, "OptionsSliderTemplate")
    ScaleSlider:SetPoint("TOPLEFT", "ReubinsBars_Addon_Settings_LockCheck", "BOTTOMLEFT", 8, -24)
    ScaleSlider:SetOrientation("HORIZONTAL")
    ScaleSlider:SetWidth(300)
    ScaleSlider:SetHeight(20)
    ScaleSlider:SetMinMaxValues(0.5, 1.5)
    ScaleSlider:SetValueStep(0.1)
    ScaleSlider:SetObeyStepOnDrag(true)
    ScaleSlider:SetValue(ReubinsBars_settings.Scale)
    _G[ScaleSlider:GetName() .. "Low"]:SetText("0.5")
    _G[ScaleSlider:GetName() .. "High"]:SetText("1.5")
    ScaleSlider.Text:SetText("|cfff9d247Scale: " .. string.format("%.1f", ScaleSlider:GetValue()))
    ScaleSlider:SetScript("OnValueChanged", function(self)
        self.Text:SetText("|cfff9d247Scale: " .. string.format("%.1f", ScaleSlider:GetValue()))
    end)

    -- Notes, Sub-title
    local subTitle = panel:CreateFontString("ReubinsBars_Addon_Settings_subTitle_Notes", "OVERLAY", "GameFontNormal")
    subTitle:SetPoint("TOPLEFT", "ReubinsBars_Addon_Settings_ScaleSlider", "BOTTOMLEFT", 0, -48)
    subTitle:SetText("Notes:")

    -- Notes, Sub-title
    local subTitle = panel:CreateFontString("ReubinsBars_Addon_Settings_subTitle_Notes_Text", "OVERLAY", "GameFontNormal")
    subTitle:SetPoint("TOPLEFT", "ReubinsBars_Addon_Settings_subTitle_Notes", "BOTTOMLEFT", 0, -12)
    subTitle:SetJustifyH("LEFT")
    subTitle:SetText('You can toggle lock by typing "/rbars lock" command in the chat')

    -- Default settings
    panel.default =
        function ()
            -- Always show
            ReubinsBars_settings.Always = false
            AlwaysCheck:SetChecked(ReubinsBars_settings.Always)
            frames.MainFrame:SetShown(ReubinsBars_settings.Always)
            -- Lock
            ReubinsBars_settings.Lock = false
            LockCheck:SetChecked(ReubinsBars_settings.Lock)
            frames.mainParent:EnableMouse(not ReubinsBars_settings.Lock)
            -- Position
            frames.mainParent:ClearAllPoints()
            frames.mainParent:SetPoint("CENTER", UIParent, "CENTER", 0, -300)
            -- Scale
            ReubinsBars_settings.Scale = 1
            ScaleSlider:SetValue(ReubinsBars_settings.Scale)
            frames.MainFrame:SetScale(ReubinsBars_settings.Scale)
        end

    -- When the player clicks okay, set the original value to the current setting
    panel.okay =
        function ()
            -- Always show
            ReubinsBars_settings.Always = AlwaysCheck:GetChecked()
            frames.MainFrame:SetShown(func:Hide_or_Show())
            -- Lock
            ReubinsBars_settings.Lock = LockCheck:GetChecked()
            frames.mainParent:EnableMouse(not ReubinsBars_settings.Lock)
            -- Scale
            ReubinsBars_settings.Scale = ScaleSlider:GetValue()
            frames.MainFrame:SetScale(ReubinsBars_settings.Scale)
        end

    -- When the player clicks cancel, set the current setting to the original value
    panel.cancel =
        function ()
            -- Always show
            AlwaysCheck:SetChecked(ReubinsBars_settings.Always)
            -- Lock
            LockCheck:SetChecked(ReubinsBars_settings.Lock)
            -- Scale
            ScaleSlider:SetValue(ReubinsBars_settings.Scale)
        end

    -- Add the panel to the Interface Options
    InterfaceOptions_AddCategory(panel)
end

----------------------------------------
-- SAVING VARIABLES
----------------------------------------
function func:Save_Settings()
    ReubinsBars_settings.Lock = ReubinsBars_settings.Lock -- Lock
end