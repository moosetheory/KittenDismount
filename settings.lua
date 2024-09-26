KittenDismount_SavedVars = {}

local category = Settings.RegisterVerticalLayoutCategory("Kitten Dismount")

local function OnSettingChanged(setting, value)
  print(KittenDismount_dump(KittenDismount_SavedVars))
  print("hey")
  print("Setting changed: ", setting:GetVariable(), value)
  print(KittenDismount_SavedVars["surgeForward"])
end

local function RegisterCheckbox(category, variable, variableKey, name, defaultValue, tooltip)
  local setting = Settings.RegisterAddOnSetting(category, variable, variableKey, KittenDismount_SavedVars, Settings.VarType.Boolean, name, defaultValue)
  setting:SetValueChangedCallback(OnSettingChanged)
  Settings.CreateCheckbox(category, setting, tooltip)
end

function KittenDismount_dump(o)
  if type(o) == 'table' then
     local s = '{ '
     for k,v in pairs(o) do
        if type(k) ~= 'number' then k = '"'..k..'"' end
        s = s .. '['..k..'] = ' .. KittenDismount_dump(v) .. ','
     end
     return s .. '} '
  else
     return tostring(o)
  end
end


do
  local name = "Surge Forward"
  local variable = "surgeForwardToggle"
  local variableKey = "surgeForward"
  local variableTbl = KittenDismount_SavedVars
  local defaultValue = true
  local tooltip = "Automatically dismount when Surge Forward is cast while on the ground."

  RegisterCheckbox(category, variable, variableKey, name, defaultValue, tooltip)
end
do
  local name = "Skyward Ascent"
  local variable = "skywardAscentToggle"
  local variableKey = "skywardAscent"
  local variableTbl = KittenDismount_SavedVars
  local defaultValue = false
  local tooltip = "Automatically dismount when Skyward Ascent is cast while on the ground."

  RegisterCheckbox(category, variable, variableKey, name, defaultValue, tooltip)
end
do
  local name = "Whirling Surge"
  local variable = "whirlingSurgeToggle"
  local variableKey = "whirlingSurge"
  local variableTbl = KittenDismount_SavedVars
  local defaultValue = true
  local tooltip = "Automatically dismount when Whirling Surge is cast while on the ground."

  RegisterCheckbox(category, variable, variableKey, name, defaultValue, tooltip)
end
do
  local name = "Aeriel Halt"
  local variable = "aerielHaltToggle"
  local variableKey = "aerielHalt"
  local variableTbl = KittenDismount_SavedVars
  local defaultValue = true
  local tooltip = "Automatically dismount when Aeriel Halt is cast while on the ground."

  RegisterCheckbox(category, variable, variableKey, name, defaultValue, tooltip)
end
do
  local name = "Second Wind"
  local variable = "secondWindToggle"
  local variableKey = "secondWind"
  local variableTbl = KittenDismount_SavedVars
  local defaultValue = false
  local tooltip = "Automatically dismount when Second Wind is cast while on the ground."

  RegisterCheckbox(category, variable, variableKey, name, defaultValue, tooltip)
end

Settings.RegisterAddOnCategory(category)
