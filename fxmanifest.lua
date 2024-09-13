fx_version 'cerulean'
game 'gta5'

author 'Treety'
description 'phone charging script for QBCore with PolyZone'
version '1.0.0'

shared_script 'config.lua'

client_script {
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/ComboZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/creation/PolyZone.lua',
    'client.lua'
}

server_script {
    'server.lua'
}

dependencies {
    'qb-core',
    'PolyZone'
}
