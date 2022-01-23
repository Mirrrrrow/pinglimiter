
local warnings = 0
local maxWarnings = 3
local playerPing = 0
local pinglimit = 60
Citizen.CreateThread(function ()
    while true do
        Citizen.Wait(30000)
        TriggerServerEvent('requestPlayerPing')
        if playerPing > pinglimit then
            warnings = warnings + 1
            if warnings > maxWarnings then
                TriggerServerEvent('kickPlayerBecausePing')
            end
            ShowNotification("Please watch out your ping! (Warn " ..tostring(warnings).. "/" ..tostring(maxWarnings).. ")")
        end
    end
end)

RegisterNetEvent('responsePlayerPing')
AddEventHandler('responsePlayerPing', function (ping)
    playerPing = ping
end)

function ShowNotification(text)
	SetNotificationTextEntry('STRING')
    AddTextComponentString(text)
	DrawNotification(false, true)
end