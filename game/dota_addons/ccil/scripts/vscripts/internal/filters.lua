BUTTINGS = BUTTINGS or {}

InternalFilters = class({})

ListenToGameEvent("addon_game_mode_activate",function()
	local contxt = {}
	GameRules:GetGameModeEntity():SetAbilityTuningValueFilter( InternalFilters.AbilityTuningValueFilter, contxt )
	GameRules:GetGameModeEntity():SetBountyRunePickupFilter( InternalFilters.BountyRunePickupFilter, contxt )
	GameRules:GetGameModeEntity():SetDamageFilter( InternalFilters.DamageFilter, contxt )
	GameRules:GetGameModeEntity():SetExecuteOrderFilter( InternalFilters.ExecuteOrderFilter, contxt )
	GameRules:GetGameModeEntity():SetHealingFilter( InternalFilters.HealingFilter, contxt )
	GameRules:GetGameModeEntity():SetItemAddedToInventoryFilter( InternalFilters.ItemAddedToInventoryFilter, contxt )
	GameRules:GetGameModeEntity():SetModifierGainedFilter( InternalFilters.ModifierGainedFilter, contxt )
	GameRules:GetGameModeEntity():SetModifyExperienceFilter( InternalFilters.ModifyExperienceFilter, contxt )
	GameRules:GetGameModeEntity():SetModifyGoldFilter( InternalFilters.ModifyGoldFilter, contxt )
	GameRules:GetGameModeEntity():SetRuneSpawnFilter( InternalFilters.RuneSpawnFilter, contxt )
	GameRules:GetGameModeEntity():SetTrackingProjectileFilter( InternalFilters.TrackingProjectileFilter, contxt )
end, nil)

function InternalFilters:AbilityTuningValueFilter(event)
	return Filters:AbilityTuningValueFilter(event)
end

function InternalFilters:BountyRunePickupFilter(event)
	event.xp_bounty = event.xp_bounty * BUTTINGS.XP_GAIN_PERCENTAGE * 0.01
	event.gold_bounty = event.gold_bounty * BUTTINGS.GOLD_GAIN_PERCENTAGE * 0.01

	return Filters:BountyRunePickupFilter(event)
end

function InternalFilters:DamageFilter(event)
	return Filters:DamageFilter(event)
end

function InternalFilters:ExecuteOrderFilter(event)
	local iUnit = event.units and event.units["0"]
	local hero = EntIndexToHScript(iUnit)

	if 1==BUTTINGS.BUYBACK_RULES and DOTA_UNIT_ORDER_BUYBACK==event.order_type then
		self.bbCount = self.bbCount or {}
		self.bbCount[iUnit] = self.bbCount[iUnit] or BUTTINGS.BUYBACK_LIMIT
		if self.bbCount[iUnit] <= 0 then
			HUDError("No buybacks left", hero:GetPlayerOwnerID())
			return false 
		else
			hero:SetThink(function() hero:SetBuybackCooldownTime(BUTTINGS.BUYBACK_COOLDOWN) end, 0.2)
			self.bbCount[iUnit] = self.bbCount[iUnit] - 1 
		end
	end

	if EditFilterToCourier and false==EditFilterToCourier(event) then
		return false
	end

	if event.order_type==DOTA_UNIT_ORDER_PURCHASE_ITEM then
		local itemName = event.shop_item_name
		print(itemName)
		if itemName == "item_recipe_storm_scythe" and BUTTINGS.BAN_STORM_SCYTHE==1 then
			HUDError("Item is Banned", hero:GetPlayerOwnerID())
			return false
		end
		if itemName == "item_recipe_hand_of_midas_upgraded" and BUTTINGS.BAN_FIST_OF_GILGAMESH==1 then
			HUDError("Item is Banned", hero:GetPlayerOwnerID())
			return false
		end
		if itemName == "item_recipe_flask_of_ambrosia_datadriven" and BUTTINGS.BAN_FLASK_OF_AMBROSIA==1 then
			HUDError("Item is Banned", hero:GetPlayerOwnerID())
			return false
		end
		if itemName == "item_diamond_spectacle" and BUTTINGS.BAN_ODIN_SPECTACLE==1 then
			HUDError("Item is Banned", hero:GetPlayerOwnerID())
			return false
		end
		if itemName == "item_recipe_viper_cleats" and BUTTINGS.BAN_VIPER_CLEATS==1 then
			HUDError("Item is Banned", hero:GetPlayerOwnerID())
			return false
		end
		if itemName == "item_recipe_staff_of_fate" and BUTTINGS.BAN_STAFF_OF_FATE==1 then
			HUDError("Item is Banned", hero:GetPlayerOwnerID())
			return false
		end
		if itemName == "item_recipe_farahs_knife" and BUTTINGS.BAN_FARAHS_KNIFE==1 then
			HUDError("Item is Banned", hero:GetPlayerOwnerID())
			return false
		end
		if itemName == "item_scorpion_bow" and BUTTINGS.BAN_SCORPION_BOW==1 then
			HUDError("Item is Banned", hero:GetPlayerOwnerID())
			return false
		end
		if itemName == "item_recipe_thorn_plate" and BUTTINGS.BAN_THORN_PLATE==1 then
			HUDError("Item is Banned", hero:GetPlayerOwnerID())
			return false
		end
	end

	return Filters:ExecuteOrderFilter(event)
