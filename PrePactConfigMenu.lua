
RunStartControl.PrePactConfigMenuToggle = nil
RunStartControl.HammerPreference = nil
RunStartControl.GodPreference = nil
RunStartControl.SlotPreference = nil

function CreatePrePactConfigMenu()
  local components = {};

  local screen = {
      Components = components,
      MenuComponents = {},
      CloseAnimation  = "QuestLogBackground_Out"
    }
  OnScreenOpened({ Flag = screen.Name, PersistCombatUI = true})
  FreezePlayerUnit()
  EnableShopGamepadCursor()
  SetConfigOption({ Name = "FreeFormSelectWrapY", Value = false })
  SetConfigOption({ Name = "FreeFormSelectStepDistance", Value = 8 })

  components.ShopBackgroundDim = CreateScreenComponent({ Name = "rectangle01", Group = "Combat_Menu"})
  components.ShopBackgroundSplatter = CreateScreenComponent({ Name = "LevelUpBackground", Group = "Combat_Menu"})
  components.ShopBackground = CreateScreenComponent({ Name = "rectangle01", Group = "Combat_Menu"})

  SetAnimation({ DestinationId = components.ShopBackground.Id, Name = "QuestLogBackgroun_In", OffsetY = 30 })

  SetScale({ Id = components.ShopBackgroundDim.Id, Fraction = 4})
  SetColor({ Id = components.ShopBackgroundDim.Id, Color = { 0.090, 0.055, 0.157, 0.8 } })

  PlaySound({ Name = "/SFX/Menu Sounds/FatedListOpen" })

  wait(0.2)

  -- Title
  CreateTextBox({ Id = components.ShopBackground.Id, Text = "Configure Your Run", FontSize = 34, OffsetX = 0, OffsetY = -460,
  Color = Color.White, Font = "SpectralSCLightTitling", ShadowBlur = 0, ShadowColor = { 0, 0, 0, 1 }, ShadowOffset = { 0, 2 },
  Justification = "Center" })

  -- Hammer / Boon toggle buttons
  screen.Components["HammerButton"] = CreateScreenComponent({
    Name = "ButtonDefault",
    Scale = 1.0,
    Group = "Combat_Menu",
    X = 760,
    Y = 360})   
    )
  screen.Components["HammerButton"].OnPressedFunctionName = "ToggleSelectionScreen"
  screen.Components["HammerButton"].args = {
    SwitchTo = "hammer"
  }
  CreateTextBox({ Id = screen.Components["HammerButton"].Id,
      Text = "Hammer",
      OffsetX = 0, OffsetY = 0,
      FontSize = 22,
      Color = Color.White,
      Font = "AlegreyaSansSCRegular",
      ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
      Justification = "Center",
      DataProperties =
      {
      OpacityWithOwner = true,
      },
  })
  Attach({ Id = screen.Components["HammerButton"].Id, DestinationId = creen.Components["HammerButton"].Id, OffsetX = 500, OffsetY = 500 })

  screen.Components["BoonButton"] = CreateScreenComponent({
    Name = "ButtonDefault",
    Scale = 1.0,
    Group = "Combat_Menu",
    X = 1160,
    Y = 360})   
    )
  screen.Components["BoonButton"].OnPressedFunctionName = "ToggleSelectionScreen"
  screen.Components["BoonButton"].args = {
    SwitchTo = "boon"
  }
  CreateTextBox({ Id = screen.Components["BoonButton"].Id,
      Text = "Boon",
      OffsetX = 0, OffsetY = 0,
      FontSize = 22,
      Color = Color.White,
      Font = "AlegreyaSansSCRegular",
      ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
      Justification = "Center",
      DataProperties =
      {
      OpacityWithOwner = true,
      },
  })
  Attach({ Id = screen.Components["BoonButton"].Id, DestinationId = creen.Components["BoonButton"].Id, OffsetX = 500, OffsetY = 500 })

  -- Aspect Image
  local weaponAspectData = RunStartControl.GetEquippedWeaponAspect()
  local aspectX = 500
  local aspectY = 540
  screen.Components["AspectIcon"] = CreateScreenComponent({ Name = "BlankObstacle", Scale = 1.2, Group = "Combat_Menu", X = aspectX, Y = aspectY })
  local aspectIcon = TraitData[weaponAspectData.Aspect].Icon .. "_Large"
  SetAnimation({ DestinationId = screen.Components["AspectIcon"..weaponAspectData.Aspect].Id, Name = aspectIcon})

  -- Aspect Text Box
  screen.Components["AspectName"] = CreateScreenComponent({ Name = "BlankObstacle", Scale = 0.5, Group = "Combat_Menu", X = aspectX, Y = aspectY + 50})
  CreateTextBox({ Id = screen.Components["AspectName"].Id,
      Text = weaponAspectData.Aspect
      OffsetX = 0,
      OffsetY = 0,
      FontSize = 20,
      Color = Color.White,
      Font = "AlegreyaSansSCRegular",
      ShadowBlur = 0,
      ShadowColor = {0,0,0,1},
      ShadowOffset={0, 2},
      Justification = "Center",
      DataProperties = {
        OpacityWithOwner = true,
      },
    })

  -- Confirm button
  screen.Components["ConfirmButton"] = CreateScreenComponent({
      Name = "ButtonDefault",
      Scale = 1.0,
      Group = "Combat_Menu",
      X = 960,
      Y = 800})   
  )
  screen.Components["ConfirmButton"].OnPressedFunctionName = "ConfirmSelection"
  CreateTextBox({ Id = screen.Components["ConfirmButton"].Id,
      Text = "Confirm",
      OffsetX = 0, OffsetY = 0,
      FontSize = 22,
      Color = Color.White,
      Font = "AlegreyaSansSCRegular",
      ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
      Justification = "Center",
      DataProperties =
      {
        OpacityWithOwner = true,
      },
    })
  Attach({ Id = screen.Components["ConfirmButton"].Id, DestinationId = creen.Components["ConfirmButton"].Id, OffsetX = 500, OffsetY = 500 })

  -- Close Button
  screen.Components["CloseButton"] = CreateScreenComponent({ Name = "ButtonClose", Scale = 0.7, Group = "Combat_Menu"})
  Attach({ Id = screen.Components["CloseButton"], DestinationId = screen.Components["ShopBackground"].Id, OffsetX = -6, OffsetY = 456 })
  screen.Components["CloseButton"].OnPressedFunctionName = "ExitPrePactConfigMenu"
  screen.Components["CloseButton"].ControlHotkey = "Cancel"

