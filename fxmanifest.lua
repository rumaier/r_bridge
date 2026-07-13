---@diagnostic disable: undefined-global

fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'r_bridge'
description 'Compatibility Layer for r_scripts Resources'
author 'rumaier'
version '3.0.0'

shared_scripts {
  '@ox_lib/init.lua',
  'init.lua',
}

files {
  'init.lua',
  'imports/**/*.lua',
}

dependencies {
  'ox_lib',
}
