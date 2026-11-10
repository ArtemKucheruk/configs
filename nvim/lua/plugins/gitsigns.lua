return {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local gitsigns = require("gitsigns")

        gitsigns.setup({
            signs = {
                add          = { text = "│" },
                change       = { text = "│" },
                delete       = { text = "_" },
                topdelete    = { text = "‾" },
                changedelete = { text = "~" },
                untracked    = { text = "┆" },
            },
            current_line_blame = false, -- toggle inline blame with <leader>gb
            on_attach = function(bufnr)
                local function map(mode, lhs, rhs, desc)
                    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
                end

                -- Navigate hunks
                map("n", "]c", gitsigns.next_hunk, "Next git hunk")
                map("n", "[c", gitsigns.prev_hunk, "Prev git hunk")

                -- Actions
                map("n", "<leader>hs", gitsigns.stage_hunk, "Stage hunk")
                map("n", "<leader>hr", gitsigns.reset_hunk, "Reset hunk")
                map("n", "<leader>hp", gitsigns.preview_hunk, "Preview hunk")
                map("n", "<leader>hb", function() gitsigns.blame_line({ full = true }) end, "Blame line")
                map("n", "<leader>gb", gitsigns.toggle_current_line_blame, "Toggle line blame")
            end,
        })
    end,
}
