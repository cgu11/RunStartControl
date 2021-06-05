RunStartControl.WeaponAspectData = {
    Sword = {
        Name = "SwordWeapon",
        Aspects = {
           Zagreus = "SwordBaseUpgradeTrait",
           Nemesis = "SwordCriticalParryTrait",
           Poseidon = "DislodgeAmmoTrait",
           Arthur = "SwordConsecrationTrait",
        }
    },
    Spear = {
        Name = "SpearWeapon",
        Aspects = {
            Zagreus = "SpearBaseUpgradeTrait",
            Achilles = "SpearTeleportTrait",
            Hades = "SpearWeaveTrait",
            GuanYu = "SpearSpinTravel",            
        }
    },
    Shield = {
        Name = "ShieldWeapon",
        Aspects = {
            Zagreus = "ShieldBaseUpgradeTrait",
            Chaos = "ShieldRushBonusProjectileTrait",
            Zeus = "ShieldTwoShieldTrait",
            Beowulf = "ShieldLoadAmmoTrait",
        }
    },
    Bow = {
        Name = "BowWeapon",
        Aspects = {
            Zagreus = "BowBaseUpgradeTrait",
            Chiron = "BowMarkHomingTrait",
            Hera = "BowLoadAmmoTrait",
            Rama = "BowBondTrait",
        }
    },
    Fists = {
        Name = "FistWeapon",
        Aspects = {
            Zagreus = "FistBaseUpgradeTrait",
            Talos = "FistVacuumTrait",
            Demeter = "FistWeaveTrait",
            Gilgamesh = "FistDetonateTrait",
        }
    },
    Rail = {
        Name = "GunWeapon",
        Aspects = {
            Zagreus = "GunBaseUpgradeTrait",
            Eris = "GunGrenadeSelfEmpowerTrait",
            Hestia = "GunManualReloadTrait",
            Lucifer = "GunLoadedGrenadeTrait",
        }
    },
}

function RunStartControl.WeaponAspectReference( weapon, aspect )
    return {
        Weapon = RunStartControl.WeaponAspectData[weapon].Name,
        Aspect = RunStartControl.WeaponAspectData[weapon].Aspects[aspect]
    }
end

-- God is capitalized god name, coreSlot is Attack/Special/Cast/Dash, aspect is "ShieldLoadAmmoTrait" or nothing,
-- just checking for beowulf
function RunStartControl.CoreBoonReference( god, coreSlot, aspect )
    if coreSlot == "Attack" then
        return god .. "WeaponTrait"
    elseif coreSlot == "Special" then
        return god .. "SecondaryTrait"
    elseif coreSlot == "Cast" then
        if aspect == "ShieldLoadAmmoTrait" and god ~= "Dionysus" and god ~= "Poseidon" then
            return "ShieldLoadAmmo_" god .. "RangedTrait"
        else
            return god .. "RangedTrait"
        end
    elseif coreSlot == "Dash" then
        return god .."RushTrait"
    end
end