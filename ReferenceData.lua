RunStartControl.WeaponAspectData = {
    [1] = {
        Name = "SwordWeapon",
        Aspects = {
           [1] = "SwordBaseUpgradeTrait",
           [2] = "SwordCriticalParryTrait",
           [3] = "DislodgeAmmoTrait",
           [4] = "SwordConsecrationTrait",
        }
    },
    [2] = {
        Name = "SpearWeapon",
        Aspects = {
            [1] = "SpearBaseUpgradeTrait",
            [2] = "SpearTeleportTrait",
            [3] = "SpearWeaveTrait",
            [4] = "SpearSpinTravel",            
        }
    },
    [3] = {
        Name = "ShieldWeapon",
        Aspects = {
            [1] = "ShieldBaseUpgradeTrait",
            [2] = "ShieldRushBonusProjectileTrait",
            [3] = "ShieldTwoShieldTrait",
            [4] = "ShieldLoadAmmoTrait",
        }
    },
    [4] = {
        Name = "BowWeapon",
        Aspects = {
            [1] = "BowBaseUpgradeTrait",
            [2] = "BowMarkHomingTrait",
            [3] = "BowLoadAmmoTrait",
            [4] = "BowBondTrait",
        }
    },
    [5] = {
        Name = "FistWeapon",
        Aspects = {
            [1] = "FistBaseUpgradeTrait",
            [2] = "FistVacuumTrait",
            [3] = "FistWeaveTrait",
            [4] = "FistDetonateTrait",
        }
    },
    [6] = {
        Name = "GunWeapon",
        Aspects = {
            [1] = "GunBaseUpgradeTrait",
            [2] = "GunGrenadeSelfEmpowerTrait",
            [3] = "GunManualReloadTrait",
            [4] = "GunLoadedGrenadeTrait",
        }
    },
}

