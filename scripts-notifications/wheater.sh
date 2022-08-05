#! /bin/bash

id_w=0
while true; do
    data=$(curl --silent http://wttr.in?format=4 | awk '{$1="";$2="";print $0}')
    city=$(curl --silent http://wttr.in | head -1 | awk '{$1="";$2="";print $0}')

    new_id=$(notify-send "$city" "$data" -h string:x-canonical-private-synchronous:wheater-notification -u low -p --replace-id $id_w -a WHEATE_APP -i wheater)
    id_w=$new_id
done
