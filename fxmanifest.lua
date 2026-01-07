---@diagnostic disable: undefined-global

fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'r_bridge'
description 'Compatibility layer for r_scripts resources'
author 'rumaier'
version '2.0.6'

shared_scripts {
  '@ox_lib/init.lua',
  'util/init.lua',
  'util/natives.lua',
  'util/inventory.lua',
}

server_scripts {
  'framework/**/server.lua',
  'inventory/**/server.lua',
  'target/**/server.lua',
  'util/version.lua',
}

client_scripts {
  'util/natives.lua',
  'framework/**/client.lua',
  'inventory/**/client.lua',
  'target/**/client.lua',
  'interface/*.lua',
}

ui_page 'nui/build/index.html'

files {
  'nui/build/index.html',
  'nui/build/**/*'
}

dependencies {
  'ox_lib',
}