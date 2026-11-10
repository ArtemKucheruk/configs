-- Plugin for undotree
-- Plugin gives you sidebar with history of your changes.

return {
	"mbbill/undotree",
	config = function()
	-- keybinds here
		vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
	end
}



