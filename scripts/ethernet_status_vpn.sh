#! /bin/bash

if [ "$(ip add | grep vpn)" == "" ]; then
    echo "FORTI CLIENT OFF"
else
    /opt/forticlient/fortivpn status | grep "VPN name" | awk 'BEGIN{FS=":"}{print $2}'
fi
