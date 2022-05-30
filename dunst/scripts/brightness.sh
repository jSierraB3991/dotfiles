#!/usr/bin/bash

# Brightness notification: dunst


icon_path=/usr/share/icons/Adwaita/64x64/status
notify_id=817


function get_brightness {
    echo "$(brightnessctl info | tail -3 | head -1 | grep -Eo "[0-9]." | tail -1 )"
}

function brightness_notification {
    brightness=`get_brightness`
    printf -v br_int %.0f "$brightness"
    echo $br_int
    bar=$(seq -s "─" $(($br_int / 5)) | sed 's/[0-9]//g')
    dunstify -r $notify_id -u low -i $icon_path/display-brightness-symbolic.symbolic.png $bar
}

case $1 in
    up)
        brightnessctl set 5%+
        brightness_notification
        ;;
    down)
        brightnessctl set 5%-
        brightness_notification
	    ;;
    *)
        echo "Usage: $0 up | down "
        ;;
esac

