

function RunStartControl.SetAspectSettings( weapon, aspectTrait, hammerReward )
    if not GameState.RunStartControl then
        GameState.RunStartControl = { AspectSettings = {}}
    end

    local existingSettings = GameState.RunStartControl.AspectSettings[aspectTrait] or {}

    GameState.RunStartControl.AspectSettings[aspectTrait] = {
        Weapon = weapon or existingSettings.Weapon,
        Aspect = aspectTrait or existingSettings.Aspect,
        Hammer = hammerReward or existingSettings.Hammer,
    }
end


function RunStartControl.ResetAspectSettings()
    for weaponIdx, weaponData in pairs(RunStartControl.WeaponAspectData) do
        for aspectIdx, aspectID in pairs(weaponData.Aspects) do
            RunStartControl.SetAspectSettings(
                weaponData.Name,
                aspectID,
                RunStartControl.DefaultHammerSettings[aspectID]
            )
        end
    end
end

function RunStartControl.DeleteModDataFromSavefile()
    GameState.RunStartControl = nil
end

ModUtil.WrapBaseFunction("StartOver", function( baseFunc )
    if RunStartControl.ForceFirstHammer and GameState.RunStartControl then
        for aspectTrait, aspectSettings in pairs(GameState.RunStartControl.AspectSettings) do
            if HeroHasTrait(aspectTrait) and not RunStartControl.ForcedHammer.Trait then
                RunStartControl.SetForcedHammer(
                    aspectSettings.Weapon,
                    aspectSettings.Aspect,
                    aspectSettings.Hammer
                )

                break
            end
        end
    end
    
    baseFunc()
end, RunStartControl)

ModUtil.LoadOnce( function()
    if not GameState.RunStartControl then
        RunStartControl.ResetAspectSettings()
    end 
end, RunStartControl)