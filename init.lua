-- Just use vim.
for name, key in pairs {
  'Left',
  'Right',
  'Up',
  'Down',
  'PageUp',
  'PageDown',
  'End',
  'Home',
  Delete = 'Del',
} do
  if type(name) == 'number' then
    name = key
  end

  local keymap = function(modes, left, right, options)
    options = vim.tbl_extend('force', { noremap = true, silent = true }, options or {})
    vim.keymap.set(modes, left, right, options)
  end

  keymap('n', '<' .. key .. '>', '<cmd>echo "No ' .. name .. ' for you!"<CR>', { noremap = false })
  keymap('v', '<' .. key .. '>', '<cmd><C-u>echo "No ' .. name .. ' for you!"<CR>', { noremap = false })
  keymap('i', '<' .. key .. '>', '<C-o><cmd>echo "No ' .. name .. ' for you!"<CR>', { noremap = false })
end

vim.g.mapleader = ','
vim.g.maplocalleader = ','

vim.keymap.set('n', '<leader>,', ',', { noremap = true, silent = true })

vim.o.number = true
vim.o.relativenumber = true

vim.o.autoread = true
vim.o.fileencoding = 'UTF-8'
vim.o.mouse = 'a'
vim.o.smartindent = true
vim.o.swapfile = false
vim.o.undofile = false
vim.o.clipboard = 'unnamedplus'
vim.o.backup = false
vim.o.writebackup = false
vim.o.cursorline = true
vim.o.showmode = false
vim.o.laststatus = 3
vim.o.wrap = true
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.ignorecase = true
-- vim.o.smartcase = true
vim.o.list = true
vim.o.listchars = 'tab: ·,trail:×,nbsp:%,eol:·,extends:»,precedes:«'
vim.o.termguicolors = true

vim.keymap.set('n', '<C-n>', '<cmd>bnext<cr>')
vim.keymap.set('n', '<C-p>', '<cmd>bprevious<cr>')
vim.keymap.set('n', '<C-h>', '<cmd>wincmd h<cr>')
vim.keymap.set('n', '<C-j>', '<cmd>wincmd j<cr>')
vim.keymap.set('n', '<C-k>', '<cmd>wincmd k<cr>')
vim.keymap.set('n', '<C-l>', '<cmd>wincmd l<cr>')

local function git_clone(url, dir, callback)
  local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/' .. dir

  if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system {
      'git',
      'clone',
      '--depth',
      '1',
      url,
      install_path,
    }
    callback(vim.v.shell_error)
  end
end

git_clone('https://github.com/lewis6991/impatient.nvim', 'impatient.nvim', function(res)
  if res == 0 then
    vim.cmd [[packadd impatient.nvim]]
  end
end)

xpcall(function()
  require 'impatient'
end, function(_)
  vim.api.nvim_echo({ { 'Error while loading impatient', 'ErrorMsg' } }, true, {})
end)

git_clone('https://github.com/wbthomason/packer.nvim', 'packer.nvim', function(res)
  if res == 0 then
    vim.g.packer_bootstrap = true
    vim.cmd [[packadd packer.nvim]]
  end
end)

require('packer').init {
  display = {
    open_fn = function()
      return require('packer.util').float { border = 'rounded' }
    end,
  },
}

require('packer').startup(function(use)
  use 'lewis6991/impatient.nvim'
  use 'wbthomason/packer.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'kyazdani42/nvim-web-devicons'

  use {
    'andersevenrud/nordic.nvim',
    config = function()
      require('nordic').colorscheme {}
    end,
  }

  use {
    'stevearc/dressing.nvim',
    config = function()
      require('dressing').setup {
        input = {
          insert_only = false,
          win_options = {
            winblend = 20,
          },
        },
      }
    end,
  }
  use {
    'nvim-treesitter/nvim-treesitter',
    config = function()
      require 'config.plugins.treesitter'
    end,
    run = function()
      require('nvim-treesitter.install').update { with_sync = true }
    end,
  }
  use {
    'nvim-treesitter/nvim-treesitter-textobjects',
    config = function()
      require 'config.plugins.treesitter-textobjects'
    end,
  }
  use {
    'williamboman/mason.nvim',
    config = function()
      require 'config.plugins.mason'
    end,
  }
  use {
    'williamboman/mason-lspconfig.nvim',
    config = function()
      require('mason-lspconfig').setup { automatic_installation = true }
    end,
  }
  use { 'ray-x/lsp_signature.nvim' }
  use {
    'neovim/nvim-lspconfig',
    config = function()
      require 'config.plugins.lspconfig'
    end,
  }

  use 'L3MON4D3/LuaSnip'

  use 'saadparwaiz1/cmp_luasnip'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use {
    'hrsh7th/nvim-cmp',
    config = function()
      require 'config.plugins.cmp'
    end,
  }

  use {
    'numToStr/Comment.nvim',
    config = function()
      require 'config.plugins.comment'
    end,
  }

  use {
    'jose-elias-alvarez/null-ls.nvim',
    config = function()
      require 'config.plugins.null-ls'
    end,
  }

  use {
    'folke/neodev.nvim',
    config = function()
      require('neodev').setup {}
    end,
  }

  use { 'nvim-telescope/telescope-ui-select.nvim' }
  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'make',
  }
  use {
    'nvim-telescope/telescope.nvim',
    config = function()
      require 'config.plugins.telescope'
    end,
  }

  use {
    'folke/which-key.nvim',
    config = function()
      require('which-key').setup {}
    end,
  }

  use {
    'nvim-lualine/lualine.nvim',
    config = function()
      require 'config.plugins.lualine'
    end,
  }

  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup {}
    end,
  }

  use {
    'rcarriga/nvim-notify',
    config = function()
      local notify = require 'notify'
      notify.setup {}
      vim.notify = notify
    end,
  }

  use {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require('indent_blankline').setup {
        show_current_context = true,
        show_current_context_start = true,
        filetype_exclude = {
          'alpha',
          'dashboard',
          'NvimTree',
          'help',
          'packer',
          'lsp-installer',
          'rfc',
          'DressingInput',
          'mason',
        },
        buftype_exclude = {
          'terminal',
        },
      }
    end,
  }

  use {
    'j-hui/fidget.nvim',
    config = function()
      require('fidget').setup {}
    end,
  }

  use {
    'romgrk/barbar.nvim',
    config = function()
      require 'config.plugins.barbar'
    end,
  }

  use {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup {}
    end,
  }

  use { 'tpope/vim-repeat' }

  use {
    'kylechui/nvim-surround',
    config = function()
      require 'config.plugins.surround'
    end,
  }
end)

if vim.g.packer_bootstrap then
  require('packer').sync()
end
