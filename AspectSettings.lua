

function RunStartControl.SetAspectSettings( weapon, aspectTrait, hammerReward, boonGod, boonSlot, boonRarity, forcedFirstReward )
    if not GameState.RunStartControl then
        GameState.RunStartControl = { AspectSettings = {}}
    end

    local existingSettings = GameState.RunStartControl.AspectSettings[aspectTrait] or {}

    local boonTrait = RunStartControl.CoreBoonReference( boonGod, boonSlot, aspectTrait )
    GameState.RunStartControl.AspectSettings[aspectTrait] = {
        Weapon = weapon or existingSettings.Weapon,
        Aspect = aspectTrait or existingSettings.Aspect,
        Hammer = hammerReward or existingSettings.Hammer,
        God = boonGod or existingSettings.God,
        Trait = boonTrait or existingSettings.Trait,
        Rarity = boonRarity or existingSettings.Rarity,
        StartingReward = forcedFirstReward or existingSettings.StartingReward
    }
end


function RunStartControl.ResetAspectSettings()
    for weaponIdx, weaponData in pairs(RunStartControl.WeaponAspectData) do
        for aspectIdx, aspectID in pairs(weaponData.Aspects) do
            RunStartControl.SetAspectSettings( weaponData.Name, aspectID, RunStartControl.DefaultHammerSettings[aspectID], nil, nil, nil, nil )
        end
    end
end

function RunStartControl.DeleteModDataFromSavefile()
    GameState.RunStartControl = nil
end

ModUtil.WrapBaseWithinFunction("StartNewRun", "EquipWeaponUpgrade", function( baseFunc, ... )
    baseFunc( ... )
    if RunStartControl.ForceFirstHammer and GameState.RunStartControl then
        for aspectTrait, aspectSettings in pairs(GameState.RunStartControl.AspectSettings) do
            if HeroHasTrait(aspectTrait) then
                DebugPrint({Text="Attempting to set rewards"})
                RunStartControl.SetStartingRewards(
                    aspectSettings.Weapon,
                    aspectSettings.Aspect,
                    aspectSettings.Hammer,
                    aspectSettings.God,
                    aspectSettings.Trait,
                    aspectSettings.Rarity,
                    aspectSettings.StartingReward
                )
            break
            end
        end
    end
end, RunStartControl)


ModUtil.LoadOnce( function()
    if not GameState.RunStartControl then
        RunStartControl.ResetAspectSettings()
    end 
end, RunStartControl)