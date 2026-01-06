local ESX = exports['es_extended']:getSharedObject()
local PlayerData = {}
local isProcessing = false
local targetSystem = nil
local jobBlips = {} -- Blips restreints au job

-- Détection automatique du système de target
Citizen.CreateThread(function()
    if GetResourceState('ox_target') == 'started' then
        targetSystem = 'ox_target'
        print("^2[ZFundry]^7 ox_target détecté")
    elseif GetResourceState('qtarget') == 'started' then
        targetSystem = 'qtarget'
        print("^2[ZFundry]^7 qtarget détecté")
    elseif GetResourceState('qb-target') == 'started' then
        targetSystem = 'qb-target'
        print("^2[ZFundry]^7 qb-target détecté")
    else
        print("^1[ZFundry]^7 ERREUR: Aucun système de target détecté!")
    end
end)

-- Initialisation
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
    Citizen.Wait(1000)
    SetupTargets()
    RefreshJobBlips()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
    RefreshJobBlips()
end)

-- Créer le blip principal (visible pour tous)
Citizen.CreateThread(function()
    local foundryZone = Config.Zones.Foundry
    if foundryZone.Blip and foundryZone.Blip.Enabled then
        local blip = AddBlipForCoord(foundryZone.Position.x, foundryZone.Position.y, foundryZone.Position.z)
        SetBlipSprite(blip, foundryZone.Blip.Sprite)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, foundryZone.Blip.Scale)
        SetBlipColour(blip, foundryZone.Blip.Color)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(foundryZone.Blip.Label)
        EndTextCommandSetBlipName(blip)
    end
end)

-- Rafraîchir les blips selon le job
function RefreshJobBlips()
    -- Supprimer les anciens blips
    for _, blip in pairs(jobBlips) do
        if DoesBlipExist(blip) then
            RemoveBlip(blip)
        end
    end
    jobBlips = {}

    -- Créer les blips si le joueur a le bon job
    if PlayerData.job and PlayerData.job.name == Config.Job then
        for zoneName, zoneData in pairs(Config.Zones) do
            -- Skip le blip principal (déjà créé pour tous)
            if zoneName ~= 'Foundry' and zoneData.Blip and zoneData.Blip.Enabled then
                local blip = AddBlipForCoord(zoneData.Position.x, zoneData.Position.y, zoneData.Position.z)
                SetBlipSprite(blip, zoneData.Blip.Sprite)
                SetBlipDisplay(blip, 4)
                SetBlipScale(blip, zoneData.Blip.Scale)
                SetBlipColour(blip, zoneData.Blip.Color)
                SetBlipAsShortRange(blip, true)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString(zoneData.Blip.Label)
                EndTextCommandSetBlipName(blip)

                jobBlips[zoneName] = blip
            end
        end
    end
end

-- Configurer tous les targets
function SetupTargets()
    if not targetSystem then return end

    -- Target Fonderie
    AddTargetZone('foundry_zone', Config.Zones.Foundry.Position, {
        name = 'foundry_zone',
        heading = 0.0,
        debugPoly = false,
        minZ = Config.Zones.Foundry.Position.z - 1.0,
        maxZ = Config.Zones.Foundry.Position.z + 2.0
    }, {
        options = {
            {
                icon = 'fas fa-fire',
                label = 'Ouvrir la Fonderie',
                action = function()
                    OpenFoundryMenu()
                end
            }
        },
        distance = 2.5
    })

    -- Target Bijouterie
    AddTargetZone('jewelry_zone', Config.Zones.Jewelry.Position, {
        name = 'jewelry_zone',
        heading = 0.0,
        debugPoly = false,
        minZ = Config.Zones.Jewelry.Position.z - 1.0,
        maxZ = Config.Zones.Jewelry.Position.z + 2.0
    }, {
        options = {
            {
                icon = 'fas fa-gem',
                label = 'Ouvrir la Bijouterie',
                action = function()
                    OpenJewelryMenu()
                end
            }
        },
        distance = 2.5
    })

    -- Target Export
    AddTargetZone('export_zone', Config.Zones.Export.Position, {
        name = 'export_zone',
        heading = 0.0,
        debugPoly = false,
        minZ = Config.Zones.Export.Position.z - 1.0,
        maxZ = Config.Zones.Export.Position.z + 2.0
    }, {
        options = {
            {
                icon = 'fas fa-shipping-fast',
                label = 'Point d\'Exportation',
                action = function()
                    OpenExportMenu()
                end
            }
        },
        distance = 2.5
    })

    -- Target Garage
    AddTargetZone('garage_zone', Config.Zones.Garage.Position, {
        name = 'garage_zone',
        heading = 0.0,
        debugPoly = false,
        minZ = Config.Zones.Garage.Position.z - 1.0,
        maxZ = Config.Zones.Garage.Position.z + 2.0
    }, {
        options = {
            {
                icon = 'fas fa-warehouse',
                label = 'Ouvrir le Garage',
                action = function()
                    OpenGarageMenu()
                end
            }
        },
        distance = 3.0
    })

    -- Target Boss Actions
    AddTargetZone('boss_zone', Config.Zones.BossActions.Position, {
        name = 'boss_zone',
        heading = 0.0,
        debugPoly = false,
        minZ = Config.Zones.BossActions.Position.z - 1.0,
        maxZ = Config.Zones.BossActions.Position.z + 2.0
    }, {
        options = {
            {
                icon = 'fas fa-user-tie',
                label = 'Actions Patron',
                action = function()
                    OpenBossActionsMenu()
                end,
                canInteract = function()
                    return PlayerData.job and PlayerData.job.name == Config.Job and PlayerData.job.grade_name == 'boss'
                end
            }
        },
        distance = 2.5
    })

    print("^2[ZFundry]^7 Tous les targets ont été configurés!")
