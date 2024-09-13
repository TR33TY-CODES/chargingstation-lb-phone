local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateUseableItem("charging_cable", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player then
        TriggerClientEvent('charging:startCharge', source)
    end
end)
