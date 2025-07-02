---@diagnostic disable: undefined-global
fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'r_bridge'
description 'Function library for r_scripts resources'
author 'r_scripts'
version '1.2.3'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

server_scripts {
    'utils/server/*.lua',
    'framework/**/server.lua',
    'inventory/**/server.lua',
    'target/**/server.lua',
}

client_scripts {
    -- '@qbx_core/modules/playerdata.lua',	-- uncomment this if you use qbx_core
    'utils/client/*.lua',
    'framework/**/client.lua',
    'inventory/**/client.lua',
    'target/**/client.lua',
    'ui/client.lua',
}

ui_page 'ui/index.html'

files {
    'ui/index.html',
    'ui/styles.css',
    'ui/script.js'
}