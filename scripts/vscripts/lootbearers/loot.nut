// entity templates for each item that can be dropped
entityTables <- {
    pills = {
        classname = "weapon_pain_pills_spawn"
        keyvalues = {
            count = 1
            spawnflags = 3
        }
    }
    adrenaline = {
        classname = "weapon_adrenaline_spawn"
        keyvalues = {
            count = 1
            spawnflags = 3
        }
    }
    pipebomb = {
        classname = "weapon_pipe_bomb_spawn"
        keyvalues = {
            count = 1
            spawnflags = 3
        }
    }
    bile = {
        classname = "weapon_vomitjar_spawn"
        keyvalues = {
            count = 1
            spawnflags = 3
        }
    }
    molotov = {
        classname = "weapon_molotov_spawn"
        keyvalues = {
            count = 1
            spawnflags = 3
        }
    }
    medkit = {
        classname = "weapon_first_aid_kit_spawn"
        keyvalues = {
            count = 1
            spawnflags = 3
        }
    }
    defib = {
        classname = "weapon_defibrillator_spawn"
        keyvalues = {
            count = 1
            spawnflags = 3
        }
    }
    fireammo = {
        classname = "weapon_upgradepack_incendiary_spawn"
        keyvalues = {
            count = 1
            spawnflags = 3
        }
    }
    explosiveammo = {
        classname = "weapon_upgradepack_explosive_spawn"
        keyvalues = {
            count = 1
            spawnflags = 3
        }
    }
    pistol = {
        classname = "weapon_pistol_spawn"
        keyvalues = {
            count = 1
            spawnflags = 3
        }
    }
    melee = {
        classname = "weapon_melee_spawn"
        keyvalues = {
            count = 1
            spawnflags = 3
            melee_weapon = "Any"
        }
    }
    deagle = {
        classname = "weapon_pistol_magnum_spawn"
        keyvalues = {
            count = 1
            spawnflags = 3
        }
    }
    uzi = {
        classname = "weapon_smg_spawn"
        keyvalues = {
            count = 1
            spawnflags = 3
        }
    }
    mp5 = {
        classname = "weapon_smg_mp5_spawn"
        keyvalues = {
            count = 1
            spawnflags = 3
        }
    }
    mac10 = {
        classname = "weapon_smg_silenced_spawn"
        keyvalues = {
            count = 1
            spawnflags = 3
        }
    }
    pumpshotgun = {
        classname = "weapon_pumpshotgun_spawn"
        keyvalues = {
            count = 1
            spawnflags = 3
        }
    }
    chromeshotgun = {
        classname = "weapon_shotgun_chrome_spawn"
        keyvalues = {
            count = 1
            spawnflags = 3
        }
    }
    awp = {
        classname = "weapon_sniper_awp_spawn"
        keyvalues = {
            count = 1
            spawnflags = 3
        }
    }
    scout = {
        classname = "weapon_sniper_scout_spawn"
        keyvalues = {
            count = 1
            spawnflags = 3
        }
    }
    m16 = {
        classname = "weapon_rifle_spawn"
        keyvalues = {
            count = 1
            spawnflags = 3
        }
    }
    sg552 = {
        classname = "weapon_rifle_sg552_spawn"
        keyvalues = {
            count = 1
            spawnflags = 3
        }
    }
    burst = {
        classname = "weapon_rifle_desert_spawn"
        keyvalues = {
            count = 1
            spawnflags = 3
        }
    }
    ak47 = {
        classname = "weapon_rifle_ak47_spawn"
        keyvalues = {
            count = 1
            spawnflags = 3
        }
    }
    benelli = {
        classname = "weapon_autoshotgun_spawn"
        keyvalues = {
            count = 1
            spawnflags = 3
        }
    }
    spas = {
        classname = "weapon_shotgun_spas_spawn"
        keyvalues = {
            count = 1
            spawnflags = 3
        }
    }
    militaryrifle = {
        classname = "weapon_sniper_military_spawn"
        keyvalues = {
            count = 1
            spawnflags = 3
        }
    }
    huntingrifle = {
        classname = "weapon_hunting_rifle_spawn"
        keyvalues = {
            count = 1
            spawnflags = 3
        }
    }
    chainsaw = {
        classname = "weapon_chainsaw_spawn"
        keyvalues = {
            count = 1
            spawnflags = 3
        }
    }
    grenadelauncher = {
        classname = "weapon_grenade_launcher_spawn"
        keyvalues = {
            count = 1
            spawnflags = 3
        }
    }
    m60 = {
        classname = "weapon_rifle_m60_spawn"
        keyvalues = {
            count = 1
            spawnflags = 3
        }
    }
    ammopile = {
        classname = "weapon_ammo_spawn"
        keyvalues = {
            spawnflags = 3
            count = 4
        }
    }
    lasersight = {
        classname = "upgrade_spawn"
        keyvalues = {
            spawnflags = 3
            laser_sight = 1
        }
    }
}


