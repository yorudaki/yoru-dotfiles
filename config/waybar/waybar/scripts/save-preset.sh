#!/bin/bash

PRESET=$1

cat ~/.config/waybar/config.jsonc > ~/.config/waybar/presets/"$PRESET".jsonc
cat ~/.config/waybar/style.css > ~/.config/waybar/presets/"$PRESET".css
