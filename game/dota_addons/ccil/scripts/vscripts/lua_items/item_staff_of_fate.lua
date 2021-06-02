LinkLuaModifier( "modifier_attack_may_cast_spells", "modifiers/modifier_attack_may_cast_spells.lua", LUA_MODIFIER_MOTION_NONE )

if item_staff_of_fate == nil then
    item_staff_of_fate = class({})
end

function item_staff_of_fate:GetIntrinsicModifierName( keys )
  return "modifier_attack_may_cast_spells"
end
