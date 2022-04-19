#! /bin/bash

num_ports=$(ss -tulpn | grep LISTEN | awk '{print $5}' | grep "^[0-9].*" | wc -l)
echo "ports listeng is: $num_ports"
ports=$(ss -tulpn | grep LISTEN | awk '{print $5}' | grep "^[0-9].*" | awk 'BEGIN{FS=":"} {print $2}')

while true; do
    num_ports2=$(ss -tulpn | grep LISTEN | awk '{print $5}' | grep "^[0-9].*" | wc -l)
    if [ "$num_ports" != "$num_ports2" ]; then

        port_change=23
        method="up"
        ports_new=$(ss -tulpn | grep LISTEN | awk '{print $5}' | grep "^[0-9].*" | awk 'BEGIN{FS=":"} {print $2}')
        is_add=1
        if [ $num_ports -lt $num_ports2 ]; then
            #up a service in a port
            method="up"
            for port_new in ${ports_new[*]}; do
                for port in ${ports[*]}; do
                    if [ $port_new -eq $port ]; then
                        is_add=2
                        break
                    fi
                done
                if [ $is_add -eq 1 ]; then
                    port_change=$port_new
                    break
                else
                    is_add=1
                fi
            done
        else
            #down a service in a port
            method="down"
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
                fi
            done
        fi

        num_ports=$num_ports2
        ports=$ports_new
        notify-send "A port $port_change is change to $method"
        echo "ports listeng is: $num_ports"
    fi
    sleep 2
done
