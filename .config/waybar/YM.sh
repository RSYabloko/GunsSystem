#!/bin/bash

# Получаем ID Chromium
ID=$(pactl list sink-inputs | awk '/Sink Input #/{id=$3} /node.name = "Chromium"/ {gsub("#","",id); print id; exit}')

if [ -z "$ID" ]; then
    echo "0"
    exit 0
fi

# Получаем громкость
VOL=$(pactl list sink-inputs | awk -v id="$ID" '
    $1 == "Sink" && $2 == "Input" && $3 == "#"id {found=1}
    found && /Volume:/ {
        match($0, /\/[ ]*([0-9]+)%/, m);
        print m[1];
        exit
    }
')

# Определяем иконку по уровню громкости
if [ "$VOL" -eq 0 ]; then
    ICON="  "
elif [ "$VOL" -lt 50 ]; then
    ICON="  "
else
    ICON="  "
fi

echo " $VOL"
