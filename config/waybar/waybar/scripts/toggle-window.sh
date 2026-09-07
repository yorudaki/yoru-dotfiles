#!/usr/bin/env bash
# ~/.config/waybar/scripts/toggle-window.sh
# Use: toggle-window.sh <class> <open-command> [args...]

#this script was vibe-coded, lol
#feel free to change this to a better version

set -euo pipefail
 
if [ "$#" -lt 2 ]; then
  echo "Uso: $(basename "$0") <class> <comando> [args...]" >&2
  exit 1
fi
 
CLASS="$1"
shift
CMD=("$@")
 
WIN=$(hyprctl clients -j | jq -r --arg CLASS "$CLASS" \
  '.[] | select(.class | test($CLASS)) | .address' | head -n1)
 
if [ -n "$WIN" ]; then
  hyprctl dispatch "hl.dsp.focus({ window = \"address:$WIN\" })"
  hyprctl dispatch "hl.dsp.window.close()"
else
  "${CMD[@]}" &
  disown
fi
