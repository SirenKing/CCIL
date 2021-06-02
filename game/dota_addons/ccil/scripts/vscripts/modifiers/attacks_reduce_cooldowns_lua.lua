attacks_reduce_cooldowns_lua = class({})


function attacks_reduce_cooldowns_lua:IsHidden()
	return true
end


function attacks_reduce_cooldowns_lua:RemoveOnDeath()
	return false
end


function attacks_reduce_cooldowns_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_EVENT_ON_ATTACK_LANDED,
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
	}

	return funcs
end

function attacks_reduce_cooldowns_lua:GetModifierBonusStats_Strength()
	local strength = self:GetAbility():GetSpecialValueFor("bonus_str")
	return strength
end

function attacks_reduce_cooldowns_lua:GetModifierBonusStats_Intellect()
	local intellect = self:GetAbility():GetSpecialValueFor("bonus_int")
	return intellect
end

function attacks_reduce_cooldowns_lua:GetModifierAttackSpeedBonus_Constant()
	local attackSpeed = self:GetAbility():GetSpecialValueFor("attack_speed")
	return attackSpeed
end

function attacks_reduce_cooldowns_lua:GetModifierConstantManaRegen()
	local manaRegen = self:GetAbility():GetSpecialValueFor("mana_regen")
	return manaRegen
end

function attacks_reduce_cooldowns_lua:GetModifierConstantManaRegen()
	local healthRegen = self:GetAbility():GetSpecialValueFor("health_regen")
	return healthRegen
end

function attacks_reduce_cooldowns_lua:GetModifierConstantManaRegen()
	local damageBonus = self:GetAbility():GetSpecialValueFor("attack_damage")
	return damageBonus
end

if IsServer() then
	function attacks_reduce_cooldowns_lua:OnAttackLanded(keys)
		local parent = self:GetParent()
		local cdDrop = self:GetAbility():GetSpecialValueFor("cd_drop")
		if keys.attacker == parent and parent:IsRealHero() and self:GetAbility():IsCooldownReady() then

			for i = 0, parent:GetAbilityCount() - 1 do
				local ability = parent:GetAbilityByIndex(i)
				reduce_cooldown(ability, cdDrop)
			end
		self:GetAbility():StartCooldown(self:GetAbility():GetCooldown(1))
		end
	end
end


function reduce_cooldown(ability, cdDrop)
	if ability and not ability:IsCooldownReady() then
		local remaining = ability:GetCooldownTimeRemaining()

		ability:EndCooldown()

		if remaining > cdDrop then
			ability:StartCooldown(remaining - cdDrop)
		end
	end
end
