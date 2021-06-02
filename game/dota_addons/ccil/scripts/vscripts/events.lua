require('tower_abilities')
require('settings_butt')

ListenToGameEvent("dota_player_killed",function(keys)
	-- for k,v in pairs(keys) do print("dota_player_killed",k,v) end
	local playerID = keys.PlayerID
	local heroKill = keys.HeroKill
	local towerKill = keys.TowerKill

end, nil)

ListenToGameEvent("entity_killed", function(keys)
	-- for k,v in pairs(keys) do	print("entity_killed",k,v) end
	local attackerUnit = keys.entindex_attacker and EntIndexToHScript(keys.entindex_attacker)
	local killedUnit = keys.entindex_killed and EntIndexToHScript(keys.entindex_killed)
	local damagebits = keys.damagebits -- This might always be 0 and therefore useless

	if (killedUnit and killedUnit:IsRealHero()) then
		-- when a hero dies
	end

end, nil)

ListenToGameEvent("npc_spawned", function(keys)
	-- for k,v in pairs(keys) do print("npc_spawned",k,v) end
	local spawnedUnit = keys.entindex and EntIndexToHScript(keys.entindex)

end, nil)

ListenToGameEvent("game_rules_state_change", function(keys)
	-- for k,v in pairs(keys) do print("npc_spawned",k,v) end
	if (GameRules:State_Get()==DOTA_GAMERULES_STATE_PRE_GAME) then

    local difficulty = nil

    if BUTTINGS.BUILDING_DIFFICULTY=="EASY" then
      difficulty = 1
    elseif BUTTINGS.BUILDING_DIFFICULTY=="NORMAL" then
      difficulty = 2
    elseif BUTTINGS.BUILDING_DIFFICULTY=="HARD" then
      difficulty = 3
    elseif BUTTINGS.BUILDING_DIFFICULTY=="TITANIC" then
      difficulty = 4
    elseif BUTTINGS.BUILDING_DIFFICULTY=="GODLIKE" then
      difficulty = 5
    end

    GameRules:SetCustomGameDifficulty( difficulty )

    local towers = Entities:FindAllByClassname("npc_dota_tower")
    print("There are ", #towers, " towers on the map!")

    for i=1,#towers do
      towers[i]:AddAbility("building_difficulty")
      towers[i]:AddAbility("building_cast")

      for a=1,BUTTINGS.TOWER_ABILITIES do

        local abilityName
        
        repeat
          abilityName = RollForAbility()
        until( towers[i]:HasAbility(abilityName)==false )

        local ability = towers[i]:AddAbility(abilityName)      
        local maxLevel = ability:GetMaxLevel()
        ability:SetLevel(maxLevel)
        if ability:IsToggle() then
          ability:ToggleAbility()
        end
      end
    end

    local forts = Entities:FindAllByClassname("npc_dota_fort")
    print("There are ", #forts, " on the map!")

    for i=1,#forts do
      forts[i]:AddAbility("building_difficulty")
    end

    local barracks = Entities:FindAllByClassname("npc_dota_barracks")
    print("There are ", #barracks, " on the map!")

    for i=1,#barracks do
      barracks[i]:AddAbility("building_difficulty")
    end

    local fillers = Entities:FindAllByClassname("npc_dota_filler")
    print("There are ", #fillers, " on the map!")

    for i=1,#fillers do
      fillers[i]:AddAbility("building_difficulty")
    end

  end

end, nil)

ListenToGameEvent("entity_hurt", function(keys)
	-- for k,v in pairs(keys) do print("entity_hurt",k,v) end
	local damage = keys.damage
	local attackerUnit = keys.entindex_attacker and EntIndexToHScript(keys.entindex_attacker)
	local victimUnit = keys.entindex_killed and EntIndexToHScript(keys.entindex_killed)
	local damagebits = keys.damagebits -- This might always be 0 and therefore useless

end, nil)

ListenToGameEvent("dota_player_gained_level", function(keys)
	-- for k,v in pairs(keys) do print("dota_player_gained_level",k,v) end
	local newLevel = keys.level
	local playerEntindex = keys.player
	local playerUnit = EntIndexToHScript(playerEntindex)
	local heroUnit = playerUnit:GetAssignedHero()
	
end, nil)

ListenToGameEvent("dota_player_used_ability", function(keys)
	-- for k,v in pairs(keys) do print("dota_player_used_ability",k,v) end
	local casterUnit = keys.caster_entindex and EntIndexToHScript(keys.caster_entindex)
	local abilityname = keys.abilityname
	local playerID = keys.PlayerID
	local player = keys.PlayerID and PlayerResource:GetPlayer(keys.PlayerID)
	-- local ability = casterUnit and casterUnit.FindAbilityByName and casterUnit:FindAbilityByName(abilityname) -- bugs if hero has 2 times the same ability

end, nil)

ListenToGameEvent("last_hit", function(keys)
	-- for k,v in pairs(keys) do print("last_hit",k,v) end
	local killedUnit = keys.EntKilled and EntIndexToHScript(keys.EntKilled)
	local playerID = keys.PlayerID
	local firstBlood = keys.FirstBlood
	local heroKill = keys.HeroKill
	local towerKill = keys.TowerKill

end, nil)

ListenToGameEvent("dota_tower_kill", function(keys)
	-- for k,v in pairs(keys) do print("dota_tower_kill",k,v) end
	local gold = keys.gold
	local towerTeam = keys.teamnumber
	local killer_userid = keys.killer_userid

end, nil)

------------------------------------------ example --------------------------------------------------

ListenToGameEvent("this_is_just_an_example", function(keys)
	local targetUnit = EntIndexToHScript(keys.entindex)

	local neighbours = FindUnitsInRadius(
		targetUnit:GetTeam(), -- int teamNumber, 
		targetUnit:GetAbsOrigin(), -- Vector position, 
		false, -- handle cacheUnit, 
		1000, -- float radius,
		DOTA_UNIT_TARGET_TEAM_FRIENDLY, -- int teamFilter, 
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_CREEP, -- int typeFilter, 
		DOTA_UNIT_TARGET_FLAG_NOT_ILLUSIONS + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE, -- int flagFilter, 
		FIND_ANY_ORDER, -- int order, 
		false -- bool canGrowCache
	)

	for n,neighUnit in pairs(neighbours) do

		ApplyDamage({
			victim = neighUnit,
			attacker = targetUnit,
			damage = 100,
			damage_type = DAMAGE_TYPE_MAGICAL,
			damage_flags = DOTA_DAMAGE_FLAG_NON_LETHAL,
			ability = nil
		})

		neighUnit:AddNewModifierButt(
			targetUnit, -- handle caster, 
			nil, -- handle optionalSourceAbility, 
			"someweirdmodifier", -- string modifierName, 
			{duration = 5} -- handle modifierData
		)

	end
end, nil)