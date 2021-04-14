local kickBypass = {
    "831877873530830920",
}

RegisterServerEvent('AFK_Kick:CheckUser')
AddEventHandler('AFK_Kick:CheckUser', function()
    local playerSource = source
    for k, v in ipairs(GetPlayerIdentifiers(playerSource)) do
        if string.sub(v, 1, string.len("discord:")) == "discord:" then
            identifierDiscord = v
        end
    end

    if identifierDiscord then 
        exports['discordroles']:isRolePresent(playerSource, kickBypass, function(hasRole, roles)
            if not roles then 
                TriggerClientEvent('AFK_Kick:CheckUser:Return', playerSource, false, true)
            end
            if hasRole then 
                TriggerClientEvent('AFK_Kick:CheckUser:Return', playerSource, true, false)
            else 
                TriggerClientEvent('AFK_Kick:CheckUser:Return', playerSource, false, false)
            end
        end)
    else
        TriggerClientEvent('AFK_Kick:CheckUser:Return', playerSource, false, true)   
    end 
end)

RegisterNetEvent('AFK-Kick:kickPlayer')
AddEventHandler('AFK-Kick:kickPlayer', function()
    local playerSource = source
    DropPlayer(playerSource, "AFK-Kick: Kicked for idling")
end)