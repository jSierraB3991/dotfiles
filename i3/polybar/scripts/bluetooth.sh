#!/bin/bash

POWER=$(bluetoothctl show | awk '/Powered:/ {print $2}')

if [ "$POWER" != "yes" ]; then
    echo " off"
    exit
fi

DEVICE=$(bluetoothctl devices Connected | sed 's/^Device [^ ]* //')

if [ -n "$DEVICE" ]; then
    echo " $DEVICE"
else
    echo ""
fi
