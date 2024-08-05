fx_version 'cerulean'
game "gta5"
author "FearlessStudios"
version '1.1.0'
lua54 'yes'

escrow_ignore {
  'config/**/*'
}

files {
  'config/postals.json'
}

client_scripts {
  'client/*.lua'
}

server_scripts {
  'server/*.lua'
}

shared_scripts {
  'shared/*.lua',
  'config/*.lua'
}

dependencies {
  'FS-Lib'
}
