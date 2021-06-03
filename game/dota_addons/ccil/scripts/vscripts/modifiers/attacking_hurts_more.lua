attacking_hurts_more_lua = class({})

function attacking_hurts_more_lua:IsHidden()
	return false
end

function attacking_hurts_more_lua:RemoveOnDeath()
	return true
end

function attacking_hurts_more_lua:AllowIllusionDuplicate()
	return true
end

function attacking_hurts_more_lua:IsPurgable()
	return false
end

function attacking_hurts_more_lua:OnDestroy()
	if not IsServer() then return end

	self:GetParent():EmitSound("DOTA_Item.BladeMail.Deactivate")
end

function attacking_hurts_more_lua:GetEffectName()
	return "particles/basic_ambient/blademail_golden.vpcf"
end

function attacking_hurts_more_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function attacking_hurts_more_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_TAKEDAMAGE,
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE
	}

	return funcs
end

function attacking_hurts_more_lua:OnTakeDamage(params)

	if params.unit == self:GetParent() then

		local passiveReflect = self:GetAbility():GetSpecialValueFor("active_ref")/100
		local originalAttacker = params.attacker
		local originalDamage = params.original_damage
		local damageType = params.damage_type

		if not params.unit:IsOther() and params.attacker:IsAlive() and bit.band(params.damage_flags, DOTA_DAMAGE_FLAG_REFLECTION) ~= DOTA_DAMAGE_FLAG_REFLECTION then
		EmitSoundOnClient("DOTA_Item.BladeMail.Damage", params.attacker:GetPlayerOwner())

			if params.inflictor and not params.inflictor:GetAbilityName()=="item_blade_mail" and not params.inflictor:GetAbilityName()=="spectre_dispersion" then
				if self:GetParent() == params.unit then

					if self:GetParent():IsIllusion() then
						local originalDamage = originalDamage*.1
					end
					local DamageInfo = {
								victim = originalAttacker,
								attacker = self:GetParent(),
								damage = originalDamage*passiveReflect,
								damage_flags	= DOTA_DAMAGE_FLAG_REFLECTION + DOTA_DAMAGE_FLAG_NO_SPELL_LIFESTEAL + DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION,
								damage_type = damageType,
								ability = self:GetAbility()
								}
					ApplyDamage(DamageInfo)
				end
			end

		end
	end
end

function attacking_hurts_more_lua:GetModifierIncomingDamage_Percentage()
	local damageReduction = 0 - self:GetAbility():GetSpecialValueFor("dmg_red_amt")
	return damageReduction
end
