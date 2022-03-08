#! /bin/bash
 
echo "$(curl --silent https://whatismyipaddress.com/es/mi-ip | grep 'Your IP'  | grep -Eo '[0-9.]+' | tail -1)"
