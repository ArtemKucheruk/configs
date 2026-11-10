#!/bin/bash
# Hyprland-like dwindle: new window splits the window it opened next to, alternating orientation.
# Run from on-window-detected. AeroSpace inserts new window right after the focused one,
# so join-with toward the previous sibling nests them; the nested container gets the opposite
# orientation via enable-normalization-opposite-orientation-for-nested-containers.
# Needs AeroSpace >= 0.20 for %{window-parent-container-layout}.
w=$AEROSPACE_WINDOW_ID

read -r ws layout < <(aerospace list-windows --all \
  --format '%{window-id} %{workspace} %{window-parent-container-layout}' |
  awk -v w="$w" '$1 == w { print $2, $3 }')

# ponytail: only the root can have <3 children after insert (flatten normalization), so
# "<= 2 tiling windows" == "first split, leave it side by side".
n=$(aerospace list-windows --workspace "$ws" --format '%{window-parent-container-layout}' | grep -c tiles)
(( n > 2 )) || exit 0

case $layout in
  h_tiles) aerospace join-with --window-id "$w" left ;;
  v_tiles) aerospace join-with --window-id "$w" up ;;
esac