end

function CreateHammerSelectionScreen( screen )
    -- Hammer Picker
    local weaponAspectData = RunStartControl.GetEquippedWeaponAspect()

    local xpos = 800
    local ypos = 600

    screen.Components["HammerLeft"] = CreateScreenComponent({ Name = "ButtonCodexDown", X = xpos - 120, Y = ypos, Scale = 1.0, Group = "Combat_Menu"})
    SetAngle({ Id = screen.Components["HammerLeft"].Id, Angle = -90})
    SetScale({ Id = screen.Components["HammerLeft"].Id, Fraction = 0.85})
    screen.Components["HammerLeft"].OnPressedFunctionName = "HammerLeft"

    screen.Components["HammerRight"] = CreateScreenComponent({ Name = "ButtonCodexDown", X = xpos + 120, Y = ypos, Scale = 1.0, Group = "Combat_Menu"})
    SetAngle({ Id = screen.Components["HammerRight"].Id, Angle = 90})
    SetScale({ Id = screen.Components["HammerRight"].Id, Fraction = 0.85})
    screen.Components["HammerRight"].OnPressedFunctionName = "HammerRight"

    screen.Components["CurrentHammer"] = CreateScreenComponent({ Name = "BlankObstacle", Scale = 0.5, Group = "Combat_Menu", X = xpos, Y = ypos})

    -- hammer text box
    local aspectHammers = RunStartControl.HammerOptions[weaponAspectData.Aspect]
    local hammerSetting = RunStartControl.DefaultHammerSettings[weaponAspectData.Aspect]

    for i, hammer in ipairs(aspectHammers) do
        if hammer == RunStartControl.HammerPreference then
            hammerSetting = hammer
            break
        end
    end

    RunStartControl.HammerPreference = hammerSetting


    CreateTextBox({ Id = screen.Components["CurrentHammer"].Id,
      Text = RunStartcontrol.HammerPreference,
      OffsetX = 0,
      OffsetY = 0,
      FontSize = 24,
      Color = Color.White,
      Font = "AlegreyaSansSCRegular",
      ShadowBlur = 0,
      ShadowColor = {0,0,0,1},
      ShadowOffset={0, 2},
      Justification = "Center",
      DataProperties = {
        OpacityWithOwner = true,
      },
    })

end

