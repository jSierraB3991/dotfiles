#! /bin/bash

if [ ! -f $HOME/notas.txt ]; then
    touch ~/notas.txt
    echo "Now add task in file $HOME/notas.txt" > ~/notas.txt
fi

while true; do 
    id=1
    while read -r line; 
    do
        if [ "$line" != "" ]; then
            name_not=$(echo "notification$id")
            notify-send "$line" -h string:x-canonical-private-synchronous:$name_not
            let id+=1
        fi
    done < ~/notas.txt
    sleep 4
done
