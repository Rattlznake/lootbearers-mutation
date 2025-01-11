IncludeScript("lootbearers/loot")
// TODO: Finish writing code comments and reorganize functions to make more sense to read



local debug = false; // used in Debug functions, enables all kinds of fun printouts

local function DebugPrintLine(text, line, category, check = true) { // printl with debug info
    if (debug && check) {
        printl("[TIME:" + Time() + "] " + "[LINE:" + line + "] " + "[CATEGORY:" + category + "]: " + text);
    }
}

local function DebugPrintArray(array, line, category, check = true) { // prints an array with debug info as well
    local stringyArray = "["; // create the base array and start with just an opening bracket
    foreach(index, item in array) { // for every item in the array:
        if (index == array.len() - 1) { // if it is the last item:
            stringyArray = stringyArray + item + "]"; // add it to stringyArray and close the bracket
        } else {
            stringyArray = stringyArray + item + ", "; // add it to stringyArray and add a comma & space
        }
    }
    DebugPrintLine(stringyArray, line, category, check); // print the final array w/ all the debug info
} // extra note: i reccomend you just use DebugDeepPrintTable function. if it's an array of tables, that will be much more helpful

local function DebugDeepPrintTable(table, line, category, check = true) { // DeepPrintTable function with debug info
    if (debug && check) {
        print("[TIME:" + Time() + "] " + "[LINE:" + line + "] " + "[CATEGORY:" + category + "] TABLE: "); // print the debug info
        DeepPrintTable(table); // call the DeepPrintTable function to do all the dirty work
    }
}



local doConvert = true; // used in MutationOptions.ConvertWeaponSpawn and MutationOptions.AllowWeaponSpawn - turned off later to prevent weapons spawned by script from being changed

local mutationOptionsDebug = true; // enables the printouts in ↓ table, if debug variable is false, this doesn't matter
MutationOptions <- // director options
{
 	weaponsToConvert =
 	{   // REPLACING WEAPON ENTITIES
		weapon_shotgun_spas     = "weapon_shotgun_chrome_spawn" // SPAS is replaced with Chrome Shotgun
        weapon_autoshotgun      = "weapon_pumpshotgun_spawn"    // Benelli M3 is replaced with Pump Shotgun
        weapon_rifle_ak47       = "weapon_smg_silenced_spawn"   // AK47 is replaced with MAC10
        weapon_rifle_desert     = "weapon_smg_silenced_spawn"   // Burst Rifle is replaced with MAC10 as well
        weapon_rifle            = "weapon_smg_spawn"            // M16 is replaced with Uzi
        weapon_rifle_sg552      = "weapon_smg_mp5_spawn"        // SG552 is replaced with MP5
        weapon_sniper_military  = "weapon_sniper_awp_spawn"     // Military Sniper is replaced with AWP
        weapon_hunting_rifle    = "weapon_sniper_scout_spawn"   // Hunting Rifle is replaced with Scout
 	}

 	function ConvertWeaponSpawn(classname)
 	{
 		if ( classname in weaponsToConvert && doConvert) // if classname matches one of the entities that should be replaced and replacing is enabled:
 		{
            DebugPrintLine("Found weapon " + classname + " in weaponsToConvert, replacing with " + weaponsToConvert[classname], 56, "MutationOptions.ConvertWeaponSpawn", mutationOptionsDebug);
 			return weaponsToConvert[classname]; // return what weapon it should be converted to
		} else if (!doConvert) { // if check failed because of doConvert, print that
            DebugPrintLine("Function quit due to shutoff, checked " + classname, 59, "MutationOptions.ConvertWeaponSpawn", mutationOptionsDebug);
        } else { // if check failed because checked thing isn't something that should be converted, print that
            DebugPrintLine("Checked " + classname + " and found nothing, dropping out of function", 61, "MutationOptions.ConvertWeaponSpawn", mutationOptionsDebug);
        }
		return 0;
	}
}


local function CheckForWeaponsToConvert() { // checks if any instances of the weapons that should be converted exist, returns true if they do, returns false if they don't
    local shouldReturn = false; // by default false because if every if statement below fails, this will never be changed
    for (local ent; ent = Entities.FindByClassname(ent, "weapon_*");) { // for every entity beginning with weapon_ :
        if (ent.GetClassname() in MutationOptions.weaponsToConvert) { // if this entity is in weaponsToConvert
            shouldReturn = true; // set it to return true
            break; // exit out of the for loop
        }
    }
    return shouldReturn; // return
}

