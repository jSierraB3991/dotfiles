#! /bin/bash

#killall picom
killall copyq
killall dunst
killall blueman-applet
killall xscreensaver
killall listeng_port_listeng_diff.sh
killall verify_battery.sh
killall kdeconnect-indicator
killall  pasystray

/home/juan-sierra/Source/scripts/bash/change_automatic_wallpaper_one.sh &
#picom &
copyq &
dunst &
blueman-applet &
/usr/lib/polkit-kde-authentication-agent-1 &
kdeconnect-indicator &
 pasystray &
eval "$(dbus-launch)"
export $(dbus-launch)
betterlockscreen -u ~/Source/dotfiles/betterlocker/ --display 1 --span &

xss-lock --transfer-sleep-lock -- $HOME/.config/i3/betterlok.sh --nofork &
/home/juan-sierra/Source/scripts/bash/listeng_port_listeng_diff.sh &
/home/juan-sierra/Source/scripts/bash/verify_battery.sh &
#yakuake &

disown
disown -a
