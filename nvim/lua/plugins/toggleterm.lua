return{
	"akinsho/toggleterm.nvim", tag = '*', config = function()
  require("toggleterm").setup()
  end,
vim.keymap.set('n', '<leader>t', ':ToggleTerm<CR>')

}
