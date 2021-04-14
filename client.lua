-- [
    -- AFK-Kick 
    -- Created by JavaHampus
-- ]

debugMode = false 

-- Do not touch -- 
local currentPosition  = nil
local previousPosition = nil
local currentHeading   = nil
local previousHeading  = nil
local timer = 0
local kickBypass = false

-- [
    -- Configuration
-- ]
local kickTime = 1200 -- In seconds

AddEventHandler('playerSpawning', function()
    TriggerServerEvent('AFK_Kick:CheckUser', source)
end)

RegisterNetEvent('AFK_Kick:CheckUser:Return')
AddEventHandler('AFK_Kick:CheckUser:Return', function(bypassPerms, err)
    if err then 
        debugPrint("An error occured. Please contact an server developer.")
    end 

    if bypassPerms then 
        kickBypass = true 
        debugPrint("Player is bypassing the script.")
    else
        kickBypass = false 
        debugPrint("Player is not bypassing the script.")
    end 
end)

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(1000)
        local player = PlayerPedId()

        if player then 
            currentPosition = GetEntityCoords(player, )
            currentHeading = GetEntityHeading(player)

            if currentPosition == previousPosition and currentHeading == previousHeading then -- Check if the player is not moving
                if timer > 0 then 
                    -- Notifications 
                    if timer == math.ceil(kickTime / 4) then
                        showNotification('~r~Move or you will be kicked in ~w~' .. math.ceil(kickTime / 4) .. ' seconds.')
                    end 

                    if timer == math.ceil(kickTime / 2) then
                        showNotification('~r~Move or you will be kicked in ~w~' .. math.ceil(kickTime / 2) .. ' seconds.')
                    end 

                    timer = timer - 1
                else
                    TriggerServerEvent('AFK-Kick:kickPlayer') 
                end
            else
                timer = kickTime
            end

            previousPosition = currentPosition
			previousHeading  = currentHeading
        end
    end
end)

function debugPrint(text)
    if debugMode then 
        print('^1[Debug Mode]^0: ' .. text)
    else 
        return
    end
end

function showNotification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(0, 1)
end 