end

-- Fonction universelle pour ajouter un target
function AddTargetZone(name, coords, zoneData, options)
    if targetSystem == 'ox_target' then
        -- Convertir les options pour ox_target (action -> onSelect)
        local oxOptions = {}
        for _, opt in ipairs(options.options) do
            table.insert(oxOptions, {
                name = opt.label,
                icon = opt.icon,
                label = opt.label,
                onSelect = opt.action,
                canInteract = opt.canInteract
            })
        end

        exports.ox_target:addBoxZone({
            coords = coords,
            size = vec3(2.0, 2.0, 2.0),
            rotation = zoneData.heading or 0.0,
            debug = zoneData.debugPoly or false,
            options = oxOptions
        })
    elseif targetSystem == 'qtarget' or targetSystem == 'qb-target' then
        local targetExport = targetSystem == 'qtarget' and exports.qtarget or exports['qb-target']
        targetExport:AddBoxZone(name, coords, 2.0, 2.0, {
            name = name,
            heading = zoneData.heading or 0.0,
            debugPoly = zoneData.debugPoly or false,
            minZ = zoneData.minZ,
            maxZ = zoneData.maxZ
        }, {
            options = options.options,
            distance = options.distance
        })
    end
end

-- Menu Fonderie (UI Personnalisée)
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
            action = 'openCraftingUI',
            recipes = recipes,
            title = '🔥 Fonderie',
            menuType = 'foundry'
        })
    else
        SendNotification("Vous ne travaillez pas ici!", 'error')
    end
end

-- Menu Bijouterie (UI Personnalisée)
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
            action = 'openCraftingUI',
            recipes = recipes,
            title = '💎 Bijouterie',
            menuType = 'jewelry'
        })
    else
        SendNotification("Vous ne travaillez pas ici!", 'error')
    end
end

-- Menu Export (UI Personnalisée)
function OpenExportMenu()
    ESX.TriggerServerCallback('zfundry:getPlayerInventory', function(inventory)
        if #inventory == 0 then
            SendNotification("Vous n'avez rien à exporter!", 'error')
            return
        end

        SetNuiFocus(true, true)
        SendNUIMessage({
            action = 'openExportUI',
            items = inventory
        })
    end)
end

-- Menu Garage (UI Personnalisée)
function OpenGarageMenu()
    if PlayerData.job and PlayerData.job.name == Config.Job then
        SetNuiFocus(true, true)
        SendNUIMessage({
            action = 'openGarageUI',
            vehicles = Config.Vehicles
        })
    else
        SendNotification("Vous ne travaillez pas pour la " .. Config.JobLabel .. "!", 'error')
    end
end

-- Menu Boss Actions (UI Personnalisée)
function OpenBossActionsMenu()
    if PlayerData.job and PlayerData.job.name == Config.Job and PlayerData.job.grade_name == 'boss' then
        ESX.TriggerServerCallback('zfundry:getBossData', function(data)
            SetNuiFocus(true, true)
            SendNUIMessage({
                action = 'openBossUI',
                societyMoney = data.money,
                employees = data.employees
            })
        end)
    else
        SendNotification("Vous n'êtes pas le patron!", 'error')
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

