#!/bin/bash

wallpaper=$1
conf="/home/breno/.config/hypr/hyprpaper.conf"

# Generate wallust colors
echo "Generating colors..."
wallust run $wallpaper
echo " "
echo "Color palette generated!"

# Set hyprpaper wallpaper
echo " "
echo "Applying wallpaper (hyprpaper)..."
echo " " > $conf
echo "wallpaper {" >> $conf
echo "	monitor = " >> $conf
echo "	path = $wallpaper" >> $conf
echo "	fit_mode = cover" >> $conf
echo "}" >> $conf
echo "splash = false" >> $conf
killall hyprpaper 
hyprpaper &
echo "Wallpaper set!"

# Refresh waybar config
echo " "
echo "Refreshing waybar..."
~/.config/waybar/scripts/reload.sh
swaync-client -R && swaync-client -rs
echo "Waybar colors applied!"

echo " "
echo "If the used terminal is GHOSTTY: Reload configurations manually using: CTRL + SHIFT + ,"
