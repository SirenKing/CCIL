modifier_item_viper_cleats = modifier_item_viper_cleats or class({})

LinkLuaModifier( "modifier_item_viper_cleats_melee", "modifiers/modifier_item_viper_cleats_melee.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_item_viper_cleats_ranged", "modifiers/modifier_item_viper_cleats_ranged.lua", LUA_MODIFIER_MOTION_NONE )

-- check out https://developer.valvesoftware.com/wiki/Dota_2_Workshop_Tools/Scripting/API

-- The modifier Tooltip is inside resource/addon_english.txt (Have fun playing)


function modifier_item_viper_cleats:GetTexture() return "item_orb_of_venom" end -- get the icon from a different ability

function modifier_item_viper_cleats:IsPermanent() return false end
function modifier_item_viper_cleats:RemoveOnDeath() return false end
function modifier_item_viper_cleats:IsHidden() return true end 	-- we can hide the modifier
function modifier_item_viper_cleats:IsDebuff() return false end 	-- make it red or green

function modifier_item_viper_cleats:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_ATTACK_LANDED,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_UNIQUE,
		MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE_MIN,
		-- these functions are usually called with everyone on the map
		-- check the link for more
		-- https://developer.valvesoftware.com/wiki/Dota_2_Workshop_Tools/Scripting/API#modifierfunction
	}
	return funcs
end

function modifier_item_viper_cleats:OnAttackLanded( params )
	if params.attacker == self:GetParent() and not params.target:IsBuilding() then
		local attacker = params.attacker
		if attacker:IsRangedAttacker() then
			params.target:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_item_viper_cleats_ranged", { duration = self:GetAbility():GetSpecialValueFor("poison_duration")})
		else
			params.target:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_item_viper_cleats_melee", { duration = self:GetAbility():GetSpecialValueFor("poison_duration")})
		end
	end
end

function modifier_item_viper_cleats:GetModifierMoveSpeedBonus_Special_Boots()
	return self:GetAbility():GetSpecialValueFor("ms_bonus")
end

function modifier_item_viper_cleats:GetModifierMoveSpeed_AbsoluteMin()
	return self:GetAbility():GetSpecialValueFor("min_ms_bonus") + 100
end

-- passing a number to the Tooltip in resource/addon_english.txt
-- with %dMODIFIER_PROPERTY_TOOLTIP%
function modifier_item_viper_cleats:OnTooltip(event)
	return 123
end

function modifier_item_viper_cleats:OnCreated(event)
	self:StartIntervalThink(1)
	-- for k,v in pairs(event) do print("modifier_item_viper_cleats created",k,v,(IsServer() and "on Server" or "on Client")) end
	-- called when the modifier is created
end

function modifier_item_viper_cleats:OnRefresh(event)
	local stacks = self:GetStackCount()
	self:SetStackCount(stacks+1)-- called when the modifier is refreshed
end

function modifier_item_viper_cleats:OnDeath(event)
	-- for k,v in pairs(event) do print("OnDeath",k,v) end -- find out what event.__ to use
	self:SetStackCount(0)
	if IsClient() then return end
	if event.unit~=self:GetParent() then return end -- only affect the own hero
	-- space for some fancy stuff
end
