ESX = nil
Citizen.CreateThread(function() while ESX == nil do TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) Citizen.Wait(0) end end)

GoFastDispo = Config.GoFastStart 
NumberOnlineIFPD = 0
Desc = nil
ChoixStart = nil

function LoadMenuGoFast()
    local MenuGoFast = RageUI.CreateMenu("~u~".._U("Menu1:Name"), _U("Menu1:Desc"), 10, 40, 'skbanner', 'sk_banner')
    RageUI.Visible(MenuGoFast, not RageUI.Visible(MenuGoFast))
    while MenuGoFast do
        Citizen.Wait(0)
        RageUI.IsVisible(MenuGoFast,true,true,true,function()
            RageUI.Separator(_U("Menu1:Separator1", GoFastDispo))
            RageUI.Line(Config.ColorRGB.r, Config.ColorRGB.g, Config.ColorRGB.b)
            if GoFastDispo > 0 then Desc = nil else Desc = _U("NoGoFast") end 
            if Config.Police.Required then if NumberOnlineIFPD >= Config.Police.NumberRequired then Desc = nil else Desc = _U("NoIFPD") end end
            if Config.Police.Required then if NumberOnlineIFPD >= Config.Police.NumberRequired then CheckIFPD = true else CheckIFPD = false end else CheckIFPD = true end
            RageUI.ButtonWithStyle(Config.Color.."→~s~ ".._U("Menu1:BTN1"), Desc, {}, GoFastDispo > 0  and CheckIFPD and GoFastDispo > 0, function(h, a, s)
                if s then
                    GoFastDispo = GoFastDispo - 1
                    local RandomCar = math.random(1, #Config.Car)
                    local RandomPos = math.random(1, #Config.EndGoFast)
                    SpawnVehicle(Config.Car[RandomCar].Name, Config.StartGoFast[ChoixStart].PosSpawnCar, Config.StartGoFast[ChoixStart].Heading)
                    if Config.Police.Notification then SetTimeout(Config.Police.TimeNotification * 1000, function() TriggerServerEvent("skGoFast:CallPolice") end) end
                    GoFastBlip = AddBlipForCoord(Config.EndGoFast[RandomPos].x, Config.EndGoFast[RandomPos].y, Config.EndGoFast[RandomPos].z)
                    SetBlipSprite(GoFastBlip, Config.Blips.Modele)
                    SetBlipScale(GoFastBlip, Config.Blips.Size)
                    SetBlipColour(GoFastBlip, Config.Blips.Color)
                    SetBlipAlpha(GoFastBlip, 400)
                    PulseBlip(GoFastBlip)
                    SetBlipRoute(GoFastBlip, true)
                    ESX.ShowAdvancedNotification(_U("Notif:Title"), "", _U("StartGoFast", Config.Car[RandomCar].Label), "CHAR_MP_MEX_BOSS", 8)
                    FreezeEntityPosition(PlayerPedId(), false)
                    RageUI.CloseAll()
                    GoFastEnCours(Config.EndGoFast[RandomPos])
                end
            end)

        end, function() end, 1)
        if not RageUI.Visible(MenuGoFast) then
            MenuGoFast=RMenu:DeleteType("Go Fast", true)
            FreezeEntityPosition(PlayerPedId(), false)
        end 
        if RageUI.Visible(MenuGoFast) then FreezeEntityPosition(PlayerPedId(), true) end
    end
end