function OnGameEvent_round_start_post_nav(params) { // once the game is loaded and items are placed
    for (local ent; ent = Entities.FindByClassname(ent, "weapon_ammo*");) { // for each weapon_ammo or weapon_ammo_spawn
        ent.Kill(); // get rid of it!!!
    }
    while (CheckForWeaponsToConvert()) {} // wait until there are no more weapons that need to be converted or deleted
    doConvert = false; // shut off conversion
}



local function JoinTables(...) { // joins tables. can have an infinite number of arguments
    local finalTable = {}; // the final table that will be returned
    foreach (table in vargv) { // for each table in the arguments:
        foreach(key, value in table) { // for every key in the table:
            finalTable[key] <- value; // add this key to the final table
        }
    }
    return finalTable; // return the big table
}

local function Chance(chance) { // takes a floating point value (0-1) and uses that to pick a weighted true/false value.
    local generatedNumber = RandomFloat(0, 1) // pick a random floating point value from 0 to 1

    // ↓ less than is important here because for example, if chance was 0.6, the chance to return true would instead be 0.4 because it would be essentially reversing the probability
    if (generatedNumber <= chance) // if generated number is less than or equal to the inputted chance:
        return true // return true
    else // if not:
        return false // return false
}



local rollLootTableDebug = true; // enables the printouts in ↓ function, if debug variable is false, this doesn't matter
function RollLootTable(lootTable) {
    local loot = []; // array that will be filled with all of the items in lootTable
    local lootNumbers = []; // array that will be filled with numbers based off of the chance values in lootTable's elements
    local chosenNumber; // number that will be chosen randomly soon
    local finalLoot; // the final loot item to be returned, will be chosen soon

    // ↓ add values for loot array
    foreach (key, value in lootTable) { // for each item in lootTable:
        loot.append(value); // add it to the loot list
    }
    DebugPrintArray(loot, 122, "RollLootTable.loot", rollLootTableDebug);

    // add values for lootNumbers
    foreach (index, item in loot) { // for each item in loot:
        local previousNumber = 0; // previous number, used to decide what to add to lootNumbers list

        if (index != 0) { // if we are not acessing the first item in the list:
            previousNumber = lootNumbers[index - 1]; // set previousNumber variable
        }

        lootNumbers.append(previousNumber + loot[index].chance); // add number to lootNumbers that corresponds to the current loot item chance + every previous loot item's chance
    }
    DebugPrintArray(lootNumbers, 134, "RollLootTable.lootNumbers", rollLootTableDebug);

    chosenNumber = RandomInt(1, lootNumbers[lootNumbers.len() - 1]); // pick a random number from 1 to the greatest number in lootNumbers
    DebugPrintLine(chosenNumber, 137, "RollLootTable.chosenNumber", rollLootTableDebug);

    // use chosenNumber to pick an entity
    foreach (index, item in lootNumbers) { // for each item in lootNumbers:
        DebugPrintLine(chosenNumber + "<=" + item + " is " + (chosenNumber <= item), 141, "RollLootTable.chooseItem", rollLootTableDebug);
        if (chosenNumber <= item) { // if the chosen number is less than or equal to the number we're currently on
            finalLoot = loot[index]; // choose final loot to match this chance number
            break; // break out of the foor loop
        }
    }

    /* Explaining ↑ in more detail:
        It first of all creates a list of the items in the loot table. (lines 90-92)
        This is a list of tables, because the loot tables are basically lists of subtables that correspond to items that can be spawned. (see lootbearers/loot.nut)

        Then, a list is created using the "chance" value in each table in the loot list.
        Each item is the previous loot item 's chance number + the next loot item's number.

        For example: if we had a loot list that looked something like this:
        [{chance = 15}, {chance = 15}, {chance = 15}] (this is of course theoretical, there would be more stuff inside the tables)
        The lootNumbers list would look something like this:
        [15, 30, 45]

        Then, a foreach loop iterates through each item in the loot list, from smallest to largest.
        On each element in the list, it checks if the element is less than the chosen number.
        Here, the smallest to largest part really shines, because it is really checking if the chosen number is larger than the previous number and smaller than the current.
        This is because if the previous check, on the smaller number, passed, the next check never would have happened.
        Because of this, it results in every chance number being represented correctly, as a larger number would have a larger window in the list of checks.
        If the check for index #2 in lootNumbers passes, we know that we should grab item #2 from the loot list, and return that.
    */

    DebugPrintLine(finalLoot, 168, "RollLootTable.finalLoot", rollLootTableDebug);
    if (finalLoot == null) { // if final loot does not exist (this check exists because of a previous error in the chooser forloop where the boolean operator was < instead of <=)
        DebugPrintLine("finalLoot is null!! :(", 170, "RollLootTable.finalLoot - Check to make sure it exists", rollLootTableDebug); // complain
        finalLoot = RollLootTable(lootTable); // reroll
        DebugPrintLine(finalLoot, 172, "RollLootTable.finalLoot - REROLLED", rollLootTableDebug);
    }

    return finalLoot // return the loot table
}


