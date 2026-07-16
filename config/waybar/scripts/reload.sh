#!/bin/bash

PROCESS="waybar"

if pgrep -x "$PROCESS" > /dev/null; then
    killall "$PROCESS"
    
    sleep 0.5
fi

echo "Starting Waybar..."
waybar > /dev/null 2>&1 &
