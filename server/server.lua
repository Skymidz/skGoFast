ESX = nil 
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function sendWebhook(titre,description,footer)
    local embeds = {
        {
            ["title"] = titre,
            ["description"] = description,
            ["type"] = "rich",
            ["color"] = 16711680,
            ["footer"] =  {
                ["text"]= footer
            },
        }
    }
    PerformHttpRequest(Config.Webhook.Link, function(err, text, headers) end, 'POST', json.encode({ embeds = embeds }), { ['Content-Type'] = 'application/json' })
end

RegisterServerEvent("skGoFast:Log")
AddEventHandler("skGoFast:Log", function(txt)
	sendWebhook(_U("Log:Title"), GetPlayerName(source).." "..txt, _U("Log:Footer"))
end)

RegisterServerEvent("skGoFast:Fini")
AddEventHandler("skGoFast:Fini", function()
    local _src = source 
    local xPlayer = ESX.GetPlayerFromId(_src)
    local randomCash = math.random(Config.Reward.Min, Config.Reward.Max)
	if Config.Reward.Type == "black_money" then
		xPlayer.addAccountMoney('black_money', randomCash)
	elseif Config.Reward.Type == "money" then
		xPlayer.addAccountMoney('money', randomCash)
	end 
    TriggerClientEvent('esx:showAdvancedNotification', _src, _U("Notif:Title"), _U("Notif:Desc1"), _U("Notif:Message1", randomCash), "CHAR_MP_MEX_BOSS", 3)
	if Config.Webhook.State == true and Config.Webhook.Link ~= "" then sendWebhook(_U("Log:Title"), _U("LogEnd:Desc", GetPlayerName(source), randomCash), _U("Log:Footer")) end
end)

RegisterServerEvent("skGoFast:CallPolice")
AddEventHandler("skGoFast:CallPolice", function()
    local xPlayers = ESX.GetPlayers()
    for i = 1, #xPlayers, 1 do
        local selectPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if selectPlayer.getJob().name == "police" then 
            TriggerClientEvent("esx:showAdvancedNotification", xPlayers[i], _U("Notif2:Title"), _U("Notif2:Desc"), _U("Notif2:Message"), "CHAR_JOSEF", 3)
        end
    end
end)

ESX.RegisterServerCallback("skGoFast:CheckIFPD", function(source, cb)
    local allPlayer = ESX.GetPlayers()
	local OnlineIFPD = 0
	for i=1, #allPlayer, 1 do 
		local selectPlayer = ESX.GetPlayerFromId(allPlayer[i])
		if selectPlayer.getJob().name == Config.Police.nameJobIFPD then OnlineIFPD = OnlineIFPD + 1 end 
	end 
	cb(OnlineIFPD)
end)

print("[^1Auteur^7] : ^4Skymidz#7333^7")