local ESX = exports['es_extended']:getSharedObject()

-- Event: Vérifier et démarrer le crafting
RegisterNetEvent('zfundry:craftItem')
AddEventHandler('zfundry:craftItem', function(recipe, amount, craftType)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return end

    -- Vérifier le job
    if recipe.requiredJob and xPlayer.job.name ~= recipe.requiredJob then
        TriggerClientEvent('zfundry:notify', source, "Vous ne travaillez pas ici!", 'error')
        return
    end

    -- Vérifier le grade
    if recipe.requiredGrade and xPlayer.job.grade < recipe.requiredGrade then
        TriggerClientEvent('zfundry:notify', source, "Vous n'avez pas le grade requis!", 'error')
        return
    end

    -- Vérifier les ingrédients
    local hasAllIngredients = true
    for _, ingredient in ipairs(recipe.requires) do
        local itemCount = xPlayer.getInventoryItem(ingredient.item).count
        if itemCount < (ingredient.amount * amount) then
            hasAllIngredients = false
            TriggerClientEvent('zfundry:notify', source, "Il vous manque: " .. (ingredient.amount * amount) .. "x " .. ingredient.item, 'error')
            break
        end
    end

    if not hasAllIngredients then return end

    -- Retirer les ingrédients
    for _, ingredient in ipairs(recipe.requires) do
        xPlayer.removeInventoryItem(ingredient.item, ingredient.amount * amount)
    end

    -- Démarrer le crafting côté client
    TriggerClientEvent('zfundry:startCrafting', source, recipe, amount, craftType)
end)

-- Event: Terminer le crafting
RegisterNetEvent('zfundry:finishCrafting')
AddEventHandler('zfundry:finishCrafting', function(recipe, amount, craftType)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return end

    -- Donner l'item crafté
    local totalAmount = recipe.amount * amount

    -- Vérifier si le joueur a la place
    local item = xPlayer.getInventoryItem(recipe.item)
    if item.limit ~= -1 and (item.count + totalAmount) > item.limit then
        TriggerClientEvent('zfundry:notify', source, "Vous n'avez pas assez de place dans votre inventaire!", 'error')

        -- Rembourser les ingrédients
        for _, ingredient in ipairs(recipe.requires) do
            xPlayer.addInventoryItem(ingredient.item, ingredient.amount * amount)
        end
        return
    end

    xPlayer.addInventoryItem(recipe.item, totalAmount)
    TriggerClientEvent('zfundry:notify', source, "Vous avez fabriqué " .. totalAmount .. "x " .. recipe.label .. "!", 'success')

    -- Log
    print(string.format("[ZFundry] %s (%s) a fabriqué %dx %s",
        xPlayer.getName(),
        xPlayer.identifier,
        totalAmount,
        recipe.item
    ))
end)

-- Callback: Obtenir l'inventaire du joueur
ESX.RegisterServerCallback('zfundry:getPlayerInventory', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then
        cb({})
        return
    end

    local inventory = {}

    for itemName, _ in pairs(Config.ExportPrices) do
        local item = xPlayer.getInventoryItem(itemName)
        if item and item.count > 0 then
            table.insert(inventory, {
                name = item.name,
                label = item.label,
                count = item.count
            })
        end
    end

    cb(inventory)
end)

-- Event: Vendre des items
RegisterNetEvent('zfundry:sellItem')
AddEventHandler('zfundry:sellItem', function(itemName, amount, price)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return end

    -- Vérifier que l'item est exportable
    local isExportable = false
    for _, exportableItem in ipairs(Config.ExportableItems) do
        if exportableItem == itemName then
            isExportable = true
            break
        end
    end

    if not isExportable then
        TriggerClientEvent('zfundry:notify', source, "Cet item ne peut pas être exporté!", 'error')
        return
    end

    -- Vérifier que le joueur a l'item
    local item = xPlayer.getInventoryItem(itemName)
    if not item or item.count < amount then
        TriggerClientEvent('zfundry:notify', source, "Vous n'avez pas assez de cet item!", 'error')
        return
    end

    -- Retirer l'item et donner l'argent
    xPlayer.removeInventoryItem(itemName, amount)
    local totalPrice = price * amount
    xPlayer.addMoney(totalPrice)

    TriggerClientEvent('zfundry:notify', source, "Vous avez vendu " .. amount .. "x " .. item.label .. " pour $" .. totalPrice .. "!", 'success')

    -- Log
    print(string.format("[ZFundry Export] %s (%s) a vendu %dx %s pour $%d",
        xPlayer.getName(),
        xPlayer.identifier,
        amount,
        itemName,
        totalPrice
    ))
end)

