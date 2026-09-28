#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Usage: $0 --performance | --check | --powersave"
    exit 1
fi

# Ambil status governor saat ini langsung dari kernel (tanpa sudo)
CURRENT_GOV=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor)

case "$1" in
    --check) 
        notifi-send -u normal -a "auto-cpufreq" "CPU Mode: $CURRENT_GOV" "Active Mode: $CURRENT_GOV"
        ;;
    --performance)
        if [ "$CURRENT_GOV" == "performance" ]; then
            # Jika sedang performance, kembalikan ke auto/default (schedutil/powersave)
            sudo auto-cpufreq --force reset

            # Kirim notifikasi
            notify-send -u normal -a "auto-cpufreq" "CPU Mode: Default" "Performance mode inactive"
        else
            # Jika selain performance, paksa masuk ke mode performance
            sudo auto-cpufreq --force performance

            # Send notification
            notify-send -u critical -a "auto-cpufreq" "CPU Mode: Performance" "Performance mode activated"
        fi
        ;;
    --powersave)
	if [ "$CURRENT_GOV" == "powersave" ]; then
            # Jika sedang performance, kembalikan ke auto/default (schedutil/powersave)
            sudo auto-cpufreq --force reset

            # Kirim notifikasi
            notify-send -u normal -a "auto-cpufreq" "CPU Mode: Default" "Powersave mode inactive"
        else
            # Jika selain performance, paksa masuk ke mode performance
            sudo auto-cpufreq --force powersave

            # Send notification
            notify-send -u critical -a "auto-cpufreq" "CPU Mode: Powersave" "Powersave mode activated"
	fi
	;;
    *)
        echo "Invalid option: $1"
        echo "Usage: $0 --toggle | --check | --powersave"
        exit 1
        ;;
esac
