LinkLuaModifier("modifier_attack_may_cast_spells", "modifiers/modifier_attack_may_cast_spells", LUA_MODIFIER_MOTION_NONE)

building_difficulty = building_difficulty or class({})

function building_difficulty:GetTexture() return "doom_bringer_doom" end

function building_difficulty:IsPermanent() return true end
function building_difficulty:RemoveOnDeath() return false end
function building_difficulty:IsDebuff() return true end
function building_difficulty:IsPurgable() return false end
function building_difficulty:IsHidden() return true end

function building_difficulty:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_EXTRA_HEALTH_PERCENTAGE,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
		MODIFIER_PROPERTY_BASE_ATTACK_TIME_CONSTANT,
		-- MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_MANACOST_PERCENTAGE,
	}

	return funcs
end

function building_difficulty:OnCreated(params)
	print("Difficulty Parent is:", self:GetParent():GetUnitName())
end

function building_difficulty:GetModifierPercentageManacost(params)
	return 100
end

function building_difficulty:GetModifierExtraHealthPercentage(params)
	local healthPerc = 0
	if GameRules:GetDifficulty()==1 then
		healthPerc = -50
	elseif GameRules:GetDifficulty()==2 then
		healthPerc = 0
	elseif GameRules:GetDifficulty()==3 then
		healthPerc = 100
	elseif GameRules:GetDifficulty()==4 then
		healthPerc = 400
	elseif GameRules:GetDifficulty()==5 then
		healthPerc = 1000
	end
	return healthPerc
end

function building_difficulty:GetModifierMagicalResistanceBonus(params)
	local magicPerc = 0
	if GameRules:GetDifficulty()==1 then
		magicPerc = -30
	elseif GameRules:GetDifficulty()==2 then
		magicPerc = 0
	elseif GameRules:GetDifficulty()==3 then
		magicPerc = 30
	elseif GameRules:GetDifficulty()==4 then
		magicPerc = 45
	elseif GameRules:GetDifficulty()==5 then
		magicPerc = 75
	end
	return magicPerc
end

function building_difficulty:GetModifierSpellAmplify_Percentage(params)
	local amplifyPerc = 0
	if GameRules:GetDifficulty()==1 then
		amplifyPerc = -30
	elseif GameRules:GetDifficulty()==2 then
		amplifyPerc = 0
	elseif GameRules:GetDifficulty()==3 then
		amplifyPerc = 50
	elseif GameRules:GetDifficulty()==4 then
		amplifyPerc = 100
	elseif GameRules:GetDifficulty()==5 then
		amplifyPerc = 200
	end
	return amplifyPerc
end

function building_difficulty:GetModifierBaseAttackTimeConstant(params)
	local perc = 1.7
	if GameRules:GetDifficulty()==1 then
		perc = 1.3
	elseif GameRules:GetDifficulty()==2 then
		perc = 0.9
	elseif GameRules:GetDifficulty()==3 then
		perc = 0.7
	elseif GameRules:GetDifficulty()==4 then
		perc = 0.5
	elseif GameRules:GetDifficulty()==5 then
		perc = 0.3
	end
	return perc
end

function building_difficulty:GetModifierPhysicalArmorBonus(params)
	local perc = 1.7
	if GameRules:GetDifficulty()==1 then
		perc = -30
	elseif GameRules:GetDifficulty()==2 then
		perc = 0
	elseif GameRules:GetDifficulty()==3 then
		perc = 100
	elseif GameRules:GetDifficulty()==4 then
		perc = 400
	elseif GameRules:GetDifficulty()==5 then
		perc = 1000
	end
	return perc/100*self:GetParent():GetPhysicalArmorBaseValue()
end
