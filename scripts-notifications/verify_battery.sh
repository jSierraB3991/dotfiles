#! /bin/bash

batstat="$(/usr/bin/cat /sys/class/power_supply/BAT1/status)"
while true; do
    battery="$(/usr/bin/cat /sys/class/power_supply/BAT1/capacity)"
    if [ $batstat == 'Unknown' ]; then
        notify-send "This computer not contains battery, finalizaing script" -u low
        killall verify_battery.sh
    elif [[ $battery -ge 5 ]] && [[ $battery -le 20 ]]; then
        notify_id=508
        icon="/usr/share/icons/gnome/48x48/status/battery-caution.png"
        number=$(cat /sys/class/power_supply/BAT1/capacity)

        dunstify -u critical -i $icon -r $notify_id "Battery low percentaje: $number%"
    fi
    sleep 9
done