function HideHammerSelectionScreen( screen )
  local ids = {}
  local hammerComponentNames = {
    "HammerLeft", "HammerRight", "CurrentHammer","HammerIcon"
  }
  for i, hammerComponentName in ipairs(hammerComponentNames) do
    if screen.Components[hammerComponentName] then
      table.insert(ids, screen.Components[hammerComponentName].Id)
      screen.Components[hammerComponentName] = nil
    end
  end
  CloseScreen(ids)
end

function CreateBoonSelectionScreen( screen )
  RunStartControl.GodPreference = RunStartControl.GodPreference or "Zeus"
  RunStartControl.SlotPreference = RunStartControl.SlotPreference or "Attack"

  -- God Icon
  screen.Components["GodIcon"] = CreateScreenComponent({ Name = "BlankObstacle", Scale = 1.0, Group = "Combat_Menu", X = 1200, Y = 400 })
  Attach({ Id = screen.Components["GodIcon"].Id, DestinationId = screen.Components.ShopBackground.Id, OffsetX = 0, OffsetY = 0})
  SetAnimation({ Name = "BoonSymbol" .. RunStartControl.GodPreference .. "Isometric", DestinationId = screen.Components.GodIcon.Id, OffsetX = 640, OffsetY = -45})

  -- God buttons
  local x = -250
  local y = 30
  for _, god in pairs(RunStartControl.BoonGods) do
    screen.Components[god .. "Filter"] = CreateScreenComponent({ Name = "ButtonDefault", Scale = 0.5, Group = "Combat_Menu", X = 1200 + x, Y = 650 + y })
    screen.Components[god .. "Filter"].OnPressedFunctionName = "SelectGod"
    screen.Components[god .. "Filter"].args = {God = god}
    CreateTextBox({ Id = screen.Components[god .. "Filter"].Id,
        Text = god,
        OffsetX = 0, OffsetY = 0,
        FontSize = 16,
        Color = Color.BoonPatchCommon,
        Font = "AlegreyaSansSCRegular",
        ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
        Justification = "Center",
        DataProperties =
        {
          OpacityWithOwner = true,
        },
      })

    x = x + 150
    if x > 250 then
      x = -250
      y = y + 50
    end
  end

  ModifyTextBox({ Id = screen.Components[RunStartControl.GodPreference .. "Filter"].Id, Color = Color.Gray})

  -- Slot buttons
  x = -250
  y = 150
  for _, priorityBoon in pairs({"Attack", "Special", "Cast", "Dash"}) do
    screen.Components[priorityBoon .. "Filter"] = CreateScreenComponent({ Name = "ButtonDefault", Scale = 0.5, Group = "Combat_Menu", X = 1200 + x, Y = 800 + y })
    screen.Components[priorityBoon .. "Filter"].OnPressedFunctionName = "SelectBoon"
    screen.Components[priorityBoon .. "Filter"].args = {Boon = priorityBoon}
    CreateTextBox({ Id = screen.Components[priorityBoon .. "Filter"].Id,
        Text = priorityBoon,
        OffsetX = 0, OffsetY = 0,
        FontSize = 16,
        Color = Color.White,
        Font = "AlegreyaSansSCRegular",
        ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
        Justification = "Center",
        DataProperties =
        {
          OpacityWithOwner = true,
        },
      })
    x = x + 150
    if x > 250 then
      x = -250
      y = y + 60
    end
  end
  ModifyTextBox({ Id = screen.Components[RunStartControl.SlotPreference .. "Filter"].Id, Color = Color.Gray})

end

function HideBoonSelectionScreen( screen )
  local ids = {}
  local boonComponentNames = {
    "GodIcon", "ZeusFilter", "AphroditeFilter", "PoseidonFilter", "AresFilter", "AthenaFilter",
     "ArtemisFilter", "DionysusFilter", "DemeterFilter", "AttackFilter", "SpecialFilter", "DashFilter", "CastFIlter",
  }
  for i, boonComponentName in ipairs(boonComponentNames) do
    if screen.Components[boonComponentName] then
      table.insert(ids, screen.Components[boonComponentName].Id)
      screen.Components[boonComponentName] = nil
    end
  end
  CloseScreen(ids)
end

function ToggleSelectionScreen( screen, button )
    local switchTo = button.args.SwitchTo
    if switchTo ~= RunStartControl.PrePactConfigMenuToggle then
        if RunStartControl.PrePactConfigMenuToggle == "boon" then
            HideBoonSelectionScreen(screen)
        elseif RunStartControl.PrePactConfigMenuToggle == "hammer" then
            HideHammerSelectionScreen(screen)
        end

        if switchTo == "boon" then
            CreateBoonSelectionScreen(screen)
            RunStartControl.PrePactConfigMenuToggle = "boon"
        elseif switchTo == "hammer" then
            CreateHammerSelectionScreen(screen)
            RunStartControl.PrePactConfigMenuToggle = "hammer"
        end
    end
