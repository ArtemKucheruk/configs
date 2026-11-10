-- Per-directory sessions. Saves your open buffers/layout on exit, keyed by cwd.
-- auto_restore = false so the dashboard shows on startup instead of jumping
-- straight back in; "Restore Session" (AutoSession search) lists past project dirs.
return {
  "rmagatti/auto-session",
  lazy = false,
  dependencies = { "nvim-telescope/telescope.nvim" },
  opts = {
    auto_restore = false,
    suppressed_dirs = { "~/", "~/Downloads", "~/Desktop", "/" },
    session_lens = { load_on_setup = true },
  },
}