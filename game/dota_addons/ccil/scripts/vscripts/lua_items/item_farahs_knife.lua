LinkLuaModifier( "attacks_reduce_cooldowns_lua", "modifiers/attacks_reduce_cooldowns_lua.lua", LUA_MODIFIER_MOTION_NONE )

if item_farahs_knife == nil then
    item_farahs_knife = class({})
end

function item_farahs_knife:GetIntrinsicModifierName( keys )
  return "attacks_reduce_cooldowns_lua"
end
