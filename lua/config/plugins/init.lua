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

  use {
    'nvim-tree/nvim-tree.lua',
    config = function()
      require('nvim-tree').setup {}
      vim.keymap.set('n', '<space>e', '<cmd>NvimTreeToggle<CR>', { desc = 'Toggle nvim-tree' })
    end,
  }
end)
