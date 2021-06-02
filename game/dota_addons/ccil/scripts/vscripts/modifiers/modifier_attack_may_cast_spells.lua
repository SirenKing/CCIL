if modifier_attack_may_cast_spells == nil then
    modifier_attack_may_cast_spells = class({})
end

function modifier_attack_may_cast_spells:OnCreated(keys)
    if not IsServer() then return end
    self:SetStackCount(1)
    local hHero = self:GetParent()
    self.args = keys
    self.args.itemProcChance  = 0
    self.args.illProcChance  = 0
    self.args.procChance  = 25
    self.trolls = {}
    self.trolls[1] =    "warlock_upheaval"
    self.trolls[2] =    "windrunner_powershot"
    self.trolls[3] =    "item_travel_boots"
    self.trolls[4] =    "item_travel_boots_2"
    self.trolls[5] =    "item_helm_of_the_dominator"
    if self:CheckOption(self.args.disableTrollAbilities) then
        self.trolls[6] =    "chen_holy_persuasion"
        self.trolls[7] =    "ember_spirit_sleight_of_fist"
        self.trolls[8] =    "enigma_black_hole"
        self.trolls[9] =    "enchantress_enchant"
        self.trolls[10] =    "furion_wrath_of_nature"
        self.trolls[11] =    "life_stealer_infest"
        self.trolls[12] =   "life_stealer_assimilate"
        self.trolls[13] =   "morphling_morph"
        self.trolls[14] =   "enraged_wildkin_tornado"
        self.trolls[15] =    "zuus_thundergods_wrath"
        self.trolls[16] =    "enigma_demonic_conversion"
        self.trolls[17] =    "item_hand_of_midas"
        if self:CheckOption(self.args.dsilence) then
            self.trolls[18] =   "silencer_global_silence"
        end
    end

    self.ill_trolls = {}
    self.ill_trolls[1] = "antimage_blink"
    self.ill_trolls[2] = "chaos_knight_phantasm"
    self.ill_trolls[3] = "naga_siren_mirror_image"
    self.ill_trolls[4] = "phantom_lancer_spirit_lance"
    self.ill_trolls[5] = "phantom_lancer_doppelwalk"
    self.ill_trolls[6] = "spectre_haunt"
    self.ill_trolls[7] = "terrorblade_conjure_image"
    self.ill_trolls[8] = "arc_warden_tempest_double"
    self.ill_trolls[9] = "item_manta"
    self.ill_trolls[10] = "item_illusionsts_cape"

    self.problematic = {}
    self.problematic[1] = "tidehunter_anchor_smash"
    self.problematic[2] = "arc_warden_tempest_double"
    self.problematic[3] = "monkey_king_boundless_strike"
    self.problematic[4] = "mars_gods_rebuke"
    self.problematic[5] = "void_spirit_astral_step"

    self.channelSpecial = {}
    self.channelSpecial[1] = "sandking_epicenter"
    self.channelSpecial[2] = "oracle_fortunes_end"
    self.channelSpecial[3] = "elder_titan_echo_stomp"

    self.castdebug = {}
end

function modifier_attack_may_cast_spells:DebugAbility(sAbility)
    if (self.castdebug[sAbility] == nil) then
        print("First Cast: " .. sAbility)
        self.castdebug[sAbility] = true
        self:SendDebugNote("First Cast","Ability : " .. sAbility,3)
    end
end

function modifier_attack_may_cast_spells:DebugUnit()
    local ablityList = "Abilities: "
    local hHero = self:GetParent()
    for i = 0, hHero:GetAbilityCount()-1 do
        local hAbility = hHero:GetAbilityByIndex(i)
        if (hAbility and hAbility:GetAbilityName() ~= nil and hAbility:GetAbilityName() ~= "") then
            ablityList = ablityList .. " " .. hAbility:GetAbilityName()
            print("Death: " .. hAbility:GetAbilityName())
        end
    end
    self:SendDebugNote("Death",ablityList,3)
