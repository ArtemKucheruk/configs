vim.wo.relativenumber = true



-- Enable 24-bit color (usually already in init.lua)
vim.opt.termguicolors = true

require('artemConfig')
require('artemConfig.lsp')
require('artemConfig.packer')
require('artemConfig.remap')
require('artemConfig.colors')
require('artemConfig.terminal')
