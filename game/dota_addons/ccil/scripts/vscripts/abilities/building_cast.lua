LinkLuaModifier("modifier_tower_may_cast_spells", "modifiers/modifier_tower_may_cast_spells", LUA_MODIFIER_MOTION_NONE)

building_cast = class ({})

function building_cast:GetIntrinsicModifierName()
  return "modifier_tower_may_cast_spells"
end
