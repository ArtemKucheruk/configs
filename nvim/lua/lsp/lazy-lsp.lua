return {
  "neovim/nvim-lspconfig",
  dependencies = {
    {"VonHeikemen/lsp-zero.nvim", branch = "v3.x"},
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/nvim-cmp",
    "L3MON4D3/LuaSnip",
    { "folke/lazydev.nvim", ft = "lua", opts = {} },
  },
  config = function()
    local lsp_zero = require("lsp-zero")
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- 1. LSP Keymaps
    lsp_zero.on_attach(function(client, bufnr)
      lsp_zero.default_keymaps({ buffer = bufnr, preserve_mappings = false })
      local opts = { buffer = bufnr, remap = false }
      vim.keymap.set("n", "gl", function() vim.diagnostic.open_float() end, opts)
      vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end, opts)
      vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, opts)
    end)

    -- 2. Server configs
    vim.lsp.config("gopls", {
      capabilities = capabilities,
      settings = {
        gopls = {
          analyses = { unusedparams = true, shadow = true },
          staticcheck = true,
          gofumpt = true,
        },
      },
      on_attach = function(client, bufnr)
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format({ bufnr = bufnr, async = false })
          end,
        })
      end,
    })

    vim.lsp.config("vtsls", {
      capabilities = capabilities,
      settings = {
        typescript = {
          updateImportsOnFileMove = { enabled = "always" },
          suggest = { completeFunctionCalls = true },
          inlayHints = {
            parameterNames = { enabled = "literals" },
            parameterTypes = { enabled = true },
            variableTypes = { enabled = true },
            propertyDeclarationTypes = { enabled = true },
            functionLikeReturnTypes = { enabled = true },
            enumMemberValues = { enabled = true },
          },
        },
        javascript = {
          updateImportsOnFileMove = { enabled = "always" },
          suggest = { completeFunctionCalls = true },
        },
      },
    })

    vim.lsp.config("html", {
      capabilities = capabilities,
      filetypes = { "html", "htmldjango" },
    })

    vim.lsp.config("pyright", {
      capabilities = capabilities,
      settings = {
        python = {
          analysis = {
            typeCheckingMode = "off",
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
            diagnosticMode = "openFilesOnly",
          },
        },
      },
      on_init = function(client)
        local cwd = client.config.root_dir
        for _, name in ipairs({ ".venv", "venv", "env" }) do
          if vim.fn.isdirectory(vim.fs.joinpath(cwd, name)) == 1 then
            client.config.settings.python.pythonPath = vim.fs.joinpath(cwd, name, "bin", "python")
            client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
            break
          end
        end
      end,
    })

    vim.lsp.config("lua_ls", {
      capabilities = capabilities,
    })

    vim.lsp.config("sqls", {
      capabilities = capabilities,
    })

    vim.lsp.config("yamlls", {
      capabilities = capabilities,
      settings = {
        yaml = {
          keyOrdering = false,
          validate = true,
          schemaStore = { enable = true, url = "" },
        },
      },
      on_attach = function(client, bufnr)
        local opts = { buffer = bufnr }

        -- show active schema for current file
        vim.keymap.set("n", "<leader>ys", function()
          local params = { uri = vim.uri_from_bufnr(bufnr) }
          client:request("yaml/getJsonSchema", params, function(err, result)
            if err or not result then
              vim.notify("No schema detected", vim.log.levels.INFO)
            else
              local schema = type(result) == "table" and (result.uri or result.url or vim.inspect(result)) or tostring(result)
              vim.notify("Schema: " .. schema, vim.log.levels.INFO)
            end
          end, bufnr)
        end, vim.tbl_extend("force", opts, { desc = "YAML: show schema" }))

        -- format on save
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format({ bufnr = bufnr, async = false })
          end,
        })
      end,
    })

    vim.lsp.enable({ "gopls", "vtsls", "html", "pyright", "lua_ls", "yamlls", "sqls" })

    -- 3. Diagnostic config
    vim.diagnostic.config({
      virtual_text = false,
      virtual_lines = { current_line = true },
      signs = { severity = { min = vim.diagnostic.severity.WARN } },
      underline = { severity = { min = vim.diagnostic.severity.ERROR } },
      update_in_insert = false,
      severity_sort = true,
    })

    -- 4. Completion
    local cmp = require("cmp")
    cmp.setup({
      sources = { { name = "nvim_lsp" }, { name = "lazydev", group_index = 0 } },
      mapping = cmp.mapping.preset.insert({
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
      }),
      snippet = {
        expand = function(args) require("luasnip").lsp_expand(args.body) end,
      },
    })
  end,
}
