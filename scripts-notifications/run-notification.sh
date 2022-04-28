#! /bin/bash

killall notas.sh
killall verify_battery.sh
killall power_pc_2am.sh
killall listeng_port_listeng.sh
clipcatctl clear

~/scripts/notas.sh &
~/scripts/verify_battery.sh &
~/Source/scripts/bash/power_pc_2am.sh &
~/Source/scripts/bash/listeng_port_listeng.sh &
