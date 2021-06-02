LinkLuaModifier( "attacking_hurts_lua", "modifiers/attacking_hurts.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "attacking_hurts_more_lua", "modifiers/attacking_hurts_more.lua", LUA_MODIFIER_MOTION_NONE )

if item_thorn_plate == nil then
    item_thorn_plate = class({})
end

function item_thorn_plate:GetIntrinsicModifierName( keys )
  return "attacking_hurts_lua"
end

function item_thorn_plate:OnSpellStart( keys )
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "attacking_hurts_more_lua", { duration = 4.5 })
	self:GetCaster():EmitSound("DOTA_Item.BladeMail.Activate")
end
