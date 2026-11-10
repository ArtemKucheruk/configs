return {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-tree/nvim-web-devicons',
        'MunifTanjim/nui.nvim',
    },
    cmd = 'Neotree',
    keys = {
        { '<leader>e', '<cmd>Neotree toggle<cr>', desc = 'Toggle file tree' },
    },
    init = function()
        vim.api.nvim_create_autocmd('BufWinEnter', {
            callback = function()
                if vim.bo.filetype == 'neo-tree' then
                    vim.wo.number = true
                    vim.wo.relativenumber = true
                end
            end,
        })
    end,
    opts = {
        close_if_last_window = true,
        filesystem = {
            follow_current_file = { enabled = true },
            use_libuv_file_watcher = true,
            filtered_items = {
                hide_dotfiles = false,
                hide_gitignored = false,
            },
        },
    },
}