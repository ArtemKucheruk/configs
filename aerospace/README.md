# AeroSpace

[AeroSpace](https://github.com/nikitabobko/AeroSpace) is an i3-like tiling
window manager for macOS. It doesn't need SIP disabled. It places every
window in a tree of tiles and switches workspaces without macOS Spaces
animations.

Installed to `~/.config/aerospace/`.

| File | Purpose |
|------|---------|
| `aerospace.toml` | Main config: gaps, workspaces, keybindings, hooks |
| `dwindle.sh` | Runs on every new window to get a Hyprland-style spiral layout |

## Highlights

- **Gaps:** 40px around the screen edge, 10px between windows. This leaves
  room for [JankyBorders](../borders/) and shows the wallpaper.
- **Persistent workspaces:** `1`–`9` plus most letters `A`–`Z`.
- **One or two monitors:** works the same on a single screen, and splits
  the workspaces across two. See [Multi-monitor](#multi-monitor).
- **Dwindle layout:** `dwindle.sh` runs on `on-window-detected`. The first two
  windows sit side by side. Each window after that splits the focused window
  and alternates horizontal/vertical, as Hyprland's dwindle does. Needs
  AeroSpace ≥ 0.20.
- **SketchyBar hook:** every workspace change runs
  `sketchybar --trigger aerospace_workspace_change`, so
  [SketchyBar](../sketchybar/) shows the active workspace.
- **Starts at login** (`start-at-login = true`).

## Multi-monitor

The config is written for both setups. Nothing needs to change when you plug
a second monitor in or out.

| Setup | Workspaces `1`–`5` | Workspaces `6`–`9` |
|-------|--------------------|--------------------|
| One monitor | that monitor | that monitor |
| Two monitors | **secondary** monitor (e.g. external display) | **main** monitor (e.g. laptop screen) |

```toml
[workspace-to-monitor-force-assignment]
1 = ['secondary', 'main']   # same for 2–5: secondary if present, else main
6 = 'main'                  # same for 7–9
```

- **Which monitor is "main":** the one macOS treats as main, meaning the
  one with the menu bar in *System Settings → Displays → Arrange*. To flip
  the split, drag the menu bar to the other display there, or swap
  `'secondary'` and `'main'` in `aerospace.toml`.
- **Unplugging:** with `['secondary', 'main']`, workspaces `1`–`5` fall back
  to the main monitor, so no windows get lost. They move back when the second
  monitor returns.
- **Letter workspaces** (`A`–`Z`) aren't tied to a monitor. They open on
  whichever monitor has focus. Use `alt-shift-tab` to send the current
  workspace to the other monitor.
- **Mouse follows focus:** when focus moves to another monitor, the pointer
  jumps to its center.
- **Orientation:** `default-root-container-orientation = 'auto'` stacks
  windows top to bottom on a portrait monitor and side by side on a wide one.
- **Bar:** [SketchyBar](../sketchybar/) shows one workspace label per monitor.
  The second label hides automatically when only one monitor is connected.

## Keybindings

`alt` = Option key.

| Keys | Action |
|------|--------|
| `alt-space` | Workspace switcher popup (provided by [Hammerspoon](../hammerspoon/), not AeroSpace) |
| `alt-enter` | New Ghostty window (opens Ghostty if it isn't running) |
| `alt-e` | New Finder window |
| `alt-h/j/k/l` | Focus left / down / up / right |
| `alt-shift-h/j/k/l` | Move window left / down / up / right |
| `alt-shift-minus` / `alt-shift-equal` | Shrink / grow window |
| `alt-/` | Tiles layout (toggle horizontal / vertical) |
| `alt-,` | Accordion layout (toggle horizontal / vertical) |
| `alt-1…9`, `alt-<letter>` | Switch to workspace |
| `alt-shift-1…9`, `alt-shift-<letter>` | Move window to workspace and follow it |
| `alt-tab` | Back to the previous workspace |
| `alt-shift-tab` | Move workspace to the next monitor |
| `alt-shift-;` | Enter **service** mode |

### Service mode

| Key | Action |
|-----|--------|
| `esc` | Reload config, back to main |
| `r` | Flatten workspace tree (reset layout) |
| `f` | Toggle floating / tiling |
| `backspace` | Close all windows except the focused one |
| `alt-shift-h/j/k/l` | Join with the neighbor in that direction |
| `alt-shift-s` | Screenshot of a region to the clipboard |

## Notes

- There are no workspaces `H`, `J`, `K`, `L`, because those keys handle focus.
  Workspace `E` exists, but `alt-e` opens Finder, so you can only reach it by
  moving a window there with `alt-shift-e`.
- AeroSpace captures these `alt` combos globally, so other apps never receive
  them.
- Reload after editing: `aerospace reload-config` (or `alt-shift-;` then `esc`).
- The installer makes `dwindle.sh` executable. If you copy files by hand, run
  `chmod +x ~/.config/aerospace/dwindle.sh`.
