#! /bin/bash

killall notas.sh
killall verify_battery.sh
killall power_pc_2am.sh

~/scripts/notas.sh &
~/scripts/verify_battery.sh &
~/scripts/power_pc_2am.sh &
