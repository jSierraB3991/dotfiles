#! /bin/bash


while true; do
    date_hour=$(date "+%H")
    
    if [ $date_hour -lt 06 ] || [ $date_hour -ge 23 ]; then
        notify-send "Go To Sleep" -h string:x-canonical-private-synchronous:sleep
    fi

    if [ $date_hour -ge 02 ] && [ $date_hour -lt 06 ]; then

        for num in $(echo "1 2 3"); do

            faltan=30
            if [ $num -eq 2 ]; then
                faltan=20
            elif [ $num -eq 3 ]; then
                faltan=10
            fi

            notify-send "The Pc shutdown in $faltan" -h string:x-canonical-private-synchronous:poweroff -u critical
            sleep 10
        done
        systemctl poweroff
    fi
    sleep 5
done
