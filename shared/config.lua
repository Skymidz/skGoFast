Config = {}

Config.Locale = "fr" -- "fr" = Français or "en" = English
Config.Color = "~r~" -- "~r~" = Red / "~o~" = Orange / "~y~" = Yellow /  "~g~" = Green / "~b~" = Blue / "~p~" = Purple / "~u~" = Black
Config.ColorRGB = { r = 216, g = 49, b = 49 }
Config.GoFastStart = 1 -- Number of base GoFast for each reboot
Config.DrawDistance = 2 -- Distance to open menu
Config.IntervalGoFast = 30 -- +1 GoFast every x times (in minutes)
Config.OutCarFire = true -- The vehicle catches fire if the person leaves the vehicle during the GoFast

Config.Webhook = {
    State = false, -- Receive GoFast logs (Launch, failed and end)
    Link = "", -- Your webhook link
}

Config.Police = {
    nameJobIFPD = "police", -- LSPD job name
    Required = true, -- LSPD agent required to launch a GoFast
    NumberRequired = 3, -- Number of LSPD agents to launch a GoFast
    Notification = true, -- Notification when launching GoFast
    TimeNotification = 5, -- Interval time between the launch of the GoFast and the sending of the LSPD notification (in seconds)
}

Config.Reward = {
    Type = "black_money", --black_money (Argent Sale) or money (Argent Propre)
    Min = 10000, -- Minimum money to win
    Max = 15000, -- Maximum money to win
}

-- Location of Gofast launch points
Config.StartGoFast = {
    {
        PosMenu = vector3(933.07666015625, -1151.3666992188, 25.957834243774),
        PosSpawnCar = vector3(937.50384521484, -1149.0692138672, 25.172357559204),
        Heading = 180.19676208496097
    }
}

-- Location of Gofast Endpoints
Config.EndGoFast = {
    vector3(512.40954589844, -1985.1717529297, 24.985084533691),
    vector3(308.27536010742, 362.37835693359, 105.25410461426),
}

-- Vehicle donated for the launch of the GoFast
Config.Car = {
    { Name = "sultan", Label = "Sultan" },
    { Name = "t20", Label = "T20" },
}

-- Configuring the Blips for vehicle delivery
Config.Blips = {
    Modele = 430,
    Size = 0.8,
    Color = 1,
}

