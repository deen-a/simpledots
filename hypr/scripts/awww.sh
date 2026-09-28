#!/bin/bash

# ensure daemon is running
awww-daemon &

# Set main monitor
awww img -o eDP-1 $HOME/Pictures/wallpaper/wallhaven-kxrwj1.png

# Set Second monitor
if hyprctl monitors | grep -l "Monitor HDMI-A"; then
    awww img -o HDMI-A-1 $HOME/Pictures/wallpaper/dark-panzer.jpg
fi

