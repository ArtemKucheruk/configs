#!/bin/bash

FOCUSED="${FOCUSED_WORKSPACE:-$(aerospace list-workspaces --focused 2>/dev/null)}"

# Get active workspace per monitor
MON1_WS=$(aerospace list-workspaces --monitor 1 --visible 2>/dev/null | head -1)
MON2_WS=$(aerospace list-workspaces --monitor 2 --visible 2>/dev/null | head -1)

if [ "$NAME" = "workspace_1" ]; then
  WS="${MON1_WS:-$FOCUSED}"
  sketchybar --set "$NAME" icon="$WS" background.drawing=on

elif [ "$NAME" = "workspace_2" ]; then
  if [ -n "$MON2_WS" ]; then
    sketchybar --set "$NAME" drawing=on icon="$MON2_WS"
  else
    sketchybar --set "$NAME" drawing=off
  fi
fi
