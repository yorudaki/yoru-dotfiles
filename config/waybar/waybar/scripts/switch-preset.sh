#!/bin/bash

if [$# -lt 1]; then
	echo "Correct usage: $0 [preset]"
	exit 1
fi

PRESET=$1

echo "Applying preset..."
cat ~/.config/waybar/presets/"$PRESET".jsonc > ~/.config/waybar/config.jsonc
cat ~/.config/waybar/presets/"$PRESET".css > ~/.config/waybar/style.css

~/.config/waybar/scripts/reload.sh
