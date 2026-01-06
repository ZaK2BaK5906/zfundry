local ESX = exports['es_extended']:getSharedObject()

-- Fonction pour obtenir le prix d'un item
function GetExportPrice(itemName)
    return Config.ExportPrices[itemName] or 0
end

-- Export pour d'autres scripts
exports('GetExportPrice', GetExportPrice)

-- Callback pour obtenir tous les prix d'exportation
ESX.RegisterServerCallback('zfundry:getExportPrices', function(source, cb)
    cb(Config.ExportPrices)
end)

-- Event pour vendre en masse (optionnel - pour vendre tout d'un coup)
RegisterNetEvent('zfundry:sellAllExportable')
AddEventHandler('zfundry:sellAllExportable', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return end

    local totalEarned = 0
    local itemsSold = {}

    for itemName, price in pairs(Config.ExportPrices) do
        local item = xPlayer.getInventoryItem(itemName)
        if item and item.count > 0 then
            local earnings = price * item.count

            xPlayer.removeInventoryItem(itemName, item.count)
            totalEarned = totalEarned + earnings

            table.insert(itemsSold, {
                label = item.label,
                count = item.count,
                earnings = earnings
            })
        end
    end

    if totalEarned > 0 then
        xPlayer.addMoney(totalEarned)

        local message = "Exportation terminée! Gain total: $" .. totalEarned .. "\n"
        for _, soldItem in ipairs(itemsSold) do
            message = message .. soldItem.count .. "x " .. soldItem.label .. " ($" .. soldItem.earnings .. ")\n"
        end

        TriggerClientEvent('zfundry:notify', source, message, 'success')

        -- Log
        print(string.format("[ZFundry Export All] %s (%s) a exporté pour $%d",
            xPlayer.getName(),
            xPlayer.identifier,
            totalEarned
        ))
    else
        TriggerClientEvent('zfundry:notify', source, "Vous n'avez rien à exporter!", 'error')
    end
end)

print("^2[ZFundry Export]^7 Système d'exportation chargé!")
