-- Leader button, is something you will press on every keybind(like windows or command btn)
vim.g.mapleader = " "

-- set up a access to a buil-in file explorer via official vim api.
-- "n" - means I have to be in a normal mode to execute this keybind
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Window navigation from a terminal (Claude Code, toggleterm, etc.)
-- Normal mode already has <C-w>hjkl natively; terminal mode traps keys,
-- so escape terminal mode first, then move. Bare <C-w> still reaches the
-- program (delete-word) unless followed by h/j/k/l/w.
for _, dir in ipairs({ "h", "j", "k", "l", "w" }) do
  vim.keymap.set("t", "<C-w>" .. dir, [[<C-\><C-n><C-w>]] .. dir, { desc = "Terminal → window " .. dir })
end
