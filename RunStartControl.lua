--[[
    RunStartControl v1.0
    Authors:
        cgull (Discord: cgull#4469)
        Museus (Discord: Museus#7777)
    Makes the first room reward offer whatever is set by the function
    RunStartControl.SetStartingReward. See function header for details
]]

ModUtil.RegisterMod("RunStartControl")

local config = {
    Enabled = true,
    Debug = true,
    Menu = "both", --"prerun" for pre-pact selection, "configmenu" for modconfigmenu, "both" for both
}
RunStartControl.config = config

RunStartControl.ForceFirstReward = RunStartControl.config.Enabled and (RunStartControl.config.Menu == "prerun" or RunStartControl.config.Menu == "both")
RunStartControl.ForceFirstHammer = RunStartControl.config.Enabled and (RunStartControl.config.Menu == "configmenu" or RunStartControl.config.Menu == "both")

function RunStartControl.Log(debugText)
    if RunStartControl.config.Debug and debugText ~= nil then
        DebugPrint({ Text="[RunStartControl] " .. debugText })
    end
end

function IsHammerValid(hammerData, weapon, aspectTrait)
    local aspectInvalid = Contains(hammerData.RequiredFalseTraits, aspectTrait)
    local weaponMatch = hammerData.RequiredWeapon == weapon or 
                       (hammerData.RequiredWeapon == "SpearWeaponThrow" and weapon == "SpearWeapon") or 
                       (hammerData.RequiredWeapon == "BowSplitShot" and weapon == "BowWeapon")

    return weaponMatch and not aspectInvalid
end

--[[ current intention is to have actual values passed in for traits, could replace with "common" ones and 
     use mappings instead, depends on UI
 ]]
function RunStartControl.SetForcedBoon( boonGod, boonTrait, boonRarity )
    -- beowulf check later??? maybe push that upstream
    if boonGod and boonTrait then
        RunStartControl.ForcedBoon = {
            God = boonGod,
            Rarity = boonRarity,
            Trait = boonTrait
        }
    end
end

function RunStartControl.SetForcedHammer( weapon, aspectTrait, hammerReward )
    local hammerData = TraitData[hammerReward]

    -- check hammer compatibility
    if weapon and aspectTrait and hammerData and IsHammerValid(hammerData, weapon, aspectTrait) then
        RunStartControl.Log("Successfully set hammer: " .. hammerReward)
        RunStartControl.ForcedHammer = {
            Aspect = aspectTrait,
            Trait = hammerReward,
        }
    else
        RunStartControl.Log("Failed to set hammer: " .. hammerReward)
    end
end

-- Reset starting rewards
function RunStartControl.ResetStartingRewards()
    RunStartControl.Log("Resetting starting rewards... ")

    RunStartControl.StartingReward = nil -- "Boon" or "WeaponUpgrade"

    RunStartControl.ForcedHammer = {
        Aspect = nil, -- actual apsect trait name
        Trait = nil, -- actual trait name
    }

    RunStartControl.ForcedBoon = {
        God = nil, -- god name, nothing else
        Rarity = nil,
        Trait = nil, -- actual trait name
    }
end

RunStartControl.ResetStartingRewards()

-- force reward type (starting, boon or hammer), only for first room if requested
ModUtil.WrapBaseFunction("ChooseRoomReward", function( baseFunc, run, room, rewardStoreName, previouslyChosenRewards, args )
    local startingReward = RunStartControl.StartingReward
    if not (RunStartControl.ForceFirstReward and room.Name == "RoomOpening" and startingReward) then
        return baseFunc(run, room, rewardStoreName, previouslyChosenRewards, args)
    end

    -- removing reward from reward store if exists. skipping refilling since it's not
    -- relevant for a first reward
    for rewardKey, reward in pairs(run.RewardStores['RunProgress']) do
        if rewardKey == RunStartControl.StartingReward then
            run.RewardStores['RunProgress'][rewardKey] = nil
            CollapseTable( run.RewardStores['RunProgress'] )
            break
        end
    end

    RunStartControl.StartingReward = nil
    return startingReward

end, RunStartControl)

-- force boon type
ModUtil.WrapBaseFunction("ChooseLoot", function( baseFunc, excludeLootNames, forceLootName )

    -- checking if it's the first boon, and we have a god to overwrite with
    if RunStartControl.ForceFirstReward and RunStartControl.ForcedBoon.God then
        forceLootName = RunStartControl.ForcedBoon.God .. "Upgrade"
    end

    return baseFunc( excludeLootNames, forceLootName)

end, RunStartControl)

-- force reward (if to be forced)
ModUtil.WrapBaseFunction("SetTraitsOnLoot", function(baseFunc, lootData, args)
    local hammerToForce = lootData.Name == "WeaponUpgrade" and RunStartControl.ForcedHammer.Trait
    local boonToForce = lootData.GodLoot and RunStartControl.ForcedBoon.Trait

    -- verifying aspect
    RunStartControl.Log("Setting traits on loot. ")
    if RunStartControl.ForcedHammer.Trait ~= nil then
        RunStartControl.Log("Hammer: " .. RunStartControl.ForcedHammer.Trait)
    end
    if RunStartControl.ForcedBoon.Trait ~= nil then
        RunStartControl.Log("Boon: " .. RunStartControl.ForcedBoon.Trait)
    end
    if RunStartControl.ForceFirstHammer and hammerToForce then
        RunStartControl.Log("Forcing hammer: " .. RunStartControl.ForcedHammer.Trait)
        RunStartControl.Log("It requires: " .. RunStartControl.ForcedHammer.Aspect or "nil")
    end

    if RunStartControl.ForceFirstHammer and hammerToForce and HeroHasTrait(RunStartControl.ForcedHammer.Aspect) then
        lootData.BlockReroll = true
        lootData.UpgradeOptions = {
            { 
                ItemName = RunStartControl.ForcedHammer.Trait, 
                Type = "Trait",
                Rarity = "Common",
            }
        }
    elseif RunStartControl.ForceFirstReward and boonToForce and lootData.Name == RunStartControl.ForcedBoon.God .. "Upgrade" then
        lootData.BlockReroll = true
        lootData.UpgradeOptions = {
            {
                ItemName = RunStartControl.ForcedBoon.Trait,
                Type = 'Trait',
                Rarity = RunStartControl.ForcedBoon.Rarity or "Common"
            }
        }
    else
        baseFunc(lootData, args)
    end

end, RunStartControl)

ModUtil.WrapBaseFunction("AddTraitToHero", function(baseFunc, trait)
    local rewardWasHammer = ModUtil.SafeGet(trait, ModUtil.PathToIndexArray("TraitData.Frame")) == "Hammer"
    local rewardWasForcedGod = trait.TraitData and trait.TraitData.God

    if rewardWasHammer then
        RunStartControl.Log("Forced hammer used up.")

        RunStartControl.ForcedHammer = {
            Aspect = nil,
            Trait = nil,
        }
    elseif rewardWasForcedGod then
        RunStartControl.Log("Forced boon used up.")

        RunStartControl.ForcedBoon = {
            God = nil,
            Trait = nil,
            Rarity = nil
        }
    end

    baseFunc(trait)
end, RunStartControl)
