-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use { "catppuccin/nvim", as = "catppuccin" }
  use { "sitiom/nvim-numbertoggle" }
  use {
  "hkupty/iron.nvim",
  config = function()
    local iron = require("iron.core")

    iron.setup({
      config = {
        scratch_repl = true,
        repl_definition = {
          python = {
            command = { "python" }  -- Use standard Python REPL
            -- Or if you have python3 specifically:
            -- command = { "python3" }
          },
        },
        repl_open_cmd = require("iron.view").right(60),
      },
      keymaps = {
        send_motion = "<space>rc",
        visual_send = "<space>rc",
        send_file = "<space>rf",
        send_line = "<space>rl",
        send_mark = "<space>rm",
        mark_motion = "<space>rmc",
        mark_visual = "<space>rmc",
        remove_mark = "<space>rmd",
        cr = "<space>r<cr>",
        interrupt = "<space>r<space>",
        exit = "<space>rq",
        clear = "<space>rx",
      },
      highlight = {
        italic = true,
      },
      ignore_blank_lines = true,
    })

    vim.keymap.set("n", "<space>rs", "<cmd>IronRepl<cr>")
    vim.keymap.set("n", "<space>rr", "<cmd>IronRestart<cr>")
    vim.keymap.set("n", "<space>rF", "<cmd>IronFocus<cr>")
    vim.keymap.set("n", "<space>rh", "<cmd>IronHide<cr>")
  end,
}


  use({
    'MeanderingProgrammer/render-markdown.nvim',
    after = { 'nvim-treesitter' },
    requires = { 'nvim-mini/mini.nvim', opt = true },            -- if you use the mini.nvim suite
    -- requires = { 'nvim-mini/mini.icons', opt = true },        -- if you use standalone mini plugins
    -- requires = { 'nvim-tree/nvim-web-devicons', opt = true }, -- if you prefer nvim-web-devicons
    config = function()
        require('render-markdown').setup({})
    end,
})


  use {
  "windwp/nvim-autopairs",
  config = function()
    require("nvim-autopairs").setup()
  end
  }
use {"akinsho/toggleterm.nvim", tag = '*', config = function()
  require("toggleterm").setup()
end}

  -- In your plugins.lua or packer config
use({
    'rebelot/kanagawa.nvim',
    config = function()
        require('kanagawa').setup({
            transparent = true,
            overrides = function(colors)
                return {
                    Normal = { bg = "none" },
                    NormalFloat = { bg = "none" },
                }
            end,
        })
        vim.cmd("colorscheme kanagawa")
    end
})

 

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
