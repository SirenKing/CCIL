modifier_item_storm_scythe_debuff = class({})

function modifier_item_storm_scythe_debuff:IsHidden()
	return false
end

function modifier_item_storm_scythe_debuff:RemoveOnDeath()
	return true
end

function modifier_item_storm_scythe_debuff:AllowIllusionDuplicate()
	return true
end

function modifier_item_storm_scythe_debuff:IsPurgable()
	return false
end

function modifier_item_storm_scythe_debuff:IsDebuff()
	return true
end

function modifier_item_storm_scythe_debuff:GetTexture()
	return "item_storm_scythe"
end

function modifier_item_storm_scythe_debuff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}
	return funcs
end

function modifier_item_storm_scythe_debuff:GetModifierPhysicalArmorBonus()
	return -12
end
