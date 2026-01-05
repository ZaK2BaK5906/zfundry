local ESX = exports['es_extended']:getSharedObject()
local PlayerData = {}
local isProcessing = false
local currentZone = nil

-- Initialisation
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)

-- Créer les blips
Citizen.CreateThread(function()
    for zoneName, zoneData in pairs(Config.Zones) do
        if zoneData.Blip and zoneData.Blip.Enabled then
            local blip = AddBlipForCoord(zoneData.Position.x, zoneData.Position.y, zoneData.Position.z)
            SetBlipSprite(blip, zoneData.Blip.Sprite)
            SetBlipDisplay(blip, 4)
            SetBlipScale(blip, zoneData.Blip.Scale)
            SetBlipColour(blip, zoneData.Blip.Color)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(zoneData.Blip.Label)
            EndTextCommandSetBlipName(blip)
        end
    end
end)

-- Afficher les markers et gérer les interactions
Citizen.CreateThread(function()
    while true do
        local sleep = 500
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)

        for zoneName, zoneData in pairs(Config.Zones) do
            if zoneName ~= 'Garage' then -- Le garage est géré séparément
                local distance = #(playerCoords - zoneData.Position)

                if distance < zoneData.Marker.DrawDistance then
                    sleep = 0
                    DrawMarker(
                        zoneData.Marker.Type,
                        zoneData.Position.x,
                        zoneData.Position.y,
                        zoneData.Position.z,
                        0.0, 0.0, 0.0,
                        0.0, 0.0, 0.0,
                        zoneData.Marker.Size.x,
                        zoneData.Marker.Size.y,
                        zoneData.Marker.Size.z,
                        zoneData.Marker.Color.r,
                        zoneData.Marker.Color.g,
                        zoneData.Marker.Color.b,
                        100,
                        false, true, 2, false, nil, nil, false
                    )

                    if distance < zoneData.Marker.InteractionDistance then
                        currentZone = zoneName
                        DrawText3D(zoneData.Position.x, zoneData.Position.y, zoneData.Position.z + 1.0, "~g~[E]~w~ Ouvrir le menu")

                        if IsControlJustReleased(0, 38) then -- Touche E
                            if zoneName == 'Foundry' then
                                OpenFoundryMenu()
                            elseif zoneName == 'Jewelry' then
                                OpenJewelryMenu()
                            elseif zoneName == 'Export' then
                                OpenExportMenu()
                            elseif zoneName == 'BossActions' then
                                OpenBossActionsMenu()
                            end
                        end
                    else
                        if currentZone == zoneName then
                            currentZone = nil
                        end
                    end
                end
            end
        end

        Citizen.Wait(sleep)
    end
end)

-- Afficher du texte 3D
function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())

    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x, _y)
    local factor = (string.len(text)) / 370
    DrawRect(_x, _y + 0.0125, 0.015 + factor, 0.03, 0, 0, 0, 75)
end

-- Menu Fonderie
function OpenFoundryMenu()
    if PlayerData.job and PlayerData.job.name == Config.Job then
        local recipes = {}

        for _, recipe in ipairs(Config.FoundryRecipes) do
            local canCraft = true

            if recipe.requiredJob then
                if PlayerData.job.name ~= recipe.requiredJob then
                    canCraft = false
                end
                if recipe.requiredGrade and PlayerData.job.grade < recipe.requiredGrade then
                    canCraft = false
                end
            end

            table.insert(recipes, {
                label = recipe.label,
                item = recipe.item,
                time = recipe.time,
                amount = recipe.amount,
                requires = recipe.requires,
                requiredGrade = recipe.requiredGrade,
                canCraft = canCraft,
                _original = recipe
            })
        end

        -- Ouvrir l'UI NUI
        SetNuiFocus(true, true)
        SendNUIMessage({
            action = 'openUI',
            recipes = recipes,
            title = 'Fonderie',
            menuType = 'foundry'
        })
    else
        ShowNotification("~r~Vous ne travaillez pas ici!", 'error')
    end
end

-- Menu Bijouterie
function OpenJewelryMenu()
    if PlayerData.job and PlayerData.job.name == Config.Job then
        local recipes = {}

        for _, recipe in ipairs(Config.JewelryRecipes) do
            local canCraft = true

            if recipe.requiredJob then
                if PlayerData.job.name ~= recipe.requiredJob then
                    canCraft = false
                end
                if recipe.requiredGrade and PlayerData.job.grade < recipe.requiredGrade then
                    canCraft = false
                end
            end

            table.insert(recipes, {
                label = recipe.label,
                item = recipe.item,
                time = recipe.time,
                amount = recipe.amount,
                requires = recipe.requires,
                requiredGrade = recipe.requiredGrade,
                canCraft = canCraft,
                _original = recipe
            })
        end

        -- Ouvrir l'UI NUI
        SetNuiFocus(true, true)
        SendNUIMessage({
            action = 'openUI',
            recipes = recipes,
            title = 'Bijouterie',
            menuType = 'jewelry'
        })
    else
        ShowNotification("~r~Vous ne travaillez pas ici!", 'error')
    end
