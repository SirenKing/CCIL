LinkLuaModifier( "modifier_item_diamond_spectacle", "modifiers/modifier_item_diamond_spectacle.lua", LUA_MODIFIER_MOTION_NONE )

if item_diamond_spectacle == nil then
  item_diamond_spectacle = class({})
end

function item_diamond_spectacle:GetIntrinsicModifierName( keys )
  return "modifier_item_diamond_spectacle"
end
