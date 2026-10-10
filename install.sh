#!/usr/bin/env bash
# Applies these Unturned settings on a Linux PC (close Unturned and Steam first).
# Disable Steam Cloud sync for Unturned, or Steam may overwrite the files with older cloud copies.
set -euo pipefail
here="$(cd "$(dirname "$0")" && pwd)"
STEAM="${STEAM_DIR:-$HOME/.local/share/Steam}"
GAME="$STEAM/steamapps/common/Unturned"
for d in "$STEAM"/userdata/*/304930/remote; do
  [ -d "$d" ] || continue
  mkdir -p "$d/Settings"
  cp "$here"/steam_cloud/*.dat "$d/"
  cp "$here"/steam_cloud/Settings/Graphics.json "$d/Settings/"
  echo "Installed cloud settings to $d"
done
cp "$here/game_dir/Preferences.json" "$GAME/Preferences.json"
mkdir -p "$HOME/.config/unity3d/Smartly Dressed Games/Unturned"
cp "$here/unity/prefs" "$HOME/.config/unity3d/Smartly Dressed Games/Unturned/prefs"
echo "Done."
