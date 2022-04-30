----------------------------------------
-- NAMESPACES
----------------------------------------
local myAddon, core = ...
local func   = core.func
local frames = core.frames
local colors = core.colors
local ticks = {}
----------------------------------------
-- LOCALS
----------------------------------------
local _, _, id = UnitClass("player")
----------------------------------------
-- HANDLING EVENTS 
----------------------------------------
function core:init(event, ...)
    if event == "ADDON_LOADED" then
        local name = ...
        if name == myAddon then
            func:Create_mainParent()
            func:Create_MainFrame()
            func:Create_HP_Bar()
            func:Create_Power_Bar()
            func:Create_Druids_Bar()
            func:Create_EnergyTick()
            func:Create_ComboPoints()
            func:Create_ManaTick()
            func:Create_FiveSeconds()

            func:Settings() -- Settings
        end
    end
    ----------------------------------------
    if event == "PLAYER_LOGOUT" then
        func:Save_Settings() -- Saving settings
    end
    ----------------------------------------
    if event == "PLAYER_ENTERING_WORLD" then
        func:UpdateHealth()
        func:UpdateHealthMax()
        func:UpdatePower()
        func:UpdatePowerMax()
        if id == 11 then
            func:UpdateDruidsBar() 
        end
    end
    ----------------------------------------
    if event == "UPDATE_SHAPESHIFT_FORM" then
        local pType = UnitPowerType("player", 1)
        if id == 11 then
            func:Shapeshift()
            func:UpdateDruidsBar()
            if pType == 0 then
                frames.EnergyTick_Group:Stop()
            end
            if pType == 1 then
                frames.EnergyTick_Group:Stop()
                frames.ManaTick_Group:Stop()
            end
            if pType == 3 then
                frames.ManaTick_Group:Stop()
            end
        end
    end
    ----------------------------------------
    if event == "UNIT_HEALTH_FREQUENT" then
        local unit = ...
        if UnitIsUnit(unit, "player") then
            func:UpdateHealth()
        end
    end
    ----------------------------------------
    if event == "UNIT_MAXHEALTH" then
        local unit = ...
        if UnitIsUnit(unit, "player") then
            func:UpdateHealthMax()
        end
    end
    ----------------------------------------
    if event == "UNIT_POWER_FREQUENT" then
        local unit, pType = ...
        if UnitIsUnit(unit, "player") then
            func:UpdatePower()
        end
    end
    ----------------------------------------
    if event == "UNIT_MAXPOWER" then
        local unit = ...
        if UnitIsUnit(unit, "player") then
            func:UpdatePowerMax()
        end
    end
    ----------------------------------------
    if event == "PLAYER_REGEN_DISABLED"
    or event == "PLAYER_REGEN_ENABLED"
    or event == "PLAYER_ALIVE"
    or event == "PLAYER_DEAD"
    or event == "PLAYER_UNGHOST" then
        frames.MainFrame:SetShown(func:Hide_or_Show())
    end
    ----------------------------------------
    if event == "UNIT_SPELLCAST_START" then
        local unit, castGUID, spellID = ...
        if UnitIsUnit(unit, "player") then
            local costs_table = GetSpellPowerCost(spellID)
            if next(costs_table) ~= nil then
                if (type(costs_table[1]["cost"]) == "table") then
                    if costs_table[1]["cost"][1]["type"] == 0
                    or costs_table[1]["cost"][1]["type"] == 1
                    or costs_table[1]["cost"][1]["type"] == 3
                    then
                        func:Cost(costs_table[1]["cost"][1]["cost"])
                    elseif costs_table[1]["cost"][2]["type"] == 0
                    or costs_table[1]["cost"][2]["type"] == 1
                    or costs_table[1]["cost"][2]["type"] == 3
                    then
                        func:Cost(costs_table[1]["cost"][2]["cost"])
                    end
                else
                    func:Cost(costs_table[1]["cost"])
                end
            end
        end
    end
    ----------------------------------------
    if event == "UNIT_SPELLCAST_STOP"
    or event == "UNIT_SPELLCAST_FAILED"
    then
        local unit, castGUID, spellID = ...
        if UnitIsUnit(unit, "player") then
            frames.Power_Cost:Hide()
        end 
    end
    ----------------------------------------
    if event == "UNIT_POWER_UPDATE" then
        local unit, pType = ...
        local Active_Power = UnitPowerType("player", 1)
        if UnitIsUnit(unit, "player") then
            if Active_Power == 3 then
                if pType == "ENERGY" then
                    if ticks.Previous_Tick == nil then
                        ticks.Previous_Tick = GetTime()
                        ticks.Previous_Energy = UnitPower("player")
                    elseif ticks.Current_Tick ~= nil then
                        ticks.Previous_Tick = ticks.Current_Tick
                        ticks.Current_Tick = GetTime()
                        ticks.Previous_Energy = ticks.Current_Energy
                        ticks.Current_Energy = UnitPower("player")

                        if ticks.Current_Tick > ticks.Previous_Tick + 2.5 then
                            frames.EnergyTick_Group:Stop()
                        elseif ticks.Current_Energy > ticks.Previous_Energy or ticks.Current_Tick > ticks.Previous_Tick + 2 then
                            frames.EnergyTick_Group:Stop()
                            frames.EnergyTick_Group:Play()
                        end
                    else
                        ticks.Current_Tick = GetTime()
                        ticks.Current_Energy = UnitPower("player")
                    end
                end
            end
            func:ComboPoints()
            if Active_Power == 0 then
                if pType == "MANA" then
                    if ticks.Previous_Mana == nil then
                        ticks.Previous_Mana = UnitPower("player")
                    elseif ticks.Current_Mana ~= nil then
                        ticks.Previous_Mana = ticks.Current_Mana
                        ticks.Current_Mana = UnitPower("player")
                        
                        if ticks.Current_Mana > ticks.Previous_Mana then
                            frames.ManaTick_Group:Stop()
                            frames.ManaTick_Group:Play()
                        else
                            frames.ManaTick_Group:Stop()
                        end
                    else
                        ticks.Current_Mana = UnitPower("player")
                    end
                end
            end
        end
    end
    ----------------------------------------
    if event == "PLAYER_TARGET_CHANGED" then
        func:ComboPoints()
    end
    ----------------------------------------
    if event == "UNIT_SPELLCAST_SUCCEEDED" then
        local unit, _, spellID = ...
        local pType = UnitPowerType("player", 1)
        if UnitIsUnit(unit, "player") then
            frames.Power_Cost:Hide() -- hiding cost overlay after casting

            --[[ Five second rule
            local _, MP5 = GetManaRegen("player")
            local costs_table = GetSpellPowerCost(spellID)
            if pType == 0 and math.floor(MP5) == 0 then -- if mana is active power and mp5 is 0 (not ticking in combat)
                if costs_table[1] then
                    if costs_table[1]["cost"] then
                        if (type(costs_table[1]["cost"]) == "table") then
                            if costs_table[1]["cost"][1]["type"] == 0
                            or costs_table[1]["cost"][2]["type"] == 0 then
                                --frames.ManaTick_Group:Stop()
                                --frames.FiveSecond_Group:Stop()
                                --frames.FiveSecond_Group:Play()
                            end
                        else
                            if costs_table[1]["type"] == 0 then
                                --frames.ManaTick_Group:Stop()
                                --frames.FiveSecond_Group:Stop()
                                --frames.FiveSecond_Group:Play()
                            end
                        end
                    end
                end
            end
            ]]
        end
    end
    ----------------------------------------
    if event == "UNIT_HEAL_PREDICTION" then
        local unit = ...
        func:HealPrediction()
    end
    ----------------------------------------
    if event == "UNIT_ABSORB_AMOUNT_CHANGED" then
        local unit = ...
        func:Absorbs()
    end
