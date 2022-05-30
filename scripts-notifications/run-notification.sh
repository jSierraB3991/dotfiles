#! /bin/bash

killall clipcatd
killall listeng_port_listeng.sh
killall change_automatic_wallpaper.sh
killall deadd-notification-center
killall verify_battery.sh
killall notas.sh
killall power_pc_2am.sh

clipcatd
clipcatctl clear

~/Source/scripts/bash/change_automatic_wallpaper.sh &
~/Source/scripts/bash/listeng_port_listeng.sh &
~/Source/scripts/bash/verify_battery.sh &
deadd-notification-center &
~/Source/scripts/bash/power_pc_2am.sh &
