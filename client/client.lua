local minimap

-- Initialization Thread
Citizen.CreateThread(function()
    -- Load resources
    minimap = RequestScaleformMovie("minimap")
    while not HasScaleformMovieLoaded(minimap) do
        Citizen.Wait(0)
    end

    -- Set up the big map
    SetBigmapActive(true, false)
    Citizen.Wait(0)
    SetBigmapActive(false, false)

    -- Load postals and request AOP from server
    LoadPostals()
    TriggerServerEvent("FS-HUD:getAOP")
end)

-- HUD Update Thread
Citizen.CreateThread(function()
    local scale = 0.45
    local bigScale = 1.0

    while true do
        Citizen.Wait(0)

        if minimap ~= nil then
            BeginScaleformMovieMethod(minimap, "SETUP_HEALTH_ARMOUR")
            ScaleformMovieMethodAddParamInt(3)
            EndScaleformMovieMethod()
        end

        if HudVisible then
            local playerPedID = PlayerPedId()
            local playerCoords = GetEntityCoords(playerPedID, false)
            local streetHash, streetCrossinghash = GetStreetNameAtCoord(playerCoords.x, playerCoords.y, playerCoords.z)
            local streetName = GetStreetNameFromHashKey(streetHash)
            local streetCrossingName = GetStreetNameFromHashKey(streetCrossinghash)
            local zone = GetLabelText(GetNameOfZone(playerCoords.x, playerCoords.y, playerCoords.z))
            local heading = GetGameplayCamRot(0).z

            -- Draw HUD elements
            FS_Lib:DrawText2D(Config.headingX, Config.headingY,
                "~w~| " .. LocationHudColor .. HeadingToCardinal(heading) .. " ~w~|", bigScale, false)
            if streetCrossingName ~= '' then
                FS_Lib:DrawText2D(Config.streetX, Config.streetY,
                    LocationHudColor .. streetName .. " ~c~/ " .. streetCrossingName, 0.45, false)
            else
                FS_Lib:DrawText2D(Config.streetX, Config.streetY, LocationHudColor .. streetName, 0.45, false)
            end
            FS_Lib:DrawText2D(Config.zoneX, Config.zoneY, LocationHudColor .. zone, 0.45, false)

            local date, time = GetCurrentTime(false)
            if Config.useGametime then
                FS_Lib:DrawText2D(Config.timeX, Config.timeY,
                    LocationHudColor .. "ID: " .. GetPlayerServerId(PlayerId()) .. " | TIME: " .. time, scale, false)
            else
                FS_Lib:DrawText2D(Config.timeX, Config.timeY,
                    LocationHudColor ..
                    "ID: " .. GetPlayerServerId(PlayerId()) .. " | TIME: " .. time .. " | DATE: " .. date, scale, false)
            end

            local closestPostal = GetClosestPostal()
            if Config.useAOP and Config.usePeacetime then
                FS_Lib:DrawText2D(Config.postalaopX, Config.postalaopY,
                    LocationHudColor ..
                    "POSTAL: " ..
                    closestPostal .. " | AOP: " .. AOP .. " | Peacetime: " .. CapitalizeFirst(tostring(Peacetime)), scale,
                    false)
            elseif Config.useAOP and not Config.usePeacetime then
                FS_Lib:DrawText2D(Config.postalaopX, Config.postalaopY,
                    LocationHudColor .. "POSTAL: " .. closestPostal .. " | AOP: " .. AOP, scale, false)
            elseif not Config.useAOP and Config.usePeacetime then
                FS_Lib:DrawText2D(Config.postalaopX, Config.postalaopY,
                    LocationHudColor ..
                    "POSTAL: " .. closestPostal .. " | Peacetime: " .. CapitalizeFirst(tostring(Peacetime)), scale, false)
            else
                FS_Lib:DrawText2D(Config.postalaopX, Config.postalaopY, LocationHudColor .. "POSTAL: " .. closestPostal, scale,
                    false)
            end
        else
            DisplayRadar(false)
        end
    end
end)

-- Minimap Visibility Thread
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500) -- Check minimap visibility every 500 milliseconds

        if HudVisible then
            local playerPedID = PlayerPedId()
            if Config.hideMinimapOnFoot and not IsPedInAnyVehicle(playerPedID, false) then
                DisplayRadar(false)
            else
                DisplayRadar(true)
            end
        end
    end
end)

-- Peacetime Handling Thread
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if Peacetime then
            local playerPedID = PlayerPedId()

            if IsControlPressed(0, 106) then
                FS_Lib:DrawText2D(0.5, 0.8, "~r~Peacetime is enabled.", 0.6, true)
            end
            DisableControlAction(0, 140, true)     -- Disable melee attack
            SetPlayerCanDoDriveBy(playerPedID, false)
            DisablePlayerFiring(playerPedID, true) -- Disable firing
        end
    end
end)
