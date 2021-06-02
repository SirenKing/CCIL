BUTTINGS = BUTTINGS or {}

require("internal/utils/butt_api")

ListenToGameEvent("game_rules_state_change", function()
	if (GameRules:State_Get()==DOTA_GAMERULES_STATE_HERO_SELECTION) then
		
		GameRules:SetSameHeroSelectionEnabled( 1 == BUTTINGS.ALLOW_SAME_HERO_SELECTION )
		GameRules:SetUseUniversalShopMode( 1 == BUTTINGS.UNIVERSAL_SHOP_MODE )
		GameRules:SetGoldTickTime( 60/BUTTINGS.GOLD_PER_MINUTE )

		
		GameRules:GetGameModeEntity():SetCustomXPRequiredToReachNextLevel( BUTTINGS.ALTERNATIVE_XP_TABLE() )
		GameRules:GetGameModeEntity():SetUseCustomHeroLevels(BUTTINGS.MAX_LEVEL~=25)
		GameRules:SetUseCustomHeroXPValues(BUTTINGS.MAX_LEVEL~=25)
		GameRules:GetGameModeEntity():SetCustomHeroMaxLevel(BUTTINGS.MAX_LEVEL)

		if ("AR"==BUTTINGS.GAME_MODE) then
			local time = (BUTTINGS.HERO_BANNING) and 16 or 0
			GameRules:GetGameModeEntity():SetThink( function()
				for p,player in pairs(PlayerList:GetValidTeamPlayers()) do
					player:MakeRandomHeroSelection()
				end
			end, time)
		end
	-- elseif (GameRules:State_Get()>=DOTA_GAMERULES_STATE_PRE_GAME) then
		-- GameRules:GetGameModeEntity():SetThink( function(asd)
		-- 	if (1==BUTTINGS.FREE_COURIER) then TeamList:GetFreeCouriers() end
		-- end, 5 )
	end
end, nil)

-- local l1 = ListenToGameEvent("npc_spawned", function(keys)
-- 	if (1==BUTTINGS.FREE_COURIER) then
-- 		local unit = EntIndexToHScript(keys.entindex)
-- 		local alreadyHasCourier = PlayerResource:GetNthCourierForTeam(0, unit:GetTeam())
-- 		if (unit:GetName()=="npc_dota_courier") and (alreadyHasCourier) and (unit~=alreadyHasCourier) then
-- 			unit:Destroy()
-- 		end
-- 	elseif (GameRules:State_Get()>=DOTA_GAMERULES_STATE_PRE_GAME) then
-- 		StopListeningToGameEvent(l1)
-- 	end
-- end, nil)


ListenToGameEvent("dota_player_pick_hero", function(keys)
end, self)

ListenToGameEvent("dota_player_killed",function(kv)
	if (1==BUTTINGS.ALT_WINNING) then
		-- local unit = PlayerResource:GetSelectedHeroEntity(kv.PlayerID)
		for _,t in ipairs(TeamList:GetPlayableTeams()) do
			if (PlayerResource:GetTeamKills(t)>=BUTTINGS.ALT_KILL_LIMIT) then
				GameRules:SetGameWinner(t)
			end
		end
end
end, nil)

ListenToGameEvent("entity_killed", function(keys)
	local killedUnit = EntIndexToHScript(keys.entindex_killed)
	if killedUnit:IsRealHero() and not killedUnit:IsTempestDouble() and not killedUnit:IsReincarnating() then

		-- fix respawn lvl>25
		if (killedUnit:GetLevel()>25) then
			print(killedUnit,killedUnit:GetName(),4*killedUnit:GetLevel())
			killedUnit:SetTimeUntilRespawn(4*killedUnit:GetLevel())
		end

		-- tombstone
		if (1==BUTTINGS.TOMBSTONE) then
			local tombstoneItem = CreateItem("item_tombstone", killedUnit, killedUnit)
			if (tombstoneItem) then
				local tombstone = SpawnEntityFromTableSynchronous("dota_item_tombstone_drop", {})
				tombstone:SetContainedItem(tombstoneItem)
				tombstone:SetAngles(0, RandomFloat(0, 360), 0)
				FindClearSpaceForUnit(tombstone, killedUnit:GetAbsOrigin(), true)
			end
		end

	end
end, nil)

