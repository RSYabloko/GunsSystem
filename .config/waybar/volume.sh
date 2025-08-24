#!/bin/bash
CHANGE=$1
ID=$(pactl list sink-inputs | awk '/Sink Input #/{id=$3} /node.name = "Chromium"/ {gsub("#", "", id); print id; exit}')
[ -n "$ID" ] && pactl set-sink-input-volume "$ID" "$CHANGE"
pkill -RTMIN+10 waybar
