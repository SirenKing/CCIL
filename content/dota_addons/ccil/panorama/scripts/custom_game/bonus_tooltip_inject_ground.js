
const ground_text = {
	"RING OF PROTECTION": ["+ 2 Armor"],
	"BLADES OF ATTACK": ["+ 9 Damage"],
	"GLOVES OF HASTE": ["+ 20 Attack Speed"],
	"CHAINMAIL": ["+ 4 Armor"],
	"QUARTERSTAFF": ["+ 10 Damage", "+ 10 Attack Speed"],
	"HELM OF IRON WILL": ["+ 5 Armor", "+ 5 HP Regen"],
	"BROADSWORD": ["+ 16 Damage"],
	"CLAYMORE": ["+ 21 Damage"],
	"MITHRIL HAMMER": ["+ 24 Damage"],
	"IRON BRANCH": ["+ 1 All Attributes"],
	"GAUNTLETS OF STRENGTH": ["+ 3 Strength"],
	"SLIPPERS OF AGILITY": ["+ 3 Agility"],
	"MANTLE OF INTELLIGENCE": ["+ 3 Intelligence"],
	"CIRCLET": ["+ 2 All Attributes"],
	"BELT OF STRENGTH": ["+ 6 Strength"],
	"BAND OF ELVENSKIN": ["+ 6 Agility"],
	"ROBE OF THE MAGI": ["+ 6 Intelligence"],
	"CROWN": ["+ 4 All Attributes"],
	"OGRE AXE": ["+ 10 Strength"],
	"BLADE OF ALACRITY": ["+ 10 Agility"],
	"STAFF OF WIZARDRY": ["+ 10 Intelligence"],
	"WIND LACE": ["+ 20 Movement Speed"],
	"RING OF REGEN": ["+ 1.75 HP Regeneration"],
	"SOBE MASK": ["+ 1 Mana Regeneration"],
	"BOOTS OF SPEED": ["+ 45 Movement Speed"],
	"CLOAK": ["+ 15% Magic Resistance"],
	"RING OF TARRASQUE": ["+ 150 Health", "+ 4 HP Regeneration"],
	"GHOST SCEPTER": ["+ 5 All Attributes"],
	"RING OF HEALTH": ["+ 6.5 HP Regeneration"],
	"VOID STONE": ["+ 2.25 Mana Regeneration"],
	"ENERGY BOOSTER": ["+ 250 Mana"],
	"VITALITY BOOSTER": ["+ 250 Health"],
	"POINT BOOSTER": ["+ 175 Mana", "+ 175 Health"],
	"PLATEMAIL": ["+ 10 Armor"],
	"TALISMAN OF EVASION": ["+ 15% Evasion"],
	"HYPERSTONE": ["+ 55 Attack Speed"],
	"ULTIMATE ORB": ["+ 10 All Attributes"],
	"DEMON EDGE": ["+ 42 Damage"],
	"MYSTIC STAFF": ["+ 25 Intelligence"],
	"REAVER": ["+ 25 Strength"],
	"EAGLESONG": ["+ 25 Agility"],
	"SACRED RELIC": ["+ 60 Damage"],

	"MAGIC WAND": ["+ 2 All Attributes"],
	"NULL TALISMAN": ["+ 3 Strength", "+ 3 Agility", "+ 6 Intelligence", "+ 3% Spell Amplification"],
	"WRAITH BAND": ["+ 3 Strength", "+ 6 Agility", "+ 3 Intelligence", "+ 5 Attack Speed"],
	"BRACER": ["+ 6 Strength", "+ 3 Agility", "+ 3 Intelligence"],
	"SOUL RING": ["+ 6 Strength"],
	"POWER TREADS": ["+ 45 Movement Speed", "+ 10 Selected Attribute", "+ 25 Attack Speed"],
	"PHASE BOOTS": ["+ 45 Movement Speed", "+ 18 Damage (MELEE)", "+ 12 Damage (RANGED)", "+ 4 Armor"],
	"OBLIVION STAFF": ["+ 10 Intelligence", "+ 10 Attack Speed", "+ 10 Damage", "+ 1.25 Mana Regeneration"],
	"PERSEVERANCE": ["+ 6.5 HP Regeneration", "+ 2.25 Mana Regeneration"],
	"MASK OF MADNESS": ["+ 15 Damage", "+ 10 Attack Speed"],
	"HELM OF THE DOMINATOR": ["+ 7 All Attributes"],
	"HAND OF MIDAS": ["+ 40 Attack Speed"],
	"BOOTS OF TRAVEL": ["+ 110 Movement Speed"],
	"MOON SHARD": ["+ 140 Attack Speed"],
	"GLIMMER CAPE": ["+ 20 Attack Speed", "+ 15% Magic Resistance"],
	"VEIL OF DISCORD": ["+ 9 All Attributes"],
	"FORCE STAFF": ["+ 10 Intelligence", "+ 2.5 HP Regeneration"],
	"AETHER LENS": ["+ 450 Mana", "+ 3 Mana Regeneration"],
	"NECRONOMICON": ["+ 6/12/18 Strength", "+ 3/3.5/4 Mana Regeneration"],
	"DAGON": ["+ 5 All Attributes"],
	"EUL'S SCEPTER OF DIVINITY": ["+ 10 Intelligence", "+ 5 Mana Regeneration", "+ 20 Movement Speed"],
	"ROD OF ATOS": ["+ 20 Intelligence", "+ 10 Strength", "+ 10 Agility"],
	"SOLAR CREST": ["+ 8 Armor", "+ 10 All Attributes", "+ 20 Movement Speed", "+ 1.75 Mana Regeneration"],
	"ORCHID MALEVOLENCE": ["+ 25 Intelligence", "+ 30 Attack Speed", "+ 30 Damage", "+ 5.5 Mana Regeneration"],
	"AGHANIM'S SCEPTER": ["+ 10 All Attributes", "+ 175 Health", "+ 175 Mana"],
	"NULLIFIER": ["+ 80 Damage", "+ 8 Armor", "+ 6 HP Regeneration"],
	"REFRESHER ORB": ["+ 13 HP Regeneration", "+ 12 Mana Regeneration"],
	"SCYTHE OF VYSE": ["+ 10 Strength", "+ 10 Agility", "+ 35 Intelligence", "+ 9 Mana Regeneration"],
	"OCTARINE CORE": ["+ 425 Health", "+ 425 Mana"],
	"CRYSTALYS": ["+ 34 Damage"],
	"ARMLET OF MORDIGGIAN": ["+ 15 Damage", "+ 25 Attack Speed", "+ 5 Armor", "+ 5 HP Regeneration"],
	"METEOR HAMMER": ["+ 5 HP Regeneration", "+ 3 Mana Regeneration"],
	"SHADOW BLADE": ["+ 27 Damage", "+ 30 Attack Speed"],
	"SKULL BASHER": ["+ 25 Damage", "+ 10 Strength"],
	"MONKEY KING BAR": ["+ 52 Damage", "+ 10 Attack Speed"],
	"BATTLE FURY": ["+ 60 Damage", "+ 7.5 HP Regen", "+ 3.75 Mana Regen"],
	"ETHEREAL BLADE": ["+ 40 Agility", "+ 10 Strength", "+ 10 Intelligence"],
	"RADIANCE": ["+ 60 Damage"],
	"DAEDELUS": ["+ 88 Damage"],
	"BUTTERFLY": ["+ 30 Agility", "+ 25 Damage", "+ 35% Evasion", "+ 30 Attack Speed"],
	"SILVER EDGE": ["+ 45 Damage", "+ 30 Attack Speed"],
	"DIVINE RAPIER": ["+ 330 Damage"],
	"ABYSSAL BLADE": ["+ 25 Damage", "+ 250 Health", "+ 10 HP Regeneration", "+ 10 Strength"],
	"BLOODTHORN": ["+ 25 Intelligence", "+ 85 Attack Speed", "+ 30 Damage", "+ 5.5 Mana Regeneration"],
	"URN OF SHADOWS": ["+ 1.5 Mana Regeneration", "+ 2 All Attributes", "+ 2 Armor"],
	"TRANQUIL BOOTS": ["+ 75 Movement Speed", "+ 14 HP Regeneration"],
	"MEDALLION OF COURAGE": ["+ 5 Armor", "+ 1.25 Mana Regeneration"],
	"ARCANE BOOTS": ["+ 45 Movement Speed", "+ 250 Mana"],
	"DRUM OF ENDURANCE": ["+ 20 Movement Speed"],
	"MEKANSM": ["+ 6 Armor"],
	"HOLY LOCKET": ["+ 250 Health", "+ 325 Mana", "+ 4.5 HP Regeneration", "+ 3 All Attributes"],
	"SPIRIT VESSEL": ["+ 250 Health", "+ 1.5 Mana Regeneration", "+ 2 All Attributes", "+ 2 Armor"],
	"PIPE OF INSIGHT": ["+ 8.5 HP Regeneration", "+ 30% Magic Resistance"],
	"GUARDIAN GREAVES": ["+ 50 Movement Speed", "+ 250 Mana", "+ 6 Armor"],
	"HOOD OF DEFIANCE": ["+ 8.5 HP Regeneration", "+ 25% Magic Resistance"],
	"VANGUARD": ["+ 250 Health", "+ 7 HP Regeneration"],
	"BLADE MAIL": ["+ 28 Damagee", "+ 6 Armor"],
	"SOUL BOOSTER": ["+ 425 Health", "+ 425 Mana"],
	"AEOM DISK": ["+ 300 Health", "+ 300 Mana"],
	"CRIMSON GUARD": ["+ 250 Health", "+ 12 HP Regeneration", "+ 6 Armor"],
	"LOTUS ORB": ["+ 10 Armor", "+ 6.5 HP Regeneration", "+ 4 Mana Regeneration", "+ 250 Mana"],
	"BLACK KING BAR": ["+ 10 Strength", "+ 24 Damage"],
	"HURRICANE PIKE": ["+ 13 Intelligence", "+ 2.5 HP Regeneration", "+ 20 Agility", "+ 15 Strength"],
	"SHIVA'S GUARD": ["+ 30 Intelligence", "+ 15 Armor"],
	"MANTA STYLE": ["+ 10 Strength", "+ 26 Agility", "+ 10 Intelligence", "+ 12 Attack Speed", "+ 8% Movement Speed"],
	"BLOODSTONE": ["+ 425 Health", "+ 425 Mana", "+ 16 Intelligence", "+ 8% Spell Amplification", "+ 100% Mana Regen Amplification"],
	"LINKEN'S SPHERE": ["+ 14 All Attributes", "+ 7 HP Regeneration", "+ 5 Mana Regeneration"],
	"HEART OF TARRASQUE": ["+ 45 Strength", "+ 400 Health"],
	"ASSAULT CURASS": ["+ 30 Attack Speed", "+ 10 Armor"],
	"DRAGON LANCE": ["+ 12 Agility", "+ 12 Strength"],
	"SANGE": ["+ 16 Strength", "+ 16% Status Resistance", + "+ 24% Self HP Regen and Lifesteal Amplification"],
	"YASHA": ["+ 16 Agility", "+ 12 Attack Speed", "+ 8% Movement Speed"],
	"KAYA": ["+ 16 Intelligence", "+ 8% Spell Amplification"],
	"ECHO SABRE": ["+ 10 Intelligence", "+ 12 Strength", "+ 10 Attack Speed", "+ 15 Damage", "+ 1.25 Mana Regeneration"],
	"MAELSTROM": ["+ 24 Damage"],
	"DIFFUSAL BLADE": ["+ 20 Agility", "+ 10 Intelligence"],
	"HEAVEN'S HALBERD": ["+ 25% Evasion", "+ 20 Strength", "+ 20% Status Resistance", + "+ 30% Self HP Regen and Lifesteal Amplification"],
	"DESOLATOR": ["+ 60 Damage"],
	"KAYA AND SANGE": ["+ 16 Strength", "+ 16 Intelligence", "+ 20% Status Resistance", "+ 14% Spell Amplification", "+ 30% Self HP Regen and Lifesteal Amplification"],
	"SANGE AND YASHA": ["+ 16 Strength", "+ 16 Agility", "+ 20% Status Resistance", "+ 16 Attack Speed", "+ 10% Movement Speed", "+ 30% Self HP Regen and Lifesteal Amplification"],
	"YASHA AND KAYA": ["+ 16 Agility", "+ 16 Intelligence", "+ 16 Attack Speed", "+ 10% Movement Speed", "+ 14% Spell Amplification"],
	"EYE OF SKADI": ["+ 25 All Attributes", "+ 225 Health", "+ 250 Mana"],
	"SATANIC": ["+ 25 Strength", "+ 25 Damage", "+ 30% Status Resistance"],
	"MJOLLNIR": ["+ 24 Damage", "+ 65 Attack Speed"],
}

