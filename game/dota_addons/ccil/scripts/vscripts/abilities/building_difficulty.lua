LinkLuaModifier("building_difficulty", "modifiers/building_difficulty", LUA_MODIFIER_MOTION_NONE)

building_difficulty = class ({})

function building_difficulty:GetIntrinsicModifierName()
  return "building_difficulty"
end
