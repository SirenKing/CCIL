modifier_item_storm_scythe = modifier_item_storm_scythe or class({})

LinkLuaModifier( "modifier_item_storm_scythe_debuff", "modifiers/modifier_item_storm_scythe_debuff.lua", LUA_MODIFIER_MOTION_NONE )

function modifier_item_storm_scythe:IsPermanent() return false end
function modifier_item_storm_scythe:RemoveOnDeath() return false end
function modifier_item_storm_scythe:IsHidden() return true end
function modifier_item_storm_scythe:IsDebuff() return false end

function modifier_item_storm_scythe:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_EVENT_ON_ATTACK_LANDED,
	}
	return funcs
end

function modifier_item_storm_scythe:GetModifierPreAttack_BonusDamage()
	return self:GetAbility():GetSpecialValueFor("damage_bonus")
end

function modifier_item_storm_scythe:OnAttackLanded(params)
	if params.attacker == self:GetParent() then
		if params.target:IsBuilding()==false then
			local damageTable = {
				victim = params.target,
				attacker = self:GetParent(),
				damage = params.target:GetPhysicalArmorBaseValue() * self:GetAbility():GetSpecialValueFor("damage_per_armor"),
				damage_type = DAMAGE_TYPE_PURE,
				damage_flags = nil,
				ability = self:GetAbility()
			}
			ApplyDamage(damageTable)
			params.target:AddNewModifier( params.attacker, self:GetAbility(), "modifier_item_storm_scythe_debuff", { duration = 7 })
		end
	end
end