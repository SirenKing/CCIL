BUTTINGS = BUTTINGS or {}

-- This is the primary barebones gamemode script and should be used to assist in initializing your game mode
BAREBONES_VERSION = "1.00"

-- Set this to true if you want to see a complete debug output of all events/processes done by barebones
-- You can also change the cvar 'barebones_spew' at any time to 1 or 0 for output/no output
BAREBONES_DEBUG_SPEW = false 

if GameMode == nil then
    print( '[BAREBONES] creating barebones game mode' )
    _G.GameMode = class({})
end

_G.ADDON_FOLDER = debug.getinfo(1,"S").source:sub(2,-37)
_G.PUBLISH_DATA = LoadKeyValues(ADDON_FOLDER:sub(5,-16).."publish_data.txt") or {}
_G.WORKSHOP_TITLE = PUBLISH_DATA.title or "Dota 2 Butt Template"-- LoadKeyValues(debug.getinfo(1,"S").source:sub(7,-53).."publish_data.txt").title

require("internal/utils/util")
require("internal/init")

require("internal/courier") -- EditFilterToCourier called from internal/filters

require("internal/utils/butt_api")
require("internal/utils/custom_gameevents")
require("internal/utils/particles")
-- require("internal/utils/notifications") -- will test it tomorrow 

require("internal/filters")
require("internal/panorama")
require("internal/shortcuts")
require("internal/talents")
require("internal/thinker")
require("internal/xp_modifier")

-- softRequire("events")
softRequire("filters")
softRequire("settings_butt")
softRequire("settings_misc")
require('settings')
softRequire("startitems")
softRequire("thinker")

require('libraries/timers')
require('libraries/physics')
require('libraries/projectiles')
require('libraries/notifications')
require('libraries/animations')
require('libraries/attachments')
require('libraries/playertables')
require('libraries/containers')
require('libraries/modmaker')
require('libraries/pathgraph')
require('libraries/selection')

require('internal/gamemode')
require('internal/events')

require('events')


-- This is a detailed example of many of the containers.lua possibilities, but only activates if you use the provided "playground" map
if GetMapName() == "playground" then
  require("examples/playground")
end

--require("examples/worldpanelsExample")

--[[
  This function should be used to set up Async precache calls at the beginning of the gameplay.

  In this function, place all of your PrecacheItemByNameAsync and PrecacheUnitByNameAsync.  These calls will be made
  after all players have loaded in, but before they have selected their heroes. PrecacheItemByNameAsync can also
  be used to precache dynamically-added datadriven abilities instead of items.  PrecacheUnitByNameAsync will 
  precache the precache{} block statement of the unit and all precache{} block statements for every Ability# 
  defined on the unit.

  This function should only be called once.  If you want to/need to precache more items/abilities/units at a later
  time, you can call the functions individually (for example if you want to precache units in a new wave of
  holdout).

  This function should generally only be used if the Precache() function in addon_game_mode.lua is not working.
]]

function Activate()
	FireGameEvent("addon_game_mode_activate",nil)
	-- GameRules.GameMode = GameMode()
	-- FireGameEvent("init_game_mode",{})
end

ListenToGameEvent("addon_game_mode_activate", function()
	print( "Dota Butt Template is loaded." )
end, nil)

function GameMode:PostLoadPrecache()
  print("[BAREBONES] Performing Post-Load precache")  
	FireGameEvent("addon_game_mode_precache",nil)
	PrecacheResource("soundfile", "soundevents/custom_sounds.vsndevts", context)  
  --PrecacheItemByNameAsync("item_example_item", function(...) end)
  --PrecacheItemByNameAsync("example_ability", function(...) end)

  --PrecacheUnitByNameAsync("npc_dota_hero_viper", function(...) end)
  --PrecacheUnitByNameAsync("npc_dota_hero_enigma", function(...) end)
end

