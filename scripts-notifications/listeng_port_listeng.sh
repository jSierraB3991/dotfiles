#! /bin/bash

num_ports=$(ss -tulpn | grep LISTEN | awk '{print $5}' | grep "^[1 | 0 | * ]" | wc -l)
echo "ports listeng is: $num_ports"
ports=$(ss -tulpn | grep LISTEN | awk '{print $5}' | grep "^[1 | 0 | * ]" | awk 'BEGIN{FS=":"} {print $2}')

while true; do
    num_ports2=$(ss -tulpn | grep LISTEN | awk '{print $5}' | grep "^[1 | 0 | * ]" | wc -l)
    if [ "$num_ports" != "$num_ports2" ]; then

        port_change=23
        ports_new=$(ss -tulpn | grep LISTEN | awk '{print $5}' | grep "^[1 | 0 | * ]" | awk 'BEGIN{FS=":"} {print $2}')
        is_add=1
        if [ $num_ports -lt $num_ports2 ]; then
            #up a service in a port
            for port_new in ${ports_new[*]}; do
                for port in ${ports[*]}; do
                    if [ $port_new -eq $port ]; then
                        is_add=2
                        break
                    fi
                done
                if [ $is_add -eq 1 ]; then
                    port_change=$port_new
                    notify-send "A port $port_change is change to up"
                else
                    is_add=1
                fi
            done
        else
            #down a service in a port
            for port in ${ports[*]}; do
                for port_new in ${ports_new[*]}; do
                    if [ $port_new -eq $port ]; then
                        is_add=2
                        break
                    fi
                done
                if [ $is_add -eq 2 ]; then
                    is_add=1
                else
                    port_change=$port
                    notify-send "A port $port_change is change to down"
                fi
            done
        fi
        num_ports=$num_ports2
        ports=$ports_new
    fi
    sleep 2
done
