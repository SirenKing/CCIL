require('internal/utils/util')

if ChangeTargets == nil then
	ChangeTargets = class({})
end

function ChangeTargets:IsHidden()
	return false
end

function ChangeTargets:RemoveOnDeath()
	return true
end

function ChangeTargets:AllowIllusionDuplicate()
	return false
end

function ChangeTargets:GetEffectName()
	return "particles/econ/items/viper/viper_ti7_immortal/viper_poison_debuff_ti7_puddle_bubble.vpcf"
end

function ChangeTargets:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function ChangeTargets:DeclareFunctions() --we want to use these functions in this item
    local funcs = {
        MODIFIER_EVENT_ON_ATTACK_LANDED,
				MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
				MODIFIER_EVENT_ON_ORDER,
    }

    return funcs
end

-- function ChangeTargets:GetModifierMoveSpeedBonus_Constant()
-- 	return 50
-- end

function ChangeTargets:GetModifierProcAttack_Feedback(event)

	-- DeepPrintTable(event)

  local attacker = event.attacker
  local target = event.target
	local attacker_position = attacker:GetAbsOrigin()
	local attacker_entid = attacker:entindex()
	local target_entid = target:entindex()

  -- Get units in radius of target
  local nearby_units =  FindUnitsInRadius(
                          attacker:GetTeamNumber(),
                          attacker_position,
                          nil,
                          400,
                          DOTA_UNIT_TARGET_TEAM_ENEMY,
                          DOTA_UNIT_TARGET_ALL,
                          DOTA_UNIT_TARGET_FLAG_NONE,
                          FIND_ANY_ORDER,
                          false
                        )

	local new_target = nearby_units[RandomInt(1,#nearby_units)]

	-- DeepPrintTable(nearby_units)

  if ( #nearby_units > 1 and attacker:IsControllableByAnyPlayer() ) then

    -- Make the attacker switch targets
    ExecuteOrderFromTable({
        UnitIndex = attacker:entindex(),
        OrderType = DOTA_UNIT_ORDER_ATTACK_TARGET,
        TargetIndex = new_target:entindex()
    })

  end

	return event
end

function ChangeTargets:IsHidden()
    return false
end

function ChangeTargets:IsPermanent()
	return false
end

function ChangeTargets:IsPurgable()
	return true
end

-- function ChangeTargets:CheckState(event)
--   DeepPrintTable(event)
--   local state = {
-- 	[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
-- 	}
--
-- 	return state
-- end
