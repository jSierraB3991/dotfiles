#! /bin/bash
device_conect=$(nmcli dev | grep -w "conectado" | awk '{print $2}')
if [[ "$device_conect" == "ethernet" ]]; then
    echo "󰈀 Interface cableada"
else
    nmcli dev wifi list | grep '*' | awk '{$1="";$2=""; print $0}' | awk 'BEGIN{FS="Infra"}{print $1}'
fi 