end

function modifier_attack_may_cast_spells:SendDebugNote(header,content,time)
    CustomGameEventManager:Send_ServerToAllClients("debug_notifications",{header=header,content=content,time=time})
end

function modifier_attack_may_cast_spells:DeclareFunctions()
    return    {
    MODIFIER_EVENT_ON_DEATH,
    MODIFIER_EVENT_ON_ABILITY_EXECUTED,
    MODIFIER_EVENT_ON_ATTACK_LANDED,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
    MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE ,
    }
end


function modifier_attack_may_cast_spells:GetModifierBonusStats_Intellect()
	local intellect = self:GetAbility():GetSpecialValueFor("bonus_int")
	return intellect
end

function modifier_attack_may_cast_spells:GetModifierAttackSpeedBonus_Constant()
	local attackSpeed = self:GetAbility():GetSpecialValueFor("attack_speed")
	return attackSpeed
end

function modifier_attack_may_cast_spells:GetModifierSpellAmplify_Percentage(params)
	local caster = self:GetCaster()
	local int = caster:GetIntellect()
	print("Int is", int)
	local amplify = int/5
	return amplify
end

function modifier_attack_may_cast_spells:CheckCreep(npc)
	local name = npc:GetUnitName()
	if (name ~= nil and string.find(name,"npc_dota_creep_") ~= nil) then return true end
	return false
end
function modifier_attack_may_cast_spells:OnDeath(keys)
    if not IsServer() then return end
    if keys.unit ~= self:GetParent() then return end
    if (keys.unit:IsBuilding()) or self:CheckCreep(keys.unit) then
        self:DebugUnit()
    end
end

function modifier_attack_may_cast_spells:OnAbilityExecuted(keys)
    if not IsServer() then return end
    if keys.unit ~= self:GetParent() then return end
    if not keys.ability:IsItem() and not self:CheckTrollAbility(keys.ability)  then
        if self:CheckOption(self.args.noultimate) and keys.ability:GetAbilityType() == 1  then return end
        self.last_spell = keys.ability:GetAbilityIndex()
    end
end