end

function InternalFilters:HealingFilter(event)
	return Filters:HealingFilter(event)
end

function InternalFilters:ItemAddedToInventoryFilter(event)
	return Filters:ItemAddedToInventoryFilter(event)
end

function InternalFilters:ModifierGainedFilter(event)
	return Filters:ModifierGainedFilter(event)
end

function InternalFilters:ModifyExperienceFilter(event)
	event.experience = event.experience * BUTTINGS.XP_GAIN_PERCENTAGE * 0.01

	-- PrintTable(event)
	local playerID = event.player_id_const
	local reason = event.reason_const
	local xp = event.experience -- can not get modified with local

	local heroUnit = playerID and PlayerResource:GetSelectedHeroEntity(playerID)
	
	-- ##
	local out = Filters:ModifyExperienceFilter(event)
	-- ##

	local teamHeroes = PlayerResourceButt:GetMainFriendlyHeroes(event.player_id_const)
	teamHeroes[event.player_id_const] = nil
	local count = table.length(teamHeroes)

	local singleAmt = event.experience * BUTTINGS.SHARED_XP_PERCENTAGE * 0.01 / count
	singleAmt = math.floor(singleAmt + 0.5)

	for h,hero in pairs(teamHeroes) do
		event.experience = event.experience - singleAmt
		hero:AddExperience(singleAmt, DOTA_ModifyXP_Unspecified, false, true)
	end

	return out
end

function InternalFilters:ModifyGoldFilter(event)
	event.gold = event.gold * BUTTINGS.GOLD_GAIN_PERCENTAGE * 0.01

	-- PrintTable(event) 
	local playerID = event.player_id_const
	local reason = event.reason_const
	local gold = event.gold -- can not get modified with local
	local reliable = event.reliable -- can not get modified with local
	
	local heroUnit = playerID and PlayerResource:GetSelectedHeroEntity(playerID)

	-- ##
	local out = Filters:ModifyGoldFilter(event)
	-- ##
	
	local teamPlayers = PlayerResourceButt:GetFriendlyPlayers(event.player_id_const)
	teamPlayers[event.player_id_const] = nil
	local count = table.length(teamPlayers)

	local singleAmt = event.gold * BUTTINGS.SHARED_GOLD_PERCENTAGE * 0.01 / count
	singleAmt = math.floor(singleAmt + 0.5)

	for tp,tPlayer in pairs(teamPlayers) do
		event.gold = event.gold - singleAmt
		PlayerResource:ModifyGold(tp,singleAmt,(1 == event.reliable),DOTA_ModifyGold_SharedGold)
	end
	return out
end


function InternalFilters:RuneSpawnFilter(event)
	-- PrintTable(event)
	-- maybe deprecated? 
	return Filters:RuneSpawnFilter(event)
end

function InternalFilters:TrackingProjectileFilter(event)
	return Filters:TrackingProjectileFilter(event)
end
