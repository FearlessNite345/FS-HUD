function DrawNotification3D(coords, text, seconds, color)
    local startTime = GetGameTimer()
    local duration = seconds * 1000

    while GetGameTimer() - startTime < duration do
        DrawText3D(coords.x, coords.y, coords.z, 0.6, '~' .. color .. '~' .. text)
        Citizen.Wait(0)
    end
end

function DrawNotification2D(text, seconds, color)
    local startTime = GetGameTimer()
    local duration = seconds * 1000

    while GetGameTimer() - startTime < duration do
        DrawText2D(0.5, 0.8, '~' .. color .. '~' .. text, 0.6, true)
        Citizen.Wait(0)
    end
end

function DrawRct(x, y, width, height, r, g, b, a)
    DrawRect(x + width/2, y + height/2, width, height, r, g, b, a)
end

function ConvertToPixels(x, y)
    local res_x, res_y = GetActiveScreenResolution()
    local px_x = x * res_x
    local px_y = y * res_y
    return px_x, px_y
end

function CapitalizeFirst(str)
    return (str:gsub("^%l", string.upper))
end


function GetCurrentTime(use24hrFormat)
    local hours
    local minutes
    local month
    local day
    local year
    
    if Config.useGametime then
        hours = GetClockHours()
        minutes = GetClockMinutes()
        month = tonumber(GetClockMonth())
        day = tonumber(GetClockDayOfMonth())
        year = tonumber(GetClockYear())
    else
        year, month, day, hours, minutes, _ = GetLocalTime()
    end

    local hourStr
    local minuteStr

    -- Add leading zeros if necessary
    if hours < 10 then
        hourStr = string.format("%02d", hours)
    else
        hourStr = tostring(hours)
    end

    if minutes < 10 then
        minuteStr = string.format("%02d", minutes)
    else
        minuteStr = tostring(minutes)
    end

    local dateString = month .. '/' .. day .. '/' .. year
    local timeString
    if use24hrFormat then
        timeString = hourStr .. ':' .. minuteStr
    else
        local ampm = "AM"
        if hours >= 12 then
            ampm = "PM"
        end
        local formattedHour = hours % 12
        if formattedHour == 0 then
            formattedHour = 12
        end
        timeString = formattedHour .. ':' .. minuteStr .. ' ' .. ampm
    end

    return dateString, timeString
end

function DrawText3D(x, y, z, scale, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)

    if onScreen then
        SetTextScale(scale, scale)
        SetTextFont(4)
        SetTextProportional(true)
        SetTextEntry("STRING")
        SetTextCentre(true)
        SetTextColour(255, 255, 255, 255)
        SetTextOutline()
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end

function DrawText2D(x, y, text, scale, center, R, G, B)
    SetTextFont(4)
    SetTextProportional(true)
    SetTextScale(scale, scale)
    SetTextColour(R, G, B, 255)
    SetTextDropShadow()
    SetTextEdge(4, 0, 0, 0, 255)
    SetTextOutline()
    if center then SetTextJustification(0) end
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end

function HeadingToCardinal(heading)
    local directions = { 'N', 'NW', 'W', 'SW', 'S', 'SE', 'E', 'NE', 'N' }
    local normalizedHeading = ((heading % 360) + 360) % 360
    local index = math.floor((normalizedHeading + 22.5) / 45)
    return directions[index + 1] -- Lua arrays start from index 1
end
