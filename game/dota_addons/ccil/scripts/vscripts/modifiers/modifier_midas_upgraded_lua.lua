modifier_midas_upgraded_lua = class({})

function modifier_midas_upgraded_lua:OnCreated()
	if IsServer() then
		self:StartIntervalThink(1.0)
	end
end

function modifier_midas_upgraded_lua:OnIntervalThink()
	if IsServer() then
		print("Thinker is thinking...")
		self:GetParent():ModifyGold(2, false, 0)
	end
end

function modifier_midas_upgraded_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}

	return funcs
end

function modifier_midas_upgraded_lua:GetModifierBonusStats_Agility()
	local hero = self:GetCaster()
	local agiGain = hero:GetAgilityGain()*100
	if agiGain < 50 then
		agiGain = 50
	end
	local gold = hero:GetGold()
	local agility = gold/agiGain
	return agility
end

function modifier_midas_upgraded_lua:GetModifierBonusStats_Strength()
	local hero = self:GetCaster()
	local gold = hero:GetGold()
	local strGain = hero:GetStrengthGain()*100
	if strGain < 50 then
		strGain = 50
	end
	local strength = gold/strGain
	return strength
end

function modifier_midas_upgraded_lua:GetModifierBonusStats_Intellect()
	local hero = self:GetCaster()
	local gold = hero:GetGold()
	local intGain = hero:GetIntellectGain()*100
	if intGain < 50 then
		intGain = 50
	end
	local intellect = gold/intGain
	return intellect
end

function modifier_midas_upgraded_lua:GetModifierAttackSpeedBonus_Constant()
	local attackSpeed = self:GetAbility():GetSpecialValueFor("attack_speed")
	return attackSpeed
end
