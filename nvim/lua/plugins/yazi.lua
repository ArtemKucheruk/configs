-- Yazi file manager inside nvim. Dashboard "Browse (Yazi)" and <leader>- use it.
return {
  "mikavilpas/yazi.nvim",
  event = "VeryLazy",
  dependencies = { { "nvim-lua/plenary.nvim", lazy = true } },
  keys = {
    { "<leader>-", "<cmd>Yazi<cr>", desc = "Yazi at current file" },
    { "<leader>cw", "<cmd>Yazi cwd<cr>", desc = "Yazi at cwd" },
  },
  ---@type YaziConfig
  opts = {
    open_for_directories = false,
  },
}