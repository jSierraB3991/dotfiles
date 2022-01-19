#!/bin/sh
 
echo "%{F#2495e7} %{F#ffffff}$(curl --silent https://whatismyipaddress.com/ |
    grep 'Your IP' | grep -Eo '[0-9.]+' | tail -1)"
