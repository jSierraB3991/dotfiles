#! /bin/bash

killall listeng_port_listeng.sh
killall deadd-notification-center
killall verify_battery.sh

~/Source/scripts/bash/listeng_port_listeng.sh &
~/Source/scripts/bash/verify_battery.sh &
deadd-notification-center &
