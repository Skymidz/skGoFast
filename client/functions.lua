ESX = nil
Citizen.CreateThread(function() while ESX == nil do TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) Citizen.Wait(0) end end)

function startAnim(lib, anim)
    ESX.Streaming.RequestAnimDict(lib, function()
        TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0.0, false, false, false)
    end)
end

function SpawnVehicle(Model, Coords, Heading)
    local HashCar = GetHashKey(Model)
    RequestModel(HashCar)
    while not HasModelLoaded(HashCar) do Wait(10) end
    local veh = CreateVehicle(HashCar, Coords.x, Coords.y, Coords.z, Heading, true, false)
    SetVehicleNumberPlateText(veh, "GOFAST")
    TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
end

function GoFastEnCours(Coords)
    if Config.Webhook.State == true and Config.Webhook.Link ~= "" then TriggerServerEvent("skGoFast:Log", _U("LogStart:Desc")) end
    PlaySoundFrontend(-1, "Event_Start_Text", "GTAO_FM_Events_Soundset", 1)
    Wait(1000)
    EtatGoFast = true
    while EtatGoFast do 
        interval = 500
        while IsPedInAnyVehicle(PlayerPedId()) == false do
            local Car = GetVehiclePedIsIn(PlayerPedId(), true)
            local CarCoords = GetEntityCoords(Car)
            if Config.OutCarFire then 
                SetTimeout(3000, function()
                    SetVehicleDoorsLocked(Car, 2)
                    SetVehicleEngineHealth(Car, -4000)
                    local idFire = StartScriptFire(CarCoords.x+0.2, CarCoords.y, CarCoords.z-0.3, 25, false)
                    SetTimeout(60000, function() RemoveScriptFire(idFire) end)
                end)
            end
            ESX.ShowAdvancedNotification(_U("Notif:Title"), _U("Notif:Desc2"), _U("Notif:Message2"), "CHAR_MP_MEX_BOSS", 8)
            RemoveBlip(GoFastBlip)
            EtatGoFast = false
            if Config.Webhook.State == true and Config.Webhook.Link ~= "" then TriggerServerEvent("skGoFast:Log", _U("LogOut:Desc")) end 
            return
        end
        local distance = #(Coords - GetEntityCoords(PlayerPedId()))  
        local veh = GetVehiclePedIsIn(PlayerPedId(), false)
        local plate = GetVehicleNumberPlateText(veh)
        local carSpeed = GetEntitySpeed(veh) * 3.6
        if distance <= 5 then 
            interval = 0
            DrawMarker(27, Coords.x,Coordsy,Coords.z-1, 0.0,0.0,0.0, 0.0,0.0,0.0, 1.5,1.5,1.5, Config.ColorRGB.r,Config.ColorRGB.g,Config.ColorRGB.b,200, false, true, p19, true)
            RageUI.Text({ message = _U("EndGoFast"), time_display = 1 })
            if carSpeed <= 15 then if IsControlJustPressed(1, 51) then GoFastEnd(veh, plate) end end
        elseif distance > 100 then interval = 4000
        elseif distance > 50 then interval = 2000
        elseif distance > 30 then interval = 1000
        elseif distance > 10 then interval = 500
        elseif distance > 5 then interval = 200 end
        Citizen.Wait(interval)
    end
end

function GoFastEnd(veh, plate)
    RemoveBlip(GoFastBlip)
    EtatGoFast = false
    if string.find(tostring(plate), "GOFAST") then 
        TriggerServerEvent("skGoFast:Fini")
        DeleteEntity(veh)
        PlaySoundFrontend(-1, "Event_Start_Text", "GTAO_FM_Events_Soundset", 1)
    else
        ESX.ShowAdvancedNotification(_U("Notif:Title"), _U("Notif:Desc2"), _U("Notif:Message3"), "CHAR_MP_MEX_BOSS", 8)
    end
end

Citizen.CreateThread(function()
    while true do
        local interval = 500
        for k,v in pairs(Config.StartGoFast) do
            local distance = #(v.PosMenu - GetEntityCoords(PlayerPedId()))
            if distance <= Config.DrawDistance then 
                interval = 0
                ChoixStart = nil 
                ChoixStart = k
                RageUI.Text({ message = _U("OpenMenu"), time_display = 1 })
                if IsControlJustPressed(1, 51) then
                    ESX.TriggerServerCallback("skGoFast:CheckIFPD", function(data) NumberOnlineIFPD = data end)
                    LoadMenuGoFast()
                end 
            elseif distance > 100 then interval = 4000
            elseif distance > 50 then interval = 2000
            elseif distance > 30 then interval = 1000
            elseif distance > 10 then interval = 500
            elseif distance > 5 then interval = 200 end
        end 
        Citizen.Wait(interval)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(Config.IntervalGoFast * 60000)
        GoFastDispo = GoFastDispo + 1
    end 
end)