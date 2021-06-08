

function RunStartControl.SetAspectSettings( weapon, aspectTrait, hammerReward, boonGod, boonSlot, boonRarity, forcedFirstReward )
    if not GameState.RunStartControl then
        GameState.RunStartControl.AspectSettings = {}
    end

    local boonTrait = RunStartControl.CoreBoonReference( boonGod, boonSlot, aspectTrait )
    GameState.RunStartControl.AspectSettings[aspectTrait] = {
        Weapon = weapon,
        Aspect = aspectTrait,
        Hammer = hammerReward,
        God = boonGod,
        Trait = boonTrait,
        Rarity = boonRarity,
        StartingReward = forcedFirstReward
    }
end

function RunStartControl.ClearAspectSettings()
    GameState.RunStartControl.AspectSettings = {}
end

function RunStartControl.DeleteModDataFromSavefile()
    GameState.RunStartControl = nil
end

ModUtil.WrapBaseFunction("StartNewRun", function( baseFunc, ... )
    if RunStartControl.Enabled and GameState.RunStartControl then
        for aspectTrait, aspectSettings in pairs(GameState.RunStartControl.AspectSettings) do
            if HeroHasTrait(aspectTrait) then
                RunStartControl.SetStartingReward(
                    aspectSettings.Weapon,
                    aspectSettings.aspectTrait,
                    aspectSettings.hammerReward,
                    aspectSettings.boonGod,
                    aspectSettings.boonTrait,
                    aspectSettings.boonRarity,
                    aspectSettings.forcedFirstReward
                )
            end
            break
        end
    end
    return baseFunc( ... )
end, RunStartControl)