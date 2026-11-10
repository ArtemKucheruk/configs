# Neofetch

[Neofetch](https://github.com/dylanaraps/neofetch) prints system info next to
the distro logo. Here it's used for desktop screenshots.

Installed to `~/.config/neofetch/`.

| File | Purpose |
|------|---------|
| `config.conf` | Which info lines appear and how the logo is drawn |

## What it shows

OS, host, kernel, uptime, packages, shell, resolution, DE, WM (AeroSpace),
WM theme, theme, icons, terminal, terminal font, CPU, GPU, memory, and a row
of color blocks from the terminal palette.

The logo is ASCII art (`image_backend="ascii"`, `ascii_distro="auto"`), so it
uses the colors of the current Ghostty theme.

## Install

```bash
brew install neofetch
neofetch
```

> Neofetch's upstream repo is archived. [Fastfetch](https://github.com/fastfetch-cli/fastfetch)
> is a maintained alternative, but it uses its own config format.
