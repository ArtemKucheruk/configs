-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

local time
local profile_info
local should_profile = false
if should_profile then
  local hrtime = vim.loop.hrtime
  profile_info = {}
  time = function(chunk, start)
    if start then
      profile_info[chunk] = hrtime()
    else
      profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
    end
  end
else
  time = function(chunk, start) end
end

local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/artem/.cache/nvim/packer_hererocks/2.1.1748459687/share/lua/5.1/?.lua;/Users/artem/.cache/nvim/packer_hererocks/2.1.1748459687/share/lua/5.1/?/init.lua;/Users/artem/.cache/nvim/packer_hererocks/2.1.1748459687/lib/luarocks/rocks-5.1/?.lua;/Users/artem/.cache/nvim/packer_hererocks/2.1.1748459687/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/artem/.cache/nvim/packer_hererocks/2.1.1748459687/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  LuaSnip = {
    loaded = true,
    path = "/Users/artem/.local/share/nvim/site/pack/packer/start/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  catppuccin = {
    loaded = true,
    path = "/Users/artem/.local/share/nvim/site/pack/packer/start/catppuccin",
    url = "https://github.com/catppuccin/nvim"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/Users/artem/.local/share/nvim/site/pack/packer/start/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/Users/artem/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-nvim-lua"] = {
    loaded = true,
    path = "/Users/artem/.local/share/nvim/site/pack/packer/start/cmp-nvim-lua",
    url = "https://github.com/hrsh7th/cmp-nvim-lua"
  },
  cmp_luasnip = {
    loaded = true,
    path = "/Users/artem/.local/share/nvim/site/pack/packer/start/cmp_luasnip",
    url = "https://github.com/saadparwaiz1/cmp_luasnip"
  },
  ["conform.nvim"] = {
    loaded = true,
    path = "/Users/artem/.local/share/nvim/site/pack/packer/start/conform.nvim",
    url = "https://github.com/stevearc/conform.nvim"
  },
  ["friendly-snippets"] = {
    loaded = true,
    path = "/Users/artem/.local/share/nvim/site/pack/packer/start/friendly-snippets",
    url = "https://github.com/rafamadriz/friendly-snippets"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\n6\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\rgitsigns\frequire\0" },
    loaded = true,
    path = "/Users/artem/.local/share/nvim/site/pack/packer/start/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  harpoon = {
    loaded = true,
    path = "/Users/artem/.local/share/nvim/site/pack/packer/start/harpoon",
    url = "https://github.com/theprimeagen/harpoon"
  },
  ["hologram.nvim"] = {
    config = { "\27LJ\2\nK\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\17auto_display\2\nsetup\rhologram\frequire\0" },
    loaded = true,
    path = "/Users/artem/.local/share/nvim/site/pack/packer/start/hologram.nvim",
    url = "https://github.com/edluffy/hologram.nvim"
  },
  ["iron.nvim"] = {
    config = { "\27LJ\2\n‹\6\0\0\b\0\31\00066\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\r\0005\4\3\0005\5\a\0005\6\5\0005\a\4\0=\a\6\6=\6\b\5=\5\t\0046\5\0\0'\a\n\0B\5\2\0029\5\v\5)\a<\0B\5\2\2=\5\f\4=\4\14\0035\4\15\0=\4\16\0035\4\17\0=\4\18\3B\1\2\0016\1\19\0009\1\20\0019\1\21\1'\3\22\0'\4\23\0'\5\24\0B\1\4\0016\1\19\0009\1\20\0019\1\21\1'\3\22\0'\4\25\0'\5\26\0B\1\4\0016\1\19\0009\1\20\0019\1\21\1'\3\22\0'\4\27\0'\5\28\0B\1\4\0016\1\19\0009\1\20\0019\1\21\1'\3\22\0'\4\29\0'\5\30\0B\1\4\1K\0\1\0\22<cmd>IronHide<cr>\14<space>rh\23<cmd>IronFocus<cr>\14<space>rF\25<cmd>IronRestart<cr>\14<space>rr\22<cmd>IronRepl<cr>\14<space>rs\6n\bset\vkeymap\bvim\14highlight\1\0\1\vitalic\2\fkeymaps\1\0\f\14send_file\14<space>rf\16visual_send\14<space>rc\14interrupt\20<space>r<space>\16send_motion\14<space>rc\acr\17<space>r<cr>\16remove_mark\15<space>rmd\16mark_visual\15<space>rmc\texit\14<space>rq\16mark_motion\15<space>rmc\14send_mark\14<space>rm\14send_line\14<space>rl\nclear\14<space>rx\vconfig\1\0\4\fkeymaps\0\14highlight\0\vconfig\0\23ignore_blank_lines\2\18repl_open_cmd\nright\14iron.view\20repl_definition\vpython\1\0\1\vpython\0\fcommand\1\0\1\fcommand\0\1\2\0\0\vpython\1\0\3\18repl_open_cmd\0\20repl_definition\0\17scratch_repl\2\nsetup\14iron.core\frequire\0" },
    loaded = true,
    path = "/Users/artem/.local/share/nvim/site/pack/packer/start/iron.nvim",
    url = "https://github.com/hkupty/iron.nvim"
  },
  ["kanagawa.nvim"] = {
    config = { "\27LJ\2\n`\0\1\3\0\5\0\0065\1\1\0005\2\0\0=\2\2\0015\2\3\0=\2\4\1L\1\2\0\16NormalFloat\1\0\1\abg\tnone\vNormal\1\0\2\16NormalFloat\0\vNormal\0\1\0\1\abg\tnoneï\1\1\0\4\0\t\0\r6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0003\3\4\0=\3\5\2B\0\2\0016\0\6\0009\0\a\0'\2\b\0B\0\2\1K\0\1\0\25colorscheme kanagawa\bcmd\bvim\14overrides\0\1\0\2\16transparent\2\14overrides\0\nsetup\rkanagawa\frequire\0" },
    loaded = true,
    path = "/Users/artem/.local/share/nvim/site/pack/packer/start/kanagawa.nvim",
    url = "https://github.com/rebelot/kanagawa.nvim"
  },
  ["lsp-zero.nvim"] = {
    loaded = true,
    path = "/Users/artem/.local/share/nvim/site/pack/packer/start/lsp-zero.nvim",
    url = "https://github.com/VonHeikemen/lsp-zero.nvim"
  },
  ["mason-lspconfig.nvim"] = {
    loaded = true,
    path = "/Users/artem/.local/share/nvim/site/pack/packer/start/mason-lspconfig.nvim",
    url = "https://github.com/williamboman/mason-lspconfig.nvim"
  },
  ["mason.nvim"] = {
    loaded = true,
    path = "/Users/artem/.local/share/nvim/site/pack/packer/start/mason.nvim",
    url = "https://github.com/williamboman/mason.nvim"
  },
  ["mini.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/artem/.local/share/nvim/site/pack/packer/opt/mini.nvim",
    url = "https://github.com/nvim-mini/mini.nvim"
  },
  ["notebook.nvim"] = {
    loaded = true,
    path = "/Users/artem/.local/share/nvim/site/pack/packer/start/notebook.nvim",
    url = "https://github.com/meatballs/notebook.nvim"
  },
  ["nvim-autopairs"] = {
    config = { "\27LJ\2\n<\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\19nvim-autopairs\frequire\0" },
    loaded = true,
    path = "/Users/artem/.local/share/nvim/site/pack/packer/start/nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-cmp"] = {
    loaded = true,
    path = "/Users/artem/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/Users/artem/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-numbertoggle"] = {
    loaded = true,
    path = "/Users/artem/.local/share/nvim/site/pack/packer/start/nvim-numbertoggle",
    url = "https://github.com/sitiom/nvim-numbertoggle"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/Users/artem/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/artem/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  playground = {
    loaded = true,
    path = "/Users/artem/.local/share/nvim/site/pack/packer/start/playground",
    url = "https://github.com/nvim-treesitter/playground"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/artem/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["render-markdown.nvim"] = {
    config = { "\27LJ\2\nA\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\20render-markdown\frequire\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/Users/artem/.local/share/nvim/site/pack/packer/opt/render-markdown.nvim",
    url = "https://github.com/MeanderingProgrammer/render-markdown.nvim"
  },
  ["telescope-media-files.nvim"] = {
    loaded = true,
    path = "/Users/artem/.local/share/nvim/site/pack/packer/start/telescope-media-files.nvim",
    url = "https://github.com/nvim-telescope/telescope-media-files.nvim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/Users/artem/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["toggleterm.nvim"] = {
    config = { "\27LJ\2\n8\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\15toggleterm\frequire\0" },
    loaded = true,
    path = "/Users/artem/.local/share/nvim/site/pack/packer/start/toggleterm.nvim",
    url = "https://github.com/akinsho/toggleterm.nvim"
  },
  undotree = {
    loaded = true,
    path = "/Users/artem/.local/share/nvim/site/pack/packer/start/undotree",
    url = "https://github.com/mbbill/undotree"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/Users/artem/.local/share/nvim/site/pack/packer/start/vim-fugitive",
    url = "https://github.com/tpope/vim-fugitive"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: kanagawa.nvim
time([[Config for kanagawa.nvim]], true)
try_loadstring("\27LJ\2\n`\0\1\3\0\5\0\0065\1\1\0005\2\0\0=\2\2\0015\2\3\0=\2\4\1L\1\2\0\16NormalFloat\1\0\1\abg\tnone\vNormal\1\0\2\16NormalFloat\0\vNormal\0\1\0\1\abg\tnoneï\1\1\0\4\0\t\0\r6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0003\3\4\0=\3\5\2B\0\2\0016\0\6\0009\0\a\0'\2\b\0B\0\2\1K\0\1\0\25colorscheme kanagawa\bcmd\bvim\14overrides\0\1\0\2\16transparent\2\14overrides\0\nsetup\rkanagawa\frequire\0", "config", "kanagawa.nvim")
time([[Config for kanagawa.nvim]], false)
-- Config for: iron.nvim
time([[Config for iron.nvim]], true)
try_loadstring("\27LJ\2\n‹\6\0\0\b\0\31\00066\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\r\0005\4\3\0005\5\a\0005\6\5\0005\a\4\0=\a\6\6=\6\b\5=\5\t\0046\5\0\0'\a\n\0B\5\2\0029\5\v\5)\a<\0B\5\2\2=\5\f\4=\4\14\0035\4\15\0=\4\16\0035\4\17\0=\4\18\3B\1\2\0016\1\19\0009\1\20\0019\1\21\1'\3\22\0'\4\23\0'\5\24\0B\1\4\0016\1\19\0009\1\20\0019\1\21\1'\3\22\0'\4\25\0'\5\26\0B\1\4\0016\1\19\0009\1\20\0019\1\21\1'\3\22\0'\4\27\0'\5\28\0B\1\4\0016\1\19\0009\1\20\0019\1\21\1'\3\22\0'\4\29\0'\5\30\0B\1\4\1K\0\1\0\22<cmd>IronHide<cr>\14<space>rh\23<cmd>IronFocus<cr>\14<space>rF\25<cmd>IronRestart<cr>\14<space>rr\22<cmd>IronRepl<cr>\14<space>rs\6n\bset\vkeymap\bvim\14highlight\1\0\1\vitalic\2\fkeymaps\1\0\f\14send_file\14<space>rf\16visual_send\14<space>rc\14interrupt\20<space>r<space>\16send_motion\14<space>rc\acr\17<space>r<cr>\16remove_mark\15<space>rmd\16mark_visual\15<space>rmc\texit\14<space>rq\16mark_motion\15<space>rmc\14send_mark\14<space>rm\14send_line\14<space>rl\nclear\14<space>rx\vconfig\1\0\4\fkeymaps\0\14highlight\0\vconfig\0\23ignore_blank_lines\2\18repl_open_cmd\nright\14iron.view\20repl_definition\vpython\1\0\1\vpython\0\fcommand\1\0\1\fcommand\0\1\2\0\0\vpython\1\0\3\18repl_open_cmd\0\20repl_definition\0\17scratch_repl\2\nsetup\14iron.core\frequire\0", "config", "iron.nvim")
time([[Config for iron.nvim]], false)
-- Config for: hologram.nvim
time([[Config for hologram.nvim]], true)
try_loadstring("\27LJ\2\nK\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\17auto_display\2\nsetup\rhologram\frequire\0", "config", "hologram.nvim")
time([[Config for hologram.nvim]], false)
-- Config for: gitsigns.nvim
time([[Config for gitsigns.nvim]], true)
try_loadstring("\27LJ\2\n6\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\rgitsigns\frequire\0", "config", "gitsigns.nvim")
time([[Config for gitsigns.nvim]], false)
-- Config for: nvim-autopairs
time([[Config for nvim-autopairs]], true)
try_loadstring("\27LJ\2\n<\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\19nvim-autopairs\frequire\0", "config", "nvim-autopairs")
time([[Config for nvim-autopairs]], false)
-- Config for: toggleterm.nvim
time([[Config for toggleterm.nvim]], true)
try_loadstring("\27LJ\2\n8\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\15toggleterm\frequire\0", "config", "toggleterm.nvim")
time([[Config for toggleterm.nvim]], false)
-- Load plugins in order defined by `after`
time([[Sequenced loading]], true)
vim.cmd [[ packadd nvim-treesitter ]]
vim.cmd [[ packadd render-markdown.nvim ]]

-- Config for: render-markdown.nvim
try_loadstring("\27LJ\2\nA\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\20render-markdown\frequire\0", "config", "render-markdown.nvim")

time([[Sequenced loading]], false)

_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
