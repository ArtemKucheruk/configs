# Neovim Config

A personal Neovim config built from scratch. It uses
[lazy.nvim](https://github.com/folke/lazy.nvim) only as a plugin manager, with
no LazyVim or other preset. The theme is transparent kanagawa, so the blurred
Ghostty background shows through.

Installed to `~/.config/nvim/`. Also published separately at
[ArtemKucheruk/nvim](https://github.com/ArtemKucheruk/nvim).

## Requirements

- Neovim **≥ 0.11** (uses `vim.lsp.config` / `vim.lsp.enable` and the Treesitter `main` branch)
- `git`, `make`, a C compiler (Treesitter parsers, telescope-fzf-native)
- `ripgrep` (Telescope grep), `fd` (project finder)
- `node` / `npm` (vtsls, html, yamlls)
- Go toolchain (gopls), Python 3 (pyright)
- A [Nerd Font](https://www.nerdfonts.com) for icons
- Optional: [`yazi`](../yazi/), the [`claude`](https://claude.com/claude-code) CLI, and a Roslyn binary at `~/.local/bin/roslyn` for C#

## Structure

```
.
├── init.lua                  # Entry point: remaps → options → lazy.nvim
└── lua/
    ├── config/
    │   └── remap.lua         # Leader key + global keymaps
    ├── core/
    │   ├── options.lua       # 2-space indent, smartindent
    │   ├── lazy-nvim.lua     # lazy.nvim bootstrap; imports plugins/, ui/, lsp/, ai/
    │   └── projects.lua      # Project finder used by the dashboard
    ├── plugins/              # Editing, navigation, git
    ├── ui/                   # Colorscheme, dashboard, line numbers
    ├── lsp/                  # LSP servers, Mason, completion, C#
    └── ai/
        └── claudecode.lua    # Claude Code integration
```

Every file in `plugins/`, `ui/`, `lsp/` and `ai/` returns a lazy.nvim spec,
so a new plugin needs only a new file.

## Plugins

| Plugin | Folder | Purpose |
|--------|--------|---------|
| `rebelot/kanagawa.nvim` | ui | Colorscheme: `kanagawa-wave`, transparent |
| `goolord/alpha-nvim` | ui | Start dashboard |
| `mluders/comfy-line-numbers.nvim` | ui | Relative numbers you can reach with the left hand |
| `nvim-telescope/telescope.nvim` + fzf-native | plugins | Fuzzy finder |
| `nvim-neo-tree/neo-tree.nvim` | plugins | File tree that follows the current file and shows dotfiles |
| `mikavilpas/yazi.nvim` | plugins | Yazi file manager in a float |
| `rmagatti/auto-session` | plugins | Per-directory sessions, saved on exit |
| `nvim-treesitter/nvim-treesitter` (`main`) | plugins | Syntax highlighting; installs missing parsers on startup |
| `windwp/nvim-autopairs` | plugins | Auto-closes brackets and quotes |
| `lewis6991/gitsigns.nvim` | plugins | Git signs in the gutter, hunk actions, blame |
| `tpope/vim-fugitive` | plugins | Git commands inside Neovim |
| `mbbill/undotree` | plugins | Visual undo history |
| `akinsho/toggleterm.nvim` | plugins | Toggleable terminal |
| `MeanderingProgrammer/render-markdown.nvim` | plugins | Renders Markdown in the buffer |
| `neovim/nvim-lspconfig` + `lsp-zero` v3 | lsp | LSP setup and keymaps |
| `hrsh7th/nvim-cmp` + LuaSnip | lsp | Completion |
| `williamboman/mason.nvim` + mason-lspconfig | lsp | Installs language servers automatically |
| `seblyng/roslyn.nvim` | lsp | C# via Roslyn |
| `folke/lazydev.nvim` | lsp | Completion for the Neovim Lua API |
| `coder/claudecode.nvim` (+ snacks.nvim) | ai | Claude Code in a right split, diffs in a new tab |

## Dashboard

Running `nvim` with no arguments opens the dashboard:

| Key | Action |
|-----|--------|
| `f` | Find project: subfolders of `~/development`, `~/personalProjects`, `~/University`, `~/CascadeProjects`, `~/configs` (edit `M.roots` in `core/projects.lua`) |
| `s` | Restore a saved session |
| `r` | Recent files |
| `y` | Browse with Yazi |
| `c` | Open this config |
| `q` | Quit |

Picking a project runs `:tcd` into it and opens Neo-tree. Auto-session saves
the layout on exit, so `s` brings it back next time.

## LSP

Mason installs the servers in `ensure_installed`. Mason uses two registries:
`mason-org/mason-registry` and `Crashdummyy/mason-registry` (for Roslyn).

| Language | Server | Extras |
|----------|--------|--------|
| Go | `gopls` | gofumpt, staticcheck, format on save |
| TypeScript / JavaScript | `vtsls` | Inlay hints, updates imports when files move |
| HTML | `html` | Also runs on `htmldjango` |
| Python | `pyright` | Picks up `.venv` / `venv` / `env` automatically |
| Lua | `lua_ls` | + lazydev |
| YAML | `yamlls` | SchemaStore, format on save, `<leader>ys` shows the active schema |
| SQL | `sqls` | |
| C# | `roslyn` | Manual install, see below |

Diagnostics show as virtual lines on the **current line only**. The gutter
shows warnings and above, and only errors are underlined.

### C# / Roslyn

Mason doesn't install Roslyn automatically. Put the wrapper script at
`~/.local/bin/roslyn` and make it executable. See
[seblyng/roslyn.nvim](https://github.com/seblyng/roslyn.nvim).

## Keybindings

Leader: `<Space>`

### Navigation

| Key | Action |
|-----|--------|
| `<leader>pv` | netrw file explorer |
| `<leader>e` | Toggle Neo-tree |
| `<leader>pf` | Find files |
| `<C-p>` | Git files |
| `<leader>ps` | Grep for a string (asks for input) |
| `<leader>lg` | Live grep |
| `<leader>-` | Yazi at the current file |
| `<leader>cw` | Yazi at the working directory |
| `<leader>u` | Undotree |
| `<leader>t` | Toggle terminal |
| `<C-w>h/j/k/l/w` (terminal mode) | Leave the terminal and move to another window |

### Git

| Key | Action |
|-----|--------|
| `<leader>gs` | Fugitive status |
| `]c` / `[c` | Next / previous hunk |
| `<leader>hs` / `<leader>hr` | Stage / reset hunk |
| `<leader>hp` | Preview hunk |
| `<leader>hb` | Blame line (full) |
| `<leader>gb` | Toggle inline blame |

### LSP (lsp-zero defaults)

| Key | Action |
|-----|--------|
| `K` | Hover |
| `gd` / `gD` | Definition / declaration |
| `gi` / `go` | Implementation / type definition |
| `gr` | References |
| `gs` | Signature help |
| `<F2>` / `<F3>` / `<F4>` | Rename / format / code action |
| `gl` | Diagnostic float |
| `[d` / `]d` | Previous / next diagnostic |
| `<CR>` / `<C-Space>` | Confirm / trigger completion |

C# buffers also get `<leader>rn` (rename) and `<leader>ca` (code action).

### Claude Code

| Key | Action |
|-----|--------|
| `<leader>ac` | Toggle Claude |
| `<leader>af` | Focus Claude |
| `<leader>ar` / `<leader>aC` | Resume / continue a session |
| `<leader>am` | Select model |
| `<leader>ab` | Add the current buffer |
| `<leader>as` | Send the selection (visual), or add the file under the cursor (in a file tree) |
| `<leader>aa` / `<leader>ad` | Accept / deny a diff |
| `<leader>aq` | Close the window and keep the session |
| `<leader>ax` | Stop the session |

## Installation

As part of the full setup, use `../install.sh`. To install Neovim on its own:

```bash
git clone https://github.com/ArtemKucheruk/nvim ~/.config/nvim
nvim   # lazy.nvim bootstraps itself and installs every plugin
```

Mason installs the language servers on first launch.
