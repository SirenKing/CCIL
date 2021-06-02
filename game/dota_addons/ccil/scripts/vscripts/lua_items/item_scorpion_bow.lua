LinkLuaModifier( "modifier_item_scorpion_bow", "modifiers/modifier_item_scorpion_bow.lua", LUA_MODIFIER_MOTION_NONE )

if item_scorpion_bow == nil then
    item_scorpion_bow = class({})
end

function item_scorpion_bow:GetIntrinsicModifierName(keys)
  return "modifier_item_scorpion_bow"
end
