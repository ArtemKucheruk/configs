local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- 3. Initialize Lazy
-- Here I will also tell lazy to search spec directories for plugins I need to download
require("lazy").setup({
	{ import = "plugins" }, -- will search nvim/lua/plugins for files, read them and download the needed plugin
	{ import = "ui" }, -- nvim/lua/ui for ui plugins
	{ import = "lsp" }, -- nvim/lua/lsp for lsp configurations
	{ import = "ai" } -- nvim/lua/ai for ai plugins
})



