return {
    'nvim-telescope/telescope.nvim', tag = '0.1.8', -- usage of specific tag is recommended
    dependencies = {
        'nvim-lua/plenary.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    config = function()
        local telescope = require('telescope')
        local builtin = require('telescope.builtin')

        -- 1. Setup Telescope (Optional, but good for defaults)
        telescope.setup({
            defaults = {
                -- file_ignore_patterns = { "node_modules", ".git" }
                -- telescope 0.1.8 calls the legacy nvim-treesitter.parsers API
                -- (ft_to_lang), which the "main" branch rewrite removed. Disable
                -- treesitter preview highlighting to avoid the crash; falls back
                -- to regex syntax highlighting in the preview window.
                preview = { treesitter = false },
            }
        })

        -- 2. Load the FZF extension (CRITICAL: otherwise the dependency is useless)
        telescope.load_extension('fzf')

        -- 3. Keymaps
        vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = 'Telescope find files' })
        
        -- Note: git_files only works if you are inside a git repo. 
        -- If not, it will throw an error.
        vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = 'Telescope git files' })

        -- 4. Improved Grep
        -- Your original code prompts for input before searching.
        -- 'live_grep' is usually better: it searches AS you type.
        vim.keymap.set('n', '<leader>ps', function()
             builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end)
        
        -- Bonus: The standard "Live Grep" (dynamic searching)
        vim.keymap.set('n', '<leader>lg', builtin.live_grep, { desc = 'Telescope live grep' })
    end
}
