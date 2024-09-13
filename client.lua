local QBCore = exports['qb-core']:GetCoreObject()
local isCharging = false
local looped = false
local currentZone = nil
local zones = {}
local blips = {}

-- Function to create zones and optional blips
local function initializeZones()
    if not PolyZone then
        print("PolyZone is not loaded!")
        return
    end

    if not Config.ChargingZones or type(Config.ChargingZones) ~= "table" then
        print("Config.ChargingZones is not configured correctly!")
        return
    end

    for zoneName, zoneData in pairs(Config.ChargingZones) do
        print("Creating zone: " .. zoneName)
        local zone = PolyZone:Create(zoneData.points, {
            name = zoneData.name,
            minZ = zoneData.minZ,
            maxZ = zoneData.maxZ,
            debugPoly = false,
        })

        zone:onPlayerInOut(function(isPointInside)
            if isPointInside then
                currentZone = zoneName
                QBCore.Functions.Notify("You can charge your phone with a charging cable.", "success", 5000)
            else
                if isCharging then
                    exports["lb-phone"]:ToggleCharging(false)
                    QBCore.Functions.Notify("Charging stopped because you have left the charging zone.", "error", 5000)
                    isCharging = false
                    looped = false
                end
                currentZone = nil
            end
        end)

        table.insert(zones, zone)

        -- Create blip if enabled for the zone
        if zoneData.enableBlip then
            local centerPoint = zoneData.points[1]
            local blip = AddBlipForCoord(centerPoint.x, centerPoint.y, (zoneData.minZ + zoneData.maxZ) / 2)
            SetBlipSprite(blip, Config.BlipSettings.sprite)
            SetBlipDisplay(blip, Config.BlipSettings.display)
            SetBlipScale(blip, Config.BlipSettings.scale)
            SetBlipColour(blip, Config.BlipSettings.color)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(Config.BlipSettings.name)
            EndTextCommandSetBlipName(blip)
            table.insert(blips, blip)
        end
    end
end

CreateThread(function()
    initializeZones() -- Initialize zones
end)

RegisterNetEvent('charging:startCharge')
AddEventHandler('charging:startCharge', function()
    local ped = PlayerPedId()
    local inVehicle = IsPedInAnyVehicle(ped, false)
    
    if inVehicle then
        if not isCharging then
            local battery = exports["lb-phone"]:GetBattery()
            if battery >= 100 then
                QBCore.Functions.Notify("Your phone is already fully charged!", "success", 5000)
            else
                exports["lb-phone"]:ToggleCharging(true)
                isCharging = true
                if not looped then
                    looped = true
                    CreateThread(function() BatteryLoop(true) end)
                end
                QBCore.Functions.Notify("Your phone is charging in the vehicle...", "success", 5000)
            end
        else
            QBCore.Functions.Notify("Your phone is already charging...", "success", 5000)
        end
    elseif currentZone then
        if not isCharging then
            local battery = exports["lb-phone"]:GetBattery()
            if battery >= 100 then
                QBCore.Functions.Notify("Your phone is already fully charged!", "success", 5000)
            else
                exports["lb-phone"]:ToggleCharging(true)
                isCharging = true
                if not looped then
                    looped = true
                    CreateThread(function() BatteryLoop(false) end)
                end
                QBCore.Functions.Notify("Your phone is charging...", "success", 5000)
            end
        else
            QBCore.Functions.Notify("Your phone is already charging...", "success", 5000)
        end
    else
        QBCore.Functions.Notify("You are not in a charging zone or vehicle!", "error", 5000)
    end
end)

function BatteryLoop(isInVehicle)
    while looped do
        Wait(3000) -- Wait 1 second
        local battery = exports["lb-phone"]:GetBattery()
        local ped = PlayerPedId()
        
        if isInVehicle then
            if not IsPedInAnyVehicle(ped, false) then
                exports["lb-phone"]:ToggleCharging(false)
                QBCore.Functions.Notify("Charging stopped because you left the vehicle.", "error", 5000)
                isCharging = false
                looped = false
                break
            end
        end

        if battery < 100 then
            battery = battery + 1
            exports["lb-phone"]:SetBattery(battery)
        else
            exports["lb-phone"]:ToggleCharging(false)
            QBCore.Functions.Notify("Your battery is fully charged!", "success", 5000)
            isCharging = false
            looped = false
        end
    end
end
