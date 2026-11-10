# JankyBorders

[JankyBorders](https://github.com/FelixKratz/JankyBorders) draws a border
around the focused window. It works with any window manager. Here it fills
the gaps that [AeroSpace](../aerospace/) leaves, so you can see which tile
has focus even when every terminal is translucent.

Installed to `~/.config/borders/`.

| File | Purpose |
|------|---------|
| `bordersrc` | Startup script: `borders` runs it on launch with the options below |

## Settings

| Option | Value | Meaning |
|--------|-------|---------|
| `style` | `round` | Rounded corners that match macOS windows |
| `width` | `3.0` | Border thickness in points |
| `hidpi` | `off` | Normal resolution rendering |
| `active_color` | `0xffe2e2e3` | Light grey on the focused window |
| `inactive_color` | `0xff414550` | Dark slate on the other windows |

Colors use the `0xAARRGGBB` format, so the first byte is alpha.

## Usage

```bash
brew install FelixKratz/formulae/borders
brew services start borders      # launches at login and reads bordersrc
brew services restart borders    # after editing bordersrc
```

`bordersrc` must be executable (`chmod +x ~/.config/borders/bordersrc`).
The installer sets this for you.
