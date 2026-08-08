#! /bin/sh

copyq &
wl-paste -t text --watch clipman store &
lxpolkit &
swaync &

exec_always eval $(ssh-agent -s)
