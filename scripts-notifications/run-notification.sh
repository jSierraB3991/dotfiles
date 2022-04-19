#! /bin/bash

killall notas.sh
killall verify_battery.sh
killall power_pc_2am.sh
killall listeng_port_listeng.sh

~/scripts/notas.sh &
~/scripts/verify_battery.sh &
~/scripts/power_pc_2am.sh &
~/scripts/listeng_port_listeng.sh &
