-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
 

  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.8',
	  -- or                            , branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }
  use {
  'lewis6991/gitsigns.nvim',
  requires = { 'nvim-lua/plenary.nvim' },
  config = function()
    require('gitsigns').setup()
  end
  }

  use {
    'nvim-telescope/telescope-media-files.nvim',
    requires = { {'nvim-telescope/telescope.nvim'}, {'nvim-lua/plenary.nvim'} }
  }

  use {
    'edluffy/hologram.nvim',
    config = function()
      require('hologram').setup{
        auto_display = true -- show images automatically when file is opened
      }
    end
  }
  -- lua/plugins/rose-pine.lua
  

  use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
  use('nvim-treesitter/playground')
  use('theprimeagen/harpoon')
  use('mbbill/undotree')
  use('tpope/vim-fugitive')
  use {"meatballs/notebook.nvim"}
  use {
    'VonHeikemen/lsp-zero.nvim',
    requires = {
	{'neovim/nvim-lspconfig'},
	{'williamboman/mason.nvim'},
	{'williamboman/mason-lspconfig.nvim'},


	{'hrsh7th/nvim-cmp'},
	{'hrsh7th/cmp-buffer'},
	{'saadparwaiz1/cmp_luasnip'},
	{'hrsh7th/cmp-nvim-lsp'},
	{'hrsh7th/cmp-nvim-lua'},


	{'L3MON4D3/LuaSnip'},
	{'rafamadriz/friendly-snippets'},
    }
  }
  use 'stevearc/conform.nvim'
end)
