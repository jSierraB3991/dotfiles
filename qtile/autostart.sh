#! /bin/sh
export XKB_DEFAULT_LAYOUT=us
export XKB_DEFAULT_VARIANT=altgr-intl

copyq &
wl-paste -t text --watch clipman store &
lxpolkit &
swaync &
#waybar &
blueman-applet &
#swaybg -i "$HOME/Imágenes/GentooBackground.png" -m fill &

exec_always eval $(ssh-agent -s)