end
----------------------------------------
-- REGISTERING SLASH COMMANDS
----------------------------------------
SLASH_RBARS1 = "/rbars"
local function Slash_Handler(msg)
    if msg == "lock" then
        ReubinsBars_settings.Lock = not ReubinsBars_settings.Lock
        frames.LockCheck:SetChecked(ReubinsBars_settings.Lock)
        frames.mainParent:EnableMouse(not ReubinsBars_settings.Lock)
        if ReubinsBars_settings.Lock == true then
			print("|cff00ccffReubin's Bar: |cffFFFC54Bar is locked")
		else 
			print("|cff00ccffReubin's Bar: |cffFFFC54Bar is unlocked")
		end
    end
end
SlashCmdList["RBARS"] = Slash_Handler
----------------------------------------
-- REGISTERING EVENTS
----------------------------------------
local events = CreateFrame("Frame")
events:RegisterEvent("ADDON_LOADED")
events:RegisterEvent("PLAYER_LOGOUT")
events:RegisterEvent("UNIT_HEALTH_FREQUENT")
events:RegisterEvent("UNIT_POWER_FREQUENT")
events:RegisterEvent("UNIT_MAXHEALTH")
events:RegisterEvent("UNIT_MAXPOWER")
events:RegisterEvent("PLAYER_ENTERING_WORLD")
events:RegisterEvent("PLAYER_REGEN_ENABLED")
events:RegisterEvent("PLAYER_REGEN_DISABLED")
events:RegisterEvent("UNIT_SPELLCAST_START")
events:RegisterEvent("UNIT_SPELLCAST_STOP")
events:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
events:RegisterEvent("UNIT_SPELLCAST_FAILED")
events:RegisterEvent("PLAYER_DEAD")
events:RegisterEvent("PLAYER_ALIVE")
events:RegisterEvent("PLAYER_UNGHOST")
events:RegisterEvent("UPDATE_SHAPESHIFT_FORM")
events:RegisterEvent("UNIT_POWER_UPDATE")
events:RegisterEvent("PLAYER_TARGET_CHANGED")
--events:RegisterEvent("UNIT_HEAL_PREDICTION") -- to do
--events:RegisterEvent("UNIT_ABSORB_AMOUNT_CHANGED") -- to do
events:SetScript("OnEvent", core.init)