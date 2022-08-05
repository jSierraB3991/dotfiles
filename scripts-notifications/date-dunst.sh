#! /bin/bash

id=0
while true; do
    date=$(date)

    new_id=$(notify-send "$date" -h string:x-canonical-private-synchronous:my-notification -u low -p --replace-id=$id -a CALENDAR -i date)
    id=$new_id
    sleep 1
done
