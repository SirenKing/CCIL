BUTTINGS = {
	-- These will be the default settings shown on the Team Select screen.

	GAME_TITLE = WORKSHOP_TITLE,

	GAME_MODE = "AP",                   -- "AR" "AP" All Random/ All Pick
	ALLOW_SAME_HERO_SELECTION = 0,      -- 0 = everyone must pick a different hero, 1 = can pick same
	HERO_BANNING = 1,                   -- 0 = no banning, 1 = banning phase
	USE_BOTS = 0, -- TODO
	MAX_LEVEL = 50,              -- (default = 30) the max level a hero can reach

	UNIVERSAL_SHOP_MODE = 1,            -- 0 = normal, 1 = you can buy every item in every shop (secret/side/base).
	ALWAYS_PASSIVE_GOLD = 0,			-- 0 = normal, 1 = courier dead doesnt affect passive gold
	COOLDOWN_PERCENTAGE = 100,          -- (default = 100) factor for all cooldowns
	GOLD_GAIN_PERCENTAGE = 322,         -- (default = 100) factor for gold income
	GOLD_PER_MINUTE = 90,               -- (default =  90) passive gold
	RESPAWN_TIME_PERCENTAGE = 50,      -- (default = 100) factor for respawn time
	XP_GAIN_PERCENTAGE = 322,           -- (default = 100) factor for xp income

	TOMBSTONE = 0,                      -- 0 = normal, 1 = You spawn a tombstone when you die. Teammates can ressurect you by channeling it.
	MAGIC_RES_CAP = 0,                  -- 0 = normal, 1 = Keeps Magic Resistance <100%
	CLASSIC_ARMOR = 1,                  -- 0 = normal, 1 = Old armor formula (pre 7.20)
	                                    -- set this to 1, if your game mode will feature high amounts of armor or agility
	                                    -- otherwise the physical resistance can go to 100% making things immune to physical damage
	
	NO_UPHILL_MISS = 0,                 -- 0 = normal, 1 = 0% uphill muss chance
	FREE_COURIER = 1,                  -- 0 = buggy volvo, 1 = courier fix
	XP_PER_MINUTE = 0,                  -- (normal dota = 0) everyone gets passive experience (like the passive gold)
	COMEBACK_TIMER = 30,                -- timer (minutes) to start comeback XP / gold 
	COMEBACK_GPM = 60,                  -- passive gold for the poorest team
	COMEBACK_XPPM = 120,                -- passive experience for the lowest team
	SHARED_GOLD_PERCENTAGE = 0,         -- all gold (except passive) is shared with teammates
	SHARED_XP_PERCENTAGE = 0,           -- all experience (except passive) is shared with teammates

	ALT_WINNING = 0,                    -- 0 = normal, 1 = use these alternative winning conditions
	ALT_KILL_LIMIT = 100,               -- Kills for alternative winnning
	ALT_TIME_LIMIT = 60,                -- Timer for alternative winning

	BUYBACK_RULES = 0,                  -- 0 = normal, 1 = use buyback restrictions
	BUYBACK_LIMIT = 1,                  -- Max amount of buybacks
	BUYBACK_COOLDOWN = 600,             -- Cooldown for buyback

	BAN_STORM_SCYTHE = 0,             	-- Allow Item
	BAN_FIST_OF_GILGAMESH = 0,           	-- Allow Item
	BAN_FLASK_OF_AMBROSIA = 0,            		-- Allow Item
	BAN_ODIN_SPECTACLE = 0,             	-- Allow Item
	BAN_VIPER_CLEATS = 0,             		-- Allow Item
	BAN_STAFF_OF_FATE = 0,             	-- Allow Item
	BAN_FARAHS_KNIFE = 0,             	-- Allow Item
	BAN_SCORPION_BOW = 0,             	-- Allow Item
	BAN_THORN_PLATE = 0,             	-- Allow Item

	BUILDING_DIFFICULTY = "NORMAL",             	-- How Strong are Towers? EASY, NORMAL, HARD, TITANIC, GODLIKE
	TOWER_ABILITIES = 0,             	-- How many abilities to give towers?

}

function BUTTINGS.ALTERNATIVE_XP_TABLE()	-- xp values if MAX_LEVEL is different than 30
	local ALTERNATIVE_XP_TABLE = {		
		0,
		230,
		600,
		1080,
		1660,
		2260,
		2980,
		3730,
		4510,
		5320,
		6160,
		7030,
		7930,
		9155,
		10405,
		11680,
		12980,
		14305,
		15805,
		17395,
		18995,
		20845,
		22945,
		25295,
		27895,
		31395,
		35895,
		41395,
		47895,
		55395,
	} for i = #ALTERNATIVE_XP_TABLE + 1, BUTTINGS.MAX_LEVEL do ALTERNATIVE_XP_TABLE[i] = ALTERNATIVE_XP_TABLE[i - 1] + (300 * ( i - 15 )) end
	return ALTERNATIVE_XP_TABLE
end

BUTTINGS_DEFAULT = table.copy(BUTTINGS)