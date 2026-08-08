#! /bin/sh
export XKB_DEFAULT_LAYOUT=us
export XKB_DEFAULT_VARIANT=altgr-intl

copyq &
wl-paste -t text --watch clipman store &
lxpolkit &
swaync &

exec_always eval $(ssh-agent -s)
