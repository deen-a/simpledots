#!/bin/bash

# Pilihan menu
options="  Shutdown\n󰜉  Reboot\n󰒲  Suspend\n  Lock"

# Konfigurasi tampilan Rofi (Dropdown di kanan atas)
# y-offset: jarak dari atas layar (sesuaikan dengan tinggi waybar)
# x-offset: jarak dari pinggir kanan layar
dir="$HOME/.config/rofi/power"
theme="style"

# Memanggil Rofi
chosen=$(echo -e "$options" | rofi -show dmenu -i -p "Power" -theme-str "${dir}/${theme}.rasi")

# Eksekusi aksi berdasarkan pilihan
case "$chosen" in
    "  Shutdown") systemctl poweroff ;;
    "󰜉  Reboot") systemctl reboot ;;
    "󰒲  Suspend") systemctl suspend ;;
    "  Lock") hyprlock ;;
esac

