-- fxmanifest.lua
fx_version 'cerulean'
game 'gta5'

author 'Nizhal'
description 'nzl_screen - Watch movies/streams with Scaleform and Render Targets'
version '1.0.0'

client_scripts {
    'client/client.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'permission.lua',
    'server/server.lua'
}

files {
    'html/index.html',
    'html/style.css',
    'html/script.js'
}

ui_page 'html/index.html'
