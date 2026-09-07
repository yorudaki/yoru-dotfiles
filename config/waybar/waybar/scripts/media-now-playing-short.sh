#!/usr/bin/env bash

zscroll -l 18 \
    --delay 0.3 \
    --update-check true \
    "sh -c \"playerctl metadata --format '{{artist}} - {{title}}' 2>&1 | grep -q 'No players found' && echo 'No media playing' || playerctl metadata --format '{{artist}} - {{title}}'\""

wait

