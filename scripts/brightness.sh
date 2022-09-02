#!/usr/bin/bash

function show_notification() {
    message=$(brightnessctl | grep "Current" | awk '{print $4}')
    replace_id=5
    id=$(notify-send "Brightness show is $message" -u low -i gpm-brightness-lcd --replace-id $replace_id -p)
}

case $1 in
    "up") brightnessctl set 5%+ 
        show_notification;;
    "down") brightnessctl set 5%- 
        show_notification;;
    *) echo "Usage: $0 up | down ";;
esac
