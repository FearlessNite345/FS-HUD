if Config.useAOP then
    RegisterCommand(Config.aopCommand, function(source, args, rawCommand)
        local newAOP = table.concat(args, ' ')
        TriggerServerEvent("FS-HUD:setAOP", newAOP)
    end, false)
end

if Config.usePeacetime then
    RegisterCommand(Config.peacetimeCommand, function(source, args, rawCommand)
        TriggerServerEvent("FS-HUD:setPeacetime", not Peacetime)
    end, false)
end

RegisterCommand(Config.hideHudCommand, function()
    HudVisible = not HudVisible
end, false)
