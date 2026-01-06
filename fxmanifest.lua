fx_version 'cerulean'
game 'gta5'

author 'ZFundry Team'
description 'Script de Fonderie & Bijouterie avec UI personnalisée + ox_target'
version '2.0.0'

shared_scripts {
    '@es_extended/imports.lua',
    'config.lua'
}

client_scripts {
    'client/main.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/main.lua',
    'server/export.lua',
    'server/market.lua'
}

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/style.css',
    'html/script.js',
    'html/img/*.png'
}

dependencies {
    'es_extended',
    'oxmysql',
    'ox_inventory'
}