--[[
  This function is called once and only once as soon as the first player (almost certain to be the server in local lobbies) loads in.
  It can be used to initialize state that isn't initializeable in InitGameMode() but needs to be done before everyone loads in.
]]
function GameMode:OnFirstPlayerLoaded()
  print("[BAREBONES] First Player has loaded")
  if BUTTINGS.BUILDING_DIFFICULTY=="EASY" then
    Gamerules:SetCustomGameDifficulty(1)
    elseif BUTTINGS.BUILDING_DIFFICULTY=="NORMAL" then
    Gamerules:SetCustomGameDifficulty(2)
    elseif BUTTINGS.BUILDING_DIFFICULTY=="HARD" then
    Gamerules:SetCustomGameDifficulty(3)
    elseif BUTTINGS.BUILDING_DIFFICULTY=="TITANIC" then
    Gamerules:SetCustomGameDifficulty(4)
  elseif BUTTINGS.BUILDING_DIFFICULTY=="GODLIKE" then
  Gamerules:SetCustomGameDifficulty(5)
  end
end

--[[
  This function is called once and only once after all players have loaded into the game, right as the hero selection time begins.
  It can be used to initialize non-hero player state or adjust the hero selection (i.e. force random etc)
]]
function GameMode:OnAllPlayersLoaded()
  print("[BAREBONES] All Players have loaded into the game")
end

--[[
  This function is called once and only once for every player when they spawn into the game for the first time.  It is also called
  if the player's hero is replaced with a new hero for any reason.  This function is useful for initializing heroes, such as adding
  levels, changing the starting gold, removing/adding abilities, adding physics, etc.

  The hero parameter is the hero entity that just spawned in
]]
function GameMode:OnHeroInGame(hero)
  print("[BAREBONES] Hero spawned in game for first time -- " .. hero:GetUnitName())

  -- This line for example will set the starting gold of every hero to 500 unreliable gold
  --hero:SetGold(500, false)

  -- These lines will create an item and add it to the player, effectively ensuring they start with the item
  local item = CreateItem("item_example_item", hero, hero)
  hero:AddItem(item)

  --[[ --These lines if uncommented will replace the W ability of any hero that loads into the game
    --with the "example_ability" ability

  local abil = hero:GetAbilityByIndex(1)
  hero:RemoveAbility(abil:GetAbilityName())
  hero:AddAbility("example_ability")]]
end

--[[
  This function is called once and only once when the game completely begins (about 0:00 on the clock).  At this point,
  gold will begin to go up in ticks if configured, creeps will spawn, towers will become damageable etc.  This function
  is useful for starting any game logic timers/thinkers, beginning the first round, etc.
]]
function GameMode:OnGameInProgress()
  print("[BAREBONES] The game has officially begun")
end

function Spawn()
	FireGameEvent("addon_game_mode_spawn",nil)
	local gmE = GameRules:GetGameModeEntity()

	gmE:SetUseDefaultDOTARuneSpawnLogic(true)
	gmE:SetTowerBackdoorProtectionEnabled(true)
	GameRules:SetShowcaseTime(0)

	FireGameEvent("created_game_mode_entity",{gameModeEntity = gmE})
end

-- This function initializes the game mode and is called before anyone loads into the game
-- It can be used to pre-initialize any values/tables that will be needed later
function GameMode:InitGameMode()
  GameMode = self
  print('[BAREBONES] Starting to load Barebones gamemode...')

  -- Commands can be registered for debugging purposes or as functions that can be called by the custom Scaleform UI
  Convars:RegisterCommand( "command_example", Dynamic_Wrap(GameMode, 'ExampleConsoleCommand'), "A console command example", FCVAR_CHEAT )

  print('[BAREBONES] Done loading Barebones gamemode!\n\n')
end

-- This is an example console command
function GameMode:ExampleConsoleCommand()
  print( '******* Example Console Command ***************' )
  local cmdPlayer = Convars:GetCommandClient()
  if cmdPlayer then
    local playerID = cmdPlayer:GetPlayerID()
    if playerID ~= nil and playerID ~= -1 then
      -- Do something here for the player who called this command
      PlayerResource:ReplaceHeroWith(playerID, "npc_dota_hero_viper", 1000, 1000)
    end
  end

  print( '*********************************************' )
end