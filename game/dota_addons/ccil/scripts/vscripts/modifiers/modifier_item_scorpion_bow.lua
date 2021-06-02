modifier_item_scorpion_bow = modifier_item_scorpion_bow or class({})

function modifier_item_scorpion_bow:GetTexture() return "item_orb_of_venom" end

function modifier_item_scorpion_bow:IsPermanent() return false end
function modifier_item_scorpion_bow:RemoveOnDeath() return false end
function modifier_item_scorpion_bow:IsHidden() return true end
function modifier_item_scorpion_bow:IsDebuff() return false end

function modifier_item_scorpion_bow:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PURE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_ATTACK_RANGE_BONUS_PERCENTAGE,
		MODIFIER_EVENT_ON_ATTACK_LANDED,
	}
	return funcs
end

function modifier_item_scorpion_bow:GetModifierProcAttack_BonusDamage_Pure()
	return 50
end

function modifier_item_scorpion_bow:GetModifierAttackSpeedBonus_Constant()
	return -50
end

function modifier_item_scorpion_bow:GetModifierAttackRangeBonusPercentage()
	return -30
end

function modifier_item_scorpion_bow:OnAttackLanded(params)
	if params.attacker == self:GetParent() then
		print("Owner of a scorpion bow hit a target!")
		if params.target:IsBuilding() then
			print("Target is a building!!!")
			local damageTable = {
				victim = params.target,
				attacker = self:GetParent(),
				damage = params.damage * 0.2,
				damage_type = DAMAGE_TYPE_PURE,
				damage_flags = nil,
				ability = self:GetAbility()
			}
			ApplyDamage(damageTable)
		end
	end
end