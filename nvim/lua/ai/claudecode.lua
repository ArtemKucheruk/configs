return {
  "coder/claudecode.nvim",
  dependencies = { "folke/snacks.nvim" },
  opts = {
    focus_after_send = true, -- jump into Claude terminal after sending selection
    diff_opts = {
      layout = "vertical",
      open_in_new_tab = true, -- diff gets its own full-screen tab, not cramped into open windows
      hide_terminal_in_new_tab = true, -- don't show Claude terminal in the diff tab (max width for the diff)
    },
    terminal = {
      split_side = "right",
      split_width_percentage = 0.28, -- smaller (was 0.34)
      provider = "snacks",
      snacks_win_opts = {
        wo = {
          winblend = 0,
          -- link terminal window highlights to global Normal (transparent bg)
          winhighlight = "Normal:Normal,NormalNC:Normal,NormalFloat:Normal,SignColumn:Normal,EndOfBuffer:Normal",
        },
      },
    },
  },
  cmd = {
    "ClaudeCode",
    "ClaudeCodeFocus",
    "ClaudeCodeSelectModel",
    "ClaudeCodeAdd",
    "ClaudeCodeSend",
    "ClaudeCodeTreeAdd",
    "ClaudeCodeStatus",
    "ClaudeCodeStart",
    "ClaudeCodeStop",
    "ClaudeCodeOpen",
    "ClaudeCodeClose",
    "ClaudeCodeDiffAccept",
    "ClaudeCodeDiffDeny",
    "ClaudeCodeCloseAllDiffs",
  },
  keys = {
    { "<leader>a", nil, desc = "AI/Claude Code" },
    { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
    { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
    { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
    { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
    { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
    { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
    { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
    {
      "<leader>as",
      "<cmd>ClaudeCodeTreeAdd<cr>",
      desc = "Add file",
      ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw", "snacks_picker_list" },
    },
    { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
    { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
    { "<leader>aq", "<cmd>ClaudeCodeClose<cr>", desc = "Close Claude window (keep session)" },
    { "<leader>ax", "<cmd>ClaudeCodeStop<cr>", desc = "Stop Claude session (kill server)" },
  },
}
