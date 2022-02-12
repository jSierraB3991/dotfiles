#! /bin/bash

if [ "$(ip add | grep vpn)" == "" ]; then
    echo "FORTI CLIENT OFF"
else
    ip addres | grep vpn | tail -1 | grep -Eo '[0-9.]+' | head -1
fi
