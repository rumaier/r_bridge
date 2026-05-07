---@diagnostic disable: undefined-global

fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'r_bridge'
description 'Compatibility layer for r_scripts resources'
author 'rumaier'
version '3.0.0'

shared_scripts {

}

server_scripts {
  'framework/**/server.lua',
}

client_scripts {
  'framework/**/client.lua',
}

dependencies {
  -- 'ox_lib',
}