local spawnLootDebug = true; // enables the printouts in ↓ function, if debug variable is false, this doesn't matter
local function SpawnLoot(x, y, z, lootTable, chance) {
    if (Chance(chance) == false) { // if the chance to drop fails, early return
        DebugPrintLine("Chance " + chance + " failed!, spawning nothing", 182, "SpawnLoot - chance", spawnLootDebug);
        return;
    }
    DebugPrintLine("Chance " + chance + " succeeded! proceeding", 185, "SpawnLoot - chance", spawnLootDebug);

    local chosenLoot = RollLootTable(lootTable); // choose the loot
    DebugDeepPrintTable(chosenLoot, 188, "SpawnLoot.chosenLoot", spawnLootDebug);
    local entityToSpawn = chosenLoot.entity; // get the entity data from the chosen loot

    SpawnEntityFromTable( // spawn the entity
        entityToSpawn.classname, // use the entity's classname from it's table
        JoinTables( // join two tables:
            {origin = Vector(x, y, z)}, // the table including the keyvalue of it's location
            entityToSpawn.keyvalues // the table including every other keyvalue
        )
    );
}


local spawnManagerDebug = true; // enables the printouts in ↓ function, if debug variable is false, this doesn't matter
function OnGameEvent_player_death(params) {
    DebugPrintLine(params.victimname + " killed at x:" + params.victim_x + " y:" + params.victim_y + " z:" + params.victim_z, 203, "OnGameEvent_player_death", spawnManagerDebug);
    switch (params.victimname) { // get the name of the killed and compare:
        case "Infected": // if common infected:
            SpawnLoot(params.victim_x, params.victim_y, params.victim_z, lootTables.commonInfected, 0.07); // roll common loot table
            break; // break out of switch statement
        case "Boomer": // if boomer:
            SpawnLoot(params.victim_x, params.victim_y, params.victim_z, lootTables.boomer, 1); // roll boomer loot table
            break; // break out of switch statement
        case "Charger": // if charger:
            SpawnLoot(params.victim_x, params.victim_y, params.victim_z, lootTables.charger, 1); // roll charger loot table
            break; // break out of switch statement
        case "Hunter": // if hunter:
            SpawnLoot(params.victim_x, params.victim_y, params.victim_z, lootTables.hunter, 1); // roll hunter loot table
            break; // break out of switch statement
        case "Smoker": // if smoker:
            SpawnLoot(params.victim_x, params.victim_y, params.victim_z, lootTables.smoker, 1); // roll hunter loot table
            break; // break out of switch statement
        case "Spitter": // if spitter:
            SpawnLoot(params.victim_x, params.victim_y, params.victim_z, lootTables.spitter, 1); // roll spitter loot table
            break; // break out of switch statement
        case "Jockey": // if jockey:
            SpawnLoot(params.victim_x, params.victim_y, params.victim_z, lootTables.jockey, 1); // roll jockey loot table
            break; // break out of switch statement
        case "Tank": // if tank:
            SpawnLoot(params.victim_x, params.victim_y, params.victim_z, lootTables.tank, 1); // roll tank loot table
            break; // break out of switch statement
        case "Witch": // if witch:
            SpawnLoot(params.victim_x, params.victim_y, params.victim_z, lootTables.witch, 1); // roll witch loot table
            break; // break out of switch statement
    }
}

/* v1.1 changes:
    • Remove all ammo spawns
    • Add M60 and Grenade Launcher to loot list
    • Make melee and pistol drops more prominent upon common kills
    • Make medkit chances lower across the board
    • Other misc. chance changes
   v1.2 changes:
    • Removed bug that prevented the shutoff of weapon conversion
   v1.3 changes:
    • Removed bug in which entity names are called improperly
   v1.4 changes:
    • Tanks & Witches no longer drop medkits, military rifles, SPASs, and AKs.
    • Special Infecteds have lower chance to drop defibs and medkits as well as deagles
    • Specialize gun drops, certain specials drop certain guns
    • Boomers & Chargers drop autoshotguns
    • Jockeys & Spitters drop assault rifles
    • Hunters & Smokers drop scoped weapons (including SG552)
*/