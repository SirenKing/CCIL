attacking_hurts_lua = class({})

function attacking_hurts_lua:IsHidden()
	return true
end

function attacking_hurts_lua:RemoveOnDeath()
	return false
end

function attacking_hurts_lua:AllowIllusionDuplicate()
	return true
end

function attacking_hurts_lua:IsPurgable()
	return false
end

function attacking_hurts_lua:OnDestroy()
	if not IsServer() then return end

	self:GetParent():EmitSound("DOTA_Item.BladeMail.Deactivate")
end

function attacking_hurts_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_EVENT_ON_TAKEDAMAGE,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
	}

	return funcs
end

function attacking_hurts_lua:GetModifierPhysicalArmorBonus()
	local strength = self:GetAbility():GetSpecialValueFor("bonus_arm")
	return strength
end

function attacking_hurts_lua:GetModifierBonusStats_Intellect()
	local intellect = self:GetAbility():GetSpecialValueFor("bonus_int")
	return intellect
end

function attacking_hurts_lua:GetModifierPreAttack_BonusDamage()
	local damageBonus = self:GetAbility():GetSpecialValueFor("attack_damage")
	return damageBonus
end

function attacking_hurts_lua:GetModifierMagicalResistanceBonus()
	local magicRes = self:GetAbility():GetSpecialValueFor("magic_res")
	return magicRes
end

function attacking_hurts_lua:GetModifierConstantHealthRegen()
	local healthRegen = self:GetAbility():GetSpecialValueFor("health_regen")
	return healthRegen
end

function attacking_hurts_lua:OnTakeDamage(params)

	if params.unit == self:GetParent() then

		local passiveReflect = self:GetAbility():GetSpecialValueFor("passive_ref")/100
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