// actual loot tables for each infected type
lootTables <- {
    commonInfected = {
        pills = {
            chance = 25
            entity = entityTables.pills
        },
        adrenaline = {
            chance = 25
            entity = entityTables.adrenaline
        },
        pipebomb = {
            chance = 15
            entity = entityTables.pipebomb
        },
        molotov = {
            chance = 15
            entity = entityTables.molotov
        },
        bile = {
            chance = 15
            entity = entityTables.bile
        },
        pistol = {
            chance = 15
            entity = entityTables.pistol
        }
        melee = {
            chance = 15
            entity = entityTables.melee
        }
    }
    boomer = {
        bile = {
            chance = 3
            entity = entityTables.bile
        }
        pipebomb = {
            chance = 2
            entity = entityTables.pipebomb
        }
        molotov = {
            chance = 1
            entity = entityTables.molotov
        }
        medkit = {
            chance = 3
            entity = entityTables.medkit
        }
        defib = {
            chance = 1
            entity = entityTables.defib
        }
        deagle = {
            chance = 3
            entity = entityTables.deagle
        }
        benelli = {
            chance = 6
            entity = entityTables.benelli
        }
        spas = {
            chance = 6
            entity = entityTables.spas
        }
    }
    charger = {
        medkit = {
            chance = 2
            entity = entityTables.medkit
        }
        defib = {
            chance = 2
            entity = entityTables.defib
        }
        deagle = {
            chance = 6
            entity = entityTables.deagle
        }
        benelli = {
            chance = 5
            entity = entityTables.benelli
        }
        spas = {
            chance = 5
            entity = entityTables.spas
        }
    }
    hunter = {
        medkit = {
            chance = 4
            entity = entityTables.medkit
        }
        defib = {
            chance = 4
            entity = entityTables.defib
        }
        deagle = {
            chance = 8
            entity = entityTables.deagle
        }
        sg552 = {
            chance = 5
            entity = entityTables.sg552
        }
        militaryrifle = {
            chance = 5
            entity = entityTables.militaryrifle
        }
        huntingrifle = {
            chance = 5
            entity = entityTables.huntingrifle
        }
    }
    smoker = {
        medkit = {
            chance = 3
            entity = entityTables.medkit
        }
        defib = {
            chance = 3
            entity = entityTables.defib
        }
        deagle = {
            chance = 7
            entity = entityTables.deagle
        }
        sg552 = {
            chance = 5
            entity = entityTables.sg552
        }
        militaryrifle = {
            chance = 5
            entity = entityTables.militaryrifle
        }
        huntingrifle = {
            chance = 5
            entity = entityTables.huntingrifle
        }
    }
    spitter = {
        medkit = {
            chance = 3
            entity = entityTables.medkit
        }
        defib = {
            chance = 3
            entity = entityTables.defib
        }
        molotov = {
            chance = 7
            entity = entityTables.molotov
        }
        deagle = {
            chance = 9
            entity = entityTables.deagle
        }
        m16 = {
            chance = 5
            entity = entityTables.m16
        }
        sg552 = {
            chance = 5
            entity = entityTables.sg552
        }
        burst = {
            chance = 5
            entity = entityTables.burst
        }
        ak47 = {
            chance = 5
            entity = entityTables.ak47
        }
    }
    jockey = {
        medkit = {
            chance = 1
            entity = entityTables.medkit
        }
        defib = {
            chance = 1
            entity = entityTables.defib
        }
        deagle = {
            chance = 6
            entity = entityTables.deagle
        }
        m16 = {
            chance = 3
            entity = entityTables.m16
        }
        sg552 = {
            chance = 3
            entity = entityTables.sg552
        }
        burst = {
            chance = 3
            entity = entityTables.burst
        }
        ak47 = {
            chance = 3
            entity = entityTables.ak47
        }
    }
    tank = {
        ammo = {
            chance = 8
            entity = entityTables.ammopile
        }
        lasersight = {
            chance = 8
            entity = entityTables.lasersight
        }
        m60 = {
            chance = 5
            entity = entityTables.m60
        }
        grenadelauncher = {
            chance = 5
            entity = entityTables.grenadelauncher
        }
    }
    witch = {
        ammo = {
            chance = 8
            entity = entityTables.ammopile
        }
        lasersight = {
            chance = 8
            entity = entityTables.lasersight
        }
        m60 = {
            chance = 5
            entity = entityTables.m60
        }
        grenadelauncher = {
            chance = 5
            entity = entityTables.grenadelauncher
        }
    }
}