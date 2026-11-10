#!/usr/bin/env bash
# Install these dotfiles into ~/.config.
#
#   ./install.sh                 install every module
#   ./install.sh nvim ghostty    install only the named modules
#
# For each module, ~/.config/<module> is either overwritten (choice 1) or moved
# to /tmp/dotfiles-backup-<timestamp>/ first (choice 2).
set -euo pipefail

REPO="$(cd "$(dirname "$0")" && pwd)"
CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}"
ALL=(aerospace borders ghostty hammerspoon neofetch nvim sketchybar yazi)

if (( $# )); then MODULES=("$@"); else MODULES=("${ALL[@]}"); fi

# Only accept known module names: they become paths passed to rm -rf.
for m in "${MODULES[@]}"; do
  ok=
  for a in "${ALL[@]}"; do [[ $m == "$a" ]] && ok=1; done
  [[ -n $ok ]] || { echo "Unknown module: '$m'. Choose from: ${ALL[*]}" >&2; exit 1; }
done

# Installing from inside ~/.config would delete the source before copying it.
if [[ $REPO == "$CONFIG" ]]; then
  echo "Clone this repo somewhere other than $CONFIG and run it from there." >&2
  exit 1
fi

echo "Install into $CONFIG: ${MODULES[*]}"
echo
echo "  1) Overwrite: delete existing configs and replace them"
echo "  2) Backup:    move existing configs to /tmp, then install"
echo
read -rp "Choose [1/2]: " choice

BACKUP=
case $choice in
  1)
    read -rp "This permanently deletes the existing folders above in $CONFIG. Continue? [y/N] " yn
    [[ $yn == [yY] ]] || { echo "Aborted."; exit 1; }
    ;;
  2)
    BACKUP="/tmp/dotfiles-backup-$(date +%Y%m%d-%H%M%S)"
    mkdir -p "$BACKUP"
    ;;
  *)
    echo "Aborted."; exit 1
    ;;
esac

mkdir -p "$CONFIG"
for m in "${MODULES[@]}"; do
  dst="$CONFIG/$m"
  [[ $m == hammerspoon ]] && dst="$HOME/.hammerspoon"   # Hammerspoon only reads ~/.hammerspoon
  if [[ -e $dst || -L $dst ]]; then
    if [[ -n $BACKUP ]]; then
      mv "$dst" "$BACKUP/$m"
      echo "  saved     $dst -> $BACKUP/$m"
    elif [[ -e $dst/.git ]]; then
      # Overwriting would wipe its git history (branches, stashes, unpushed commits).
      echo "  skipped   $m: $dst is a git repo. Use backup mode or remove it yourself."
      continue
    else
      rm -rf "$dst"
    fi
  fi
  cp -R "$REPO/$m" "$dst"
  find "$dst" -name .DS_Store -delete
  echo "  installed $m"
done

# Both are executed directly by AeroSpace / borders.
[[ -f $CONFIG/aerospace/dwindle.sh ]] && chmod +x "$CONFIG/aerospace/dwindle.sh"
[[ -f $CONFIG/borders/bordersrc ]] && chmod +x "$CONFIG/borders/bordersrc"

echo
if [[ -n $BACKUP ]]; then
  echo "Backup: $BACKUP"
  echo "  macOS clears /tmp on reboot, so copy it elsewhere if you want to keep it."
  echo "  Restore a module: rm -rf $CONFIG/<module> && mv $BACKUP/<module> $CONFIG/"
  echo
fi
echo "Next steps:"
echo "  aerospace reload-config          # or open -a AeroSpace"
echo "  brew services restart borders"
echo "  brew services restart sketchybar"
echo "  Hammerspoon menu bar icon → Reload Config"
echo "  cmd+shift+, in Ghostty           # reload config"
echo "  nvim                             # lazy.nvim installs plugins on first run"
