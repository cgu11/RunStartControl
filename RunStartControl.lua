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
}
RunStartControl.Config = config

RunStartControl.StartingData = {
    StartingReward = nil, -- "Boon" or "WeaponUpgrade"
    Hammer = {
        Aspect = nil, -- actual apsect trait name
        Trait = nil, -- actual trait name
    },
    Boon = {
        God = nil, -- god name, nothing else
        Rarity = nil,
        Trait = nil, -- actual trait name
    },
}

--[[ current intention is to have actual values passed in for traits, could replace with "common" ones and 
     use mappings instead, depends on UI
 ]]
function RunStartControl.SetStartingRewards( weapon, aspectTrait, hammerReward, boonGod, boonTrait, boonRarity, forcedFirstReward )
    RunStartControl.StartingData.StartingReward = forcedFirstReward
    -- needs weapon and aspect to check hammer compatibility
    if weapon and aspectTrait then
        DebugPrint({Text="checkpoint 1"})

        local hammerData = TraitData[hammerReward]
        if hammerData and hammerData.RequiredWeapon == weapon and not Contains(hammerData.RequiredFalseTraits, aspectTrait) then
            DebugPrint({Text="checkpoint 2"})
            RunStartControl.StartingData.Hammer = {
                Aspect = aspectTrait,
                Trait = hammerReward,
            }
        end
    end
    -- beowulf check later??? maybe push that upstream
    if boonGod and boonTrait then
        RunStartControl.StartingData.Boon = {
            God = boonGod,
            Rarity = boonRarity,
            Trait = boonTrait
        }
    end
end


-- force reward type (starting, boon or hammer), only for first room if requested
ModUtil.WrapBaseFunction("ChooseRoomReward", function( baseFunc, run, room, rewardStoreName, previouslyChosenRewards, args )
    local startingReward = RunStartControl.StartingData.StartingReward

    if RunStartControl.Config.Enabled and room.Name == "RoomOpening" and startingReward then
        -- removing reward from reward store if exists. skipping refilling since it's not
        -- relevant for a first reward
        for rewardKey, reward in pairs(run.RewardStores['RunProgress']) do
            if rewardKey == RunStartControl.StartingData.StartingReward then
                run.RewardStores['RunProgress'][rewardKey] = nil
                CollapseTable( run.RewardStores['RunProgress'] )
                break
            end
        end
        RunStartControl.StartingData.StartingReward = nil
        return startingReward
    else
        return baseFunc(run, room, rewardStoreName, previouslyChosenRewards, args)
    end
end, RunStartControl)

-- force boon type
ModUtil.WrapBaseFunction("ChooseLoot", function( baseFunc, excludeLootNames, forceLootName )
    -- checking if it's the first boon, and we have a god to overwrite with
    if RunStartControl.Config.Enabled and RunStartControl.StartingData.God and IsEmpty(GetAllUpgradableGodTraits()) then
        return baseFunc( excludeLootNames, RunStartControl.StartingData.God .. "Upgrade" )
    else
        return baseFunc( excludeLootNames, forceLootName)
    end
end, RunStartControl)

-- force reward (if to be forced)
ModUtil.WrapBaseFunction("SetTraitsOnLoot", function(baseFunc, lootData, args)
    local hammerToForce = lootData.Name == "WeaponUpgrade" and RunStartControl.StartingData.Hammer.Trait
    local boonToForce = lootData.GodLoot and RunStartControl.StartingData.Boon.Trait

    -- verifying aspect
    if RunStartControl.Config.Enabled and hammerToForce and HeroHasTrait(RunStartControl.StartingData.Hammer.Aspect) then
        lootData.BlockReroll = true
        lootData.UpgradeOptions = {
            { 
                ItemName = RunStartControl.StartingData.Hammer.Trait, 
                Type = "Trait",
                Rarity = "Common",
            }
        }
    elseif boonToForce and lootData.Name == RunStartControl.StartingData.Boon.God .. "Upgrade" then
        lootData.BlockReroll = true
        lootData.UpgradeOptions = {
            {
                ItemName = RunStartControl.StartingData.Boon.Trait,
                Type = 'Trait',
                Rarity = RunStartControl.StartinData.Boon.Rarity or "Common"
            }
        }
    else
        baseFunc(lootData, args)
    end
end, RunStartControl)

ModUtil.WrapBaseFunction("AddTraitToHero", function(baseFunc, trait)
    if ModUtil.SafeGet(trait, ModUtil.PathToIndexArray("TraitData.Frame")) == "Hammer" then
        RunStartControl.StartingData.Hammer = {
            Aspect = nil,
            Trait = nil,
        }
    elseif ModUtil.SafeGet(trait, ModUtil.PathToIndexArray("TraitData.Frame")) == "Boon" then
        RunStartControl.StartingData.Boon = {
            God = nil,
            Trait = nil,
            Rarity = nil
        }
    end
    baseFunc(trait)
  end, RunStartControl)