#! /bin/bash


while true; do
    date_hour=$(date "+%H")
    
    if [ $date_hour -lt 06 ] || [ $date_hour -ge 11 ]; then
        notify-send "Go To Sleep" -h string:x-canonical-private-synchronous:sleep -u critical
    fi

    if [ $date_hour -ge 02 ] && [ $date_hour -lt 06 ]; then
        systemctl poweroff
    fi
    sleep 10
done
