local ESX = exports['es_extended']:getSharedObject()
local PlayerData = {}
local spawnedVehicles = {}

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)

-- Marker et interaction du garage
Citizen.CreateThread(function()
    while true do
        local sleep = 500
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local garageZone = Config.Zones.Garage

        local distance = #(playerCoords - garageZone.Position)

        if distance < garageZone.Marker.DrawDistance then
            sleep = 0
            DrawMarker(
                garageZone.Marker.Type,
                garageZone.Position.x,
                garageZone.Position.y,
                garageZone.Position.z - 1.0,
                0.0, 0.0, 0.0,
                0.0, 0.0, 0.0,
                garageZone.Marker.Size.x,
                garageZone.Marker.Size.y,
                garageZone.Marker.Size.z,
                garageZone.Marker.Color.r,
                garageZone.Marker.Color.g,
                garageZone.Marker.Color.b,
                100,
                false, true, 2, false, nil, nil, false
            )

            if distance < garageZone.Marker.InteractionDistance then
                DrawText3D(garageZone.Position.x, garageZone.Position.y, garageZone.Position.z, "~g~[E]~w~ Garage Société")

                if IsControlJustReleased(0, 38) then -- Touche E
                    OpenGarageMenu()
                end
            end
        end

        Citizen.Wait(sleep)
    end
end)

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

function OpenGarageMenu()
    if PlayerData.job and PlayerData.job.name == Config.Job then
        local elements = {
            {label = "🚗 Sortir un véhicule", value = 'spawn'},
            {label = "🅿️ Ranger le véhicule", value = 'store'}
        }

        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'garage_menu', {
            title = "Garage " .. Config.JobLabel,
            align = 'top-left',
            elements = elements
        }, function(data, menu)
            if data.current.value == 'spawn' then
                menu.close()
                OpenVehicleListMenu()
            elseif data.current.value == 'store' then
                menu.close()
                StoreVehicle()
            end
        end, function(data, menu)
            menu.close()
        end)
    else
        ShowNotification("~r~Vous ne travaillez pas pour la " .. Config.JobLabel .. "!", 'error')
    end
end

function OpenVehicleListMenu()
    local elements = {}

    for _, vehicle in ipairs(Config.Vehicles) do
        table.insert(elements, {
            label = vehicle.label,
            value = vehicle.model,
            model = vehicle.model
        })
    end

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_list', {
        title = "Véhicules Disponibles",
        align = 'top-left',
        elements = elements
    }, function(data, menu)
        menu.close()
        SpawnVehicle(data.current.model)
    end, function(data, menu)
        menu.close()
    end)
end

function SpawnVehicle(model)
    local playerPed = PlayerPedId()
    local spawnPoint = Config.Zones.Garage.SpawnPoint

    ESX.Game.SpawnVehicle(model, vector3(spawnPoint.x, spawnPoint.y, spawnPoint.z), spawnPoint.w, function(vehicle)
        TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
        SetVehicleNumberPlateText(vehicle, "FOUNDRY")

        -- Clé du véhicule (compatible avec plusieurs systèmes de clés)
        TriggerEvent('vehiclekeys:client:SetOwner', GetVehicleNumberPlateText(vehicle))

        -- Fuel (compatible avec LegacyFuel et autres)
        if GetResourceState('LegacyFuel') == 'started' then
            exports['LegacyFuel']:SetFuel(vehicle, 100.0)
        end

        table.insert(spawnedVehicles, vehicle)
        ShowNotification("~g~Véhicule sorti du garage!", 'success')
    end)
end

function StoreVehicle()
    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed, false)

    if vehicle == 0 then
        ShowNotification("~r~Vous devez être dans un véhicule!", 'error')
        return
    end

    local plate = GetVehicleNumberPlateText(vehicle)
    if plate ~= "FOUNDRY" then
        ShowNotification("~r~Ce véhicule n'appartient pas à la société!", 'error')
        return
    end

    ESX.Game.DeleteVehicle(vehicle)
    ShowNotification("~g~Véhicule rangé au garage!", 'success')
end

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

-- Nettoyer les véhicules spawnés au déconnexion
AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        for _, vehicle in ipairs(spawnedVehicles) do
            if DoesEntityExist(vehicle) then
                ESX.Game.DeleteVehicle(vehicle)
            end
        end
    end
end)
