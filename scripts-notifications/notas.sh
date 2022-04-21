#! /bin/bash

FILE='~/notas.txt'

if [ ! -f $FILE ]; then
    touch ~/notas.txt
    echo "Now add task in file $FILE" > ~/notas.txt
fi

while true; do 
    id=1
    while read -r line; 
    do
        if [ "$line" != "" ]; then
            name_not=$(echo "notification$id")
            notify-send "$line" -h string:x-canonical-private-synchronous:$name_not
            id=$( echo $id+1)
        fi
    done < ~/notas.txt
    sleep 4
done
