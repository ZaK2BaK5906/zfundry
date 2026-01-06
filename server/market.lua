-- ═══════════════════════════════════════════════════════════════
-- SYSTÈME DE MARCHÉ DES LINGOTS
-- Cours dynamiques qui fluctuent automatiquement
-- ═══════════════════════════════════════════════════════════════

local ESX = exports['es_extended']:getSharedObject()

-- Prix de base des lingots (en dollars)
local IngotPrices = {
    gold_ingot = 10000,      -- Or: 10,000$
    silver_ingot = 2500,     -- Argent: 2,500$
    platinum_ingot = 15000,  -- Platine: 15,000$
    copper_ingot = 800       -- Cuivre: 800$
}

-- Variations de prix (min/max en %)
local PriceVariation = {
    min = -15, -- -15%
    max = 20   -- +20%
}

-- Prix actuels avec variations
local CurrentPrices = {}

-- Historique des prix (pour afficher la tendance)
local PriceHistory = {}

-- Initialiser les prix
function InitializeMarket()
    for ingot, basePrice in pairs(IngotPrices) do
        CurrentPrices[ingot] = basePrice
        PriceHistory[ingot] = {basePrice}
    end
    print("^2[ZFundry Market]^7 Marché des lingots initialisé!")
end

-- Mettre à jour les prix (fluctuation aléatoire)
function UpdateMarketPrices()
    for ingot, basePrice in pairs(IngotPrices) do
        -- Variation aléatoire entre -5% et +5%
        local variation = math.random(-5, 5) / 100
        local currentPrice = CurrentPrices[ingot]

        -- Appliquer la variation
        local newPrice = currentPrice + (currentPrice * variation)

        -- Limites de variation par rapport au prix de base
        local minPrice = basePrice + (basePrice * (PriceVariation.min / 100))
        local maxPrice = basePrice + (basePrice * (PriceVariation.max / 100))

        -- Appliquer les limites
        newPrice = math.max(minPrice, math.min(maxPrice, newPrice))
        newPrice = math.floor(newPrice)

        CurrentPrices[ingot] = newPrice

        -- Ajouter à l'historique (garder les 10 dernières valeurs)
        table.insert(PriceHistory[ingot], newPrice)
        if #PriceHistory[ingot] > 10 then
            table.remove(PriceHistory[ingot], 1)
        end
    end

    -- Notifier tous les joueurs connectés avec le market ouvert
    TriggerClientEvent('zfundry:updateMarketPrices', -1, CurrentPrices)
end

-- Obtenir les données du marché
ESX.RegisterServerCallback('zfundry:getMarketData', function(source, cb)
    local trends = {}

    for ingot, prices in pairs(PriceHistory) do
        local trend = 'stable'
        if #prices >= 2 then
            local lastPrice = prices[#prices]
            local previousPrice = prices[#prices - 1]

            if lastPrice > previousPrice then
                trend = 'up'
            elseif lastPrice < previousPrice then
                trend = 'down'
            end
        end
        trends[ingot] = trend
    end

    cb({
        prices = CurrentPrices,
        baseprices = IngotPrices,
        trends = trends,
        history = PriceHistory
    })
end)

-- Acheter un lingot (cash -> lingot)
RegisterNetEvent('zfundry:buyIngot')
AddEventHandler('zfundry:buyIngot', function(ingotType, amount)
    local xPlayer = ESX.GetPlayerFromId(source)

    if not IngotPrices[ingotType] then
        TriggerClientEvent('zfundry:notify', source, "Type de lingot invalide!", 'error')
        return
    end

    local price = CurrentPrices[ingotType] * amount
    local playerMoney = xPlayer.getMoney()

    if playerMoney < price then
        TriggerClientEvent('zfundry:notify', source, "Vous n'avez pas assez d'argent!", 'error')
        return
    end

    -- Retirer l'argent
    xPlayer.removeMoney(price)

    -- Donner le lingot
    xPlayer.addInventoryItem(ingotType, amount)

    TriggerClientEvent('zfundry:notify', source, string.format("Vous avez acheté %dx %s pour $%s", amount, GetIngotLabel(ingotType), ESX.Math.GroupDigits(price)), 'success')
end)

-- Vendre un lingot (lingot -> cash)
RegisterNetEvent('zfundry:sellIngot')
AddEventHandler('zfundry:sellIngot', function(ingotType, amount)
    local xPlayer = ESX.GetPlayerFromId(source)

    if not IngotPrices[ingotType] then
        TriggerClientEvent('zfundry:notify', source, "Type de lingot invalide!", 'error')
        return
    end

    local item = xPlayer.getInventoryItem(ingotType)

    if not item or item.count < amount then
        TriggerClientEvent('zfundry:notify', source, "Vous n'avez pas assez de lingots!", 'error')
        return
    end

    local price = CurrentPrices[ingotType] * amount

    -- Retirer le lingot
    xPlayer.removeInventoryItem(ingotType, amount)

    -- Donner l'argent
    xPlayer.addMoney(price)

    TriggerClientEvent('zfundry:notify', source, string.format("Vous avez vendu %dx %s pour $%s", amount, GetIngotLabel(ingotType), ESX.Math.GroupDigits(price)), 'success')
end)

-- Obtenir le label d'un lingot
function GetIngotLabel(ingotType)
    local labels = {
        gold_ingot = "Lingot d'Or",
        silver_ingot = "Lingot d'Argent",
        platinum_ingot = "Lingot de Platine",
        copper_ingot = "Lingot de Cuivre"
    }
    return labels[ingotType] or ingotType
end

-- Initialiser au démarrage
InitializeMarket()

-- Mettre à jour les prix toutes les 10 minutes (600000ms)
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(600000) -- 10 minutes
        UpdateMarketPrices()
        print("^3[ZFundry Market]^7 Prix mis à jour!")
    end
end)
