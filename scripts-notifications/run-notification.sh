#! /bin/bash

killall clipcatd
killall notas.sh
killall verify_battery.sh
killall power_pc_2am.sh
killall listeng_port_listeng.sh
killall change_automatic_wallpaper.sh

clipcatd
clipcatctl clear

~/Source/scripts/bash/change_automatic_wallpaper.sh &
~/Source/scripts/bash/verify_battery.sh &
~/Source/scripts/bash/power_pc_2am.sh &
~/Source/scripts/bash/listeng_port_listeng.sh &