-- Callback: Obtenir les données du boss
ESX.RegisterServerCallback('zfundry:getBossData', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then
        cb({money = 0, employees = {}})
        return
    end

    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_' .. Config.Job, function(account)
        local societyMoney = account and account.money or 0

        -- Récupérer les employés
        MySQL.Async.fetchAll('SELECT * FROM users WHERE job = @job ORDER BY job_grade DESC', {
            ['@job'] = Config.Job
        }, function(employees)
            local employeesList = {}

            for _, employee in ipairs(employees) do
                table.insert(employeesList, {
                    identifier = employee.identifier,
                    name = employee.firstname .. ' ' .. employee.lastname,
                    grade = employee.job_grade
                })
            end

            cb({
                money = societyMoney,
                employees = employeesList
            })
        end)
    end)
end)

-- Event: Retirer de l'argent de la société
RegisterNetEvent('zfundry:withdrawMoney')
AddEventHandler('zfundry:withdrawMoney', function(amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return end

    if xPlayer.job.name ~= Config.Job or xPlayer.job.grade_name ~= 'boss' then
        TriggerClientEvent('zfundry:notify', source, "Vous n'êtes pas le patron!", 'error')
        return
    end

    amount = tonumber(amount)
    if not amount or amount <= 0 then
        TriggerClientEvent('zfundry:notify', source, "Montant invalide!", 'error')
        return
    end

    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_' .. Config.Job, function(account)
        if account.money >= amount then
            account.removeMoney(amount)
            xPlayer.addMoney(amount)
            TriggerClientEvent('zfundry:notify', source, "Vous avez retiré $" .. amount .. " de la société", 'success')
            TriggerClientEvent('zfundry:refreshBossUI', source)

            print(string.format("[ZFundry] %s a retiré $%d de la société", xPlayer.getName(), amount))
        else
            TriggerClientEvent('zfundry:notify', source, "La société n'a pas assez d'argent!", 'error')
        end
    end)
end)

-- Event: Déposer de l'argent dans la société
RegisterNetEvent('zfundry:depositMoney')
AddEventHandler('zfundry:depositMoney', function(amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return end

    if xPlayer.job.name ~= Config.Job or xPlayer.job.grade_name ~= 'boss' then
        TriggerClientEvent('zfundry:notify', source, "Vous n'êtes pas le patron!", 'error')
        return
    end

    amount = tonumber(amount)
    if not amount or amount <= 0 then
        TriggerClientEvent('zfundry:notify', source, "Montant invalide!", 'error')
        return
    end

    if xPlayer.getMoney() >= amount then
        xPlayer.removeMoney(amount)
        TriggerEvent('esx_addonaccount:getSharedAccount', 'society_' .. Config.Job, function(account)
            account.addMoney(amount)
            TriggerClientEvent('zfundry:notify', source, "Vous avez déposé $" .. amount .. " dans la société", 'success')
            TriggerClientEvent('zfundry:refreshBossUI', source)

            print(string.format("[ZFundry] %s a déposé $%d dans la société", xPlayer.getName(), amount))
        end)
    else
        TriggerClientEvent('zfundry:notify', source, "Vous n'avez pas assez d'argent!", 'error')
    end
end)

-- Commande pour donner le job (admin seulement)
ESX.RegisterCommand('setfoundry', 'admin', function(xPlayer, args, showError)
    local targetPlayer = ESX.GetPlayerFromId(args.playerId)

    if targetPlayer then
        targetPlayer.setJob('foundry', args.grade or 0)
        TriggerClientEvent('esx:showNotification', xPlayer.source, "Vous avez donné le job Fonderie à " .. targetPlayer.getName())
        TriggerClientEvent('esx:showNotification', targetPlayer.source, "Vous avez été embauché à la Fonderie!")
    else
        showError("Joueur non trouvé")
    end
end, true, {
    help = 'Donner le job Fonderie à un joueur',
    validate = true,
    arguments = {
        {name = 'playerId', help = 'ID du joueur', type = 'player'},
        {name = 'grade', help = 'Grade (0-2)', type = 'number'}
    }
})

-- Log au démarrage
print("^2[ZFundry]^7 Script de Fonderie & Bijouterie chargé avec succès!")
print("^2[ZFundry]^7 " .. #Config.FoundryRecipes .. " recettes de fonderie disponibles")
print("^2[ZFundry]^7 " .. #Config.JewelryRecipes .. " recettes de bijouterie disponibles")
local exportCount = 0
for _ in pairs(Config.ExportPrices) do exportCount = exportCount + 1 end
print("^2[ZFundry]^7 " .. exportCount .. " items exportables")
