local frame = CreateFrame("Frame", "DismountAddonFrame");
frame:RegisterEvent("UNIT_SPELLCAST_SENT");

local function OnEvent(self, event, ...)
  if event == "UNIT_SPELLCAST_SENT" then
    local unit, target, castGUID, spellID = ...;
    if not IsFlying() then
      if KittenDismount_disabledSpells[spellID] then
        Dismount()
      end
    end
  end
end

frame:SetScript("OnEvent", OnEvent)

local function OnAddonLoaded()
  KittenDismount_SetDismountArray()
end

EventUtil.ContinueOnAddOnLoaded("KittenDismount", OnAddonLoaded);

-- Hi Kitten!
