# Yazi

[Yazi](https://github.com/sxyazi/yazi) is a fast terminal file manager
written in Rust. It previews images, code and archives inside the terminal.
Ghostty supports the Kitty graphics protocol, so image previews work out of
the box.

Installed to `~/.config/yazi/`.

| File | Purpose |
|------|---------|
| `yazi.toml` | Manager settings |

## Settings

```toml
[mgr]
show_hidden = true      # show dotfiles
sort_by = "extension"   # group files by type
```

Everything else uses Yazi's defaults.

## Integration

- **Neovim:** [`yazi.nvim`](https://github.com/mikavilpas/yazi.nvim) opens Yazi in a
  floating window:
  - `<leader>-`: Yazi at the current file
  - `<leader>cw`: Yazi at the working directory
  - `y` on the Neovim dashboard: browse with Yazi
- **Shell:** run `yazi` in any Ghostty window.

## Install

```bash
brew install yazi
brew install ffmpeg sevenzip jq poppler fd ripgrep fzf zoxide imagemagick  # optional, for previews and search
```
