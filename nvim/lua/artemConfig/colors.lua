require("catppuccin").setup({
    flavour = "mocha", -- latte, frappe, macchiato, mocha
    background = { light = "latte", dark = "mocha" },
    transparent_background = true,
    term_colors = true,
    integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        telescope = true,
        -- Add other integrations you use
    },
})

vim.cmd.colorscheme("catppuccin")
