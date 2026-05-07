---@diagnostic disable: undefined-global

fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'r_bridge'
description 'Compatibility layer for r_scripts resources'
author 'rumaier'
version '3.0.0'

shared_scripts {
  '@ox_lib/init.lua',
  'inventory/util.lua',
  'core/init.lua',
  'target/*.lua'
}

server_scripts {
  'core/version.lua',
  'framework/**/server.lua',
  'inventory/**/server.lua'
}

client_scripts {
  'core/natives.lua',
  'framework/**/client.lua',
  'inventory/**/client.lua',
  'interface/*.lua'
}

dependencies {
  'ox_lib',
}