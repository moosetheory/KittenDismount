local surgeForward = 372608;
local skywardAscent = 372610;
local whirlingSurge = 361584;
local aerielHalt = 403092;
local secondWind = 425782;

local frame = CreateFrame("Frame", "DismountAddonFrame");
frame:RegisterEvent("UNIT_SPELLCAST_SENT");

local function OnEvent(self, event, ...)
  if event == "UNIT_SPELLCAST_SENT" then
    print(KittenDismount_SavedVars)
    print(KittenDismount_SavedVars.surgeForward)
    local unit, target, castGUID, spellID = ...;
    if not IsFlying() then
      if spellID == surgeForward or spellID == whirlingSurge or spellID == aerielHalt then
        Dismount()
      end
    end
  end
end

frame:SetScript("OnEvent", OnEvent)

-- Hi Kitten!
