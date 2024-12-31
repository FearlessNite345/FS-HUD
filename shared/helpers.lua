FS_Lib = exports['FS-Lib']

function DrawNotification2D(text, seconds, color)
    local startTime = GetGameTimer()
    local duration = seconds * 1000

    while GetGameTimer() - startTime < duration do
        FS_Lib:DrawText2D(0.5, 0.8, '~' .. color .. '~' .. text, 0.6, true)
        Citizen.Wait(0)
    end
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

function HeadingToCardinal(heading)
    local directions = { 'N', 'NW', 'W', 'SW', 'S', 'SE', 'E', 'NE', 'N' }
    local normalizedHeading = ((heading % 360) + 360) % 360
    local index = math.floor((normalizedHeading + 22.5) / 45)
    return directions[index + 1] -- Lua arrays start from index 1
end
