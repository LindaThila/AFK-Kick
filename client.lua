
kickBypass = false
debugMode = true 

-- Do not touch -- 
local currentPosition  = nil
local previousPosition = nil
local currentHeading   = nil
local previousHeading  = nil

local kickTime = 180 -- In seconds
local timer = 0

AddEventHandler('playerSpawning', function()
    local playerSource = source
    TriggerServerEvent('AFK_Kick:CheckUser', playerSource)
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

        player = PlayerPedId(-1)

        if player then 
            currentPosition = GetEntityCoords(player, true)
            currentHeading = GetEntityHeading(player)

            if currentPosition == previousPosition and currentHeading == previousHeading then 
                if timer > 0 then 

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

RegisterCommand('afkreload', function()
    local playerSource = source
    TriggerServerEvent('AFK_Kick:CheckUser', playerSource)
end)

function debugPrint(text)
    if debugMode then 
        print('^1[Debug Mode]^0: ' .. text)
    else 
        return
    end
end