#! /bin/bash

batstat="$(/usr/bin/cat /sys/class/power_supply/BAT1/status)"
if [ $batstat == "Unknow" ]; then
    echo "No battery"
else
    battery="$(/usr/bin/cat /sys/class/power_supply/BAT1/capacity)"
    color="#FFFFFF"


    echo "<span color=\"$color\">$battery%</span>"
fi
