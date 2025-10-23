-- lua/artemConfig/lsp.lua
local lsp_zero = require('lsp-zero')

-- Mason setup for installing LSP servers and tools
require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = {
    'pyright',        -- Python
    'gopls',          -- Go
    'rust_analyzer',  -- Rust
    'html',           -- HTML
    'jsonls',         -- JSON
    'ruff',           -- Python formatting/linting (optional)
    'lua_ls',
    'intelephense'

  },
  handlers = {
    -- Default handler for all servers
    function(server_name)
      require('lspconfig')[server_name].setup({})
    end,
    -- Optional: Customize specific servers if needed
    rust_analyzer = function()
      require('lspconfig').rust_analyzer.setup({
        settings = {
          ['rust-analyzer'] = {
            checkOnSave = { command = 'clippy' }, -- Use clippy for Rust
          },
        },
      })
    end,
  },
})

-- Diagnostics configuration
vim.diagnostic.config({
  virtual_text = true,  -- Show errors inline
  signs = {
    active = true,
    values = {
      { name = 'DiagnosticSignError', text = '✘' },
      { name = 'DiagnosticSignWarn', text = '▲' },
      { name = 'DiagnosticSignHint', text = '⚑' },
      { name = 'DiagnosticSignInfo', text = '»' },
    },
  },
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

-- Enable inlay hints (Neovim 0.11+)
vim.lsp.inlay_hint.enable(true)

-- Autocompletion with nvim-cmp
local cmp = require('cmp')
cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' },
    { name = 'nvim_lua' },
  }),
})

-- Load snippets
require('luasnip.loaders.from_vscode').lazy_load()

-- LSP keymaps
lsp_zero.on_attach(function(client, bufnr)
  local opts = { buffer = bufnr, remap = false }
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
end)

-- Formatting with conform.nvim
require('conform').setup({
  format_on_save = {
    timeout_ms = 500,
    lsp_format = 'fallback', -- Use LSP if available, else external formatter
  },
  formatters_by_ft = {
    python = { 'ruff_format' }, -- Requires Ruff
    go = { 'goimports', 'gofmt' },
    rust = { 'rustfmt' },
    html = { 'prettier' },
    json = { 'prettier' },
  },
})

-- Manual format keymap
vim.keymap.set('n', '<leader>fo', function()
  require('conform').format({ async = true })
end, { desc = 'Format buffer' })
