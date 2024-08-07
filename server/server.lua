AOP = Config.defaultAOP
Peacetime = false

RegisterNetEvent("FS-HUD:setAOP", function(newAOP)
    local src = source
    if Config.useAOPPermissions then
        if IsPlayerAceAllowed(src, 'FSHUD.AOP') then
            AOP = newAOP
            TriggerClientEvent("FS-HUD:retrieveAOP", -1, AOP)
        end
    else
        AOP = newAOP
        TriggerClientEvent("FS-HUD:retrieveAOP", -1, AOP)
    end
end)

RegisterNetEvent("FS-HUD:getAOP", function()
    local src = source
    TriggerClientEvent("FS-HUD:retrieveAOP", src, AOP)
end)

RegisterNetEvent("FS-HUD:setAOP", function(newAOP)
    local src = source
    if Config.useAcePerms then
        if IsPlayerAceAllowed(src, 'FSHUD.AOP') then
            AOP = newAOP
            TriggerClientEvent("FS-HUD:retrieveAOP", -1, AOP)
        end
    else
        AOP = newAOP
        TriggerClientEvent("FS-HUD:retrieveAOP", -1, AOP)
    end
end)

RegisterNetEvent("FS-HUD:setPeacetime", function(newPeacetime)
    local src = source
    if Config.useAcePerms then
        if IsPlayerAceAllowed(src, 'FSHUD.PT') then
            Peacetime = newPeacetime
            TriggerClientEvent("FS-HUD:retrievePeacetime", -1, Peacetime)
        end
    else
        Peacetime = newPeacetime
        TriggerClientEvent("FS-HUD:retrievePeacetime", -1, Peacetime)
    end
end)

RegisterNetEvent("FS-HUD:getPeacetime", function()
    local src = source
    TriggerClientEvent("FS-HUD:retrievePeacetime", src, Peacetime)
end)

AddEventHandler("playerJoining", function()
    local src = source
    TriggerClientEvent("FS-HUD:retrieveAOP", src, AOP)
    TriggerClientEvent("FS-HUD:retrievePeacetime", src, Peacetime)
end)

exports['FS-Lib']:VersionCheck('FS-HUD', 'fearlessnite345/fs-hud')
