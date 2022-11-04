#! /bin/bash

killall picom
killall copyq
killall dunst
killall blueman-applet
killall xscreensaver
killall listeng_port_listeng_diff.sh
killall verify_battery.sh

/home/juan-sierra/Source/scripts/bash/change_automatic_wallpaper_one.sh &
picom &
copyq &
dunst &
blueman-applet &
xscreensaver -no-splash &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
eval "$(dbus-launch)"
export $(dbus-launch)


/home/juan-sierra/Source/scripts/bash/listeng_port_listeng_diff.sh &
/home/juan-sierra/Source/scripts/bash/verify_battery.sh &
#yakuake &

disown
disown -a