RegisterNUICallback('sellItem', function(data, cb)
    TriggerServerEvent('zfundry:sellItem', data.item, data.amount, data.price)
    cb('ok')
end)

RegisterNUICallback('spawnVehicle', function(data, cb)
    local model = data.model
    local playerPed = PlayerPedId()
    local spawnPoint = Config.Zones.Garage.SpawnPoint

    ESX.Game.SpawnVehicle(model, vector3(spawnPoint.x, spawnPoint.y, spawnPoint.z), spawnPoint.w, function(vehicle)
        TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
        SetVehicleNumberPlateText(vehicle, "FOUNDRY")

        -- Clé du véhicule
        if GetResourceState('wasabi_carlock') == 'started' then
            exports.wasabi_carlock:GiveKey(GetVehicleNumberPlateText(vehicle))
        elseif GetResourceState('qb-vehiclekeys') == 'started' then
            TriggerEvent('vehiclekeys:client:SetOwner', GetVehicleNumberPlateText(vehicle))
        end

        -- Fuel
        if GetResourceState('LegacyFuel') == 'started' then
            exports['LegacyFuel']:SetFuel(vehicle, 100.0)
        elseif GetResourceState('ox_fuel') == 'started' then
            SetVehicleFuelLevel(vehicle, 100.0)
        end

        SendNotification("Véhicule sorti du garage!", 'success')
    end)

    cb('ok')
end)

RegisterNUICallback('storeVehicle', function(data, cb)
    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed, false)

    if vehicle == 0 then
        SendNotification("Vous devez être dans un véhicule!", 'error')
        cb('error')
        return
    end

    local plate = GetVehicleNumberPlateText(vehicle)
    if plate ~= "FOUNDRY" then
        SendNotification("Ce véhicule n'appartient pas à la société!", 'error')
        cb('error')
        return
    end

    ESX.Game.DeleteVehicle(vehicle)
    SendNotification("Véhicule rangé au garage!", 'success')
    cb('ok')
end)

RegisterNUICallback('withdrawMoney', function(data, cb)
    TriggerServerEvent('zfundry:withdrawMoney', data.amount)
    cb('ok')
end)

RegisterNUICallback('depositMoney', function(data, cb)
    TriggerServerEvent('zfundry:depositMoney', data.amount)
    cb('ok')
end)

RegisterNUICallback('closeUI', function(data, cb)
    SetNuiFocus(false, false)
    cb('ok')
end)

-- Notification personnalisée via NUI
function SendNotification(message, type)
    SendNUIMessage({
        action = 'notify',
        message = message,
        type = type or 'info'
    })
end

-- Event de crafting
RegisterNetEvent('zfundry:startCrafting')
AddEventHandler('zfundry:startCrafting', function(recipe, amount, craftType)
    if isProcessing then
        SendNotification("Vous êtes déjà en train de fabriquer quelque chose!", 'error')
        return
    end

    isProcessing = true
    local totalTime = recipe.time * amount
    local stepTime = 100
    local progress = 0

    SendNotification("Fabrication de " .. amount .. "x " .. recipe.label .. " en cours...", 'info')

    -- Animation
    TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_WELDING", 0, true)

    -- Barre de progression
    SendNUIMessage({
        action = 'showProgress',
        duration = totalTime
    })

    Citizen.CreateThread(function()
        while progress < totalTime and isProcessing do
            Citizen.Wait(stepTime)
            progress = progress + stepTime
        end

        ClearPedTasksImmediately(PlayerPedId())

        if isProcessing then
            SendNotification("Fabrication terminée!", 'success')
            TriggerServerEvent('zfundry:finishCrafting', recipe, amount, craftType)
        end

        SendNUIMessage({
            action = 'hideProgress'
        })

        isProcessing = false
    end)
end)

-- Event pour les notifications du serveur
RegisterNetEvent('zfundry:notify')
AddEventHandler('zfundry:notify', function(message, type)
    SendNotification(message, type)
end)

-- Refresh UI après transaction
RegisterNetEvent('zfundry:refreshBossUI')
AddEventHandler('zfundry:refreshBossUI', function()
    -- Rafraîchir les données du menu boss si ouvert
    if PlayerData.job and PlayerData.job.name == Config.Job and PlayerData.job.grade_name == 'boss' then
        ESX.TriggerServerCallback('zfundry:getBossData', function(data)
            SendNUIMessage({
                action = 'updateBossData',
                societyMoney = data.money,
                employees = data.employees
            })
        end)
    end
end)
