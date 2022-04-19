#! /bin/bash

batstat="$(/usr/bin/cat /sys/class/power_supply/BAT1/status)"
while true; do
    battery="$(/usr/bin/cat /sys/class/power_supply/BAT1/capacity)"
    if [ $batstat == 'Unknown' ]; then
        notify-send "This computer not contains battery, finalizaing script" -u low
        killall verify_battery.sh
    elif [[ $battery -ge 5 ]] && [[ $battery -le 20 ]]; then
        notify-send "The battery is low to 20%, connect inmediatly" -h string:x-canonical-private-synchronous:battery -u critical
    fi
    sleep 9
done
