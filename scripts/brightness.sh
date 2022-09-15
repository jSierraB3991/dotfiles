#!/usr/bin/bash

function show_notification() {
    replace_id=0
    if [ ! -f /home/juan-sierra/.local/data/brightnessctl_id.txt ]; then
        echo "creating file"
        touch /home/juan-sierra/.local/data/brightnessctl_id.txt
    else
        replace_id=$(cat /home/juan-sierra/.local/data/brightnessctl_id.txt)
    fi
    echo "Hola $replace_id"
    message=$(brightnessctl | grep "Current" | awk '{print $4}')
    if [ "$replace_id" == "" ]; then
        replace_id=0
    fi
    id=$(notify-send "Brightness show is $message" -u low -i brightness-systray --replace-id $replace_id -p)
    echo $id > /home/juan-sierra/.local/data/brightnessctl_id.txt
}

case $1 in
    "up") brightnessctl set 5%+ 
        show_notification;;
    "down") brightnessctl set 5%- 
        show_notification;;
    *) echo "Usage: $0 up | down ";;
esac
