#! /bin/bash

picom &
clipcatd &
blueman-applet &
deadd-notification-center &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
eval "$(dbus-launch --sh-syntax --exit-with-session)"

/home/juan-sierra/Source/scripts/bash/listeng_port_listeng_diff.sh &
/home/juan-sierra/Source/scripts/bash/change_automatic_wallpaper_one.sh &
