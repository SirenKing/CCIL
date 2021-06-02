modifier_item_diamond_spectacle = modifier_item_diamond_spectacle or class({})

function modifier_item_diamond_spectacle:GetTexture() return "sven_gods_strength" end -- get the icon from a different ability

function modifier_item_diamond_spectacle:IsPermanent() return false end
function modifier_item_diamond_spectacle:RemoveOnDeath() return false end
function modifier_item_diamond_spectacle:IsHidden() return true end 	-- we can hide the modifier
function modifier_item_diamond_spectacle:IsDebuff() return false end 	-- make it red or green

function modifier_item_diamond_spectacle:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL,
		MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL_VALUE,
	}
	return funcs
end

function modifier_item_diamond_spectacle:OnRefresh(event)
	self:OnCreated()
end

function modifier_item_diamond_spectacle:GetModifierOverrideAbilitySpecial( params )
	local ability = params.ability
	
	-- Unomment this shit if you don't want items to work
	-- Reverse for working items
	if ability:IsItem() then return 1 end

	return 1
end

-----------------------------------------------------------------------

function modifier_item_diamond_spectacle:GetModifierOverrideAbilitySpecialValue( params )

	local szAbilityName = params.ability:GetAbilityName()
	local szSpecialValueName = params.ability_special_value

	if string.find(szSpecialValueName, "radius") then
		local nSpecialLevel = params.ability_special_level
		local flBaseValue = params.ability:GetLevelSpecialValueNoOverride( szSpecialValueName, nSpecialLevel )
		print( 'modifier_atest:GetModifierOverrideAbilitySpecialValue - radius is ' .. flBaseValue .. '. becoming ' .. (flBaseValue * 1.15) + 125 )

		return (flBaseValue * 1.15) + 125

	elseif string.find(szSpecialValueName, "area_of_effect") then
		local nSpecialLevel = params.ability_special_level
		local flBaseValue = params.ability:GetLevelSpecialValueNoOverride( szSpecialValueName, nSpecialLevel )
		print( 'modifier_atest:GetModifierOverrideAbilitySpecialValue - radius is ' .. flBaseValue .. '. becoming ' .. (flBaseValue * 1.15) + 125 )

		return (flBaseValue * 1.15) + 125

	elseif string.find(szSpecialValueName, "_aoe") then
		local nSpecialLevel = params.ability_special_level
		local flBaseValue = params.ability:GetLevelSpecialValueNoOverride( szSpecialValueName, nSpecialLevel )
		print( 'modifier_atest:GetModifierOverrideAbilitySpecialValue - radius is ' .. flBaseValue .. '. becoming ' .. (flBaseValue * 1.15) + 125 )

		return (flBaseValue * 1.15) + 125

	elseif string.find(szSpecialValueName, "aoe_") then
		local nSpecialLevel = params.ability_special_level
		local flBaseValue = params.ability:GetLevelSpecialValueNoOverride( szSpecialValueName, nSpecialLevel )
		print( 'modifier_atest:GetModifierOverrideAbilitySpecialValue - radius is ' .. flBaseValue .. '. becoming ' .. (flBaseValue * 1.15) + 125 )

		return (flBaseValue * 1.15) + 125

	else		
		local nSpecialLevel = params.ability_special_level
		local flBaseValue = params.ability:GetLevelSpecialValueNoOverride( szSpecialValueName, nSpecialLevel )

		print("This ability has no special radius")

		return flBaseValue

	end

end
