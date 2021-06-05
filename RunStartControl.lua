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
    ResetAfterSettingTraits = true,
}
RunStartControl.Config = config
RunStartControl.RewardType = nil
RunStartControl.StartingReward = nil
RunStartControl.StartingRewardRarity = nil

RunStartControl.RewardTypeNames = {
    ZeusUpgrade = "Boon",
    PoseidonUpgrade = "Boon",
    AthenaUpgrade = "Boon",
    ArtemisUpgrade = "Boon",
    DemeterUpgrade = "Boon",
    DionysusUpgrade = "Boon",
    AresUpgrade = "Boon",
    AthenaUpgrade = "Boon",
    WeaponUpgrade = "WeaponUpgrade",
    --HermesUpgrade = "HermesUpgrade"
}

--[[ Expects rewardType to be "WeaponUpgrade" for a hammer, "ZeusUpgrade" for a Zeus boon, etc. 
     Does not currently allow Hermes/Chaos/Heart/Obol/Pom/Blue Laurel starts

     Expects Trait name from TraitData for startingReward, and
     Common, Rare, Epic, or Heroic for startingRewardRarity
 ]]
function RunStartControl.SetStartingReward(rewardType, startingReward, startingRewardRarity )
    RunStartControl.RewardType = rewardType
    if rewardType then
        RunStartControl.StartingReward = RunStartControl.StartingRewardTraits[rewardType][startingReward]
    else
        RunStartControl.StartingReward = nil
    end
    if rewardType == "WeaponUpgrade" then
        RunStartReward.StartingRewardRarity = "Common"
    else
        RunStartReward.StartingRewardRarity = startingRewardRarity or "Common"
    end
    
end


-- force reward type (starting, boon or hammer)
ModUtil.WrapBaseFunction("ChooseRoomReward", function( baseFunc, run, room, rewardStoreName, previouslyChosenRewards, args )
    local rewardTypeName = RunStartControl.RewardTypeNames[RunStartControl.RewardType]

    if RunStartControl.Config.Enabled and room.Name == "RoomOpening" and rewardTypeName then
        -- removing reward from reward store if exists. skipping refilling since it's not
        -- relevant for a first reward
        for rewardKey, reward in run.RewardStores['RunProgress'] do
            if rewardKey == rewardTypeName then
                run.RewardStores['RunProgress'][rewardKey] = nil
                CollapseTable( run.RewardStores['RunProgress'] )
                break
            end
        end
        return rewardTypeName
    else
        return baseFunc(run, room, rewardStoreName, previouslyChosenRewards, args)
    end
end, RunStartControl)

-- force boon type
ModUtil.WrapBaseFunction("ChooseLoot", function( baseFunc, excludeLootNames, forceLootName )
    local rewardType = RunStartControl.RewardType

    if RunStartControl.Config.Enabled and CurrentRun.RunDepthCache <= 1.0 and rewardType and rewardType ~= "WeaponUpgrade" then
        return baseFunc( excludeLootNames, rewardType )
    else
        return baseFunc( excludeLootNames, forceLootName)
    end
end, RunStartControl)

-- force reward (starting)
ModUtil.WrapBaseFunction("SetTraitsOnLoot", function(baseFunc, lootData, args)
    if RunStartControl.Config.Enabled and CurrentRun.RunDepthCache <= 1.0 and
       lootData.Name == RunStartControl.RewardType and RunStartControl.StartingReward then
        lootData.BlockReroll = true
        lootData.UpgradeOptions = {
            { 
                ItemName = RunStartControl.StartingReward, 
                Type = "Trait",
                Rarity = RunStartControl.StartingRewardRarity,
            }
        }

        -- resetting to force this for one run only
        if RunStartControl.Config.ResetAfterSettingTraits then
            RunStartControl.RewardType = nil
            RunStartControl.StartingReward = nil
            RunStartControl.StartingRewardRarity = nil
    else
        baseFunc(lootData, args)
    end
end, RunStartControl)