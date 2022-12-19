local opts = require('nvim-surround.config').default_opts
opts.keymaps.insert = nil
opts.keymaps.insert_line = nil
opts.aliases = {}
require('nvim-surround').setup {}
