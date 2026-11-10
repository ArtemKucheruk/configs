-- Editor indentation defaults.
-- Without these Neovim uses tabstop=8 + noexpandtab, which makes tabs look huge.
local opt = vim.opt

opt.expandtab = true   -- tabs become spaces
opt.shiftwidth = 2     -- size of an indent
opt.tabstop = 2        -- a <Tab> shows as 2 columns
opt.softtabstop = 2    -- <Tab>/<BS> edit 2 spaces at a time
opt.smartindent = true -- sensible auto-indent on new lines
opt.autoindent = true  -- copy indent from current line