RunStartControl.HammerOptions = {
    SwordBaseUpgradeTrait = {"SwordTwoComboTrait","SwordSecondaryAreaDamageTrait","SwordGoldDamageTrait","SwordBlinkTrait","SwordThrustWaveTrait","SwordHealthBufferDamageTrait","SwordSecondaryDoubleAttackTrait","SwordCriticalTrait","SwordBackstabTrait","SwordDoubleDashAttackTrait","SwordHeavySecondStrikeTrait","SwordCursedLifeStealTrait"},
    SwordCriticalParryTrait = {"SwordTwoComboTrait","SwordSecondaryAreaDamageTrait","SwordGoldDamageTrait","SwordBlinkTrait","SwordThrustWaveTrait","SwordHealthBufferDamageTrait","SwordSecondaryDoubleAttackTrait","SwordCriticalTrait","SwordBackstabTrait","SwordDoubleDashAttackTrait","SwordHeavySecondStrikeTrait","SwordCursedLifeStealTrait"},
    DislodgeAmmoTrait = {"SwordTwoComboTrait","SwordSecondaryAreaDamageTrait","SwordGoldDamageTrait","SwordBlinkTrait","SwordThrustWaveTrait","SwordHealthBufferDamageTrait","SwordSecondaryDoubleAttackTrait","SwordCriticalTrait","SwordBackstabTrait","SwordDoubleDashAttackTrait","SwordHeavySecondStrikeTrait","SwordCursedLifeStealTrait"},
    SwordConsecrationTrait = {"SwordConsecrationBoostTrait","SwordSecondaryAreaDamageTrait","SwordGoldDamageTrait","SwordBlinkTrait","SwordThrustWaveTrait","SwordHealthBufferDamageTrait","SwordSecondaryDoubleAttackTrait","SwordBackstabTrait","SwordDoubleDashAttackTrait","SwordCursedLifeStealTrait"},
    SpearBaseUpgradeTrait = {"SpearReachAttack", "SpearAutoAttack", "SpearThrowExplode", "SpearThrowBounce", "SpearThrowPenetrate", "SpearThrowCritical", "SpearSpinDamageRadius", "SpearSpinChargeLevelTime", "SpearDashMultiStrike", "SpearThrowElectiveCharge", "SpearSpinChargeAreaDamageTrait", "SpearAttackPhalanxTrait"},
    SpearTeleportTrait = {"SpearReachAttack", "SpearAutoAttack", "SpearThrowPenetrate", "SpearThrowCritical", "SpearSpinDamageRadius", "SpearSpinChargeLevelTime", "SpearDashMultiStrike", "SpearSpinChargeAreaDamageTrait", "SpearAttackPhalanxTrait"},
    SpearWeaveTrait = {"SpearReachAttack", "SpearThrowExplode", "SpearThrowBounce", "SpearThrowPenetrate", "SpearThrowCritical", "SpearSpinDamageRadius", "SpearSpinChargeLevelTime", "SpearDashMultiStrike", "SpearThrowElectiveCharge", "SpearSpinChargeAreaDamageTrait", "SpearAttackPhalanxTrait"},
    SpearSpinTravel = {"SpearSpinTravelDurationTrait","SpearReachAttack", "SpearThrowPenetrate", "SpearSpinDamageRadius", "SpearSpinChargeLevelTime", "SpearDashMultiStrike", "SpearThrowElectiveCharge", "SpearSpinChargeAreaDamageTrait", "SpearAttackPhalanxTrait"},
    ShieldBaseUpgradeTrait = {"ShieldDashAOETrait", "ShieldRushProjectileTrait", "ShieldThrowFastTrait", "ShieldThrowCatchExplode", "ShieldChargeHealthBufferTrait", "ShieldChargeSpeedTrait", "ShieldBashDamageTrait", "ShieldPerfectRushTrait", "ShieldThrowElectiveCharge", "ShieldThrowEmpowerTrait", "ShieldBlockEmpowerTrait", "ShieldThrowRushTrait"},
    ShieldRushBonusProjectileTrait = {"ShieldDashAOETrait", "ShieldRushProjectileTrait", "ShieldThrowFastTrait", "ShieldThrowCatchExplode", "ShieldChargeHealthBufferTrait", "ShieldChargeSpeedTrait", "ShieldBashDamageTrait", "ShieldPerfectRushTrait", "ShieldThrowEmpowerTrait", "ShieldBlockEmpowerTrait", "ShieldThrowRushTrait"},
    ShieldTwoShieldTrait = {"ShieldDashAOETrait", "ShieldRushProjectileTrait", "ShieldThrowCatchExplode", "ShieldChargeHealthBufferTrait", "ShieldChargeSpeedTrait", "ShieldBashDamageTrait", "ShieldPerfectRushTrait", "ShieldThrowEmpowerTrait", "ShieldBlockEmpowerTrait"},
    ShieldLoadAmmoTrait = {"ShieldLoadAmmoBoostTrait", "ShieldDashAOETrait", "ShieldRushProjectileTrait", "ShieldThrowFastTrait", "ShieldThrowCatchExplode", "ShieldChargeHealthBufferTrait", "ShieldChargeSpeedTrait", "ShieldBashDamageTrait", "ShieldPerfectRushTrait", "ShieldThrowElectiveCharge", "ShieldThrowEmpowerTrait", "ShieldBlockEmpowerTrait", "ShieldThrowRushTrait"},
    BowBaseUpgradeTrait = {"BowDoubleShotTrait", "BowLongRangeDamageTrait", "BowSlowChargeDamageTrait", "BowTapFireTrait", "BowPenetrationTrait", "BowPowerShotTrait", "BowSecondaryBarrageTrait", "BowTripleShotTrait", "BowSecondaryFocusedFireTrait", "BowChainShotTrait", "BowCloseAttackTrait", "BowConsecutiveBarrageTrait"},
    BowMarkHomingTrait = {"BowDoubleShotTrait", "BowLongRangeDamageTrait", "BowSlowChargeDamageTrait", "BowTapFireTrait", "BowPenetrationTrait", "BowPowerShotTrait", "BowSecondaryBarrageTrait", "BowTripleShotTrait", "BowChainShotTrait", "BowCloseAttackTrait", "BowConsecutiveBarrageTrait"},
    BowLoadAmmoTrait = {"BowDoubleShotTrait", "BowLongRangeDamageTrait", "BowSlowChargeDamageTrait", "BowTapFireTrait", "BowPenetrationTrait", "BowPowerShotTrait", "BowSecondaryBarrageTrait", "BowTripleShotTrait", "BowSecondaryFocusedFireTrait", "BowChainShotTrait", "BowCloseAttackTrait", "BowConsecutiveBarrageTrait"},
    BowBondTrait = {"BowBondBoostTrait", "BowDoubleShotTrait", "BowLongRangeDamageTrait", "BowSlowChargeDamageTrait", "BowPowerShotTrait", "BowSecondaryBarrageTrait", "BowTripleShotTrait", "BowChainShotTrait", "BowCloseAttackTrait"},
    FistBaseUpgradeTrait = {"FistReachAttackTrait", "FistDashAttackHealthBufferTrait", "FistTeleportSpecialTrait", "FistDoubleDashSpecialTrait", "FistChargeSpecialTrait", "FistKillTrait", "FistSpecialLandTrait", "FistAttackFinisherTrait", "FistConsecutiveAttackTrait", "FistSpecialFireballTrait", "FistAttackDefenseTrait", "FistHeavyAttackTrait"},
    FistVacuumTrait = {"FistReachAttackTrait", "FistDashAttackHealthBufferTrait", "FistKillTrait", "FistSpecialLandTrait", "FistAttackFinisherTrait", "FistConsecutiveAttackTrait", "FistAttackDefenseTrait", "FistHeavyAttackTrait", "FistDoubleDashSpecialTrait"},
    FistWeaveTrait = {"FistReachAttackTrait", "FistDashAttackHealthBufferTrait", "FistTeleportSpecialTrait", "FistDoubleDashSpecialTrait", "FistChargeSpecialTrait", "FistKillTrait", "FistAttackFinisherTrait", "FistConsecutiveAttackTrait", "FistSpecialFireballTrait", "FistAttackDefenseTrait", "FistHeavyAttackTrait"},
    FistDetonateTrait = {"FistDetonateBoostTrait", "FistSpecialLandTrait", "FistChargeSpecialTrait", "FistConsecutiveAttackTrait", "FistDashAttackHealthBufferTrait", "FistAttackDefenseTrait", "FistTeleportSpecialTrait", "FistDoubleDashSpecialTrait", "FistKillTrait"},
    GunBaseUpgradeTrait = {"GunSlowGrenade", "GunMinigunTrait", "GunShotgunTrait", "GunExplodingSecondaryTrait", "GunGrenadeFastTrait", "GunArmorPenerationTrait", "GunInfiniteAmmoTrait", "GunGrenadeClusterTrait", "GunGrenadeDropTrait", "GunHeavyBulletTrait", "GunChainShotTrait", "GunHomingBulletTrait"},
    GunGrenadeSelfEmpowerTrait = {"GunSlowGrenade", "GunMinigunTrait", "GunShotgunTrait", "GunExplodingSecondaryTrait", "GunGrenadeFastTrait", "GunArmorPenerationTrait", "GunInfiniteAmmoTrait", "GunGrenadeClusterTrait", "GunGrenadeDropTrait", "GunHeavyBulletTrait", "GunChainShotTrait", "GunHomingBulletTrait"},
    GunManualReloadTrait = {"GunSlowGrenade", "GunMinigunTrait", "GunShotgunTrait", "GunExplodingSecondaryTrait", "GunGrenadeFastTrait", "GunArmorPenerationTrait", "GunInfiniteAmmoTrait", "GunGrenadeClusterTrait", "GunGrenadeDropTrait", "GunHeavyBulletTrait", "GunChainShotTrait", "GunHomingBulletTrait"},
    GunLoadedGrenadeTrait = {"GunLoadedGrenadeBoostTrait", "GunLoadedGrenadeLaserTrait", "GunLoadedGrenadeSpeedTrait", "GunLoadedGrenadeWideTrait", "GunLoadedGrenadeInfiniteAmmoTrait", "GunSlowGrenade", "GunGrenadeFastTrait", "GunArmorPenerationTrait"},
  }

