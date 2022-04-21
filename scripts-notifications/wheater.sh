#! /bin/bash

while true; do
    data=$(curl --silent http://wttr.in?format=4 | awk '{$1="";$2="";print $0}')
    city=$(curl --silent http://wttr.in | head -1 | awk '{$1="";$2="";print $0}')

    notify-send "$city" "$data" -h string:x-canonical-private-synchronous:wheater-notification -u low
done