-- The overall game state has changed
function GameMode:_OnGameRulesStateChange(keys)
  if GameMode._reentrantCheck then
    return
  end

  local newState = GameRules:State_Get()
  if newState == DOTA_GAMERULES_STATE_WAIT_FOR_PLAYERS_TO_LOAD then
    self.bSeenWaitForPlayers = true
  elseif newState == DOTA_GAMERULES_STATE_INIT then
    --Timers:RemoveTimer("alljointimer")
  elseif newState == DOTA_GAMERULES_STATE_HERO_SELECTION then
    GameMode:PostLoadPrecache()
    GameMode:OnAllPlayersLoaded()

    if USE_CUSTOM_TEAM_COLORS_FOR_PLAYERS then
      for i=0,9 do
        if PlayerResource:IsValidPlayer(i) then
          local color = TEAM_COLORS[PlayerResource:GetTeam(i)]
          PlayerResource:SetCustomPlayerColor(i, color[1], color[2], color[3])
        end
      end
    end
  elseif newState == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
    GameMode:OnGameInProgress()
  end

  GameMode._reentrantCheck = true
  GameMode:OnGameRulesStateChange(keys)
  GameMode._reentrantCheck = false
end

-- An NPC has spawned somewhere in game.  This includes heroes
function GameMode:_OnNPCSpawned(keys)
  print("something spawned")
  if GameMode._reentrantCheck then
    return
  end

  local npc = EntIndexToHScript(keys.entindex)

  if npc:IsRealHero() and npc.bFirstSpawned == nil then
    npc.bFirstSpawned = true
    GameMode:OnHeroInGame(npc)
  end

  GameMode._reentrantCheck = true
  GameMode:OnNPCSpawned(keys)
  GameMode._reentrantCheck = false
end

-- An entity died
function GameMode:_OnEntityKilled( keys )
  if GameMode._reentrantCheck then
    return
  end

  -- The Unit that was Killed
  local killedUnit = EntIndexToHScript( keys.entindex_killed )
  -- The Killing entity
  local killerEntity = nil

  if keys.entindex_attacker ~= nil then
    killerEntity = EntIndexToHScript( keys.entindex_attacker )
  end

  if killedUnit:IsRealHero() then 
    DebugPrint("KILLED, KILLER: " .. killedUnit:GetName() .. " -- " .. killerEntity:GetName())
    if END_GAME_ON_KILLS and GetTeamHeroKills(killerEntity:GetTeam()) >= KILLS_TO_END_GAME_FOR_TEAM then
      GameRules:SetSafeToLeave( true )
      GameRules:SetGameWinner( killerEntity:GetTeam() )
    end

    --PlayerResource:GetTeamKills
    if SHOW_KILLS_ON_TOPBAR then
      GameRules:GetGameModeEntity():SetTopBarTeamValue ( DOTA_TEAM_BADGUYS, GetTeamHeroKills(DOTA_TEAM_BADGUYS) )
      GameRules:GetGameModeEntity():SetTopBarTeamValue ( DOTA_TEAM_GOODGUYS, GetTeamHeroKills(DOTA_TEAM_GOODGUYS) )
    end
  end

  GameMode._reentrantCheck = true
  GameMode:OnEntityKilled( keys )
  GameMode._reentrantCheck = false
end

-- This function is called once when the player fully connects and becomes "Ready" during Loading
function GameMode:_OnConnectFull(keys)
  if GameMode._reentrantCheck then
    return
  end

  GameMode:_CaptureGameMode()

  local entIndex = keys.index+1
  -- The Player entity of the joining user
  local ply = EntIndexToHScript(entIndex)
  
  local userID = keys.userid

  self.vUserIds = self.vUserIds or {}
  self.vUserIds[userID] = ply

  GameMode._reentrantCheck = true
  GameMode:OnConnectFull( keys )
  GameMode._reentrantCheck = false
end