RunStartControl.DefaultHammerSettings = {
    SwordBaseUpgradeTrait = "SwordDoubleDashAttackTrait",
    SwordCriticalParryTrait = "SwordDoubleDashAttackTrait",
    DislodgeAmmoTrait = "SwordDoubleDashAttackTrait",
    SwordConsecrationTrait = "SwordBackstabTrait",
    SpearBaseUpgradeTrait = "SpearAutoAttack",
    SpearTeleportTrait = "SpearAutoAttack",
    SpearWeaveTrait = "SpearThrowExplode",
    SpearSpinTravel = "SpearThrowElectiveCharge",
    ShieldBaseUpgradeTrait = "ShieldRushProjectileTrait",
    ShieldRushBonusProjectileTrait = "ShieldRushProjectileTrait",
    ShieldTwoShieldTrait = "ShieldRushProjectileTrait",
    ShieldLoadAmmoTrait = "ShieldRushProjectileTrait",
    BowBaseUpgradeTrait = "BowTripleShotTrait",
    BowMarkHomingTrait = "BowConsecutiveBarrageTrait",
    BowLoadAmmoTrait = "BowTapFireTrait",
    BowBondTrait = "BowTripleShotTrait",
    FistBaseUpgradeTrait = "FistDashAttackHealthBufferTrait",
    FistVacuumTrait = "FistDashAttackHealthBufferTrait",
    FistWeaveTrait = "FistDashAttackHealthBufferTrait",
    FistDetonateTrait = "FistDashAttackHealthBufferTrait",
    GunBaseUpgradeTrait = "GunShotgunTrait",
    GunGrenadeSelfEmpowerTrait = "GunExplodingSecondaryTrait",
    GunManualReloadTrait = "GunExplodingSecondaryTrait",
    GunLoadedGrenadeTrait = "GunGrenadeFastTrait",
}

-- God is capitalized god name, coreSlot is Attack/Special/Cast/Dash, aspect is "ShieldLoadAmmoTrait" or nothing,
-- just checking for beowulf
function RunStartControl.CoreBoonReference( god, coreSlot, aspect )
    if coreSlot == "Attack" then
        return god .. "WeaponTrait"
    elseif coreSlot == "Special" then
        return god .. "SecondaryTrait"
    elseif coreSlot == "Cast" then
        if aspect == "ShieldLoadAmmoTrait" and god ~= "Dionysus" and god ~= "Poseidon" then
            return "ShieldLoadAmmo_" .. god .. "RangedTrait"
        else
            return god .. "RangedTrait"
        end
    elseif coreSlot == "Dash" then
        return god .."RushTrait"
    end
end