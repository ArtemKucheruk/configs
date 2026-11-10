# Ghostty

[Ghostty](https://ghostty.org) is a fast, native, GPU-accelerated terminal. It
is the main surface of this setup: translucent, blurred, and quick to
restyle.

Installed to `~/.config/ghostty/`.

## Layout

```
ghostty/
├── config        # main config, includes one snippet from each folder below
├── font/         # one file per font (family + tuned line height)
├── leading/      # line height overrides 0–20, or default
├── opacity/      # background opacity + blur presets
├── theme/        # color theme snippets
├── shader/       # custom GLSL shader snippets
├── shaders/      # the .glsl files the shader snippets load
└── themes/       # extra color palettes (tokyonight), loaded by name
```

The main `config` combines one snippet from each folder:

```
config-file = font/lilex
config-file = leading/default
theme = Black Metal (Bathory)
config-file = opacity/40%
config-file = shader/none
```

To change the look, change which snippet is included. You don't need to
edit settings by hand.

## Main settings

| Setting | Value | Why |
|---------|-------|-----|
| `keybind` | `global:super+ctrl+.=toggle_quick_terminal` | `cmd+ctrl+.` drops down a quick terminal from any app |
| `macos-option-as-alt` | `true` | Option works as Alt in Neovim and zsh |
| `macos-icon` | custom aluminum frame, cyan ghost | Custom Dock icon |
| `font-thicken` | `true` | Heavier glyphs on a translucent background |
| `alpha-blending` | `linear-corrected` | Cleaner text edges on transparency |
| `cursor-invert-fg-bg` | `true` | Cursor always contrasts with the text under it |
| `mouse-hide-while-typing` | `true` | |
| `custom-shader-animation` | `always` | Animated shaders keep running when unfocused |
| `auto-update-channel` | `tip` | Nightly builds |

## Snippets

| Folder | Options |
|--------|---------|
| `font/` | 0xProto, Berkeley Mono (TX-02), Cascadia Code, Codelia, Comic Code, Commit Mono, Ellograph, Fira Code, IBM Plex Mono, Intel One Mono, JetBrains Mono, **Lilex**, M+ Code, Maple Mono, Menlo, Monaspace Argon/Krypton/Neon/Xenon, MonoLisa, Operator Mono, PragmataPro (3 variants), Roboto Mono, SF Mono, Source Code Pro, Sudo, Triplicate, Ubuntu Mono, Victor Mono |
| `leading/` | `0` – `20` (extra cell height in px), `default` (use the font's own value) |
| `opacity/` | `40%`, `70%`, `75%`, `80%`, `85%`, `90%`, `95%`, `100%`. All except 100% add a 20px background blur |
| `theme/` | catppuccin-mocha, gruvbox-material, 0x96f, tokyonight (day / moon / night / storm), default |
| `shader/` | animated-gradient, bettercrt, bloom, crt, cubes, dither, drunkard, fireworks, gears-and-belts, glitchy, glow-rgbsplit-twitchy, gradient-background, inside-the-matrix, just-snow, matrix-hallway, negative, retro-terminal, smoke-and-ghost, sparks-from-fire, spotlight, starfield, starfield-colors, tft, underwater, water, **none** |

Fonts are not bundled. Install the ones you want; most free fonts are
available as Homebrew casks (`brew search font-<name>`). Several are paid
(Berkeley Mono, PragmataPro, MonoLisa, Operator Mono, Comic Code).

### How the paths resolve

- **Shaders:** each `shader/<name>` snippet contains
  `custom-shader = ../shaders/<name>.glsl`. Ghostty resolves relative paths
  against the folder of the file they are written in, so this works wherever
  the folder is installed.
- **Themes:** the `tokyonight-*` snippets use `theme = tokyonight_night` and
  so on. Ghostty looks up theme names first in `~/.config/ghostty/themes/`,
  then in its built-in themes. The other snippets use built-in themes. Run
  `ghostty +list-themes` to see them all.

### Credits

- `shaders/`: copied unchanged from
  [hackrdotsh/ghostty-shaders](https://github.com/hackrdotsh/ghostty-shaders).
  Many are ports from Shadertoy, and authors are credited in the file headers
  where known. Upstream has no license file.
- `themes/tokyonight_*`: from
  [folke/tokyonight.nvim](https://github.com/folke/tokyonight.nvim) `extras/ghostty`,
  Apache-2.0 (see [`../licenses/tokyonight.nvim-LICENSE`](../licenses/tokyonight.nvim-LICENSE)).

## Quick switcher (`gc`)

Add this to `~/.zshrc` to switch snippets with fzf (needs `fd` and `fzf`):

```zsh
function gc {
  local GHOSTTY_DIR="$HOME/.config/ghostty"
  local CMD="sed -i '' 's:\(config-file = {1}\)/.*:\1/{2}:' $GHOSTTY_DIR/config && osascript -so -e 'tell application \"Ghostty\" to activate' -e 'tell application \"System Events\" to keystroke \",\" using {command down, shift down}'"
  fd \
    --type f \
    --exclude 'config' --exclude shaders --exclude themes --exclude '*.md' \
    --base-directory $GHOSTTY_DIR \
  | fzf \
    --header="<ctrl-y> :: enable, don't exit" \
    --preview "cat $GHOSTTY_DIR/{}" \
    --delimiter=/ \
    --bind="enter:become:$CMD"
}
```

Run `gc`, pick e.g. `font/fira-code`, and Ghostty reloads with that font.
The command rewrites the matching `config-file = <folder>/...` line. Theme is
set with a plain `theme =` line, so to switch themes with `gc` too, replace
that line with `config-file = theme/<name>`.

Origin of the idea: [ghostty-org/ghostty#3527](https://github.com/ghostty-org/ghostty/discussions/3527).

## Reload

`cmd+shift+,` reloads the config in a running Ghostty.