end

-- NUI Callbacks
RegisterNUICallback('craftItem', function(data, cb)
    local recipe = data.recipe._original or data.recipe
    local amount = data.amount or 1
    local menuType = data.menuType or 'foundry'

    TriggerServerEvent('zfundry:craftItem', recipe, amount, menuType)
    cb('ok')
end)

RegisterNUICallback('closeUI', function(data, cb)
    SetNuiFocus(false, false)
    cb('ok')
end)

-- Menu Exportation
function OpenExportMenu()
    ESX.TriggerServerCallback('zfundry:getPlayerInventory', function(inventory)
        local elements = {}

        for _, item in ipairs(inventory) do
            if Config.ExportPrices[item.name] then
                local price = Config.ExportPrices[item.name]
                table.insert(elements, {
                    label = item.label .. " ~g~(" .. price .. "$ pièce) ~s~x" .. item.count,
                    value = item.name,
                    price = price,
                    count = item.count
                })
            end
        end

        if #elements == 0 then
            ShowNotification("~r~Vous n'avez rien à exporter!", 'error')
            return
        end

        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'export_menu', {
            title = "Point d'Exportation",
            align = 'top-left',
            elements = elements
        }, function(data, menu)
            menu.close()
            OpenExportAmountMenu(data.current.value, data.current.price, data.current.count)
        end, function(data, menu)
            menu.close()
        end)
    end)
end

-- Menu quantité exportation
function OpenExportAmountMenu(item, price, maxCount)
    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'export_amount', {
        title = "Combien voulez-vous en vendre? (Max: " .. maxCount .. ")"
    }, function(data, menu)
        local amount = tonumber(data.value)
        if amount and amount > 0 and amount <= maxCount then
            menu.close()
            TriggerServerEvent('zfundry:sellItem', item, amount, price)
        else
            ShowNotification("~r~Quantité invalide!", 'error')
        end
    end, function(data, menu)
        menu.close()
    end)
end

-- Menu Actions Patron
function OpenBossActionsMenu()
    if PlayerData.job and PlayerData.job.name == Config.Job and PlayerData.job.grade_name == 'boss' then
        TriggerEvent('esx_society:openBossMenu', Config.Job, function(data, menu)
            menu.close()
        end, {wash = false})
    else
        ShowNotification("~r~Vous n'êtes pas le patron!", 'error')
    end
end

-- Notification personnalisée
function ShowNotification(message, type)
    if type == 'success' then
        message = "~g~✓ " .. message
    elseif type == 'error' then
        message = "~r~✗ " .. message
    elseif type == 'info' then
        message = "~b~ℹ " .. message
    end

    BeginTextCommandThefeedPost("STRING")
    AddTextComponentSubstringPlayerName(message)
    EndTextCommandThefeedPostTicker(false, true)
end

-- Event de crafting
RegisterNetEvent('zfundry:startCrafting')
AddEventHandler('zfundry:startCrafting', function(recipe, amount, craftType)
    if isProcessing then
        ShowNotification("~r~Vous êtes déjà en train de fabriquer quelque chose!", 'error')
        return
    end

    isProcessing = true
    local totalTime = recipe.time * amount
    local stepTime = 100
    local progress = 0

    ShowNotification("~b~Fabrication de " .. amount .. "x " .. recipe.label .. " en cours...", 'info')

    -- Animation
    TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_WELDING", 0, true)

    Citizen.CreateThread(function()
        while progress < totalTime and isProcessing do
            Citizen.Wait(stepTime)
            progress = progress + stepTime

            -- Afficher la progression
            local percentage = math.floor((progress / totalTime) * 100)
            if percentage % 10 == 0 then
                ShowNotification("~b~Progression: " .. percentage .. "%", 'info')
            end
        end

        ClearPedTasksImmediately(PlayerPedId())

        if isProcessing then
            ShowNotification("~g~Fabrication terminée!", 'success')
            TriggerServerEvent('zfundry:finishCrafting', recipe, amount, craftType)
        end

        isProcessing = false
    end)
end)

-- Annuler le crafting si le joueur s'éloigne
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)

        if isProcessing and currentZone == nil then
            isProcessing = false
            ClearPedTasksImmediately(PlayerPedId())
            ShowNotification("~r~Fabrication annulée! Vous vous êtes éloigné.", 'error')
        end
    end
end)

-- Event pour les notifications du serveur
RegisterNetEvent('zfundry:notify')
AddEventHandler('zfundry:notify', function(message, type)
    ShowNotification(message, type)
end)
