---@diagnostic disable: undefined-global

fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'r_bridge'
description 'Compatibility layer for r_scripts resources'
author 'rumaier'
version '2.0.0'

shared_scripts {
  '@ox_lib/init.lua',
  'init.lua'
}

server_scripts {
  'framework/**/server.lua',
}

client_scripts {
  'natives/client.lua',
  'framework/**/client.lua',
}

ui_page 'nui/build/index.html'
files {
  'nui/build/index.html',
  'nui/build/**/*'
}

dependencies {
  'ox_lib',
}