modifier_item_viper_cleats_melee = modifier_item_viper_cleats_melee or class({})

-- check out https://developer.valvesoftware.com/wiki/Dota_2_Workshop_Tools/Scripting/API

-- The modifier Tooltip is inside resource/addon_english.txt (Have fun playing)


function modifier_item_viper_cleats_melee:GetTexture() return "item_orb_of_dogshit_icon" end -- get the icon from a different ability

function modifier_item_viper_cleats_melee:IsPermanent() return false end
function modifier_item_viper_cleats_melee:RemoveOnDeath() return true end
function modifier_item_viper_cleats_melee:IsHidden() return false end 	-- we can hide the modifier
function modifier_item_viper_cleats_melee:IsDebuff() return true end 	-- make it red or green

function modifier_item_viper_cleats_melee:IsPurgable()
	return true
end

function modifier_item_viper_cleats_melee:GetEffectName()
	return "particles/items2_fx/orb_of_venom.vpcf"
end

function modifier_item_viper_cleats_melee:OnIntervalThink()
	local stacks = self:GetStackCount()
	if stacks == 0 then
		stacks = 1
	end
	local damgePS = self:GetAbility():GetSpecialValueFor("poison_damage_per_second")
	local damageInfo = {
		victim = self:GetParent(),
		attacker = self:GetCaster(),
		damage = damgePS*stacks,
		damage_type = DAMAGE_TYPE_MAGICAL,
		damage_flags = nil,
		ability = self:GetAbility()
	}
	ApplyDamage(damageInfo)
end

function modifier_item_viper_cleats_melee:GetAttributes()
	return 0
		-- + MODIFIER_ATTRIBUTE_PERMANENT           -- Modifier passively remains until strictly removed.
		-- + MODIFIER_ATTRIBUTE_MULTIPLE            -- Allows modifier to stack with itself.
		-- + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE -- Allows modifier to be assigned to invulnerable entities.
end

function modifier_item_viper_cleats_melee:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_TOOLTIP
		-- these functions are usually called with everyone on the map
		-- check the link for more
		-- https://developer.valvesoftware.com/wiki/Dota_2_Workshop_Tools/Scripting/API#modifierfunction
	}
	return funcs
end

function modifier_item_viper_cleats_melee:GetModifierMoveSpeedBonus_Percentage()
	local stacks = self:GetStackCount()
	if stacks == 0 then
		stacks = 1
	end
	local baseSlow = 1 - self:GetAbility():GetSpecialValueFor("poison_movement_speed_melee")/100
	local moveSlow = (1 - baseSlow^stacks)*(-100)
	print(moveSlow)
	return moveSlow
end

function modifier_item_viper_cleats_melee:OnTooltip()
	local stacks = self:GetStackCount()
	if stacks == 0 then
		stacks = 1
	end
	local damgePS = self:GetAbility():GetSpecialValueFor("poison_damage_per_second")
	return stacks*damgePS
end

function modifier_item_viper_cleats_melee:OnCreated(event)
	self:StartIntervalThink(1)
	-- for k,v in pairs(event) do print("modifier_item_viper_cleats_melee created",k,v,(IsServer() and "on Server" or "on Client")) end
	-- called when the modifier is created
end

function modifier_item_viper_cleats_melee:OnRefresh(event)
	local stacks = self:GetStackCount()
	self:SetStackCount(stacks+1)-- called when the modifier is refreshed
end

function modifier_item_viper_cleats_melee:OnDeath(event)
	-- for k,v in pairs(event) do print("OnDeath",k,v) end -- find out what event.__ to use
	self:SetStackCount(0)
	if IsClient() then return end
	if event.unit~=self:GetParent() then return end -- only affect the own hero
	-- space for some fancy stuff
end
