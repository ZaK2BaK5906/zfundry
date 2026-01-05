fx_version 'cerulean'
game 'gta5'

author 'ZFundry Team'
description 'Script de Fonderie & Bijouterie avec UI personnalisée'
version '1.0.0'

shared_scripts {
    '@es_extended/imports.lua',
    'config.lua'
}

client_scripts {
    'client/main.lua',
    'client/garage.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/main.lua',
    'server/export.lua'
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
