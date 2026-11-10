return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main", -- main branch: required for Neovim 0.11+ (master is frozen, breaks on 0.12)
  lazy = false,
  build = ":TSUpdate",
  config = function()
    local ts = require("nvim-treesitter")

    local ensure = {
      "lua", "vim", "vimdoc",
      "go", "gomod", "gosum",
      "python",
      "javascript", "typescript", "tsx",
      "html", "css", "json", "yaml",
      "bash", "markdown", "markdown_inline",
    }

    -- only build parsers that aren't installed yet (avoids rebuilding every startup)
    local installed = require("nvim-treesitter.config").get_installed()
    local lookup = {}
    for _, p in ipairs(installed) do
      lookup[p] = true
    end
    local missing = vim.tbl_filter(function(p)
      return not lookup[p]
    end, ensure)
    if #missing > 0 then
      ts.install(missing)
    end

    -- main branch does not auto-enable highlight; do it per-buffer.
    -- NOTE: treesitter's indentexpr on the main branch is experimental and
    -- mis-indents JS/TS (cascades indents deeper each line), so we do NOT set
    -- it here -- Neovim's built-in autoindent/smartindent is used instead.
    local function start(buf)
      local lang = vim.treesitter.language.get_lang(vim.bo[buf].filetype)
      if lang then
        pcall(vim.treesitter.start, buf, lang)
      end
    end

    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("treesitter_start", { clear = true }),
      callback = function(ev)
        start(ev.buf)
      end,
    })

    -- catch buffers already open before this ran (e.g. file passed at launch)
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_buf_is_loaded(buf) then
        start(buf)
      end
    end
  end,
}
