#!/bin/bash

declare -A moptions

response=$(bluetoothctl info)
if [ "$response" != "Missing device address argument" ]; then
    echo "Devic Connect"
    set 1
else
    #echo "Restarting bluetooth service"
    #sudo rc-service bluetoothd restart
    echo "Config agent"
    bluetoothctl agent on
    bluetoothctl default-agent
    bluetoothctl power on
fi

question=''
bluetoothctl devices | {
    while read line
    do 
        line=${line//Device }
        mac=${line%% *}
        option=${line//$mac}
        moptions["${option:1}"]="${mac}"
        question+="${option:1}\n"
    done
    ans=$(echo -e "${question::-2}" | rofi -show combi -theme Monokai -icon-theme Tela-circle -dmenu)
    rs=$?
    if [ $rs -eq 0 ]
    then
        echo "Connecting to ${ans} with mac ${moptions[${ans}]}"
        bluetoothctl connect ${moptions["${ans}"]}
    fi
}
