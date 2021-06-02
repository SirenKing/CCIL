LinkLuaModifier( "modifier_item_storm_scythe", "modifiers/modifier_item_storm_scythe.lua", LUA_MODIFIER_MOTION_NONE )

if item_storm_scythe == nil then
    item_storm_scythe = class({})
end

function item_storm_scythe:GetIntrinsicModifierName(keys)
  return "modifier_item_storm_scythe"
end