function GetDotaHud() {
    var p = $.GetContextPanel();
    while (p !== null && p.id !== 'Hud') {
        p = p.GetParent();
    }
    if (p === null) {
        throw new HudNotFoundException('Could not find Hud root as parent of panel with id: ' + $.GetContextPanel().id);
    } else {
        return p;
    }
}

function DoGroundStuff() {
    var hud = GetDotaHud();
    $.Schedule(0.1, DoGroundStuff);

    var object = GameUI.FindScreenEntities( GameUI.GetCursorPosition() )
    var itemStuff = object[0]
    if (itemStuff) {
    var itemContainer = itemStuff["entityIndex"]
		}

		if (!itemStuff) {return null};

    var item = Entities.GetContainedItem( itemContainer )
    item &= ~0xFFFFC000;
    if (item) {
      $.Msg("Found item on ground, and it is ", item)
      GetAttributesPanelGround(item)
    }
}

DoGroundStuff()

function GetAttributesPanelGround(item) {

	if (!item) {return null};

	var base = $.GetContextPanel().GetParent().GetParent().GetParent();
	var tooltipManager = base.FindChildTraverse('Tooltips');
	x = tooltipManager.FindChildTraverse('DOTAAbilityTooltip');
	x = x.FindChildrenWithClassTraverse('TooltipRow');
	x = x[0].FindChildTraverse('Contents');
	z = x.FindChildTraverse('AbilityDetails');
	var itemName = z.FindChildTraverse('AbilityName').text;
  	x = x.FindChildTraverse('AbilityCoreDetails');
	var abilityAttributes = x.FindChildTraverse('AbilityAttributes');

	var array = CustomNetTables.GetTableValue( "item_rolls", item );

	if ( array==undefined ) {
		var extraTextInventory = [ "No extra Mods on this item..." ]
	} else {
		var extraTextInventory = [
			"... of the " + array["mod_type"].fontcolor( "white" ) + " Lvl " + array["item_level"],
			toTitleCase("+ Ability: " + array["ability"].split('_').join(' ')),
			// toTitleCase("+ Talent: " + array["talent"].slice(13).split('_').join(' ')),
			GetTrueValues(array["buff_1_lvl"],array["buff_1"]),
			GetTrueValues(array["buff_2_lvl"],array["buff_2"]),
			toTitleCase("+ " + array["buff_3_lvl"] + " " + quasiColor(array["buff_3"].slice(15))),
			toTitleCase("+ " + array["buff_4_lvl"] + " " + quasiColor(array["buff_4"].slice(15)))
		];
	}

	abilityAttributes.text = item_text[itemName].join('<br>') + '<br><br>' + extraTextInventory.join('<br>');

	return abilityAttributes;
}

