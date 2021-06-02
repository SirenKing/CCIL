LinkLuaModifier( "modifier_midas_upgraded_lua", "modifiers/modifier_midas_upgraded_lua.lua", LUA_MODIFIER_MOTION_NONE )

if item_hand_of_midas_upgraded == nil then
    item_hand_of_midas_upgraded = class({})
end

function item_hand_of_midas_upgraded:GetIntrinsicModifierName( keys )
  return "modifier_midas_upgraded_lua"
end
