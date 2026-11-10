# SketchyBar

[SketchyBar](https://github.com/FelixKratz/SketchyBar) replaces the macOS
menu bar with a scriptable status bar. Here it is a thin, transparent,
blurred bar that shows the active [AeroSpace](../aerospace/) workspace on each
monitor.

Installed to `~/.config/sketchybar/`.

| File | Purpose |
|------|---------|
| `sketchybarrc` | Bar look, items and event subscriptions |
| `colors.sh` | Color variables (white / grey palette) |
| `plugins/*.sh` | One script per item. SketchyBar runs it on its timer or event |

## Bar

32px high, at the top of every display. The bar background is fully
transparent with a 30px blur. Each item has a thin grey outline
(`0xff6c7086`) and rounded corners. Text uses SF Pro.

| Position | Item | Script | Updates |
|----------|------|--------|---------|
| left | Workspace, monitor 1 | `aerospace.sh` | `aerospace_workspace_change` event |
| left | Workspace, monitor 2 (hidden with one monitor) | `aerospace.sh` | `aerospace_workspace_change` event |
| left | Focused app name | `front_app.sh` | `front_app_switched` event |
| left | Next Notion Calendar event (click opens the app) | `notion_calendar.sh` | every 30s |
| right | Clock (`Mon 10 Nov  13:05`) | `clock.sh` | every 10s |
| right | Battery % | `battery.sh` | every 2 min, wake, power change |
| right | CPU % | `cpu.sh` | every 2s |
| right | Memory in use (GB) | `memory.sh` | every 2s |

`space.sh` and `volume.sh` are included but not used in `sketchybarrc`.

## How it talks to AeroSpace

`aerospace.toml` has:

```toml
exec-on-workspace-change = ['/bin/bash', '-c',
  'sketchybar --trigger aerospace_workspace_change FOCUSED_WORKSPACE=$AEROSPACE_FOCUSED_WORKSPACE'
]
```

`sketchybarrc` registers that custom event, and both workspace items
subscribe to it. `plugins/aerospace.sh` then asks AeroSpace which workspace
is visible on each monitor and updates the labels. The last line of
`sketchybarrc` fires the event once at startup so the bar is correct right
away.

## Install

```bash
brew install FelixKratz/formulae/sketchybar
brew install --cask font-sf-pro            # bar font
brew services start sketchybar
brew services restart sketchybar           # after editing
```

To hide the native menu bar: System Settings → Control Center →
*Automatically hide and show the menu bar* → **Always**.

The Notion Calendar item reads the app's menu bar title through System
Events, so SketchyBar needs **Accessibility** permission. Without Notion
Calendar the item shows "No events".
