-- Start screen. Shows on `nvim` with no file args. Turns nvim into a launcher:
-- find a project, restore a past session, or jump into your config.
return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    dashboard.section.header.val = {
      [[╭────────────────────────────────────────────────────────────╮]],
      [[│                                                            │]],
      [[│               "An idiot admires complexity,                │]],
      [[│               a genius admires simplicity."                │]],
      [[│                                                            │]],
      [[│                      — Terry A. Davis                      │]],
      [[│                                                            │]],
      [[╰────────────────────────────────────────────────────────────╯]],
    }

    dashboard.section.buttons.val = {
      dashboard.button("f", "  Find Project", "<cmd>lua require('core.projects').pick()<CR>"),
      dashboard.button("s", "  Restore Session", "<cmd>AutoSession search<CR>"),
      dashboard.button("r", "  Recent Files", "<cmd>Telescope oldfiles<CR>"),
      dashboard.button("y", "  Browse (Yazi)", "<cmd>Yazi cwd<CR>"),
      dashboard.button("c", "  Config", "<cmd>lua require('core.projects').config()<CR>"),
      dashboard.button("q", "  Quit", "<cmd>qa<CR>"),
    }

    dashboard.section.footer.val = ""

    alpha.setup(dashboard.config)
  end,
}