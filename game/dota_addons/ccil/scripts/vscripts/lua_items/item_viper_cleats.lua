LinkLuaModifier( "modifier_item_viper_cleats", "modifiers/modifier_item_viper_cleats.lua", LUA_MODIFIER_MOTION_NONE )

if item_viper_cleats == nil then
    item_viper_cleats = class({})
end

function item_viper_cleats:GetIntrinsicModifierName(keys)
  return "modifier_item_viper_cleats"
end
