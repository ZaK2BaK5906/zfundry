fx_version 'cerulean'
game 'gta5'

author 'ZFundry Team'
description 'Fonderie, Bijouterie & Marché des Lingots - UI Moderne v4.0.2'
version '4.0.2'

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