end

function HammerMove( screen, button, offset )
    local weaponAspectData = RunStartControl.GetEquippedWeaponAspect()
    local aspect = weaponAspectData.Aspect
    local currentHammer = RunStartControl.HammerPreference
    local aspectHammers = RunStartControl.HammerOptions[aspect]

    local hammerIndex = nil
    for i, hammer in ipairs(aspectHamemrs) do
        if hammer == currentHammer then
            hammerIndex = i
            break
        end
    end
    hammerIndex = hammerIndex + offset

    if hammerIndex <= 0 then
        hammerIndex = TableLength(RunStartControl.HammerOptions[aspect]) + hammerIndex
    elseif hammerIndex > TableLength(RunStartControl.HammerOptions[aspect]) then
        hammerIndex = hammerIndex - TableLength(RunStartControl.HammerOptions[aspect])
    end

    RunStartControl.HammerPreference = RunStartControl.HammerOptions[aspect][hammerIndex]

    ModifyTextBox({ Id = screen.Components["CurrentHammer"].Id, Text = RunStartControl.HammerPreference})
end

function HammerLeft( screen, button )
    HammerMove(screen, button, -1)
end

function HammerRight( screen, button )
    HammerMove(screen, button, 1)
end

function SelectGod( screen, button )
  local god = button.args.God
  if god ~= RunStartControl.GodPreference then
    ModifyTextBox({ Id = screen.Components[RunStartControl.GodPreference .. "Filter"].Id, Color = Color.BoonPatchCommon})

    RunStartControl.GodPreference = god
    SetAnimation({ Name = "BoonSymbol" .. RunStartControl.GodPreference .. "Isometric", DestinationId = screen.Components.GodIcon.Id, OffsetX = 640, OffsetY = -45})
    ModifyTextBox({ Id = screen.Components[god .. "Filter"].Id, Color = Color.Gray})
  end
end

function SelectBoon( screen, button )
  local boon = button.args.boon
  if boon ~= RunStartControl.SlotPreference then
    ModifyTextBox({ Id = screen.Components[RunStartControl.SlotPreference .. "Filter"].Id, Color = Color.BoonPatchCommon})

    RunStartControl.SlotPreference = boon
    ModifyTextBox({ Id = screen.Components[boon .. "Filter"].Id, Color = Color.Gray})
  end
end

function ConfirmSelection( screen, button )
  local weaponAspectData = RunStartControl.GetEquippedWeaponAspect()
  if RunStartControl.PrePactConfigMenuToggle == "boon" then
    RunStartControl.SetStartingRewards(
      nil, nil, nil,
      RunStartControl.GodPreference,
      RunStartControl.CoreBoonReference(RunStartControl.GodPreference, RunStartControl.SlotPreference, weaponAspectData.Aspect),
      "Epic",
      "Boon",
    )
  elseif RunStartControl.PrePactConfigMenuToggle == "hammer" then
    RunStartControl.SetStartingRewards(
      weaponAspectData.Weapon,
      weaponAspectData.Aspect,
      RunStartControl.HammerPreference,
      nil, nil, nil,
      "WeaponUpgrade",
    )
  end
  ExitPrePactConfigMenu(screen, button)
end

function ExitPrePactConfigMenu( screen, button )
  DisableShopGamepadCursor()
  SetConfigOption({ Name = "FreeFormSelectWrapY", Value = false })
  SetConfigOption({ Name = "FreeFormSelectStepDistance", Value = 16 })
  SetConfigOption({ Name = "FreeFormSelectSuccessDistanceStep", Value = 8})
  SetAnimation({ DestinationId = screen.Components.ShopBackground.Id, Name = screen.CloseAnimation })
  PlaySound({ Name = "/SFX/Menu Sounds/FatedListClose" })
  CloseScreen( GetAllIds( screen.Components ), 0.1)
  UnfreezePlayerUnit()
  screen.KeepOpen = false
  OnScreenClosed({ Flag = screen.Name })
end

ModUtil.WrapBaseFunction('UseEscapeDoor', function( baseFunc, ... ) 
    if RunStartControl.config.Enabled and RunStartControl.config.Menu == "prerun" then
        CreatePrePactConfigMenu()
    end

    baseFunc( ... )
end, RunStartControl)