function toTitleCase(str) {
  return str.replace(
    /\w\S*/g,
    function(txt) {
      return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase();
    }
  );
}

function quasiColor(str) {
	if (str=="wex") {
		return str.fontcolor( "violet" ).toUpperCase();
	} else if (str=="exort") {
		return str.fontcolor( "orange" ).toUpperCase();
	} else if (str=="quas") {
		return str.fontcolor( "aqua" ).toUpperCase();
	}
}

function GetTrueValues(buffLvl, buff) {
	if (buff == "modifier_bonus_attack_range") {
		return toTitleCase("+ " + buffLvl*5 + " " + buff.slice(15).split('_').join(' ')) + " (+Exort Effect)";
	} else if (buff == "modifier_bonus_attack_speed") {
			return toTitleCase("+ " + buffLvl*5 + " " + buff.slice(15).split('_').join(' '));
	} else if (buff == "modifier_bonus_damage") {
			return toTitleCase("+ " + buffLvl*2 + " Base " + buff.slice(15).split('_').join(' '));
	} else if (buff == "modifier_bonus_move_speed") {
			return toTitleCase("+ " + buffLvl*5 + " " + "Movespeed (and Max)");
	} else if (buff == "modifier_bonus_move_speed_percent") {
			return toTitleCase("+ " + buffLvl + "% Movespeed");
	} else if (buff == "modifier_bonus_evasion") {
			return toTitleCase("+ " + buffLvl + "% " + "Evasion");
	} else if (buff == "modifier_bonus_armor") {
		return toTitleCase("+ " + buffLvl + " " + "Armor");
	} else if (buff == "modifier_bonus_agility") {
		return toTitleCase("+ " + buffLvl + " " + "Agility") + " (+Exort Effect)";
	} else if (buff == "modifier_bonus_strength") {
		return toTitleCase("+ " + buffLvl + " " + "Strength") + " (+Wex Effect)";
	} else if (buff == "modifier_bonus_intelligence") {
		return toTitleCase("+ " + buffLvl + " " + "Intelligence") + " (+Quas Effect)";
	} else if (buff == "modifier_bonus_cast_range") {
		return toTitleCase("+ " + buffLvl*5 + " " + "Cast Range") + " (+Quas Effect)";
	} else if (buff == "modifier_bonus_block_phys") {
		return toTitleCase("+ Block " + buffLvl + " Physical Damage") + " (+Wex Effect)";
	}
}
