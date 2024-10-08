-------------------------------------------------------------------------------
-- KittenDismount.lua
-------------------------------------------------------------------------------
--[[
KittenDismount
Author: Anisa of Scarlet Crusade

Usage: go to Options->AddOns->Kitten Easy Dismount
]]--

KittenDismount = {
  DefaultSettings = {
    surgeForward = true,
    skywardAscent = false,
    whirlingSurge = true,
    arielHalt = true,
    secondWind = false,
    Active = true,
  },
  Version = "0.0.3",
  VersionNumber = 3,
  DataCode = "2",
  Settings = {},
  Active = true,
  Spells = {
    surgeForward = 372608,
    skywardAscent = 372610,
    whirlingSurge = 361584,
    aerielHalt = 403092,
    secondWind = 425782,
  },
}
KittenDismountData = {}
KittenDismount.__index = KittenDismount
KittenDismount.disabledSpells = {}


-- Initialize the addon frame
local kittenDismountFrame = CreateFrame("Frame", "KittenDismount")
-- These are the event(s) that we listen for
kittenDismountFrame:RegisterEvent("VARIABLES_LOADED")
-- Function to "automatically" call the correct even function without having to have a gigantic block of if statements.
kittenDismountFrame:SetScript("OnEvent", function(this, event, ...)
  KittenDismount[event](KittenDismount, ...)
end)

-- Set up some other bits
local category = Settings.RegisterVerticalLayoutCategory("Kitten Easy Dismount")

-- Event Handlers
---@diagnostic disable-next-line: duplicate-set-field
function KittenDismount:UNIT_SPELLCAST_SENT(...)
  local unit, target, castGUID, spellID = ...;
  if ((not IsFlying()) and KittenDismount.disabledSpells[spellID]) then
    Dismount()
  end
end

-- Setup stuff
---@diagnostic disable-next-line: duplicate-set-field
function KittenDismount:VARIABLES_LOADED()
  if (KittenDismountData.DataCode ~= self.DataCode) then
    self:SetDefaults()
    self:Print("New settings format detected, settings have been reset to default")
  end
  self.Settings = {
    surgeForward = KittenDismountData.surgeForward,
    skywardAscent = KittenDismountData.skywardAscent,
    whirlingSurge = KittenDismountData.whirlingSurge,
    arielHalt = KittenDismountData.arielHalt,
    secondWind = KittenDismountData.secondWind,
  }
  self:SetDismountArray()
  do
    local name = "Surge Forward"
    local variable = "surgeForwardToggle"
    local variableKey = "surgeForward"
    local defaultValue = Settings.Default.True
    local tooltip = "Automatically dismount when Surge Forward is cast while on the ground."

    self:RegisterCheckbox(category, variable, variableKey, name, defaultValue, tooltip)
  end
  do
    local name = "Skyward Ascent"
    local variable = "skywardAscentToggle"
    local variableKey = "skywardAscent"
    local defaultValue = Settings.Default.False
    local tooltip = "Automatically dismount when Skyward Ascent is cast while on the ground."

    self:RegisterCheckbox(category, variable, variableKey, name, defaultValue, tooltip)
  end
  do
    local name = "Whirling Surge"
    local variable = "whirlingSurgeToggle"
    local variableKey = "whirlingSurge"
    local defaultValue = Settings.Default.True
    local tooltip = "Automatically dismount when Whirling Surge is cast while on the ground."

    self:RegisterCheckbox(category, variable, variableKey, name, defaultValue, tooltip)
  end
  do
    local name = "Aeriel Halt"
    local variable = "aerielHaltToggle"
    local variableKey = "aerielHalt"
    local defaultValue = Settings.Default.True
    local tooltip = "Automatically dismount when Aeriel Halt is cast while on the ground."

    self:RegisterCheckbox(category, variable, variableKey, name, defaultValue, tooltip)
  end
  do
    local name = "Second Wind"
    local variable = "secondWindToggle"
    local variableKey = "secondWind"
    local defaultValue = Settings.Default.False
    local tooltip = "Automatically dismount when Second Wind is cast while on the ground."

    self:RegisterCheckbox(category, variable, variableKey, name, defaultValue, tooltip)
  end
  Settings.RegisterAddOnCategory(category)
  self:ActivateMod()
end

---@diagnostic disable-next-line: duplicate-set-field
function KittenDismount:SaveSettings()
  KittenDismountData.DataCode = KittenDismount.DataCode
  KittenDismountData.Active = KittenDismount.Active
  KittenDismountData.surgeForward = KittenDismount.Settings.surgeForward
  KittenDismountData.skywardAscent = KittenDismount.Settings.skywardAscent
  KittenDismountData.whirlingSurge = KittenDismount.Settings.whirlingSurge
  KittenDismountData.arielHalt = KittenDismount.Settings.arielHalt
  KittenDismountData.secondWind = KittenDismount.Settings.secondWind
end
---@diagnostic disable-next-line: duplicate-set-field
function KittenDismount:SetDefaults()
  KittenDismount.Active = KittenDismountData.Active
  KittenDismount.Settings.surgeForward = KittenDismount.DefaultSettings.surgeForward
  KittenDismount.Settings.skywardAscent = KittenDismount.DefaultSettings.skywardAscent
  KittenDismount.Settings.whirlingSurge = KittenDismount.DefaultSettings.whirlingSurge
  KittenDismount.Settings.arielHalt = KittenDismount.DefaultSettings.arielHalt
  KittenDismount.Settings.secondWind = KittenDismount.DefaultSettings.secondWind
  self:SaveSettings()
end
---@diagnostic disable-next-line: duplicate-set-field
function KittenDismount:ActivateMod()
  if (KittenDismount.Active) then
    kittenDismountFrame:RegisterEvent("UNIT_SPELLCAST_SENT")
  else
    kittenDismountFrame:UnregisterEvent("UNIT_SPELLCAST_SENT")
  end
end

-- Other misc functions
local function settingChanged(setting, value)
  KittenDismount:SetDismountArray()
end
---@diagnostic disable-next-line: duplicate-set-field
function KittenDismount:SetDismountArray()
  local disabled = {}

  for key, value in pairs(KittenDismount.Spells) do
    disabled[value] = KittenDismountData[key]
  end

  self.disabledSpells = disabled
end
---@diagnostic disable-next-line: duplicate-set-field
function KittenDismount:RegisterCheckbox(cat, variable, variableKey, name, defaultValue, tooltip)
  local setting = Settings.RegisterAddOnSetting(cat, variable, variableKey, KittenDismountData, Settings.VarType.Boolean, name, defaultValue)
  setting:SetValueChangedCallback(settingChanged)
  Settings.CreateCheckbox(cat, setting, tooltip)
end
---@diagnostic disable-next-line: duplicate-set-field
function KittenDismount:Print(message)
  DEFAULT_CHAT_FRAME:AddMessage("[|c44ff44ffKittenDismount|r] " .. tostring(message))
end
---@diagnostic disable-next-line: duplicate-set-field
function KittenDismount:Error(message)
  DEFAULT_CHAT_FRAME:AddMessage("[|c44ff44ffKittenDismount|r] |cff0000ff" .. tostring(message) .. "|r")
end
