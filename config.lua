Config = {}

Config.BlipSettings = {
    enableBlips = true, 
    sprite = 354, 
    display = 4, 
    scale = 1.0, 
    color = 5, 
    name = "Charging Station" 
}

Config.ChargingZones = {
    ["pdm"] = {
        name = "pdm",
        enableBlip = true,
        points = {
            vector2(-41.166236877442, -1107.0288085938),
            vector2(-40.435356140136, -1104.5045166016),
            vector2(-45.530647277832, -1102.7706298828),
            vector2(-46.03787612915, -1105.2280273438)
        },
        minZ = 25.422353744506,
        maxZ = 35.143657684326
    },
    -- ["ZoneName"] = {
    --     name = "ZoneName",
    --     enableBlip = true,
    --     points = {
    --         vector2(x1, y1),
    --         vector2(x2, y2),
    --         ...
    --     },
    --     minZ = min_z,
    --     maxZ = max_z
    -- },
}