function modifier_attack_may_cast_spells:GetRandomSpell()
    local hHero = self:GetParent()
    local tPossible = {}
    for i = 0, hHero:GetAbilityCount()-1 do

        local hAbility = hHero:GetAbilityByIndex(i)
        local cdTotal = 1
        local cdFactor = 1
        invChanceTable = {}
        local cdTotal = 1

        if (hAbility) then
            if not hAbility:IsItem() and hAbility:IsTrained() and hAbility:IsStealable() and not hAbility:IsPassive() and not self:CheckTrollAbility(hAbility) then
                if not self:CheckProblematic(hAbility) then
                    if not (hHero:IsIllusion() or hHero:IsTempestDouble()) or not self:InList(self.ill_trolls,hAbility) then
                        tPossible[#tPossible+1] = hAbility
                    end
                end
            end
        end
    end

    -- if self.args.itemProcChance > 0 then
    --     for i = 0, 5 do
    --         local hAbility = hHero:GetItemInSlot(i)
    --             if (hAbility ~= nil) then
    --             if (self:CheckItem(hAbility))then
    --                 if not (hHero:IsIllusion() or hHero:IsTempestDouble()) or not self:InList(self.ill_trolls,hAbility) then
    --                     tPossible[#tPossible+1] = hAbility
    --                 end
    --             end
    --         end
    --     end
    -- end
    return tPossible
end

function modifier_attack_may_cast_spells:CheckItem(hAbility)
    if hAbility:IsItem() and not hAbility:IsPassive() and not self:InList(self.trolls,hAbility) then
        if (RandomInt(0,100) < self.args.itemProcChance) then
            return true;
        end
    end
    return false;
end

function modifier_attack_may_cast_spells:GetLastSpell()
    if not self.last_spell or self.last_spell == -1 then
        local hIllLast = self:GetRandomSpell()
        if (hIllLast) then
            self.last_spell = hIllLast:GetAbilityIndex()
        else
            self.last_spell = -1
        end
    end
    if self.last_spell and self.last_spell > -1 then
        local hHero = self:GetParent()
        local hAbility = self:GetParent():GetAbilityByIndex(self.last_spell)
        if not self:CheckProblematic(hAbility) then
            if not hHero:IsIllusion() or not self:InList(self.ill_trolls,hAbility) then
                return hAbility
            end
        end
    end
    return nil
end

function modifier_attack_may_cast_spells:CastASpell(hTarget)

    print("Casting a Spell")
    local hHero = self:GetParent()
    local chance = .45
    local tPossible = self:GetRandomSpell()
    local abilityLvl
    local invChanceTable = {}

    if #tPossible > 0 then
      for i=1,#tPossible do
        print(tPossible[i])
        local name = tPossible[i]:GetAbilityName()
        local abilityLevel = hHero:FindAbilityByName(name):GetLevel()
        local newCooldown = hHero:FindAbilityByName(name):GetCooldown(abilityLevel)
        invChanceTable[#invChanceTable+1] = 1/newCooldown
        print(invChanceTable[i])
      end

    -- if hHero.IsIllusion and hHero:IsIllusion() then
    --     chance = chance * self.args.illProcChance
    -- else
    --     chance = chance * self.args.procChance
    -- end

    for i=1,#invChanceTable do
      local hAbility = tPossible[i]
      if invChanceTable[i] > .66 then
        invChanceTable[i] = .66
      end
      if (hAbility) and (RandomFloat(0.0,1.0) < invChanceTable[i]*chance) and self:GetAbility():IsCooldownReady() and not hHero:IsIllusion() then
         -- self:CheckDebug(hAbility)
          local nTeam = hAbility:GetAbilityTargetTeam() or DOTA_UNIT_TARGET_TEAM_BOTH
          local nFlags = hAbility:GetAbilityTargetType() or DOTA_UNIT_TARGET_ALL
          local nBehav = hAbility:GetBehavior()
          local hSpellTarget = hTarget
          local cooldown = self:GetAbility():GetCooldown(1)

          self:GetAbility():StartCooldown(cooldown)

          if (self:FlagCheck(nBehav,DOTA_ABILITY_BEHAVIOR_UNIT_TARGET)) and not (self:FlagCheck(nBehav,DOTA_ABILITY_BEHAVIOR_POINT)) then
              if self:CheckOption(self.args.strict) then
                  hSpellTarget = self:FindStrictTarget(hAbility,hTarget)
              else
                  if (nTeam == DOTA_UNIT_TARGET_TEAM_FRIENDLY) then
                      hSpellTarget = self:FindTarget(DOTA_UNIT_TARGET_TEAM_FRIENDLY,DOTA_UNIT_TARGET_ALL,hTarget,hAbility)
                  else
                      hSpellTarget = self:FindTarget(DOTA_UNIT_TARGET_TEAM_ENEMY,DOTA_UNIT_TARGET_ALL,hTarget,hAbility)
                  end
              end
          end
          if (hSpellTarget) then
              --print("cast: " .. hAbility:GetAbilityName())
              if (hHero:IsBuilding() or self:CheckCreep(hHero)) then
                  self:DebugAbility(hAbility:GetAbilityName())
              end
              hHero:SetCursorCastTarget(hSpellTarget)
              hHero:SetCursorPosition(hSpellTarget:GetAbsOrigin())
              --if not (self:NeedSpecial(hAbility,hSpellTarget)) then
              if (not hSpellTarget:TriggerSpellAbsorb(hAbility)) then
                  hAbility:OnAbilityPhaseStart()
                  hAbility:OnSpellStart()
                  if (self:FlagCheck(nBehav,DOTA_ABILITY_BEHAVIOR_CHANNELLED)) then
                      --hAbility:SetChanneling(true)
                      --for j=0,hAbility:GetChannelTime() do
                      --    hAbility:OnChannelThink(1)
                        --end
                    if (self:InList(self.channelSpecial,hAbility)) then hAbility:OnChannelFinish(false) end
                    -- hAbility:SetChanneling(false)
                    end
                  end
              end
             -- end
          end
      end
    end
end

function modifier_attack_may_cast_spells:CheckOption(op)
    return (op == 1 or op == true)
end

function modifier_attack_may_cast_spells:OnAttackLanded(keys)
    if not IsServer() then return end
        if keys.attacker ~= self:GetParent() then return end
    local hTarget = keys.target
    local hHero = keys.attacker
    if not keys.target:IsAlive() then return end
    if not keys.attacker:IsAlive() then return end

    if hHero:IsDisarmed() then return end
    if hHero:IsSilenced() and self:CheckOption(self.args.dsilence) then return end
    if hHero:PassivesDisabled() and self:CheckOption(self.args.dbreak) then return end
    if hTarget:IsMagicImmune() and self:CheckOption(self.args.dimmune) then return end
    if hTarget:HasModifier("modifier_fountain_glyph") then return end

    self:CastASpell(hTarget)
end

function modifier_attack_may_cast_spells:FlagCheck(iFlags,i)
    return (bit.band(iFlags,i) == i)
end

function modifier_attack_may_cast_spells:FlagFilter(nTeam,nFlags,hTarget,hHero)
    if (self:FlagCheck(nTeam ,DOTA_UNIT_TARGET_TEAM_FRIENDLY) and hTarget:GetTeamNumber() ~= hHero:GetTeamNumber()) then return 1 end
    if (self:FlagCheck(nTeam ,DOTA_UNIT_TARGET_TEAM_ENEMY) and hTarget:GetTeamNumber() == hHero:GetTeamNumber()) then return 1 end
    if (self:FlagCheck(nFlags ,DOTA_UNIT_TARGET_BUILDING) and hTarget:IsBuilding()) then return 0 end
    if (self:FlagCheck(nFlags ,DOTA_UNIT_TARGET_CREEP) and hTarget:IsCreep()) then return 0 end
    if (self:FlagCheck(nFlags ,DOTA_UNIT_TARGET_HERO) and hTarget:IsHero()) then return 0 end
    if (self:FlagCheck(nFlags ,DOTA_UNIT_TARGET_BASIC) and hTarget:IsCreature()) then return 0 end
    if (self:FlagCheck(nFlags ,DOTA_UNIT_TARGET_CUSTOM) and (hTarget:IsCreep() and (hTarget:IsNeutralUnitType() and not hTarget:IsAncient()))) then return 0 end
    return 2
end

function modifier_attack_may_cast_spells:FindStrictTarget(hAbility,hcTarget)
    local hHero = self:GetParent()
    local nTeam = hAbility:GetAbilityTargetTeam() or DOTA_UNIT_TARGET_TEAM_BOTH
    local nFlags = hAbility:GetAbilityTargetType() or DOTA_UNIT_TARGET_ALL
    local nBehav = hAbility:GetBehavior()
    if (self:FlagCheck(nBehav,DOTA_ABILITY_BEHAVIOR_UNIT_TARGET)) then
        local nRes = self:FlagFilter(nTeam,nFlags,hcTarget,hHero)
        if nRes == 0 then
            return hcTarget
        end
        local vPos = hcTarget:GetAbsOrigin()
        local tTargets = FindUnitsInRadius( hHero:GetTeamNumber(), vPos, nil, 500, nTeam, nFlags, 0, FIND_FARTHEST, false )
        local hEnemy = nil
        hcTarget = nil
        local hFriendly = hHero
        if #tTargets > 0 then
            for _,hTarget in pairs(tTargets) do
                if hTarget ~= nil and ( not hTarget:IsMagicImmune() ) and ( not hTarget:IsInvulnerable() ) then
                    if self:FlagFilter(nTeam,nFlags,hTarget,hHero) == 0 then
                        if (hHero:CanEntityBeSeenByMyTeam(hTarget)) then
                            hcTarget = hTarget
                        end
                    end
                end
            end
        end
    elseif (self:FlagCheck(nTeam,DOTA_UNIT_TARGET_TEAM_FRIENDLY)) then
        hcTarget = hHero
    end
    return hcTarget
end

function modifier_attack_may_cast_spells:FindTarget(nTeam,nFlags,hcTarget,hAbility)
    local hHero = self:GetParent()
    local nTeam = hAbility:GetAbilityTargetTeam() or DOTA_UNIT_TARGET_TEAM_BOTH
    local nBehav = hAbility:GetBehavior()
    if (self:FlagCheck(DOTA_ABILITY_BEHAVIOR_UNIT_TARGET,nBehav)) then
        local nRes = self:FlagFilter(nTeam,DOTA_UNIT_TARGET_ALL,hcTarget,hHero)
        if nRes == 0 then
            return hcTarget
        end
        local vPos = hHero:GetAbsOrigin()
        local tTargets = FindUnitsInRadius( hHero:GetTeamNumber(), vPos, nil, 500, nTeam, nFlags, 0, FIND_FARTHEST, false )
        local hEnemy = nil
        local hFriendly = hHero
        if #tTargets > 0 then
            for _,hTarget in pairs(tTargets) do
                if hTarget ~= nil and ( not hTarget:IsMagicImmune() ) and ( not hTarget:IsInvulnerable() ) then
                    if (hHero:CanEntityBeSeenByMyTeam(hTarget)) then
                        hcTarget = hTarget
                    end
                end
            end
        end
    elseif (self:FlagCheck(DOTA_UNIT_TARGET_TEAM_FRIENDLY,nTeam)) then
        hcTarget = hHero
    end
    return hcTarget
end

function modifier_attack_may_cast_spells:IsDebuff() return false end
function modifier_attack_may_cast_spells:DestroyOnExpire() return false end
function modifier_attack_may_cast_spells:IsDebuff() return false end
function modifier_attack_may_cast_spells:IsHidden() return true end
function modifier_attack_may_cast_spells:IsPermanent() return true end
function modifier_attack_may_cast_spells:IsPurgable() return false end
function modifier_attack_may_cast_spells:IsPurgeException() return false end
function modifier_attack_may_cast_spells:IsStunDebuff() return false end
function modifier_attack_may_cast_spells:AllowIllusionDuplicate() return false end
function modifier_attack_may_cast_spells:GetAttributes() return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE + MODIFIER_ATTRIBUTE_PERMANENT end


function modifier_attack_may_cast_spells:CheckTrollAbility(hAbility)
    local name = hAbility:GetAbilityName()
    for k,v in pairs(self.trolls) do
        if (name == v) then return true end
    end
    return false
end

function modifier_attack_may_cast_spells:CheckProblematic(hAbility)
    local name = hAbility:GetAbilityName()
    for k,v in pairs(self.problematic) do
        if (name == v) then
            if self.args.problematicChance < 100 then
                return (RandomInt(0,100) > self.args.problematicChance)
            else
                return false
            end
        end
    end
    return false
end

function modifier_attack_may_cast_spells:InList(list,hAbility)
    local name = hAbility:GetAbilityName()
    for k,v in pairs(list) do
        if (v == name) then
            return true
        end
    end
    return false
end
function modifier_attack_may_cast_spells:DebugStuff(hAbility)
    local nTeam = hAbility:GetAbilityTargetTeam()
    local nFlags = hAbility:GetAbilityTargetType()
    local nBehav = hAbility:GetBehavior()
    print("----- Debug Ability -----")
    print("Ability: " .. hAbility:GetAbilityName())
    print("Teams: " .. nTeam)
    print("Flags: " .. nFlags)
    print("Behaviour: " .. nBehav)


end
