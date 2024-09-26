KittenDismount_SavedVars = {}
KittenDismount_disabledSpells = {}

function KittenDismount_SetDismountArray()
  local spells = {
    surgeForward = 372608,
    skywardAscent = 372610,
    whirlingSurge = 361584,
    aerielHalt = 403092,
    secondWind = 425782,
  }
  local disabled = {}

  for key, value in pairs(spells) do
    disabled[value] = KittenDismount_SavedVars[key]
  end
  KittenDismount_disabledSpells = disabled
end

local category = Settings.RegisterVerticalLayoutCategory("Kitten Dismount")

local function OnSettingChanged(setting, value)
  KittenDismount_SetDismountArray()
end

local function RegisterCheckbox(category, variable, variableKey, name, defaultValue, tooltip)
  local setting = Settings.RegisterAddOnSetting(category, variable, variableKey, KittenDismount_SavedVars, Settings.VarType.Boolean, name, defaultValue)
  setting:SetValueChangedCallback(OnSettingChanged)
  Settings.CreateCheckbox(category, setting, tooltip)
end

do
  local name = "Surge Forward"
  local variable = "surgeForwardToggle"
  local variableKey = "surgeForward"
  local defaultValue = Settings.Default.True
  local tooltip = "Automatically dismount when Surge Forward is cast while on the ground."

  RegisterCheckbox(category, variable, variableKey, name, defaultValue, tooltip)
end
do
  local name = "Skyward Ascent"
  local variable = "skywardAscentToggle"
  local variableKey = "skywardAscent"
  local defaultValue = Settings.Default.False
  local tooltip = "Automatically dismount when Skyward Ascent is cast while on the ground."

  RegisterCheckbox(category, variable, variableKey, name, defaultValue, tooltip)
end
do
  local name = "Whirling Surge"
  local variable = "whirlingSurgeToggle"
  local variableKey = "whirlingSurge"
  local defaultValue = Settings.Default.True
  local tooltip = "Automatically dismount when Whirling Surge is cast while on the ground."

  RegisterCheckbox(category, variable, variableKey, name, defaultValue, tooltip)
end
do
  local name = "Aeriel Halt"
  local variable = "aerielHaltToggle"
  local variableKey = "aerielHalt"
  local defaultValue = Settings.Default.True
  local tooltip = "Automatically dismount when Aeriel Halt is cast while on the ground."

  RegisterCheckbox(category, variable, variableKey, name, defaultValue, tooltip)
end
do
  local name = "Second Wind"
  local variable = "secondWindToggle"
  local variableKey = "secondWind"
  local defaultValue = Settings.Default.False
  local tooltip = "Automatically dismount when Second Wind is cast while on the ground."

  RegisterCheckbox(category, variable, variableKey, name, defaultValue, tooltip)
end

Settings.RegisterAddOnCategory(category)
