#!/bin/bash

# Получаем список мониторов Hyprland
outputs=$(hyprctl monitors | grep 'Monitor' | awk '{print $2}')

# Показываем выбор через rofi или wofi
selected=$(echo "$outputs" | wofi -dmenu -p "Вас снимает скрытая камера")

# Если пользователь выбрал монитор
if [ -n "$selected" ]; then

    sleep 0.2

    filepath=~/Pictures/$(date +'%Y-%m-%d_%H-%M-%S').png

    grim -o "$selected" "$filepath"

    wl-copy < "$filepath"
fi
