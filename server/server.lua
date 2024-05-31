AOP = Config.defaultAOP
Peacetime = false

RegisterNetEvent("FearlessStudios-HUD:setAOP", function(newAOP)
    local src = source
    if Config.useAOPPermissions then
        if IsPlayerAceAllowed(src, 'FSHUD.AOP') then
            AOP = newAOP
            TriggerClientEvent("FearlessStudios-HUD:retrieveAOP", -1, AOP)
        end
    else
        AOP = newAOP
        TriggerClientEvent("FearlessStudios-HUD:retrieveAOP", -1, AOP)
    end
end)

RegisterNetEvent("FearlessStudios-HUD:getAOP", function()
    local src = source
    TriggerClientEvent("FearlessStudios-HUD:retrieveAOP", src, AOP)
end)

RegisterNetEvent("FearlessStudios-HUD:setAOP", function(newAOP)
    local src = source
    if Config.useAcePerms then
        if IsPlayerAceAllowed(src, 'FSHUD.AOP') then
            AOP = newAOP
            TriggerClientEvent("FearlessStudios-HUD:retrieveAOP", -1, AOP)
        end
    else
        AOP = newAOP
        TriggerClientEvent("FearlessStudios-HUD:retrieveAOP", -1, AOP)
    end
end)

RegisterNetEvent("FearlessStudios-HUD:setPeacetime", function(newPeacetime)
    local src = source
    if Config.useAcePerms then
        if IsPlayerAceAllowed(src, 'FSHUD.PT') then
            Peacetime = newPeacetime
            TriggerClientEvent("FearlessStudios-HUD:retrievePeacetime", -1, Peacetime)
        end
    else
        Peacetime = newPeacetime
        TriggerClientEvent("FearlessStudios-HUD:retrievePeacetime", -1, Peacetime)
    end
end)

RegisterNetEvent("FearlessStudios-HUD:getPeacetime", function()
    local src = source
    TriggerClientEvent("FearlessStudios-HUD:retrievePeacetime", src, Peacetime)
end)

AddEventHandler("playerJoining", function()
    local src = source
    TriggerClientEvent("FearlessStudios-HUD:retrieveAOP", src, AOP)
    TriggerClientEvent("FearlessStudios-HUD:retrievePeacetime", src, Peacetime)
end)
